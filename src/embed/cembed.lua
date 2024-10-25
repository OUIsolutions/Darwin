--@param value string
function PrivateDarwinEmbed_global_concat(value)
    PrivateDarwin_cglobals = PrivateDarwin_cglobals .. value
end

---@param original_name string
---@param table_name string
---@param current_table table
function PrivateDarwinEmbed_c_table(original_name, table_name, current_table)
    for key, val in pairs(current_table) do
        local key_type = type(key)
        local valtype = type(val)
        if key_type == "number" and valtype == "string" then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_double_by_index(%s,%d,%lf);\n",
                table_name,
                key,
                val
            ))
        end

        if key_type == "number" and valtype == "string" then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_string_by_index(%s,%d,(char*)%s);\n",
                table_name,
                key,
                val
            ))
        end

        if key_type == "number" and valtype == true then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_bool_by_index(%s,%d,true);\n",
                table_name,
                key
            ))
        end
        if key_type == "number" and valtype == false then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_bool_by_index(%s,%d,false);\n",
                table_name,
                key
            ))
        end
        if key_type == "number" and valtype == "table" then
            local sub_name = 'x' .. PrivateDarwin_cglobals_size
            PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
            PrivateDarwinEmbed_global_concat(string.format(
                'LuaCembedTable *%s = LuaCembed_new_anonymous_table(args);\n',
                sub_name
            ));
            PrivateDarwinEmbed_global_concat(string.format(
                'LuaCEmbedTable_set_sub_table_by_index(%s,%d,%s);\n',
                table_name,
                key,
                sub_name
            ));
            PrivateDarwinEmbed_c_table(original_name, sub_name, val)
        end

        if key_type == "string" and valtype == "number" then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_double_prop(%s,%s,%lf);\n",
                table_name,
                key,
                val
            ))
        end
        if key_type == "string" and valtype == "string" then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_string_prop(%s,%s,(char*)%s);\n",
                table_name,
                key,
                val
            ))
        end
        if key_type == "string" and valtype == true then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_bool_prop(%s,%s,true);\n",
                table_name,
                key
            ))
        end
        if key_type == "string" and valtype == false then
            PrivateDarwinEmbed_global_concat(string.format(
                "LuaCEmbedTable_set_bool_prop(%s,%s,false);\n",
                table_name,
                key
            ))
        end

        if key_type == "string" and valtype == "table" then
            local sub_name = 'x' .. PrivateDarwin_cglobals_size
            PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
            PrivateDarwinEmbed_global_concat(string.format(
                'LuaCembedTable *%s = LuaCembed_new_anonymous_table(args);\n',
                sub_name
            ));

            PrivateDarwinEmbed_global_concat(string.format(
                'LuaCEmbedTable_set_sub_table_prop(%s,%d,%s);\n',
                table_name,
                key,
                sub_name
            ));
            PrivateDarwinEmbed_c_table(original_name, sub_name, val)
        end
    end
end

---@param name string
---@param var any
function Private_embed_global_in_c(name, var)
    var_type = type(var)
    if var_type == "number" then
        PrivateDarwinEmbed_global_concat(
            string.format("LuaCEmbed_set_global_long(%s,%d);\n", name, var)
        )
    end
    if var_type == "boolean" then
        if var == true then
            PrivateDarwinEmbed_global_concat(
                string.format("LuaCEmbed_set_global_bool(%s,true);\n", name)
            )
        end
        if var == false then
            PrivateDarwinEmbed_global_concat(
                string.format("LuaCEmbed_set_global_bool(%s,false);\n", name)
            )
        end
    end
    if var_type == "string" then
        PrivateDarwinEmbed_global_concat(
            string.format(
                "LuaCEmbed_set_global_raw_string(%s,(char*)%s,%d);\n",
                PrivateDarwing_Create_c_str_buffer(var),
                string.len(var)
            )
        )
    end
    if var_type == "table" then
        local table_name = 'x' .. PrivateDarwin_cglobals_size
        PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
        PrivateDarwinEmbed_global_concat(string.format(
            'LuaCembedTable *%s = LuaCembed_new_global_table(args,"%s");\n',
            table_name,
            name
        ));
        PrivateDarwinEmbed_c_table(table_name, table_name, var)
    end

    if var_type == "nil" then
        error("nill cannot be serialized")
    end
    if var_type == "function" then
        error("functions cannot be  not serialized")
    end
end
