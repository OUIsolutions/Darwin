private_darwin_project.construct_globals = function(self_obj)
    self_obj.lua_code = {}
    self_obj.c_code = {}
    self_obj.c_calls = {}
    self_obj.embed_data = {}
    self_obj.embed_lua_requires = {}
    self_obj.required_funcs  = {}
    self_obj.so_includeds= {}
end
