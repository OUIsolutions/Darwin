---@class Darwin
---@field Addlua_code fun(code:string)
---@field Addluafile fun(filename:string)
---@field generate_lua_code fun():string
---@field generate_lua_output fun(filename:string)
---@field generate_c_executable_code fun():string
---@field generate_c_executable_output fun(filename:string)

---@class PrivateDarwin
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




---@type string
PRIVATE_DARWIN_LUA_CEMBED = PRIVATE_DARWIN_LUA_CEMBED

---@type string[]
PRIVATE_DARWIN_ASSETS = PRIVATE_DARWIN_ASSETS

---@type Darwin
darwin = darwin

---@type PrivateDarwin
private_darwin = private_darwin
