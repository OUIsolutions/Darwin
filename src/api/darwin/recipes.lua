
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