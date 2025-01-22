function Drop_types()
    local file = darwin.argv.get_arg_by_index(3)
    if not file then
        file = "darwintypes.lua"
    end
    darwin.dtw.write_file(file, PRIVATE_DARWIN_TYPES)
end
