---@class PrivateDarwin
---@field get_asset fun(asset_struct:Asset[],src:string):string
---@field list_assets_recursivly fun(asset_struct:Asset[],src:string):string[]
---@field list_assets fun(asset_struct:Asset[],src:string):string[]
---@field is_file_stream fun(item:any):boolean
---@field transfer_file_stream fun(filestream:DarwinFileStream, stream:fun(data:string))
---@field transfer_file_stream_bytes fun(filestream:DarwinFileStream, stream:fun(data:string))
---@field transfer_byte_direct_stream fun(str:string,stream:fun(data:string))
---@field transfer_byte_internal_format fun(str:string,stream:fun(data:string))
---@field transfer_byte_size_decide fun(str:string,stream:fun(data:string))

---@class PrivateDarwin
---@field is_inside fun(array:any[],value:any):boolean
---@field count_bars fun(src:string):number
---@field extract_dir fun(src:string):string

---@class PrivateDarwin
---@field is_string_at_point fun(str:string,target:string,point:number):boolean
---@field starts_with fun(str:string,target:string):boolean


---@type PrivateDarwin
private_darwin = private_darwin
