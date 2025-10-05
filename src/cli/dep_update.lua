local function get_latest_release_tag(repo)
    local command = "gh release list -R " .. repo .. " --limit 1 --json tagName -q '.[0].tagName'"
    local handle = io.popen(command)
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    
    if result and result ~= "" then
        return result:gsub("%s+", "") -- trim whitespace
    end
    return nil
end

local function compare_versions(v1, v2)
    -- Simple version comparison (e.g., "0.12.0" vs "0.13.0")
    -- Returns true if v2 is higher than v1
    if not v1 or not v2 then
        return false
    end
    
    -- Remove 'v' prefix if present
    v1 = v1:gsub("^v", "")
    v2 = v2:gsub("^v", "")
    
    local parts1 = {}
    for part in v1:gmatch("[^.]+") do
        table.insert(parts1, tonumber(part) or 0)
    end
    
    local parts2 = {}
    for part in v2:gmatch("[^.]+") do
        table.insert(parts2, tonumber(part) or 0)
    end
    
    local max_len = math.max(#parts1, #parts2)
    for i = 1, max_len do
        local p1 = parts1[i] or 0
        local p2 = parts2[i] or 0
        if p2 > p1 then
            return true
        elseif p2 < p1 then
            return false
        end
    end
    
    return false
end

function dep_update()
    -- Check if gh CLI is available
    if not os.execute("gh --version > /dev/null 2>&1") then
        error("gh CLI is required for dep_update", 0)
    end
    
    local possible_darwindeps = darwin.argv.get_next_unused()
    
    local darwin_deps_json = nil
    local deps_file_path = nil
    
    if possible_darwindeps then
        deps_file_path = possible_darwindeps
        darwin_deps_json = darwin.dtw.load_file(possible_darwindeps)
    else
        deps_file_path = "darwindeps.json"
        darwin_deps_json = darwin.dtw.load_file("darwindeps.json")
    end
    
    if not darwin_deps_json then
        print("No darwindeps.json file found")
        return
    end
    
    local deps = darwin.json.load_from_string(darwin_deps_json)
    local updated = false
    
    for i = 1, #deps do
        local current = deps[i]
        
        -- Skip if not gitrelease type
        if current.type ~= "gitrelease" then
            private_darwin.print_yellow("Skipping non-gitrelease dep: " .. (current.dest or "unknown") .. "\n")
            goto continue
        end
        
        -- Skip if locked
        if current.lock == true then
            private_darwin.print_yellow("Skipping locked dep: " .. current.dest .. " (current: " .. (current.tag or "latest") .. ")\n")
            goto continue
        end
        
        -- Get latest release
        private_darwin.print_blue("Checking for updates: " .. current.repo .. "\n")
        local latest_tag = get_latest_release_tag(current.repo)
        
        if not latest_tag then
            private_darwin.print_red("Failed to get latest release for: " .. current.repo .. "\n")
            goto continue
        end
        
        local current_tag = current.tag
        
        -- If no current tag, update to latest
        if not current_tag then
            private_darwin.print_green("Updating " .. current.dest .. ": no tag -> " .. latest_tag .. "\n")
            deps[i].tag = latest_tag
            updated = true
        -- If current tag is different and latest is higher, update
        elseif current_tag ~= latest_tag and compare_versions(current_tag, latest_tag) then
            private_darwin.print_green("Updating " .. current.dest .. ": " .. current_tag .. " -> " .. latest_tag .. "\n")
            deps[i].tag = latest_tag
            updated = true
        else
            print("No update needed for " .. current.dest .. " (current: " .. current_tag .. ")")
        end
        
        ::continue::
    end
    
    if updated then
        -- Write updated deps back to file
        local updated_json = darwin.json.dump_to_string(deps, "    ")
        darwin.dtw.write_file(deps_file_path, updated_json)
        private_darwin.print_green("\nDependencies file updated: " .. deps_file_path .. "\n")
        print("Run 'darwin install_deps' to download the updated dependencies")
    else
        print("\nAll dependencies are up to date!")
    end
end
