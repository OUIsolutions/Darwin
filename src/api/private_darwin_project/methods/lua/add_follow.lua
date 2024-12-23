private_darwin_project.add_lua_file_followin_require_recursively = function(selfob, src)
    local content = darwin.dtw.load_file(src)
    if not content then
        error("content of " .. src .. "not provided")
    end

    local SMALL_STRING              = 1
    local NORMAL_STRING             = 2
    local BIG_STRING                = 3

    local NORMAL_STATE              = 1
    local WAITING_REQUIRE_STRING    = 2
    local COLLECTING_REQUIRE_STRING = 3
    local INSIDE_COMMENT            = 4
    local state                     = NORMAL_STATE
    local current_string_identifier = 0
    local require_buffer            = ""
    local i                         = 1

    while true do
        if i > #content then
            break
        end
        --print("char:" .. string.sub(content, i, i) .. "state: " .. state .. " identifier" .. current_string_identifier)
        if private_darwin.is_string_at_point(content, "\\", i) then
            goto continue
        end

        if state == NORMAL_STATE then
            if private_darwin.is_string_at_point(content, "require", i) then
                state = WAITING_REQUIRE_STRING
                i = i + #"require" - 1
                goto continue
            end
            if private_darwin.is_string_at_point(content, "--", i) then
                state = INSIDE_COMMENT
                goto continue
            end
        end
        if state == INSIDE_COMMENT then
            if private_darwin.is_string_at_point(content, "\n", i) then
                state = NORMAL_STATE
                goto continue
            end
        end

        if state == WAITING_REQUIRE_STRING then
            if private_darwin.is_string_at_point(content, "(", i) then
                goto continue
            elseif private_darwin.is_string_at_point(content, " ", i) then
                goto continue
            elseif private_darwin.is_string_at_point(content, "'", i) then
                state = COLLECTING_REQUIRE_STRING
                current_string_identifier = SMALL_STRING
                goto continue
            elseif private_darwin.is_string_at_point(content, '"', i) then
                state = COLLECTING_REQUIRE_STRING
                current_string_identifier = NORMAL_STRING
                goto continue
            elseif private_darwin.is_string_at_point(content, "[[", i) then
                state                     = COLLECTING_REQUIRE_STRING
                current_string_identifier = BIG_STRING
                i                         = i + #"[[" - 1

                goto continue
            else
                error("invalid value at require index: " .. i .. " of file" .. src)
            end
        end

        if state == COLLECTING_REQUIRE_STRING then
            local found_end = false
            if current_string_identifier == SMALL_STRING then
                if private_darwin.is_string_at_point(content, "'", i) then
                    found_end = true
                end
            end
            if current_string_identifier == NORMAL_STRING then
                if private_darwin.is_string_at_point(content, '"', i) then
                    found_end = true
                end
            end
            if current_string_identifier == BIG_STRING then
                if private_darwin.is_string_at_point(content, ']]', i) then
                    found_end = true
                end
            end

            if found_end then
                print(require_buffer)
                state = NORMAL_STATE
                require_buffer = ""
                current_string_identifier = 0
                goto continue
            end

            if not found_end then
                require_buffer = require_buffer .. string.sub(content, i, i)
            end
        end

        ::continue::
        i = i + 1
    end
end

private_darwin_project.add_lua_file_followin_require = function(selfobj, src)
    private_darwin_project.add_lua_file(selfobj, src)
    private_darwin_project.add_lua_file_followin_require_recursively(selfobj, src)
end
