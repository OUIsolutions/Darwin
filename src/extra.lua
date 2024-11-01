private_darwin.create_c_str_buffer = function(str_code)
    local buffer = { "{" }
    local size = string.len(str_code)
    for i = 1, size do
        local current_char = string.sub(str_code, i, i)
        local byte = string.byte(current_char)
        buffer[#buffer + 1] = string.format("%d,", byte)
    end
    buffer[#buffer + 1] = "0}"
    return table.concat(buffer, "")
end


private_darwin.create_lua_str_buffer = function(str_code)
    PrivateDarwin_require_parse_to_bytes = true
    local buffer = { "table.concat(PrivateDarwing_parse_to_bytes({" }
    local size = string.len(str_code)
    for i = 1, size do
        local current_char = string.sub(str_code, i, i)
        local byte = string.byte(current_char)
        buffer[#buffer + 1] = string.format("%d,", byte)
    end

    buffer[#buffer + 1] = "}))"
    return table.concat(buffer, "")
end


private_darwin.replace_simple = function(text, old, new)
    local start_pos = text:find(old)
    if start_pos then
        return text:sub(1, start_pos - 1) .. new .. text:sub(start_pos + #old)
    else
        return text -- Retorna a string original se não encontrar
    end
end

---@param target_table table
---@param value any
function PrivateDarwin_is_inside(target_table, value)
    for i = 1, #target_table do
        if target_table[i] == value then
            return true
        end
    end
    return false
end

private_darwin.is_string_at_point = function(str, target, point)
    local possible = string.sub(str, point, point + #target - 1)
    if possible == target then
        return true
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
