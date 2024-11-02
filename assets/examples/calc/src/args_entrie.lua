---@param arg_num number
function get_arg_number(arg_num)
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

function get_operator()
    local operator        = arg[3]
    local VALID_OPERATORS = { "+", "-", "*", "/" }
    for i = 1, #VALID_OPERATORS do
        if VALID_OPERATORS[i] == operator then
            return operator
        end
    end
    return nil
end
