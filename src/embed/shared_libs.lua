private_darwin.embed_shared_lib = function(filename)
    local content = dtw.load_file(filename)
    local sha = dtw.generate_sha(content)

    for i = 1, #private_darwin.shared_libs do
        if private_darwin.shared_libs[i].sha_item == sha then
            return filename
        end
    end

    private_darwin.shared_libs[#private_darwin.shared_libs + 1] = {
        sha_item = sha,
        content = content,
        filename = filename
    }

    return sha
end

darwin.embed_shared_libs = function(mode)
    if private_darwin.shared_libs_were_embed then
        error("shared libs were already embed")
    end

    if #private_darwin.shared_libs > 0 then
        private_darwin.shared_libs_were_embed = true
        darwin.embed_global("Private_darwin_shared_libs", private_darwin.shared_libs, mode)
    end
end
