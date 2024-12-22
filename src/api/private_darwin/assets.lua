private_darwin.get_asset = function(asset_struct, src)
    for i = 1, #asset_struct do
        local current = asset_struct[i]
        if current.path == src then
            return current.content
        end
    end
    error("unknow asset" .. src)
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
private_darwin.list_assets = function(asset_struct, src)
    local values = private_darwin.list_assets_recursivly(asset_struct, src)
    local valid_values = {}
    for i = 1, #values do
        local current = values[i]
        if private_darwin.count_bars(current) == 0 then
            valid_values[#valid_values + 1] = current
        end
    end
    return valid_values
end
