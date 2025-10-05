

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
       


        dtw.remove_any("temp.json")
        local command = "gh release view -R "..current.repo.." --json tagName,assets --jq '{tag: .tagName, assets: [.assets[] | {name: .name, updated_at: .updatedAt}]}' > temp.json"
        os.execute(command)
        local temp_json = darwin.dtw.load_file("temp.json")
        if not temp_json then
            private_darwin.print_red("Failed to fetch release info for: " .. current.repo .. "\n")
            goto continue
        end
        local parsed = darwin.json.load_from_string(temp_json)
        local assets = parsed.assets
        for j=1,#assets do 
            local current_asset = assets[j]
            if current_asset.name == current.dest then
                current.tag = parsed.tag
                current.updated_at = current.updated_at
            end
        end

        ::continue::
    end

    local updated_json = darwin.json.dumps_to_string(deps,true)
    darwin.dtw.write_file(deps_file_path, updated_json)
    private_darwin.print_green("\nDependencies file updated: " .. deps_file_path .. "\n")
  

end
