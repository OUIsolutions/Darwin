private_darwin.is_inside = function(target_table, value)
    for i = 1, #target_table do
        if target_table[i] == value then
            return true
        end
    end
    return false
end


private_darwin.extract_dir = function(path)
    local i = string.len(path)
    while i > 0 do
        local current_char = string.sub(path, i, i)
        if current_char == '/' then
            return string.sub(path, 1, i)
        end
        i = i - 1
    end
    return ""
end


private_darwin.count_bars = function(str)
    local total = 0
    for i = 1, #str do
        if string.sub(str, i, i) == "/" then
            total = total + 1
        end
    end
    return total
end
