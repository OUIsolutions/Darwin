private_darwin_project.add_lua_methods = function(selfobj)
    selfobj.add_lua_code = function(code)
        private_darwin_project.add_lua_code(selfobj, code)
    end
    selfobj.add_lua_file = function(src)
        private_darwin_project.add_lua_file(selfobj, src)
    end

    selfobj.generate_lua_complex = function(props)
        private_darwin_project.generate_lua_complex(props)
    end

    selfobj.generate_lua_code = function(props)
        return private_darwin_project.generate_lua_code(props)
    end
    selfobj.generate_lua_file = function(props)
        private_darwin_project.generate_lua_file(props)
    end
end
