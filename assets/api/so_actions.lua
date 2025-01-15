


for i=1, #SO_INCLUDE do
    local current = SO_INCLUDE[i]
    local write_point = io.open(PRIVATE_DARWIN_SO_DEST.."/"..i..".so", "wb")
    write_point:write(current.content)
end