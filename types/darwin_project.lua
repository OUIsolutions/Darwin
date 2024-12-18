---@class DarwinProject
---@field lua_code string[]
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
---@field unsafe_add_lua_code_following_require fun(start_filename:string,shared_lib_import:boolean | nil)

---@class PrivateDarwinProject
---@field create_project_globals fun(self:DarwinProject)

---@type PrivateDarwinProject
private_darwin_project = private_darwin_project
