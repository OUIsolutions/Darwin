private_darwin.get_asset = function(src)
    for i = 1, #PRIVATE_DARWIN_ASSETS do
        local current = PRIVATE_DARWIN_ASSETS[i]
        if current.path == src then
            return current.content
        end
    end
    return nil
end

private_darwin.list_assets_recursivly = function(src)
    local result = {}
    for i = 1, #PRIVATE_DARWIN_ASSETS do
        local current = PRIVATE_DARWIN_ASSETS[i]
        if private_darwin.starts_with(current.path, src) then
            result[#result + 1] = current.path
        end
    end
    return result
end
private_darwin.list_assets = function(src)
    local result = {}
    for i = 1, #PRIVATE_DARWIN_ASSETS do
        local current = PRIVATE_DARWIN_ASSETS[i]
        if private_darwin.starts_with(current.path, src) then
        end
    end
    return result
end
