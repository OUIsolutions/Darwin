


for i=1, #REQUIRE_SO do
    local current = REQUIRE_SO[i]
    local write_point = io.open(PRIVATE_DARWIN_SO_DEST.."/"..i..".so", "w")
    write_point:write(current.content)
end