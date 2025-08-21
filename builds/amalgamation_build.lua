function Create_api_assets(project)
    ---@type Asset[]
    local api_assets = {}

    local assets_files = darwin.dtw.list_files_recursively("assets/api", false)
    for i = 1, #assets_files do
        local current_item = assets_files[i]
        local path = "assets/api/" .. current_item
        api_assets[#api_assets + 1] = {
            path = current_item,
            content = darwin.dtw.load_file(path)
        }
    end

    project.embed_global("PRIVATE_DARWIN_API_ASSETS", api_assets)

    local cli_assets = {}
    local cli_files = darwin.dtw.list_files_recursively("assets/cli", false)
    for i = 1, #cli_files do
        local current_item = cli_files[i]
        local path = "assets/cli/" .. current_item
        cli_assets[#cli_assets + 1] = {
            path = current_item,
            content = darwin.dtw.load_file(path)
        }
    end

    project.embed_global("PRIVATE_DARWIN_CLI_ASSETS", cli_assets)
end

function Embed_c_code(project)
    project.add_c_file("dependencies/CTextEngineOne.c")
    project.add_c_external_code("#define error LuaError\n")
    project.add_c_file("assets/api/LuaCEmbedOne.c")
    project.add_c_external_code("#undef error\n")
    project.add_c_file("dependencies/doTheWorldOne.c")
    project.add_c_file("dependencies/lua_c_amalgamator_dependencie_not_included.c")
    project.add_c_file("dependencies/silverchain_no_dependecie_included.c")
    project.add_c_file("dependencies/luaDoTheWorld_no_dep.c")
    project.add_c_file("dependencies/luaFluidJson_no_dep.c")
    project.add_c_file("dependencies/MDeclareApiNoDependenciesIncluded.h")
    project.add_c_file("dependencies/luamdeclare.c")
    project.add_c_file("dependencies/candangoEngine.c")
    project.load_lib_from_c("luaopen_luamdeclare", "private_darwin_luamdeclare")
    project.load_lib_from_c("luaopen_lua_c_amalgamator", "private_darwin_camalgamator")
    project.load_lib_from_c("luaopen_lua_silverchain", "private_darwin_silverchain")
    project.load_lib_from_c("load_luaDoTheWorld", "private_darwin_dtw")
    project.load_lib_from_c("load_lua_fluid_json", "private_darwin_json")
    project.load_lib_from_c("luaopen_CandangoEngine_start_point", "private_darwin_candango")
end


function amalgamation_build()

    local project = darwin.create_project("darwin")
    Embed_c_code(project)
    Create_api_assets(project)

    project.add_lua_code("darwin = {}")
    if darwin.argv.one_of_args_exist("build_linux") then
        project.add_lua_code("darwin.os = 'linux'")
    end
    if darwin.argv.one_of_args_exist("build_windows") then
        project.add_lua_code("darwin.os = 'windows'")
    end
    project.add_lua_code("darwin.dtw=private_darwin_dtw")
    project.add_lua_code("darwin.json=private_darwin_json")
    project.add_lua_code("darwin.mdeclare=private_darwin_luamdeclare")
    project.add_lua_code("darwin.candango=private_darwin_candango")
    project.add_lua_code("darwin.camalgamator=private_darwin_camalgamator")
    project.add_lua_code("darwin.silverchain = private_darwin_silverchain")
    local lua_argv_content = darwin.dtw.load_file("dependencies/luargv.lua")
    project.add_lua_code(string.format(
        "darwin.argv = function()\n %s\n end \n",
        lua_argv_content
    ))
    project.add_lua_code("darwin.argv = darwin.argv()")


    local lua_ship_content = darwin.dtw.load_file("dependencies/LuaShip.lua")
    project.add_lua_code(string.format(
        "darwin.ship = function()\n %s\n end \n",
        lua_ship_content
    ))
    project.add_lua_code("darwin.ship = darwin.ship()")




    project.add_lua_code("private_darwin = {}")

    project.add_lua_code("private_darwin_project = {}")
    local src_files = darwin.dtw.list_files_recursively("src", true)
    for i = 1, #src_files do
        local current = src_files[i]
        project.add_lua_code("-- file " .. current)
        project.add_lua_file(current)
    end


    project.add_lua_code("private_darwin.main()")
    project.generate_lua_file({ output = "debug.lua" })
    project.generate_c_file({output="release/amalgamation.c",include_lua_cembed=false})
end


darwin.add_recipe({
    name="amalgamation",
    description="make a single file amalgamation of the project",
    outs={"release/amalgamation.c"},
    callback=amalgamation_build
})