function release_download(dep)

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
        local version = dep.version or "latest"
        local command = "curl -L " .. dep.repo .."releases/download/"..version.."/"..dep.file.." -o temp"
        os.execute(command)
    elseif dep.cli == "gh" then
        local version = dep.version or "latest"
        local command = "gh release download " .. version .. " -R " .. dep.repo .. " --pattern " .. dep.file .. " -D temp"
        os.execute(command)
    else 
        error("invalid dep mode:"..dep.cli,0)
    end
    darwin.dtw.move_any_overwriting("temp",dep.dest)

end 
function git_download(dep)
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
        else 
            error("invalid dep type:"..current.type,0)
        end 
    end 

end 