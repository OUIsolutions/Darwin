
---create a dir for dest if not exists

os.execute("mkdir -p "..PRIVATE_DARWIN_SO_DEST)

for i=1, #SO_INCLUDE do
    local current = SO_INCLUDE[i]
    local dest = PRIVATE_DARWIN_SO_DEST.."/"..i..".so"
    local write_point = io.open(dest, "wb")
    if not write_point then
        error("impossible to write in "..dest)
    end
    write_point:write(current.content)
end

