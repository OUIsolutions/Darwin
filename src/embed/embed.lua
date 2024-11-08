darwin.embedglobal = function(name, var, mode)
    if private_darwin.is_inside(private_darwin.globals_already_setted, name) then
        error("var " .. name .. "already setted")
    end
    local var_type = type(var)
    private_darwin.globals_already_setted[# private_darwin.globals_already_setted + 1] = name

    if not private_darwin.is_inside({ "string", "number", "table", "boolean" }, var_type) then
        error("invalid val on " .. name)
    end

    if not mode then
        mode = "c"
    end


    if mode == "c" then
        private_darwin.embed_global_in_c(name, var, var_type)
    elseif mode == "lua" then
        private_darwin.embed_global_in_lua(name, var, var_type)
    else
        error("mode " .. mode .. " not in " .. '"lua"|"c"')
    end
end
