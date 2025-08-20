function release_download(dep)
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
        if current.type == "release" then 
            release_download(current) 
        elseif current.type == "git" then
            git_download(current)
        else 
            error("invalid dep type:"..current.type,0)
        end 
    end 

end 