---@param name string
---@param var any
function Private_embed_global_in_lua(name, var)
    PrivateDawring_cglobals_already_setted[#PrivateDawring_cglobals_already_setted + 1] = name
    var_type = type(var)

    if not is_inside({ "string", "number", "table", "boolean" }, var_type) then
        error("invalid val on " .. name)
    end

    -- For simple types (number, boolean, string)
    if var_type == "number" then
        PrivateDarwinEmbed_global_concat(
            string.format('%s = %f\n', name, var)
        )
    end
    if var_type == "boolean" then
        PrivateDarwinEmbed_global_concat(
            string.format('%s = %s\n', name, tostring(var))
        )
    end
    if var_type == "string" then
        PrivateDarwinEmbed_global_concat(
            string.format('%s = %q\n', name, var)
        )
    end
    if var_type == "table" then
        PrivateDarwinEmbed_global_concat(string.format('%s = {}\n', name))
        Private_embed_lua_table(name, var)
    end
end

---@param table_name string
---@param current_table table
function Private_embed_lua_table(table_name, current_table)
    for key, val in pairs(current_table) do
        local key_type = type(key)
        local val_type = type(val)

        if not is_inside({ "string", "number" }, key_type) then
            error("invalid key on " .. table_name)
        end
        if not is_inside({ "string", "number", "table", "boolean" }, val_type) then
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
            PrivateDarwinEmbed_global_concat(
                string.format('%s%s = %f\n', table_name, formatted_key, val)
            )
        elseif val_type == "string" then
            PrivateDarwinEmbed_global_concat(
                string.format('%s%s = %q\n', table_name, formatted_key, val)
            )
        elseif val_type == "boolean" then
            PrivateDarwinEmbed_global_concat(
                string.format('%s%s = %s\n', table_name, formatted_key, tostring(val))
            )
        elseif val_type == "table" then
            PrivateDarwinEmbed_global_concat(
                string.format('%s%s = {}\n', table_name, formatted_key)
            )
            Private_embed_lua_table(
                table_name .. formatted_key,
                val
            )
        end
    end
end
