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
    private_darwin.transfer_byte_size_decide(str_code, stream)

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
    private_darwin.transfer_file_stream_bytes(filestream, stream)
    stream("}))\n")
    return name
end



private_darwin_project.embed_table_in_lua = function(table_name, current_table, streamed_shas, stream)
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
            stream(
                string.format('%s%s = %f\n', table_name, formatted_key, val)
            )
        end
        if val_type == "boolean" then
            stream(
                string.format('%s%s = %s\n', table_name, formatted_key, tostring(val))
            )
        end

        if val_type == "string" then
            local sha_name = private_darwin_project.create_lua_str_buffer(val, streamed_shas, stream)
            stream(
                string.format('%s%s = %s;\n', table_name, formatted_key, sha_name)
            )
        end
        local is_stream = private_darwin.is_file_stream(val)
        if is_stream then
            local sha_name = private_darwin_project.create_lua_stream_buffer(val, streamed_shas, stream)
            stream(
                string.format('%s%s = %s;\n', table_name, formatted_key, sha_name)
            )
        end

        if val_type == "table" and not is_stream then
            stream(
                string.format('%s%s = {}\n', table_name, formatted_key)
            )

            private_darwin_project.embed_table_in_lua(
                table_name .. formatted_key,
                val,
                streamed_shas,
                stream
            )
        end
    end
end


private_darwin_project.embed_global_in_lua = function(name, var, streamed_shas, stream)
    local var_type = type(var)

    if not private_darwin.is_inside({ "string", "number", "table", "boolean" }, var_type) then
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
    if var_type == 'table' and not is_stream then
        private_darwin_project.embed_table_in_lua(name, var, streamed_shas, stream)
    end
end
