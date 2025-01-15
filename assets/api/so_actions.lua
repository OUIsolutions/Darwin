


for i=1, #SO_INCLUDE do
    local current = SO_INCLUDE[i]
    local dest = PRIVATE_DARWIN_SO_DEST.."/"..i..".so"
    local write_point = io.open(dest, "wb")
    write_point:write(current.content)
end