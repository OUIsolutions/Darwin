---typestart
---@class Darwin
---@field create_project fun():DarwinProject

---@class DarwinProject
---@field lua_code string[]
---@field c_code string[]
---@field c_calls string[]
---@field embed_data PrivateDarwinEmbed[]
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(src:string)
---@field generate_lua_complex fun(props:LuaGenerationComplexProps)
---@field generate_lua_code fun(props:LuaGenerationCodeProps):string
---@field generate_lua_file fun(props:LuaGenerationOutputProps)
---typeend

darwin.create_project = function()
    local self_obj = {}
    private_darwin_project.construct_globals(self_obj)
    private_darwin_project.add_lua_methods(self_obj)
    return self_obj
end
