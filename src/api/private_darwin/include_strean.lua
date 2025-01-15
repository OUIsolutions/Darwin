

private_darwin.get_included_file_stream = function(include,relative_path)

    if relative_path == nil then
        relative_path = ""
    end

    local possibles = {
        string.format("/usr/share/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/share/lua/%s/%s/init.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, item),
        string.format("/usr/lib64/lua/%s/%s/init.lua", _VERSION, item),
        string.format("%s./%s.lua",relative_path, item),
        string.format("%s./%s/init.lua",relative_path, item),
        string.format("/usr/lib64/lua/%s/%s.so", _VERSION, item),
        string.format("/usr/lib64/lua/%s/loadall.so", _VERSION),
        string.format("%s./%s.so",relative_path, item),
    }
    for i=1,#possibles do
        local current = possibles[i]
        if dtw.is_file(current) then
            return darwin.file_stream(current)
        end
    end
    error("unknow include " .. include)

end 