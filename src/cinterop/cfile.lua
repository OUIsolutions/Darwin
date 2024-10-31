---@param contents string[]
---@param already_included string[]
---@param filename string
function PrivateDarwin_Addcfile(contents, already_included, filename)

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
