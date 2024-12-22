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


    local streamed_shas = {}
    for i = 1, #selfobj.embed_data do
        local current = selfobj.embed_data[i]
        private_darwin_project.embed_global_in_lua(current.name, current.value, streamed_shas, props.stream)
    end

    for i = 1, #selfobj.lua_code do
        props.stream("\n")
        local current = selfobj.lua_code[i]
        if private_darwin.is_file_stream(current) then
            private_darwin.transfer_file_stream(current, props.stream)
        else
            props.stream(selfobj.lua_code[i])
        end
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
