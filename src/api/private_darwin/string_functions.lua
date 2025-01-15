private_darwin.is_string_at_point = function(str, target, point)
    local possible = string.sub(str, point, point + #target - 1)
    if possible == target then
        return true
    end
    return false
end

private_darwin.starts_with = function(str, target)
    return private_darwin.is_string_at_point(str, target, 1)
end
private_darwin.ends_with = function(str, target)
    return private_darwin.is_string_at_point(str, target, #str - #target + 1)
end
private_darwin.replace_str = function(str, target, replacement)
    local result = ""
    local i = 1
    while i <= #str do
        local current_char = string.sub(str, i, i)
        if private_darwin.is_string_at_point(str, target, i) then
            result = result .. replacement
            i = i + #target
        else
            result = result .. current_char
            i = i + 1
        end
    end
    return result
end