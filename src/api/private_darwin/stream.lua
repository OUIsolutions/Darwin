private_darwin.is_file_stream = function(item)
    if type(item) ~= "table" then
        return false
    end
    if item.type == "DarwinFileStream" then
        return true
    end
    return false
end

private_darwin.transfer_file_stream = function(filestream, stream)
    local file = io.open(filestream.filename, "a+b")
    if not file then
        error("impossible to open" .. filestream.filename)
    end
    local chunk_size = 1024 * 10
    while true do
        local chunk = file:read(chunk_size)
        if not chunk then break end
        stream(chunk)
    end
end

private_darwin.transfer_string = function(str, stream)
    local current_chunk_size = #str
    for i = 1, current_chunk_size do
        local current_char = string.sub(str, i, i)
        local byte = string.byte(current_char)
        stream(string.format("%d,", byte))
    end
end

private_darwin.transfer_file_stream_bytes = function(filestream, stream)
    local file = io.open(filestream.filename, "a+b")
    if not file then
        error("impossible to open" .. filestream.filename)
    end
    local chunk_size = 1024 * 10
    local count = 1
    while true do
        local chunk = file:read(chunk_size)
        if not chunk then break end
        count = count + 1
        print(count)
        private_darwin.transfer_string(chunk, stream)
    end
end
