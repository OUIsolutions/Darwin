---comment
---@param str string
---@return string
function Create_c_str_buffer(str_code)
    local buffer = { "(unsigned char[]){" }
    local size = string.len(str_code)
    for i = 1, size do
        local current_char = string.sub(str_code, i, i)
        local byte = string.byte(current_char)
        buffer[#buffer + 1] = string.format("%d,", byte)
    end
    buffer[#buffer + 1] = "}"
    return table.concat(buffer, "")
end
