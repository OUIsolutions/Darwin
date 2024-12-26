private_darwin_project.add_lua_file_followin_require_recursively = darwin.watcher.create_function(
    "add_lua_file_followin_require_recursively", function(selfobj, src)
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

        while i < #content do
            darwin.watcher.plotage_point("main loop", function()
                darwin.watcher.plot_var("inside_comment", inside_comment)
                darwin.watcher.plot_var("inside_string", inside_string)
                darwin.watcher.plot_var("string_starter", string_starter_char)
                darwin.watcher.plot_var("i", i)
                darwin.watcher.plot_var('last_string_start', last_string_start_point)
                darwin.watcher.plot_var('last_string_end', last_string_end_point)
                darwin.watcher.plot_var('string_starter_char', string_starter_char)
                darwin.watcher.plot_var('acumulative_scape', acumulative_scape)
                darwin.watcher.plot_var('is_a_scape', is_a_scape)
                darwin.watcher.plot_var('waiting_required_string', waiting_required_string)

                if last_string_start_point and last_string_end_point then
                    darwin.watcher.plot_var("last_string",
                        string.sub(content, last_string_start_point, last_string_end_point))
                end
            end)
            ---------------------------Comment Tester ------------------------------------------

            if not inside_comment and not inside_string then
                local comment_start = private_darwin.is_string_at_point(content, "--", i)
                darwin.watcher.plotage_point("checking comment start", function()
                    darwin.watcher.plot_var("comment_start", comment_start)
                end)
                if comment_start then
                    inside_comment = true
                end
            end

            if inside_comment then
                local comment_end = private_darwin.is_string_at_point(content, "\n", i)
                darwin.watcher.plotage_point("checking comment end", function()
                    darwin.watcher.plot_var("comment end", comment_end)
                end)
                if comment_end then
                    inside_comment = false
                end
            end
            ----------------------------String Tester---------------------------------------------
            if not inside_comment and not inside_string then
                local is_small_string_start = private_darwin.is_string_at_point(content, "'", i)
                darwin.watcher.plotage_point("check small string start", function()
                    darwin.watcher.plot_var("is_small_string_start", is_small_string_start)
                end)
                if is_small_string_start then
                    inside_string = true
                    string_starter_char = "'"
                    last_string_start_point = i + #"'"
                end
            end

            if not inside_comment and not inside_string then
                local is_median_string_start = private_darwin.is_string_at_point(content, '"', i)
                darwin.watcher.plotage_point("check normal string start", function()
                    darwin.watcher.plot_var("is_median_string_start", is_median_string_start)
                end)
                if is_median_string_start then
                    inside_string = true
                    string_starter_char = '"'
                    last_string_start_point = i + #'"'
                end
            end

            if not inside_comment and not inside_string then
                local is_big_string_start = private_darwin.is_string_at_point(content, '[[', i)
                darwin.watcher.plotage_point("check big string start", function()
                    darwin.watcher.plot_var("is_big_string_start", is_big_string_start)
                end)
                if is_big_string_start then
                    inside_string = true
                    string_starter_char = "[["
                    last_string_start_point = i + #'[['
                end
            end
            if inside_string and string_starter_char == "'" and i > last_string_start_point and not is_a_scape then
                local is_small_string_end = private_darwin.is_string_at_point(content, "'", i)
                darwin.watcher.plotage_point("check small string end", function()
                    darwin.watcher.plot_var("is_small_string_end", is_small_string_end)
                end)
                if is_small_string_end then
                    inside_string = false
                    last_string_end_point = i - 1
                end
            end

            if inside_string and string_starter_char == '"' and i > last_string_start_point and not is_a_scape then
                local is_medium_string_end = private_darwin.is_string_at_point(content, '"', i)
                darwin.watcher.plotage_point("check medium string end", function()
                    darwin.watcher.plot_var("is_medium_string_end", is_medium_string_end)
                end)
                if is_medium_string_end then
                    inside_string = false
                    last_string_end_point = i - 1
                end
            end

            if inside_string and string_starter_char == "[[" and i > last_string_start_point and not is_a_scape then
                local is_big_string_end = private_darwin.is_string_at_point(content, "]]", i)
                darwin.watcher.plotage_point("check big string end", function()
                    darwin.watcher.plot_var("is_big_string_end", is_big_string_end)
                end)
                if is_big_string_end then
                    inside_string = false
                    last_string_end_point = i - 1
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
                local is_require_start = private_darwin.is_string_at_point(content, "require", i)
                darwin.watcher.plotage_point("check require start", function()
                    darwin.watcher.plot_var("is_big_string_end", is_require_start)
                end)
                if is_require_start then
                    waiting_required_string = true
                    required_call_point = i
                    i = i + #"require"
                end
            end

            -- means it found a required call
            if waiting_required_string and not inside_string and last_string_start_point > required_call_point then
                local require_string = string.sub(content, last_string_start_point, last_string_end_point)
                darwin.watcher.plotage_point("require string", function()
                    darwin.watcher.plot_var("require_string", require_string)
                end)
                waiting_required_string = false
            end



            i = i + 1
        end
    end)

private_darwin_project.add_lua_file_followin_require = function(selfobj, src)
    private_darwin_project.add_lua_file(selfobj, src)
    private_darwin_project.add_lua_file_followin_require_recursively(selfobj, src)
end
