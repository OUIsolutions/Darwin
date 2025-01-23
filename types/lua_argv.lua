-- file: src/types.lua

---@class Argv
---@field get_flag_size fun(flags:string[]|string):number
---@field get_flag_arg_by_index fun(flags:string[]|string,index:number,default:string | nil):string|nil
---@field flags_exist fun(flags:string[]):boolean
---@field get_flag_size_consider_only_first fun(flags:string[]|string):number
---@field get_flag_arg_by_index_consider_only_first fun(flags:string[]|string,index:number,default:string | nil):string|nil
---@field one_of_args_exist fun(arg:string[] | string):boolean
---@field get_total_args_size fun():number
---@field get_arg_by_index_not_adding_to_used fun(index:number):string
---@field get_arg_by_index fun(index:number):string | nil
---@field get_compact_flags fun(flags:string[]|string,index,default:string | nil):string|nil
---@field get_compact_flags_size fun(flags:string[]|string):number
---@field used_args number[]
---@field type fun(value:any):string
---@field argslist string[]
---@field substr_func fun(str:string,start:number,endnum:number):string
---@field get_str_size fun(str:string):number
---@field flag_identifiers string[]
---@field add_used_args_by_index fun(used_flag:number)
---@field get_total_unused_args fun():number
---@field get_unsed_arg_by_index fun(index:number):string|nil
---@field get_next_unused_index fun():number|nil
---@field get_next_unused fun():string|nil


---@class PrivateArgv
---@field starts_with fun(str:string,target:string):boolean
---@field get_array_size fun(array:table):number
---@field is_inside fun(array:table,item:any):boolean
---@field get_formmated_flag_if_its_a_flag fun(current_arg:string):string |nil



---@type PrivateArgv
private_luargv = private_luargv


---@type Argv
luargv = luargv



---@type PrivateArgv
private_luargv = private_luargv


---@type Argv
luargv = luargv
