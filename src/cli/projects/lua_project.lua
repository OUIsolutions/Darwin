
---@param entry string
---@param output string
---@param output_mode string
function create_lua_project(project,output,output_mode)

    project.generate_lua_file({
        output = output,
        include_embed_data = true
    })
    
end 