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
