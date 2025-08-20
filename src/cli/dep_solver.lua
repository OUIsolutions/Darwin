


local function release_download(dep)

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
        return
    end

    if dep.cli == "curl" then
        
        local tag = dep.tag
        if not dep.tag then
            tag = "latest"
        end

        local command = "curl -L https://github.com/" .. dep.repo .."/releases/"..tag.."/download/"..dep.file.." -o temp"
        os.execute(command)

    elseif dep.cli == "gh" then
        if dep.tag then
            local command = "gh release download " .. dep.tag .. " -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
            os.execute(command)
        end
        if not dep.tag then
            local command = "gh release download -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
            os.execute(command)
        end
    else
        error("invalid dep mode:"..dep.cli,0)
    end
    local temp_content = darwin.dtw.load_file("temp")
    if temp_content == nil or temp_content == "Not Found" then
        error("Failed to download file: " .. dep.file, 0)
    end
    darwin.dtw.write_file( dep.dest, temp_content)
    darwin.dtw.remove_any("temp")
end

local function url_download(dep)
    if not dep.url then 
        error("url not provided",0)
    end
    if not dep.dest then 
        error("dest not provided",0)
    end
    if darwin.dtw.isfile(dep.dest) then 
        return 
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
        return 
    end 
    if dep.branch then
        local command = "git clone -b " .. dep.branch .. " " .. "https://github.com/"..dep.repo ..".git" .." temp"
        os.execute(command)
    end
    if not dep.branch then
        local command = "git clone " .. "https://github.com/"..dep.repo ..".git" .." temp"
        os.execute(command)
    end
    darwin.dtw.move_any_overwriting("temp",dep.dest)
    darwin.dtw.remove_any("temp")

end 



function dep_solver()
    local darwin_deps_json = darwin.dtw.load_file("darwindeps.json")
    if not darwin_deps_json then
        return 
    end
    local deps = darwin.json.load_from_string(darwin_deps_json)
    for i=1,#deps do 
        local current = deps[i]
        if current.type == "gitrelease" then 
            release_download(current) 
        elseif current.type == "gitrepo" then
            git_download(current)
        elseif current.type == "url" then
            url_download(current)
        else 
            error("invalid dep type:"..current.type,0)
        end 
    end 

end 