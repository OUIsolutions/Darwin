---@class Actions
---@field description string
---@field name string
---@field callback fun()

---@class PrivateDarwinModuleInternal
---@field item string
---@field content string

---@class PrivateDarwinSHaredLib
---@field sha_item string
---@field content string

---@class PrivateDarwin
---@field main fun()
---@field actions Actions[]
---@field is_inside fun(target_table:table,value:any):boolean
---@field main_lua_code string
---@field cglobals_size number
---@field cglobals string
---@field include_code string
---@field c_calls string[]
---@field require_parse_to_bytes boolean
---@field lua_globals_size  number
---@field lua_globals  string
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
---@field darwin_execcode string
---@field OPEN string
---@field CLOSE string
---@field BREAK_LINE string
---@field PERCENT string
---@field ask_yes_or_no fun(question:string):boolean
---@field list_assets fun(src:string):string[]
---@field list_assets_recursivly fun(src:string):string[]
---@field get_asset fun(path:string):string | nil
---@field starts_with fun(str:string,target:string):boolean
---@field count_bars fun(str:string):number
---@field project_name string
---@field lib_name string
---@field object_export string
---@field include_lua_cembed boolean
---@field resset_lua fun()
---@field resset_c fun()
---@field resset_all fun()
---@field create_c_str_bufer fun(value:string):string
---@field create_lua_str_buffer fun(value:string):string
---@field lua_str_shas_code string
---@field generated_lua_str_shas string[]
---@field c_str_shas_code string
---@field generated_c_str_shas string[]
---@field globals_already_setted string[]
---@field lua_modules PrivateDarwinModuleInternal[]
---@field construct_possible_files string[]
---@field shared_libs  PrivateDarwinSHaredLib[]
---@field embed_shared_lib fun(filename:string):string
---@field shared_libs_were_embed boolean
---@type PrivateDarwin
private_darwin = private_darwin
