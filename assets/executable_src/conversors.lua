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
