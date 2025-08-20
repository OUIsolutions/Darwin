

function dep_solver()
    local darwin_deps_json = darwin.dtw.load_file("darwindeps.json")
    if not darwin_deps_json then
        return 
    end
    local deps = darwin.json.load_from_string(darwin_deps_json)
    for i=1,#deps do 
        local current = deps[i]
        print(current.type)
    end 

end 