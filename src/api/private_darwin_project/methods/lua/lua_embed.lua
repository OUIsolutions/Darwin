private_darwin_project.create_lua_str_buffer = function(str_code, streamed_shas, stream)
    local name = string.format("private_darwin_sha%s", darwin.dtw.generate_sha(str_code))
    if private_darwin.is_inside(streamed_shas, name) then
        return name
    end
    streamed_shas[#streamed_shas + 1] = name
    stream(string.format(
        "%s = table.concat(PrivateDarwing_parse_to_bytes({",
        name
    ))

    local size = string.len(str_code)
    for i = 1, size do
        local current_char = string.sub(str_code, i, i)
        local byte = string.byte(current_char)
        stream(string.format("%d,", byte))
    end

    stream("}))\n")
    return name
end


private_darwin_project.create_lua_stream_buffer = function(filestream, streamed_shas, stream)
    local name = string.format("private_darwin_sha%s", darwin.dtw.generate_sha_from_file(filestream.filename))
    if private_darwin.is_inside(streamed_shas, name) then
        return name
    end

    streamed_shas[#streamed_shas + 1] = name
    stream(string.format(
        "%s = table.concat(PrivateDarwing_parse_to_bytes({",
        name
    ))

    local file = io.open(filestream.filename, "a+b")
    if not file then
        error("impossible to open" .. filestream.filename)
    end

    local chunk_size = 1024
    while true do
        local chunk = file:read(chunk_size)
        if not chunk then break end
        local current_chunk_size = #chunk
        for i = 1, current_chunk_size do
            local current_char = string.sub(chunk, i, i)
            local byte = string.byte(current_char)
            stream(string.format("%d,", byte))
        end
    end


    stream("}))\n")
    return name
end



private_darwin_project.embed_lua_table = function(table_name, current_table)
    for key, val in pairs(current_table) do
        local key_type = type(key)
        local val_type = type(val)

        if not private_darwin.is_inside({ "string", "number" }, key_type) then
            error("invalid key on " .. table_name)
        end
        if not private_darwin.is_inside({ "string", "number", "table", "boolean" }, val_type) then
            error("invalid val on " .. table_name)
        end

        -- Format the key appropriately
        local formatted_key
        if key_type == "number" then
            formatted_key = string.format("[%d]", key)
        else
            formatted_key = string.format("[%q]", key)
        end

        -- Handle different value types
        if val_type == "number" then
            private_darwin.embed_lua_global_concat(
                string.format('%s%s = %f\n', table_name, formatted_key, val)
            )
        elseif val_type == "string" then
            local converted = private_darwin.create_lua_str_buffer(val)
            private_darwin.embed_lua_global_concat(
                string.format('%s%s = %s\n', table_name, formatted_key, converted)
            )
        elseif val_type == "boolean" then
            private_darwin.embed_lua_global_concat(
                string.format('%s%s = %s\n', table_name, formatted_key, tostring(val))
            )
        elseif val_type == "table" then
            private_darwin.embed_lua_global_concat(
                string.format('%s%s = {}\n', table_name, formatted_key)
            )
            private_darwin.embed_lua_table(
                table_name .. formatted_key,
                val
            )
        end
    end
end


private_darwin_project.embed_global_in_lua = function(name, var, streamed_shas, stream)
    local var_type = type(var)

    if private_darwin.is_inside({ "function", "thread", "userdata" }, var_type) then
        error("var " .. name .. "cannot be embed")
    end

    if var_type == "number" then
        stream(
            string.format('%s = %f;\n', name, var)
        )
    end
    if var_type == "boolean" then
        stream(
            string.format('%s = %s;\n', name, tostring(var))
        )
    end

    if var_type == "string" then
        local sha_name = private_darwin_project.create_lua_str_buffer(var, streamed_shas, stream)
        stream(
            string.format('%s = %s;\n', name, sha_name)
        )
    end

    local is_stream = private_darwin.is_file_stream(var)
    if is_stream then
        local sha_name = private_darwin_project.create_lua_stream_buffer(var, streamed_shas, stream)
        stream(
            string.format('%s = %s;\n', name, sha_name)
        )
    end
end
