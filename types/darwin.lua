---@alias DarwinGlobalMode "lua"| "c"

---@class Darwin
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(filename:string)
---@field generate_lua_code fun():string
---@field generate_lua_output fun(filename:string)
---@field generate_c_executable_code fun():string
---@field generate_c_executable_output fun(filename:string)
---@field generate_c_lib_code fun():string
---@field generate_c_lib_output fun(filename:string)
---@field add_c_code fun (code:string)
---@field c_include fun (lib:string)
---@field add_c_internal fun(code:string)
---@field load_lualib_from_c fun(function_name:string,object_name:string)
---@field call_c_func fun(function_name:string)
---@field add_c_file fun (filename:string, folow_includes:boolean | nil, include_verifier:fun(import:string,path:string):boolean | nil)
---@field embedglobal fun (name:string, var:any, mode:DarwinGlobalMode|nil)


---@type Darwin
darwin = darwin
