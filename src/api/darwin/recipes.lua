
darwin.add_recipie = function(props)
    if not darwin.available_builds then 
        darwin.available_builds = {}
    end
    if not props.name then 
        error("name of recipe its required",props.name,0)
    end 

    if not props.description then
        error("description of recipe its required",props.description,0)
    end
    if not props.callback then
        error("callback of recipe its required",props.callback,0)
    end
    if type(props.callback) ~= "function" then
        error("callback of recipe must be a function",props.callback,0)
    end
 
end 

darwin.run_recipe = function (name)
    for i=1,#darwin.available_builds do
        local build = darwin.available_builds[i]
        if build.name == name then
            
            private_darwin.print_green("Building: " .. name .. "\n")
            if build.outs then
                for j=1,#build.outs do
                    private_darwin.print_blue("  Output: " .. build.outs[j] .. "\n")
                end
            end

            if build.done then
                return 
            end
            if build.requires then 
                for j=1,#build.requires do
                    if build.requires[j] == name then
                        error("circular dependency detected: " .. name .. " requires itself")
                    end
                    darwin.run_build(build.requires[j])
                end
            end
            build.done = true 
            build.callback()
            private_darwin.print_green("=======================================\n")
            return
        end
    end
    error("build not found: " .. name)
end
