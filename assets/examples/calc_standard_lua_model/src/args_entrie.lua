local args_module = {}
---@param arg_num number
args_module.get_arg_number = function(arg_num)
    local possible = arg[arg_num]
    if not possible then
        return nil
    end
    local converted = tonumber(possible)
    if not converted then
        return nil
    end
    return converted
end

args_module.get_operator = function()
    local operator = arg[3]
    local VALID_OPERATORS = { "+", "-", "x", "/" }
    for i = 1, #VALID_OPERATORS do
        if operator == VALID_OPERATORS[i] then
            return operator
        end
    end
    return nil
end

return args_module
