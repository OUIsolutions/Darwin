private_darwin_project.generate_lua_complex = function(selfobj, props)
    local embed_data = props.include_embed_data
    if embed_data == nil then
        embed_data = true
    end
    if #selfobj.embed_data == 0 then
        embed_data = false
    end

    if embed_data then
        local parse_to_bytes = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "parse_to_bytes.lua")
        props.stream(parse_to_bytes)
    end

    for i = 1, #selfobj.lua_code do
        props.stream("\n")
        props.stream(selfobj.lua_code[i])
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
    return private_darwin.table.concat(content, "")
end

private_darwin_project.generate_lua_file = function(selfobj, props)
    darwin.dtw.write_file(props.output, "")
    local file = io.open(props.output, "a+b")
    if not file then
        error("impossible to generate output in" .. props.output)
    end

    local function stream(data)
        file:write(data)
    end
    private_darwin_project.generate_lua_complex(selfobj, {
        stream = stream,
        include_embed_data = props.include_embed_data
    })
end
