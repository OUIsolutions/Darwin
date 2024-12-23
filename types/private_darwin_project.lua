---@class PrivateDarwinProject
---@field construct_globals fun(selfobj:DarwinProject)
---@field add_lua_methods fun(selfobj:DarwinProject )

---@class PrivateDarwinProject
---@field add_lua_code fun(selfobj:DarwinProject,code:string)
---@field add_lua_file fun(selfobj:DarwinProject,src:string)
---@field add_lua_file_followin_require fun(selfobj:DarwinProject,src:string)
---@field add_lua_file_followin_require_recursively fun(selfobj:DarwinProject,src:string)

---@class PrivateDarwinProject
---@field embed_global_in_lua fun(name:string,var:table | number | boolean | string,streammed_shas:string[], stream:fun(data:string))
---@field embed_table_in_lua fun(name:string,var:table,streamed_shas:string[],stream:fun(data:string))
---@field create_lua_str_buffer fun(str:string,streamed_shas:string[], stream:fun(data:string)):string
---@field create_lua_stream_buffer fun(filestream:DarwinFileStream ,streamed_shas:string[], stream:fun(data:string)):string


---@class PrivateDarwinProject
---@field embed_global fun(selfobj:DarwinProject,name:string,value:table | string | boolean | number | DarwinFileStream)
---@class PrivateDarwinProject
---@field generate_lua_complex fun(selfobj:DarwinProject,props:LuaGenerationComplexProps)
---@field generate_lua_code fun(selfobj:DarwinProject,props:LuaGenerationCodeProps):string
---@field generate_lua_file fun(selfobj:DarwinProject,props:LuaGenerationOutputProps)

---@type PrivateDarwinProject
private_darwin_project = private_darwin_project
