---@param contents_list string[]
---@param already_included string[]
---@param filename string
function PrivateDarwin_Addcfile(contents_list, already_included, filename)
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

    local COLLECTING_CHAR = 0
    local WAITING_INCLUDE = 1
    local COLLECTING_FILE = 2
    local state = COLLECTING_CHAR
    local current_dir = PrivateDarwin_extract_dir(filename)
    local actual_filename = current_dir

    for i = 1, #content do
        local current_char = string.sub(content, i, i)
        local last_char = string.sub(content, i - 1, i - 1)
        if PrivateDarwin_is_string_at_point(content, "#include", i) then
            state = WAITING_INCLUDE
        end

        if state == WAITING_INCLUDE and last_char == "<" then
            state = COLLECTING_CHAR
            --anulate the inclusion because its a local inclusion
            contents_list[#contents_list + 1] = "#include <"
        end
        if state == WAITING_INCLUDE and last_char == '"' then
            state = COLLECTING_FILE
        end

        if state == COLLECTING_FILE and current_char ~= '"' then
            actual_filename = actual_filename .. current_char
        end

        if state == COLLECTING_CHAR then
            contents_list[#contents_list + 1] = current_char
        end

        --- ends collecting the filename
        if state == COLLECTING_FILE and current_char == '"' then
            PrivateDarwin_Addcfile(contents_list, already_included, actual_filename)
            actual_filename = current_dir
            state = COLLECTING_CHAR
        end
    end
    contents_list[#contents_list + 1] = "\n"
end

---@param filename string
---@param folow_includes boolean | nil
function Addcfile(filename, folow_includes)
    if not folow_includes then
        local content = io.open(filename)
        if not content then
            error("file " .. filename .. "not provided")
        end
        Addccode(content:read("a"))
        content:close()
        return
    end
    local contents_list = {}
    local already_included = {}
    PrivateDarwin_Addcfile(contents_list, already_included, filename)
    Addccode(table.concat(contents_list, ""))
end
