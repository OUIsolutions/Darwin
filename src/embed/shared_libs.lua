private_darwin.embed_shared_lib = function(filename)
    return string.format("PrivateDarwin_get_shared_lib_path('%s')", filename)
end
