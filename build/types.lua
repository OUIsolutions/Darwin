function Embed_types(project)
    local types = ""
    local types_files = darwin.dtw.list_files_recursively("types", true)
    for i = 1, #types_files do
        types = types .. "\n" .. darwin.dtw.load_file(types_files[i])
    end
    project.embed_global("PRIVATE_DARWIN_TYPES", types)
end
