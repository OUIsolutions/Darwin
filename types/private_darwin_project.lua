---@class PrivateDarwinProject
---@field construct_globals fun(selfobj:DarwinProject)
---@field add_lua_methods fun(selfobj:DarwinProject )

---@class PrivateDarwinProject
---@field add_lua_code fun(selfobj:DarwinProject,code:string)
---@field add_lua_file fun(selfobj:DarwinProject,src:string)


---@class PrivateDarwinProject
---@field embed_global fun(selfobj:DarwinProject,name:string,value:table | string | boolean | number)
---@class PrivateDarwinProject
---@field generate_lua_complex fun(selfobj:DarwinProject,props:LuaGenerationComplexProps)
---@field generate_lua_code fun(selfobj:DarwinProject,props:LuaGenerationCodeProps):string
---@field generate_lua_file fun(selfobj:DarwinProject,props:LuaGenerationOutputProps)

---@type PrivateDarwinProject
private_darwin_project = private_darwin_project
