---@param str string
---@return string
function PrivateDarwing_Create_c_str_buffer(str_code)
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

---@param str_code string
---@return string
function PrivateDarwin_create_lua_str_buffer(str_code)
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

---@param text string
---@param old string
---@param new string
---@return string
function PrivateDarwingreplace_simple(text, old, new)
    local start_pos = text:find(old)
    if start_pos then
        return text:sub(1, start_pos - 1) .. new .. text:sub(start_pos + #old)
    else
        return text -- Retorna a string original se não encontrar
    end
end

---@param target_table table
---@param value any
function is_inside(target_table, value)
    for i = 1, #target_table do
        if target_table[i] == value then
            return true
        end
    end
    return false
end
