
darwin.add_recipe = function(props)
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
    darwin.available_builds[#darwin.available_builds+1] = props
 
end 

darwin.run_recipe = function (name)
    for i=1,#darwin.available_builds do
        local build = darwin.available_builds[i]
        local asssignature = nil
        if build.inputs then 
            assignature = private_darwin.generate_assignature(build.inputs)
            for j=1,#build.outs do
                local cached_path = ".darwincache/" .. assignature .. "/" .. build.outs[j]
                if darwin.dtw.isfile(cached_path) then
                    private_darwin.print_green("Using cached output: " .. build.outs[j] .. "\n")
                    darwin.dtw.copy_any_overwriting(
                        cached_path,
                        build.outs[j]
                    )
                end
            end             
        end 

        if build.name == name then
            if build.done then
                return 
            end
            
            private_darwin.print_green("Building: " .. name .. "\n")
            if build.outs then
                for j=1,#build.outs do
                    private_darwin.print_blue("  Output: " .. build.outs[j] .. "\n")
                end
            end

         
            if build.requires then 
                for j=1,#build.requires do
                    if build.requires[j] == name then
                        error("circular dependency detected: " .. name .. " requires itself")
                    end
                    darwin.run_recipe(build.requires[j])
                end
            end
            build.done = true 
            build.callback()
            if assignature then 
                for j=1,#build.outs do
                    local cached_path = ".darwincache/" .. assignature .. "/" .. build.outs[j]
                    darwin.dtw.copy_any_overwriting(
                        build.outs[j],
                        cached_path
                    )
                end             
            end
            private_darwin.print_green("=======================================\n")

            return
        end
    end
    error("build not found: " .. name)
end
