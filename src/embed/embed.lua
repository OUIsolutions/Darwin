---@param name string
---@param var any
---@param mode "c" | "lua"
function Embedglobal(name, var, mode)
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
