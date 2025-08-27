local itens = {}
local files =dtw.list_files_recursively("src",true)
for i=1,#files do
    itens[files[i]] = dtw.generate_sha_from_file(files[i])
end
local dep_files = dtw.list_files_recursively("dependencies",true)
for i=1,#dep_files do
    itens[dep_files[i]] = dtw.generate_sha_from_file(dep_files[i])
end

json.dumps_to_file(itens,"sha.json")