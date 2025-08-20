
local function get_latest_version_from_repo(dep)
    --https://api.github.com/repos/OUIsolutions/BearHttpsClient/releases/latest
    local command = "curl -L " .. "https://api.github.com/repos/" .. dep.repo .. "/releases/latest -o temp"
    os.execute(command)
    local api_content = darwin.dtw.load_file("temp")
    if api_content == nil or api_content == "Not Found" then
        error("Failed to fetch latest version from repo: " .. dep.repo, 0)
    end
    local json_content = darwin.json.load_from_string(api_content)
    return json_content.name
end

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
        
        local version = dep.version
        if not dep.version then
            version = get_latest_version_from_repo(dep)
        end

        local command = "curl -L https://github.com/" .. dep.repo .."/releases/download/"..version.."/"..dep.file.." -o temp"
        os.execute(command)
    
    
    elseif dep.cli == "gh" then
        local version = dep.version or "latest"
        local command = "gh release download " .. version .. " -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
        os.execute(command)
    else
        error("invalid dep mode:"..dep.cli,0)
    end
    local temp_content = darwin.dtw.load_file("temp")
    if temp_content == nil or temp_content == "Not Found" then
        error("Failed to download file: " .. dep.file, 0)
    end
    darwin.dtw.write_file( dep.dest, temp_content)
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
        local command = "git clone -b " .. dep.branch .. " " .. dep.repo .. " temp"
        os.execute(command)
    end
    if not dep.branch then
        local command = "git clone " .. dep.repo .. " temp"
        os.execute(command)
    end
    darwin.dtw.move_any_overwriting("temp",dep.dest)
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