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
---@field create_project fun():DarwinProject
---@type Darwin
darwin = darwin
