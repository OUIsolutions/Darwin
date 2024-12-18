darwin.create_project = function()
    local self_obj = {}
    private_darwin_project.construct_globals(self_obj)
    private_darwin_project.add_lua_methods(self_obj)
    return self_obj
end
