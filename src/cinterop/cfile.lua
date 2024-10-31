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
