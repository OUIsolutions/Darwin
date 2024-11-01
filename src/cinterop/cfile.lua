---@param contents_list string[]
---@param already_included string[]
---@param filename string
---@param include_verifier function |nil
function PrivateDarwin_Addcfile(contents_list, already_included, filename, include_verifier)
    local file = io.open(filename, "r")
    if not file then
        error("file " .. filename .. " not provided")
    end
    local content = file:read("a")
    file:close()
    if PrivateDarwin_is_inside(already_included, content) then
        return
    end
    already_included[#already_included + 1] = content
    local START_STATE                       = 0
    local WAITING_INCLUDE                   = 1
    local COLLECTING_FILE                   = 2
    local INSIDE_INLINE_COMMENT             = 3
    local INSIDE_BLOCK_COMMENT              = 4
    local INSIDE_CHAR                       = 5
    local INSIDE_STRING                     = 6
    local state                             = START_STATE
    local current_dir                       = PrivateDarwin_extract_dir(filename)
    local actual_filename                   = ""
    local VALID_CHAR_BUFFER                 = {
        INSIDE_STRING,
        INSIDE_CHAR,
        START_STATE,
        INSIDE_INLINE_COMMENT,
        INSIDE_BLOCK_COMMENT
    }

    for i = 1, #content do
        local current_char = string.sub(content, i, i)
        local last_char = string.sub(content, i - 1, i - 1)

        if state == START_STATE and current_char == "'" then
            state = INSIDE_CHAR
        end
        if state == INSIDE_CHAR and current_char == "'" then
            state = START_STATE
        end
        if state == START_STATE and current_char == '"' then
            state = INSIDE_STRING
        end
        if state == INSIDE_STRING and current_char == '"' and last_char ~= '"' then
            state = START_STATE
        end


        if state == START_STATE and PrivateDarwin_is_string_at_point(content, "//", i) then
            state = INSIDE_INLINE_COMMENT
        end

        if state == INSIDE_INLINE_COMMENT and current_char == "\n" then
            state = START_STATE
        end


        if state == START_STATE and PrivateDarwin_is_string_at_point(content, "/*", i) then
            state = INSIDE_BLOCK_COMMENT
        end


        if state == INSIDE_BLOCK_COMMENT and PrivateDarwin_is_string_at_point(content, "*/", i) then
            state = START_STATE
        end


        if PrivateDarwin_is_string_at_point(content, "#include", i) then
            state = WAITING_INCLUDE
        end

        if state == WAITING_INCLUDE and last_char == "<" then
            state = START_STATE
            --anulate the inclusion because its a local inclusion
            contents_list[#contents_list + 1] = "#include <"
        end
        if state == WAITING_INCLUDE and last_char == '"' then
            state = COLLECTING_FILE
        end

        if state == COLLECTING_FILE and current_char ~= '"' then
            actual_filename = actual_filename .. current_char
        end

        if PrivateDarwin_is_inside(VALID_CHAR_BUFFER, state) then
            contents_list[#contents_list + 1] = current_char
        end

        --- ends collecting the filename
        if state == COLLECTING_FILE and current_char == '"' then
            local path = current_dir .. actual_filename
            local include = true
            if include_verifier then
                if not include_verifier(actual_filename, path) then
                    include = false
                end
            end
            if include then
                PrivateDarwin_Addcfile(contents_list, already_included, path, include_verifier)
            end

            actual_filename = ""
            state = START_STATE
        end
    end
    contents_list[#contents_list + 1] = "\n"
end

---@param filename string
---@param folow_includes boolean | nil
---@param include_verifier function |nil
function Add_c_file(filename, folow_includes, include_verifier)
    if not folow_includes then
        local content = io.open(filename)
        if not content then
            error("file " .. filename .. "not provided")
        end
        Add_c_code(content:read("a"))
        content:close()
        return
    end
    local contents_list = {}
    local already_included = {}
    PrivateDarwin_Addcfile(contents_list, already_included, filename, include_verifier)
    Addccode(table.concat(contents_list, ""))
end
