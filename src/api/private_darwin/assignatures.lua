
private_darwin.assignatures = {}

private_darwin.get_item_assignature = function(item)
    if darwin.dtw.isfile(item) then 
        return darwin.dtw.generate_sha_from_file(item)
    end
    if darwin.dtw.isdir(item) then
        return darwin.dtw.generate_sha_from_folder_by_last_modification(item)
    end
    return ""
end 

private_darwin.generate_assignature = function (elements)
    
    local hasher = darwin.dtw.newHasher()
    for i = 1, #elements do
        local current_item = elements[i]
        if not  private_darwin.assignatures[current_item] then 
            private_darwin.assignatures[current_item] = private_darwin.get_item_assignature(current_item)
        end 
        hasher.digest(private_darwin.assignatures[current_item])
    end
    return hasher.get_value()
end