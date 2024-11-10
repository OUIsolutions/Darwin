---@alias DarwinGlobalMode "lua"| "c"

---@class DarwinLuaGeneratorCodeProps
---@field temp_shared_lib_dir string | nil

---@class DarwinLuaGeneratorOutputProps
---@field temp_shared_lib_dir string | nil
---@field output_name string

---@class DarwinCExecutableProps
---@field temp_shared_lib_dir string | nil
---@field include_lua_cembed boolean | nil

---@class DarwinCOutputProps
---@field temp_shared_lib_dir string | nil
---@field include_lua_cembed boolean | nil
---@field output_name string

---@class DarwinClibProps
---@field libname  string
---@field object_export string
---@field include_e_luacembed boolean | nil
---@field temp_shared_lib_dir string | nil
---@field shared_lib_embed_mode DarwinGlobalMode | nil

---@class DarwinClibOutputProps
---@field output_name string
---@field libname  string
---@field object_export string
---@field include_e_luacembed boolean | nil
---@field temp_shared_lib_dir string | nil
---@field shared_lib_embed_mode DarwinGlobalMode | nil


---@class Darwin
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(filename:string)
---@field generate_lua_code fun(props: DarwinLuaGeneratorCodeProps | nil):string
---@field generate_lua_output fun(props: DarwinLuaGeneratorOutputProps)
---@field generate_c_executable_code fun(props : DarwinCExecutableProps | nil):string
---@field generate_c_executable_output fun(props: DarwinCOutputProps)
---@field generate_c_lib_code fun(props: DarwinClibProps):string
---@field generate_c_lib_output fun(props:DarwinClibOutputProps)
---@field add_c_code fun (code:string)
---@field c_include fun (lib:string)
---@field add_c_internal fun(code:string)
---@field load_lualib_from_c fun(function_name:string,object_name:string)
---@field call_c_func fun(function_name:string)
---@field add_c_file fun (filename:string, folow_includes:boolean | nil, include_verifier:fun(import:string,path:string):boolean | nil)
---@field embed_global fun (name:string, var:any, mode:DarwinGlobalMode|nil)
---@field embed_shared_libs fun( mode:DarwinGlobalMode|nil)
---@field unsafe_add_lua_code_following_require fun(start_filename:string)
---@type Darwin
darwin = darwin
