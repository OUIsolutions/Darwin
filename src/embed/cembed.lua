function PrivateEmbed_global_concat(value)
    PrivateDarwin_cglobals = PrivateDarwin_cglobals .. value
end

---@param name string
---@param var any
function Private_embed_global_in_c(name, var)
    var_type = type(var)
    if var_type == "number" then
        PrivateEmbed_global_concat(
            string.format("LuaCEmbed_set_global_long(%s,%d);\n", name, var)
        )
    end
    if var_type == "boolean" then
        if var == true then
            PrivateEmbed_global_concat(
                string.format("LuaCEmbed_set_global_bool(%s,true);\n", name)
            )
        end
        if var == false then
            PrivateEmbed_global_concat(
                string.format("LuaCEmbed_set_global_bool(%s,false);\n", name)
            )
        end
    end
end
