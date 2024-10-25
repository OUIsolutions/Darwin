---@param name string
---@param var any
---@param mode Mode
function Embedglobal(name, var, mode)
    if mode == EMBEDC then
        Private_embed_global_in_c(name, var)
    end
end
