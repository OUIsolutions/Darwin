private_darwin.resset_lua = function()
    private_darwin.main_lua_code          = ""
    private_darwin.require_parse_to_bytes = false
    private_darwin.lua_str_shas_code      = ""
    private_darwin.generated_lua_str_shas = {}
    private_darwin.lua_modules            = {}
end

private_darwin.resset_c = function()
    private_darwin.cglobals_size        = 1
    private_darwin.cglobals             = ""
    private_darwin.c_str_shas_code      = ""
    private_darwin.generated_c_str_shas = {}


    private_darwin.include_code     = ""
    private_darwin.c_calls          = {}

    private_darwin.lua_globals_size = 1
    private_darwin.lua_globals      = ""
end

private_darwin.resset_all = function()
    ---basic functions

    private_darwin.string = string
    private_darwin.table = table

    private_darwin.globals_already_setted = {}
    private_darwin.shared_libs = {}

    private_darwin.resset_lua()
    private_darwin.resset_c()
end
