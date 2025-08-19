private_darwin.transfer_byte_direct_stream = function(str, stream)
    local current_chunk_size = #str
    for i = 1, current_chunk_size do
        local current_char = string.sub(str, i, i)
        local byte = string.byte(current_char)
        stream(string.format("%d,", byte))
    end
end

private_darwin.transfer_byte_internal_format = function(str, stream)
    local current_chunk_size = #str
    local data = {}
    for i = 1, current_chunk_size do
        local current_char = string.sub(str, i, i)
        local byte = string.byte(current_char)
        data[#data + 1] = string.format("%d,", byte)
    end
    stream(table.concat(data))
end

private_darwin.transfer_byte_size_decide = function(str, stream)
    local limit = darwin.chunk_size
    if #str > limit then
        private_darwin.transfer_byte_direct_stream(str, stream)
        return
    end
    private_darwin.transfer_byte_internal_format(str, stream)
end

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

    while true do
        local chunk = file:read(math.floor(darwin.chunk_size))
        print("\t\t chunck:",chunk,"size :",darwin.chunk_size,"absolute:",math.floor(darwin.chunk_size))
        if not chunk then break end
        stream(chunk)
    end
end

private_darwin.transfer_file_stream_bytes = function(filestream, stream)
    local file = io.open(filestream.filename, "a+b")
    if not file then
        error("impossible to open" .. filestream.filename)
    end


    local count = 0
    while true do
        local chunk = file:read(math.floor(darwin.chunk_size))
        if chunk then
            count = count + #chunk
            --print("transfed: " .. count)
        end
        if not chunk then break end
        private_darwin.transfer_byte_internal_format(chunk, stream)
    end
end
