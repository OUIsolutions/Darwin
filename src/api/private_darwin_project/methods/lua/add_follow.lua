
private_darwin_project.is_required_included = function(self_obj, include)
    for i=1,#self_obj.required_funcs do
        if self_obj.required_funcs[i].name == include then
            return true
        end
    end
end

private_darwin_project.is_so_includeds = function(self_obj, include)
    for i=1,#self_obj.so_includeds do
        if self_obj.so_includeds[i].name == include then
            return true
        end
    end
end

private_darwin_project.create_include_stream = function(self_obj, include,relative_path)

    if relative_path == nil then
        relative_path = ""
    end
    include_format = private_darwin.replace_str(include, ".", "/")

    local possibles = {
        string.format("/usr/share/lua/%s/%s.lua", _VERSION, include_format),
        string.format("/usr/share/lua/%s/%s/init.lua", _VERSION, include_format),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, include_format),
        string.format("/usr/lib64/lua/%s/%s.lua", _VERSION, include_format),
        string.format("/usr/lib64/lua/%s/%s/init.lua", _VERSION, include_format),
        string.format("%s/./%s.lua",relative_path, include_format),
        string.format("%s/./%s/init.lua",relative_path, include_format),
        string.format("/usr/lib64/lua/%s/%s.so", _VERSION, include_format),
        string.format("/usr/lib64/lua/%s/loadall.so", _VERSION),
        string.format("%s/./%s.so",relative_path, include_format),
    }

    for i=1,#possibles do
        local current = possibles[i]
        if not darwin.dtw.isfile(current) then                        
            goto continue
        end

        if private_darwin.ends_with(current, ".lua") then
           --- means its already included
           if private_darwin_project.is_required_included(self_obj,include) then
                return 
           end
           self_obj.required_funcs[#self_obj.required_funcs + 1] = {
                comptime_included = include,
                content  = darwin.file_stream(current)
            }
            return  current
        end

        if private_darwin.ends_with(current, ".so") then
            --- means its already included
            if private_darwin_project.is_so_includeds(self_obj,include) then
                return 
            end
            self_obj.so_includeds[#self_obj.so_includeds + 1] = {
                comptime_included = include,
                content  = darwin.file_stream(current)
            }
            return nil
        end
        ::continue::
    end
    error("impossible to find: " .. include)

end 

private_darwin_project.add_lua_file_followin_require_recursively = function(selfobj, src,relative_path)
    local content = darwin.dtw.load_file(src)
    if not content then
        error("content of " .. src .. " not found")
    end
    local inside_comment = false
    local inside_string = false
    local string_starter_char = 0
    local last_string_start_point = 0
    local last_string_end_point = 0
    local i = 1
    local acumulative_scape = 0
    local is_a_scape = false
    local waiting_required_string = false    
    local required_call_point = 0

    local waiting_package_string = false
    local package_call_point = 0

    while i < #content do


        ---------------------------Comment Tester ------------------------------------------

        if not inside_comment and not inside_string then
            local comment_start = private_darwin.is_string_at_point(content, "--", i)
     
            if comment_start then
                inside_comment = true
            end
        end

        if inside_comment then
            local comment_end = private_darwin.is_string_at_point(content, "\n", i)
   
            if comment_end then
                inside_comment = false
            end
        end
        ----------------------------String Tester---------------------------------------------
        if not inside_comment and not inside_string then
            local is_small_string_start = private_darwin.is_string_at_point(content, "'", i)
        
            if is_small_string_start then
                inside_string = true
                string_starter_char = "'"
                last_string_start_point = i 
            end
        end

        if not inside_comment and not inside_string then
            local is_median_string_start = private_darwin.is_string_at_point(content, '"', i)
 
            if is_median_string_start then
                inside_string = true
                string_starter_char = '"'
                last_string_start_point = i 
            end
        end

        if not inside_comment and not inside_string then
            local is_big_string_start = private_darwin.is_string_at_point(content, '[[', i)
 
            if is_big_string_start then
                inside_string = true
                string_starter_char = "[["
                last_string_start_point = i
            end
        end
        if inside_string and string_starter_char == "'" and i > last_string_start_point and not is_a_scape then
            local is_small_string_end = private_darwin.is_string_at_point(content, "'", i)

            if is_small_string_end then
                inside_string = false
                last_string_end_point = i 
            end
        end

        if inside_string and string_starter_char == '"' and i > last_string_start_point and not is_a_scape then
            local is_medium_string_end = private_darwin.is_string_at_point(content, '"', i)
  
            if is_medium_string_end then
                inside_string = false
                last_string_end_point = i
            end
        end

        if inside_string and string_starter_char == "[[" and i > last_string_start_point and not is_a_scape then
            local is_big_string_end = private_darwin.is_string_at_point(content, "]]", i)

            if is_big_string_end then
                inside_string = false
                last_string_end_point = i+1
            end
        end

        if inside_string then
            local current_char = string.sub(content, i, i)
            if current_char == "\\" then
                acumulative_scape = acumulative_scape + 1
            else
                acumulative_scape = 0
            end
            is_a_scape = acumulative_scape % 2 == 1
        end
        if not inside_string and not inside_comment then
            local is_require_start = private_darwin.is_one_of_string_at_point(content,{ "require ","require("}, i)

            if is_require_start then
                waiting_required_string = true
                required_call_point = i
                i = i + #"require"
            end

            local is_package_start = private_darwin.is_one_of_string_at_point(content,{ "package.loadlib ","package.loadlib("}, i)

            if is_package_start then
                waiting_package_string = true
                package_call_point = i
                i = i + #"package.loadlib"
            end
        end
            
        if (waiting_package_string or waiting_required_string ) and not inside_string then
            local current_char = string.sub(content, i, i)
            --print(string.sub(content, i-5, i).."("..current_char..")"..string.sub(content, i, i+5))
            local valid_chars = {"(", ")", " ",'"',"'","[","]", ","}
            if not private_darwin.is_inside(valid_chars,current_char) then
                error("invalid package call at:("..src..") only raw string is allowed ")
            end
        end 

        -- means it found a required call
        if waiting_required_string and not inside_string and last_string_start_point > required_call_point then
            local require_string = string.sub(content, last_string_start_point, last_string_end_point)            
            local identifier_size = string.len(string_starter_char)

            require_string = string.sub(require_string, identifier_size+1, string.len(require_string) - identifier_size)
            point =  private_darwin_project.create_include_stream(selfobj, require_string, relative_path)
            waiting_required_string = false
            if point then
                private_darwin_project.add_lua_file_followin_require_recursively(selfobj, point,relative_path)
            end
        end
        if waiting_package_string and not inside_string and last_string_start_point > package_call_point then
            
            local package_string = string.sub(content, last_string_start_point, last_string_end_point)
            local identifier_size = string.len(string_starter_char)
            package_string = string.sub(package_string, identifier_size+1, string.len(package_string) - identifier_size)
            
            if relative_path  then
                package_string_path = relative_path .. "/" .. package_string
            end

            if not private_darwin_project.is_so_includeds(selfobj,package_string) then
                selfobj.so_includeds[#selfobj.so_includeds + 1] = {
                    comptime_included = package_string,
                    content  = darwin.file_stream(package_string_path)
                }
                 
            end
    
            waiting_package_string = false
    
        end

        i = i + 1
    end
end

private_darwin_project.add_lua_file_followin_require = function(selfobj, src,relative_path)
    private_darwin_project.add_lua_file(selfobj, src)
    private_darwin_project.add_lua_file_followin_require_recursively(selfobj, src,relative_path)
end
