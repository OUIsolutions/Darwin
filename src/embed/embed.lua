---@param name string
---@param var any
---@param mode "c" | "lua"
function Embedglobal(name, var, mode)
    if mode == "c" then
        Private_embed_global_in_c(name, var)
    end
end
