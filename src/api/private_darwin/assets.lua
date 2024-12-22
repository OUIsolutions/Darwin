---typestart
---@class Asset
---@field path string
---@field content string


---@class PrivateDarwin
---@field get_asset fun(asset_struct:Asset[],src:string):string | nil
---@field list_assets_recursivly fun(asset_struct:Asset[],strc:string):string[]
---typeend

private_darwin.get_asset = function(asset_struct, src)
    for i = 1, #asset_struct do
        local current = asset_struct[i]
        if current.path == src then
            return current.content
        end
    end
    return nil
end


private_darwin.list_assets_recursivly = function(asset_struct, src)
    local result = {}

    for i = 1, #asset_struct do
        local current = asset_struct[i]
        if private_darwin.starts_with(current.path, src .. "/") then
            local formmated_path = string.sub(current.path, #src + 2, #current.path)
            result[#result + 1] = formmated_path
        end
    end
    return result
end
private_darwin.list_assets = function(src)
    local values = private_darwin.list_assets_recursivly(src)
    local valid_values = {}
    for i = 1, #values do
        local current = values[i]
        if private_darwin.count_bars(current) == 0 then
            valid_values[#valid_values + 1] = current
        end
    end
    return valid_values
end
