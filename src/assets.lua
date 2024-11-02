private_darwin.count_bars = function(str)
    local total = 0
    for i = 1, #str do
        if string.sub(str, i, i) == "/" then
            total = total + 1
        end
    end
    return total
end
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
            if current.path ~= src then
                local formmated_path = string.sub(current.path, #src + 2, #current.path)
                result[#result + 1] = formmated_path
            end
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
