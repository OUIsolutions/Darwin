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

    local assets_dirs = darwin.dtw.list_dirs_recursively("assets", false)
    for i = 1, #assets_dirs do
        local current_item          = assets_dirs[i]
        ---removing / at the end of the the dir
        current_item                = string.sub(current_item, 0, #current_item - 1)
        api_assets[#api_assets + 1] = {
            path = current_item
        }
    end

    project.embed_global("PRIVATE_DARWIN_API_ASSETS", api_assets)
end
