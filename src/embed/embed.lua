---@param name string
---@param var any
---@param mode "c" | "lua"
function Embedglobal(name, var, mode)
    if is_inside(PrivateDawring_cglobals_already_setted, name) then
        error("var " .. name .. "already setted")
    end

    if not mode then
        mode = "c"
    end
    if mode == "c" then
        Private_embed_global_in_c(name, var)
    end
    if mode == "lua" then
        Private_embed_global_in_lua(name, var)
    end
end
