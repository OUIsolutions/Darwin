---@alias DarwinGlobalMode "lua"| "c"

---@class Darwin
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(filename:string)
---@field generate_lua_code fun():string
---@field generate_lua_output fun(filename:string)
---@field generate_c_executable_code fun():string
---@field generate_c_executable_output fun(filename:string)
---@field add_c_code fun (code:string)
---@field c_include fun (lib:string)
---@field add_c_internal fun(code:string)
---@field load_lualib_from_c fun(function_name:string,object_name:string)
---@field call_c_func fun(function_name:string)
---@field add_c_file fun (filename:string, folow_includes:boolean | nil, include_verifier:fun(import:string,path:string):boolean | nil)
---@field embedglobal fun (name:string, var:any, mode:DarwinGlobalMode|nil)

---@class PrivateDarwin
---@field is_inside fun(target_table:table,value:any):boolean
---@field main_lua_code string
---@field cglobals_size number
---@field cglobals string
---@field include_code string
---@field c_calls string
---@field require_parse_to_bytes boolean
---@field lua_globals_size  number
---@field lua_globals  string
---@field cglobals_already_setted string[]
---@field create_c_str_buffer fun(str_code:string):string
---@field create_lua_str_buffer fun(str_code:string):string
---@field replace_simple fun(text:string,old:string,new:string):string
---@field is_string_at_point fun(str:string,target:string,point:number):boolean
---@field extract_dir fun(path:string):string
---@field addcfile_internal fun(contents_list:string[], already_included:string[], filename:string, include_verifier:fun(import:string,path:string):boolean)
---@field c_global_concat fun(value:string)
---@field embed_c_table fun(original_name:string, table_name:string, current_table:table)
---@field embed_global_in_c fun(name:string, var:any, var_type:type)
---@field embed_lua_global_concat fun(value:string)
---@field embed_lua_table fun(table_name:string, current_table:table)
---@field embed_global_in_lua fun(name:string, var:any, var_type:type)
---@field print_color fun(color:string,text:string)
---@field print_green fun(text:string)
---@field print_blue fun(text:string)
---@field print_red fun(text:string)

---@type string
PRIVATE_DARWIN_LUA_CEMBED = PRIVATE_DARWIN_LUA_CEMBED

---@type string[]
PRIVATE_DARWIN_ASSETS = PRIVATE_DARWIN_ASSETS

---@type Darwin
darwin = darwin

---@type PrivateDarwin
private_darwin = private_darwin
