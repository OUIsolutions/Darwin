private_darwin_project.generate_c_complex = function(selfobj, props)
    
    local include_lua_cembed = true
    if props.include_lua_cembed == nil then
        include_lua_cembed = props.include_lua_cembed
    end
    local embed_data =  true 
    if props.embed_data == nil then
        embed_data = props.embed_data
    end
    
end
