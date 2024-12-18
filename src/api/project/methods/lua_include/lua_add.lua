private_darwin_project.add_lua_code = function(self_obj, code)
    self_obj.lua_code[#self_obj.lua_code + 1] = code
end

private_darwin_project.add_lua_file = function(self_obj, src)
    local content = dtw.load_file(src)
    if not content then
        error("content of", src, "not found")
    end
    private_darwin_project.add_lua_code(self_obj, content)
end
