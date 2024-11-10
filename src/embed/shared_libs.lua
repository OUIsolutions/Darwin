private_darwin.embed_shared_lib = function(filename)
    local content = dtw.load_file(filename)
    local sha = dtw.generate_sha(content)
    return sha
end
