function Embed_types()
    local types = ""
    local types_files = dtw.list_files_recursively("types", true)
    for i = 1, #types_files do
        types = types .. "\n" .. dtw.load_file(types_files[i])
    end
    darwin.embed_global("PRIVATE_DARWIN_TYPES", types)
end
