---@param contents string[]
---@param already_included string[]
---@param filename string
function PrivateDarwin_Addcfile(contents, already_included, filename)
    local file = io.open(filename, "r")
    if not file then
        error("file " .. filename .. "not provided")
    end
    local content = file:read("a")
    if PrivateDarwin_is_inside(already_included, content) then
        return
    end
    local COLLECTING_CHAR = 0
    local WAITING_INCLUDE = 1
    local COLLECTING_FILE = 2
    local state = COLLECTING_CHAR
    local filename = ""
    for i = 1, #content do
        if PrivateDarwin_is_string_at_point(content, "#include", i) then
            state = WAITING_INCLUDE
        end

        if state == WAITING_INCLUDE and content[i - 1] == '"' then
            state = COLLECTING_FILE
        end

        if state == COLLECTING_FILE and content[i] ~= '"' then
            filename[#filename + 1] = content[i]
        end

        --- ends collecting the filename
        if state == COLLECTING_FILE and content == '"' then
            PrivateDarwin_Addcfile(content, already_included, filename)
            filename = ""
            state = COLLECTING_CHAR
        end

        if state == COLLECTING_CHAR then
            contents[#contents + 1] = content[i]
        end
    end
    contents[#contents + 1] = "\n"
end

---@param filename string
---@param folow_includes boolean | nil
---@param not_inside string[] | nil
function Addcfile(filename, folow_includes, not_inside)
    if not folow_includes then
        local content = io.open(filename)
        if not content then
            error("file " .. filename .. "not provided")
        end
        Addccode(content:read("a"))
        content:close()
        return
    end
    local contents = {}
    local already_included = {}
    PrivateDarwin_Addcfile(contents, already_included, filename)
    Addccode(table.concat(contents))
end
