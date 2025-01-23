private_darwin_project.generate_c_complex = function(selfobj, props)
    local include_lua_cembed = true
    if props.include_lua_cembed ~= nil then
        include_lua_cembed = props.include_lua_cembed
    end

    for i = 1, #selfobj.c_external_code do
        props.stream("\n")
        local current = selfobj.c_external_code[i]
        if private_darwin.is_file_stream(current) then
            private_darwin.transfer_file_stream(current, props.stream)
        else
            props.stream(current)
        end
    end



    if include_lua_cembed then
        local lua_cembedd = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "LuaCEmbed.h")
        props.stream(lua_cembedd)
    end


    props.stream([[
        int main(int argc, char **argv) {
        LuaCEmbed  *darwin_main_obj = newLuaCEmbedEvaluation();
        LuaCEmbedTable *args_table =LuaCembed_new_global_table(darwin_main_obj,"arg");
        for(int i =0; i <argc;i++) {
                LuaCEmbedTable_append_string(args_table,argv[i]);
        }
    ]])


    local streamed_shas = {}
    local total_tables = 0
    local increment = function()
        total_tables = total_tables + 1
        return total_tables
    end

    props.stream("LuaCEmbed_load_native_libs(darwin_main_obj);\n")
    for i = 1, #selfobj.embed_data do
        local current = selfobj.embed_data[i]
        private_darwin_project.embed_global_in_c(current.name, current.value, streamed_shas, props.stream, increment)
    end
    props.stream("unsigned char lua_code[] = {");
    local function current_stream(data)
        private_darwin.transfer_byte_size_decide(data, props.stream)
    end
    private_darwin_project.generate_lua_complex(selfobj, {
        stream = current_stream,
        include_embed_data = false
    })
    props.stream("0};\n")
    for i = 1, #selfobj.c_main_code do
        local current = selfobj.c_main_code[i]
        props.stream(current);
        props.stream("\n");
    end


    props.stream([[
        LuaCEmbed_evaluate(darwin_main_obj, "%s", (const char*)lua_code);
        if (LuaCEmbed_has_errors(darwin_main_obj)) {
            printf("Error: %s\n", LuaCEmbed_get_error_message(darwin_main_obj));
            LuaCEmbed_free(darwin_main_obj);
            return 1;
        }
        LuaCEmbed_free(darwin_main_obj);
        return 0;
    }]])


   
end

private_darwin_project.generate_c_code = function(selfobj, props)
    local content = {}
    local function stream(data)
        content[#content + 1] = data
    end
    private_darwin_project.generate_c_complex(selfobj, {
        stream = stream,
        include_lua_cembed = props.include_lua_cembed
    })
    return table.concat(content)
end



private_darwin_project.generate_c_file = function(selfobj, props)
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

    private_darwin_project.generate_c_complex(selfobj, {
        stream = stream,
        include_lua_cembed = props.include_lua_cembed
    })
    if file then
        file:close()
    end
end
