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
        error("impossible to open", filestream.filename)
    end
    local chunk_size = 1024
    while true do
        local chunk = file:read(chunk_size)
        if not chunk then break end
        stream(chunk)
    end
end
