private_darwin_project.add_lua_methods = function(selfobj)
    selfobj.add_lua_code = function(code)
        private_darwin_project.add_lua_code(selfobj, code)
    end
    selfobj.add_lua_file = function(src)
        private_darwin_project.add_lua_file(selfobj, src)
    end

    selfobj.add_lua_file_followin_require = function(src,relative_path)
        private_darwin_project.add_lua_file_followin_require(selfobj, src,relative_path)
    end

    selfobj.generate_lua_complex = function(props)
        private_darwin_project.generate_lua_complex(selfobj, props)
    end

    selfobj.generate_lua_code = function(props)
        return private_darwin_project.generate_lua_code(selfobj, props)
    end
    selfobj.generate_lua_file = function(props)
        private_darwin_project.generate_lua_file(selfobj, props)
    end
end
