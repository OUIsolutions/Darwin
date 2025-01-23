---@class PrivateDarwinProject
---@field construct_globals fun(selfobj:DarwinProject)
---@field add_lua_methods fun(selfobj:DarwinProject )
---@field add_c_external_code fun(selfobj:DarwinProject,code:string)
---@field add_c_include fun(selfobj:DarwinProject,include:string)
---@field add_c_file fun(selfobj:DarwinProject,filename:string, follow_includes:boolean, verifier_callback:(fun(import:string,path:string):boolean))
---@field add_c_call fun(selfobj:DarwinProject,func_name:string)
---@field load_lib_from_c fun(selfobj:DarwinProject, lib_start_func:string, lua_obj:string)

---@class PrivateDarwinProject
---@field add_lua_code fun(selfobj:DarwinProject,code:string)
---@field add_lua_file fun(selfobj:DarwinProject,src:string)
---@field is_required_included fun(self_obj:DarwinProject, include:string):boolean
---@field is_so_includeds fun(self_obj:DarwinProject, include:string):boolean
---@field add_lua_file_followin_require fun(selfobj:DarwinProject,src:string)
---@field add_lua_file_followin_require_recursively fun(selfobj:DarwinProject,src:string)
---@field create_c_str_buffer fun(str_code:string,str_shas:string[],stream:fun(data:string)):string
---@field embed_c_table fun(current_table:table,increment:(fun():number), streamed_shas:string[], stream:fun(data:string)):string
---@field embed_global_in_c fun(name:string, var:any, streamed_shas:string[], stream:fun(data:string), increment:(fun():string))
---@field generate_c_complex fun(selfobj:DarwinProject,props:DarwinCGenerationComplexProps)
---@field generate_c_code fun(selfobj:DarwinProject,props:DarwinCGenerationCodeProps):string
---@field generate_c_file fun(selfobj:DarwinProject,props:DarwinCGenerationFileProps)
---@field generate_c_lib_complex fun(selfobj:DarwinProject,props:DarwinCLIBGenerationComplexProps)
---@field generate_c_lib_code fun(selfobj:DarwinProject,props:DarwinCLIBGenerationCodeProps):string
---@field generate_c_lib_file fun(selfobj:DarwinProject,props:DarwinCLIBGenerationFileProps)

---@class PrivateDarwinProject
---@field add_c_methods fun(selfobj:DarwinProject)
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
