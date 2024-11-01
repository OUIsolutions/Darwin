private_darwin.c_global_concat = function(value)
    PrivateDarwin_cglobals = PrivateDarwin_cglobals .. value
end


private_darwin.embed_c_table = function(original_name, table_name, current_table)
    for key, val in pairs(current_table) do
        local key_type = type(key)
        local valtype = type(val)

        if not private_darwin.is_inside({ "string", "number" }, key_type) then
            error("invalid key on " .. original_name)
        end
        if not private_darwin.is_inside({ "string", "number", "table", "boolean" }, key_type) then
            error("invalid val on " .. original_name)
        end

        if key_type == "number" and valtype == "number" then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_double_by_index(%s,%d,%f);\n",
                table_name,
                key - 1,
                val
            ))
        end

        if key_type == "number" and valtype == "string" then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_raw_string_by_index(%s,%d,(const char *)(unsigned  char[])%s,%d);\n",
                table_name,
                key - 1,
                private_darwin.create_c_str_buffer(val),
                string.len(val)
            ))
        end

        if key_type == "number" and val == true then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_bool_by_index(%s,%d,true);\n",
                table_name,
                key - 1
            ))
        end
        if key_type == "number" and val == false then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_bool_by_index(%s,%d,false);\n",
                table_name,
                key - 1
            ))
        end
        if key_type == "number" and valtype == "table" then
            local sub_name = 'x' .. PrivateDarwin_cglobals_size
            PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
            private_darwin.c_global_concat(string.format(
                'LuaCEmbedTable *%s = LuaCembed_new_anonymous_table(main_obj);\n',
                sub_name
            ));
            private_darwin.c_global_concat(string.format(
                'LuaCEmbedTable_set_sub_table_by_index(%s,%d,%s);\n',
                table_name,
                key - 1,
                sub_name
            ));
            private_darwin.embed_c_table(original_name, sub_name, val)
        end

        if key_type == "string" and valtype == "number" then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_double_prop(%s,%q,%f);\n",
                table_name,
                key,
                val
            ))
        end


        if key_type == "string" and valtype == "string" then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_raw_string_prop(%s,%q,(const char *)(unsigned  char[])%s,%d);\n",
                table_name,
                key,
                private_darwin.create_c_str_buffer(val),
                string.len(val)
            ))
        end
        if key_type == "string" and val == true then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_bool_prop(%s,%q,true);\n",
                table_name,
                key
            ))
        end
        if key_type == "string" and val == false then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_bool_prop(%s,%q,false);\n",
                table_name,
                key
            ))
        end

        if key_type == "string" and valtype == "table" then
            local sub_name = 'x' .. PrivateDarwin_cglobals_size
            PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
            private_darwin.c_global_concat(string.format(
                'LuaCEmbedTable *%s = LuaCembed_new_anonymous_table(main_obj);\n',
                sub_name
            ));

            private_darwin.c_global_concat(string.format(
                'LuaCEmbedTable_set_sub_table_prop(%s,%q,%s);\n',
                table_name,
                key,
                sub_name
            ));
            private_darwin.embed_c_table(original_name, sub_name, val)
        end
    end
end


private_darwin.embed_global_in_c = function(name, var, var_type)
    if var_type == "number" then
        private_darwin.c_global_concat(
            string.format('LuaCEmbed_set_global_double(main_obj,"%s",%f);\n', name, var)
        )
    end
    if var_type == "boolean" then
        if var == true then
            private_darwin.c_global_concat(
                string.format('LuaCEmbed_set_global_bool(main_obj,"%s",true);\n', name)
            )
        end
        if var == false then
            private_darwin.c_global_concat(
                string.format('LuaCEmbed_set_global_bool(main_obj,"%s",false);\n', name)
            )
        end
    end
    if var_type == "string" then
        private_darwin.c_global_concat(
            string.format(
                'LuaCEmbed_set_global_raw_string(main_obj,"%s",(const char *)(unsigned  char[])%s,%d);\n',
                name,
                private_darwin.create_c_str_buffer(var),
                string.len(var)
            )
        )
    end
    if var_type == "table" then
        local table_name = 'x' .. PrivateDarwin_cglobals_size
        PrivateDarwin_cglobals_size = PrivateDarwin_cglobals_size + 1
        private_darwin.c_global_concat(string.format(
            'LuaCEmbedTable *%s = LuaCembed_new_global_table(main_obj,"%s");\n',
            table_name,
            name
        ));
        private_darwin.embed_c_table(table_name, table_name, var)
    end
end
