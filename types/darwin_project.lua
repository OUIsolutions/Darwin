---@class DarwinProject
---@field lua_code (DarwinFileStream | string)[]
---@field c_code string[]
---@field c_calls string[]
---@field embed_data PrivateDarwinEmbed[]
---@field c_external_code (DarwinFileStream | string)[]
---@field c_main_code  (DarwinFileStream | string)[]
---@field required_funcs DarwinEmbedCode[]
---@field so_includeds DarwinEmbedCode[]
---@field project_name string

---- methods
---@class DarwinProject
---@field add_c_external_code fun(code:string)
---@field add_c_include fun(include:string)
---@field add_c_file fun(filename:string, follow_includes:boolean, verifier_callback:(fun(import:string,path:string):boolean))
---@field add_c_call fun(func_name:string)
---@field load_lib_from_c fun(lib_start_func:string, lua_obj:string)
---@field generate_c_complex fun(props:DarwinCGenerationComplexProps)
---@field generate_c_code fun(props:DarwinCGenerationCodeProps):string
---@field generate_c_file fun(props:DarwinCGenerationFileProps)
---@field generate_c_lib_complex fun(props:DarwinCLIBGenerationComplexProps)
---@field generate_c_lib_code fun(props:DarwinCLIBGenerationCodeProps):string
---@field generate_c_lib_file fun(props:DarwinCLIBGenerationFileProps)
---@field embed_global fun(name:string,value:table | string | number |boolean | DarwinFileStream)
---@field add_lua_code fun(code:string)
---@field add_lua_file fun(src:string)
---@field generate_lua_complex fun(props:LuaGenerationComplexProps)
---@field generate_lua_code fun(props:LuaGenerationCodeProps):string
---@field generate_lua_file fun(props:LuaGenerationOutputProps)
---@field add_lua_file_followin_require fun(src:string,relative_path:string)
