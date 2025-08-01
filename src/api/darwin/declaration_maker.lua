darwin.make_declaration_of_c_definition = function (content)
    local inside_brackets = false 
    local inside_string = false
    local bracket_count = 0
    local final_content = ""
    local current_line = ""
    local i = 1
    
    while i <= #content do
        local char = content:sub(i, i)
        
        -- Handle string literals
        if char == '"' and (i == 1 or content:sub(i-1, i-1) ~= '\\') then
            inside_string = not inside_string
            current_line = current_line .. char
        elseif inside_string then
            current_line = current_line .. char
        -- Handle single-line comments (preserve them)
        elseif char == '/' and i < #content and content:sub(i+1, i+1) == '/' and not inside_string then
            -- Copy the entire comment line
            local comment = ""
            while i <= #content and content:sub(i, i) ~= '\n' do
                comment = comment .. content:sub(i, i)
                i = i + 1
            end
            if i <= #content then
                comment = comment .. content:sub(i, i) -- add the newline
            end
            
            if not inside_brackets then
                final_content = final_content .. comment
            end
        -- Handle multi-line comments (preserve them)
        elseif char == '/' and i < #content and content:sub(i+1, i+1) == '*' and not inside_string then
            -- Copy the entire multi-line comment
            local comment = ""
            comment = comment .. content:sub(i, i) .. content:sub(i+1, i+1) -- /*
            i = i + 2
            while i <= #content do
                comment = comment .. content:sub(i, i)
                if content:sub(i-1, i-1) == '*' and content:sub(i, i) == '/' then
                    break
                end
                i = i + 1
            end
            
            if not inside_brackets then
                final_content = final_content .. comment
            end
        -- Handle function body brackets
        elseif char == '{' and not inside_string then
            if not inside_brackets then
                -- This is the start of a function body
                inside_brackets = true
                bracket_count = 1
                
                -- Clean up the current line and convert to declaration
                local declaration = current_line:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
                if declaration ~= "" and declaration:match("[%w_]+%s*%(") then
                    final_content = final_content .. declaration .. ";\n"
                end
                current_line = ""
            else
                bracket_count = bracket_count + 1
            end
        elseif char == '}' and not inside_string and inside_brackets then
            bracket_count = bracket_count - 1
            if bracket_count == 0 then
                inside_brackets = false
            end
        elseif not inside_brackets then
            current_line = current_line .. char
        end
        
        i = i + 1
    end
    
    return final_content
end