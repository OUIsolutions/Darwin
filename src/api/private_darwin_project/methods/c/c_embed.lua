
private_darwin_project.create_c_str_buffer = function(str_code, streamed_shas, stream)
    local name = string.format("private_darwin_sha%s", darwin.dtw.generate_sha(str_code))
    if private_darwin.is_inside(streamed_shas, name) then
        return name
    end
    streamed_shas[#streamed_shas + 1] = name
    stream(string.format(
        "unsigned char %s[] ={",
        name
    ))
    private_darwin.transfer_byte_size_decide(str_code, stream)
    stream("\n}\n")
    return name
end


private_darwin_project.embed_c_table = function(var,acumulator, streamed_shas,stream)
    stream("LuaCEmbedTable *private_darwin_table%d = LuaCembed_new_anonymous_table(darwin_main_obj);\n")
    
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
            stream(string.format(
                "LuaCEmbedTable_set_double_by_index(%s,%d,%f);\n",
                table_name,
                key - 1,
                val
            ))
        end

        if key_type == "number" and valtype == "string" then
            private_darwin.c_global_concat(string.format(
                "LuaCEmbedTable_set_raw_string_by_index(%s,%d,(const char*)%s,%d);\n",
                table_name,
                key - 1,
                private_darwin.create_c_str_bufer(val),
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
            local sub_name = 'x' .. private_darwin.cglobals_size
            private_darwin.cglobals_size = private_darwin.cglobals_size + 1
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
                "LuaCEmbedTable_set_raw_string_prop(%s,%q,(const char *)%s,%d);\n",
                table_name,
                key,
                private_darwin.create_c_str_bufer(val),
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
            local sub_name = 'x' .. private_darwin.cglobals_size
            private_darwin.cglobals_size = private_darwin.cglobals_size + 1
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


private_darwin_project.embed_global_in_c = function(name, var, var_type,streamed_shas,stream)
    if var_type == "number" then
        stream(
            string.format('LuaCEmbed_set_global_double(main_obj,"%s",%f);\n', name, var)
        )
    end
    if var_type == "boolean" then
        if var == true then
            stream(
                string.format('LuaCEmbed_set_global_bool(main_obj,"%s",true);\n', name)
            )
        end
        if var == false then
            stream(
                string.format('LuaCEmbed_set_global_bool(main_obj,"%s",false);\n', name)
            )
        end
    end
    if var_type == "string" then
        local sha_name = private_darwin_project.create_c_str_buffer(var, streamed_shas, stream)
        stream( string.format('LuaCEmbed_set_global_raw_string(main_obj,"%s",%s)',sha_name,sha_name))
        
    end
    if var_type == "table" then        
        private_darwin_project.embed_c_table(var,streamed_shas,stream)
    end
end