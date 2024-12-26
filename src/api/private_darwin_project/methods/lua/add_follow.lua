private_darwin_project.add_lua_file_followin_require_recursively = nil

private_darwin_project.add_lua_file_followin_require = function(selfobj, src)
    private_darwin_project.add_lua_file(selfobj, src)
    --private_darwin_project.add_lua_file_followin_require_recursively(selfobj, src)
end
