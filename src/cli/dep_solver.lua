

--a5
local function release_download(dep, cli)
    if not dep.file then
        error("file not provided",0)
    end
    if not dep.dest then
        error("dest not provided",0)
    end
    if not dep.repo then
        error("repo not provided",0)
    end
    if darwin.dtw.isfile(dep.dest) then
        darwin.dtw.remove_any(dep.dest)    
    end
    darwin.dtw.remove_any("temp")

    if cli  == "curl" then
        
        local tag = dep.tag
        local command = nil
        if dep.tag then
            command = "curl -L https://github.com/" .. dep.repo .."/releases/download/"..dep.tag.."/"..dep.file.." -o temp"

        end
        if not dep.tag then
            command = "curl -L https://github.com/" .. dep.repo .."/releases/latest/download/"..dep.file.." -o temp"
        end

        os.execute(command)
    
        

        local temp_content = darwin.dtw.load_file("temp")
        if temp_content == nil or temp_content == "Not Found" then
            error("Failed to download file: " .. dep.file, 0)
        end
        darwin.dtw.write_file( dep.dest, temp_content)
        darwin.dtw.remove_any("temp")
        return
    end 
    if cli == "gh" then
        if dep.tag then
            local command = "gh release download " .. dep.tag .. " -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
            os.execute(command)
        end
        if not dep.tag then
            local command = "gh release download -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
            os.execute(command)
        end
        local temp_path = "temp/" .. dep.file
        local temp_content = darwin.dtw.load_file(temp_path)
        if temp_content == nil or temp_content == "Not Found" then
            error("Failed to download file: " .. dep.file, 0)
        end
        darwin.dtw.write_file( dep.dest, temp_content)
        darwin.dtw.remove_any("temp")

        return

    end

end

local function url_download(dep)
    if not dep.url then 
        error("url not provided",0)
    end
    if not dep.dest then 
        error("dest not provided",0)
    end
    if darwin.dtw.isfile(dep.dest) then 
        darwin.dtw.remove_any(dep.dest)
    end 

    local command = "curl -L " .. dep.url .. " -o temp"
    os.execute(command)
    darwin.dtw.move_any_overwriting("temp",dep.dest)
    
end 



local function git_download(dep)
    if not dep.repo then 
        error("repo not provided",0)
    end
    if not dep.dest then 
        error("dest not provided",0)
    end
    if darwin.dtw.isdir(dep.dest) then 
         darwin.dtw.remove_any(dep.dest)
    end 
    darwin.dtw.remove_any("temp")

    local command = "gh repo clone " .. dep.repo .. " temp"

    os.execute(command)
    if not darwin.dtw.isdir("temp") then
        error("Failed to clone repository: " .. dep.repo, 0)
    end
    os.execute("cd temp && git checkout " .. dep.branch)
    darwin.dtw.move_any_overwriting("temp",dep.dest)
    darwin.dtw.remove_any("temp")

end 



function dep_solver()
    -- Detect CLI tool once per dep_solver call
    local cli = nil
    if os.execute("gh --version") then
        cli = "gh"
    elseif os.execute("curl --version") then
        cli = "curl"
    else
       error("no suitable CLI tool found")
    end
    local possible_darwindeps = darwin.argv.get_next_unused()
    local soft = darwin.argv.flags_exist({"soft"})

    local darwin_deps_json = nil 
    
    if possible_darwindeps then 
        darwin_deps_json = darwin.dtw.load_file(possible_darwindeps)
    end
    if not possible_darwindeps then 
        darwin_deps_json = darwin.dtw.load_file("darwindeps.json")
    end
    
    if not darwin_deps_json then
        print("No darwindeps.json file found")
        return 
    end

    local deps = darwin.json.load_from_string(darwin_deps_json)
    for i=1,#deps do 
        local current = deps[i]
        if soft then 
            if darwin.dtw.isfile(current.dest) or darwin.dtw.isdir(current.dest) then 
                private_darwin.print_yellow("Skipping existing dep: " .. current.dest .. "\n")
                goto continue
            end 
        end

        if current.type == "gitrelease" then 
            release_download(current, cli) 
        elseif current.type == "gitrepo" then
            if cli ~= "gh" then
                error("gh cli required for gitrepo type",0)
            end
            git_download(current)
        elseif current.type == "url" then
            url_download(current)
        else 
            error("invalid dep type:"..current.type,0)
        end 
        ::continue::
    end 

end 
