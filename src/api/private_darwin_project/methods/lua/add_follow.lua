private_darwin_project.add_lua_file_followin_require_recursively = function(selfob, src)
    local content = dtw.load_file(src)
    if not content then
        error("content of " .. src .. "not provided")
    end

    local NORMAL_STATE              = 1
    local WAITING_REQUIRE_STRING    = 2
    local COLLECTING_REQUIRE_STRING = 3
    local state                     = NORMAL_STATE
    local current_string_identifier = nil
    local require_buffer            = nil
    for i = 1, #content do
        local current_char = string.sub(content, i, i)
        if state == NORMAL_STATE then
            if private_darwin.is_string_at_point(content, i, "require") then
                state = WAITING_REQUIRE_STRING
                goto continue
            end
        end

        if state == WAITING_REQUIRE_STRING then
            if current_char == "(" then
                goto continue
            end
            if current_char == '"' then
                state = COLLECTING_REQUIRE_STRING
                current_string_identifier = current_char
                goto continue
            end
        end

        if state == COLLECTING_REQUIRE_STRING then
            if current_char == current_string_identifier then
                print(require_buffer)
                state = NORMAL_STATE
                goto continue
            end
            require_buffer = require_buffer .. current_char
        end

        ::continue::
    end
end

private_darwin_project.add_lua_file_followin_require = function(selfobj, src)
    private_darwin_project.add_lua_file(src)
    private_darwin_project.add_lua_file_followin_require_recursively(selfobj, src)
end
