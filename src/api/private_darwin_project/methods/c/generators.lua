private_darwin_project.generate_c_complex = function(selfobj, props)
    
    local include_lua_cembed = true
    if props.include_lua_cembed ~= nil then
        include_lua_cembed = props.include_lua_cembed
    end
    if include_lua_cembed then
        local lua_cembedd = private_darwin.get_asset(PRIVATE_DARWIN_API_ASSETS, "LuaCEmbed.h")
        props.stream(lua_cembedd)
    end
    props.stream("int main(int argc, char **argv) {\n")
    props.stream("LuaCEmbed  *darwin_main_obj = newLuaCEmbedEvaluation();\n")
    props.stream("LuaCEmbed_load_native_libs(darwin_main_obj);\n")
    props.stream("unsigned char lua_code[] = {");
    local function current_stream(data)
        private_darwin.transfer_byte_size_decide(data, props.stream)
    end 
    private_darwin_project.generate_lua_complex(selfobj, {
        stream = current_stream, 
        include_embed_data = false
    })
    props.stream("};\n")
    props.stream('LuaCEmbed_evaluate(darwin_main_obj,"%s", (const char*)lua_code);\n')
    props.stream("if(LuaCEmbed_has_errors(darwin_main_obj)) {\n")
    props.stream("    printf(\"Error: %s\\n\", LuaCEmbed_get_error_message(darwin_main_obj));\n")
    props.stream("    LuaCEmbed_free(darwin_main_obj);\n")
    props.stream("    return 1;\n")
    props.stream("}\n")
    props.stream("LuaCEmbed_free(darwin_main_obj);\n")
    props.stream("return 0;\n")
    props.stream("\n}");
end

private_darwin_project.generate_c_code = function(selfobj, props)
    local content = {}
    local function stream(data)
        content[#content + 1] = data
    end
    private_darwin_project.generate_c_complex(selfobj, {
        stream = stream,
        include_embed_data = props.include_embed_data
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
        include_embed_data = props.include_embed_data
    })
    if file then
        file:close()
    end
end