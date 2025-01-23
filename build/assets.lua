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
