
---@param entry string
---@param output string
---@param output_mode string
function create_lua_project(entry_mode,project,output,output_mode)


    if not handle_main_file(project) then
        return
    end
    
    
    if not handle_unused() then
        return
    end

    
    project.generate_lua_file({
        output = output,
        include_embed_data = true
    })
    
end 