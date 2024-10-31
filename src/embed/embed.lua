---@param name string
---@param var any
---@param mode "c" | "lua"
function Embedglobal(name, var, mode)
    if PrivateDarwin_is_inside(PrivateDawring_cglobals_already_setted, name) then
        error("var " .. name .. "already setted")
    end
    local var_type = type(var)
    PrivateDawring_cglobals_already_setted[#PrivateDawring_cglobals_already_setted + 1] = name

    if not PrivateDarwin_is_inside({ "string", "number", "table", "boolean" }, var_type) then
        error("invalid val on " .. name)
    end

    if not mode then
        mode = "c"
    end
    if mode == "c" then
        Private_embed_global_in_c(name, var, var_type)
    end
    if mode == "lua" then
        Private_embed_global_in_lua(name, var, var_type)
    end
end
