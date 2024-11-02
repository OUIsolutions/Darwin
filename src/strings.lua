private_darwin.replace_simple = function(text, old, new)
    local start_pos = text:find(old)
    if start_pos then
        return text:sub(1, start_pos - 1) .. new .. text:sub(start_pos + #old)
    else
        return text -- Retorna a string original se não encontrar
    end
end
private_darwin.is_string_at_point = function(str, target, point)
    local possible = string.sub(str, point, point + #target - 1)
    if possible == target then
        return true
    end
    return false
end

private_darwin.starts_with = function(str, target)
    return private_darwin.is_string_at_point(str, target, 0)
end
