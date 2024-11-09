---@alias DarwinGlobalMode "lua"| "c"

---@class Darwin
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(filename:string)
---@field generate_lua_code fun():string
---@field generate_lua_output fun(filename:string)
---@field generate_c_executable_code fun(include_e_luacembed:boolean | nil):string
---@field generate_c_executable_output fun(filename:string,include_e_luacembed:boolean | nil)
---@field generate_c_lib_code fun(libname:string,object_export:string,include_e_luacembed:boolean | nil):string
---@field generate_c_lib_output fun(libname:string,object_export:string,filename:string,include_e_luacembed:boolean | nil)
---@field add_c_code fun (code:string)
---@field c_include fun (lib:string)
---@field add_c_internal fun(code:string)
---@field load_lualib_from_c fun(function_name:string,object_name:string)
---@field call_c_func fun(function_name:string)
---@field add_c_file fun (filename:string, folow_includes:boolean | nil, include_verifier:fun(import:string,path:string):boolean | nil)
---@field embed_global fun (name:string, var:any, mode:DarwinGlobalMode|nil)
---@field unsafe_add_lua_code_following_require fun(start_filename:string)

---@type Darwin
darwin = darwin
