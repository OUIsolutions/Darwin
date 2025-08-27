
darwin.get_home = function ()
     if darwin_os == "windows" then
        return os.getenv("APPDATA") 
    end
    return os.getenv("HOME") 
end
darwin.get_config_dir = function ()
    return darwin.get_home() .. "/.darwinconfig/"
end

darwin.configure_global = function (prop, value)
    local config_dir = darwin.get_config_dir()
    local serialized = darwin.dtw.serialize_var(value)
    local sha_prop = darwin.dtw.generate_sha(prop)
    darwin.dtw.write_file(config_dir.."/"..sha_prop, serialized)
end

darwin.get_global_config = function (prop)
    local config_dir = darwin.get_config_dir()
    local sha_prop = darwin.dtw.generate_sha(prop)
    local serialized = darwin.dtw.load_file(config_dir.."/"..sha_prop)
    if not serialized then
        return nil
    end
    return darwin.dtw.interpret_serialized_var(serialized)
end
