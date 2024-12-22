---typestart
---@class PrivateDarwinProject
---@field construct_globals fun(selfobj:DarwinProject)

---typeend

private_darwin_project.construct_globals = function(self_obj)
    self_obj.lua_code = {}
    self_obj.c_code = {}
    self_obj.c_calls = {}
    self_obj.embed_data = {}
end
