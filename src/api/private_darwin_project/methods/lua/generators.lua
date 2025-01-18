private_darwin_project.generate_lua_complex = function(selfobj, props)
    local embed_data = props.include_embed_data
    if embed_data == nil then
        embed_data = true
    end
    if #selfobj.embed_data == 0 then
        embed_data = false
    end
    local so_dest = props.so_dest
    if not props.so_dest then
        so_dest = "/tmp/"..selfobj.project_name.."_so"
    end
    -----------------------------Embedding global variables
    if embed_data then
        local parse_to_bytes = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "parse_to_bytes.lua")
        props.stream(parse_to_bytes)
        local streamed_shas = {}
        for i = 1, #selfobj.embed_data do
            local current = selfobj.embed_data[i]
            private_darwin_project.embed_global_in_lua(current.name, current.value, streamed_shas, props.stream)
        end
    end
 
    local required_func_name = "PRIVATE_DARWIN_"..selfobj.project_name.."_REQUIRED_FUNCS"
    local so_includeds_name = "PRIVATE_DARWIN_"..selfobj.project_name.."_SO_INCLUDED"
    

    -----------------------------Embedding so files
    if #selfobj.so_includeds > 0 then
        local so_actions = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "so_actions.lua")
        local so_actions_format = private_darwin.replace_str(so_actions, "SO_INCLUDE", so_includeds_name)
        so_actions_format = private_darwin.replace_str(so_actions_format, "PRIVATE_DARWIN_SO_DEST","'"..so_dest.."'")
        props.stream(so_actions_format)   

        local load_lib_overload = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "load_lib_overload.lua")
        local load_lib_overload_format = private_darwin.replace_str(load_lib_overload, "REQUIRE_SO", so_includeds_name)
        load_lib_overload_format = private_darwin.replace_str(load_lib_overload_format, "PRIVATE_DARWIN_SO_DEST", "'"..so_dest.."'")
        props.stream(load_lib_overload_format)
    end

    -----------------------------Embedding required functions
    if #selfobj.required_funcs > 0 then
        props.stream(required_func_name.." = {}\n")
        for i=1,#selfobj.required_funcs do
            local current = selfobj.required_funcs[i]
            props.stream(required_func_name.."[" .. i .. "] = {\n")
            props.stream("comptime_include ='".. current.comptime_included .. "',\n")
            props.stream("loaded_obj = nil,\n")
            props.stream("content = function()\n")
                private_darwin.transfer_file_stream(current.content, props.stream)
            props.stream("end\n")
        
            props.stream("\n}\n")
        end


        local require_code = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "require_overload.lua")
        local require_code_format = private_darwin.replace_str(require_code, "REQUIRE_FUNCS", required_func_name)
        require_code_format = private_darwin.replace_str(require_code_format, "REQUIRE_SO", so_includeds_name)
        require_code_format = private_darwin.replace_str(require_code_format, "PRIVATE_DARWIN_SO_DEST", "'"..so_dest.."'")
        props.stream(require_code_format)
    
    end
  
    -----------------------------Embedding lua code
    for i = 1, #selfobj.lua_code do
        props.stream("\n")
        local current = selfobj.lua_code[i]
        if private_darwin.is_file_stream(current) then
            private_darwin.transfer_file_stream(current, props.stream)
        else
            props.stream(selfobj.lua_code[i])
        end
    end

    if #selfobj.required_funcs > 0 then
        local resset_require = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "resset_require.lua")
        props.stream(resset_require)
        props.stream("\n")
    end 
    if #selfobj.so_includeds > 0 then
        local resset_so = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "resset_so.lua")
        props.stream(resset_so)
        props.stream("\n")
    end 
end

private_darwin_project.generate_lua_code = function(selfobj, props)
    local content = {}
    local function stream(data)
        content[#content + 1] = data
    end
    private_darwin_project.generate_lua_complex(selfobj, {
        stream = stream,
        include_embed_data = props.include_embed_data
    })
    return table.concat(content, "")
end

private_darwin_project.generate_lua_file = function(selfobj, props)
    darwin.dtw.write_file(props.output, "")
    local file = io.open(props.output, "a+b")

    local function stream(data)
        if not file then
            file = io.open(props.output, "a+b")
        end
        if not file then
            error("impossible to generate output in" .. props.output)
        end
        file:write(data)
    end

    private_darwin_project.generate_lua_complex(selfobj, {
        stream = stream,
        include_embed_data = props.include_embed_data
    })
    if file then
        file:close()
    end
end
