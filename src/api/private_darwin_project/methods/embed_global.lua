---typestart
---@class PrivateDarwinProject
---@field embed_global fun(selfobj:DarwinProject ,name:string,value:string | number | table | boolean| PrivateDarwinFileStream)


---@class PrivateDarwinFileStream
---@field type string
---@field filename string


---@class PrivateDarwinEmbed
---@field name string
---@field value table | string | number | boolean
---typeend

private_darwin_project.embed_global = function(self_obj, name, value)
    for i = 1, #self_obj.embed_data do
        if self_obj.embed_data[i].name == name then
            error("data with name " .. name .. " its already setted")
        end
    end
    self_obj.embed_data[#self_obj.embed_data + 1] = {
        name = name,
        value = value
    }
end
