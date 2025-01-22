private_darwin_project.add_c_methods = function(selfobj)
    selfobj.add_c_external_code = function(code)
        private_darwin_project.add_c_external_code(selfobj, code)
    end

    selfobj.add_c_include = function(include_code)
        private_darwin_project.add_c_include(selfobj, include_code)
    end

    selfobj.add_c_file = function(filename, follow_includes, verifier_callback)
        private_darwin_project.add_c_file(selfobj, filename, follow_includes, verifier_callback)
    end

    selfobj.add_c_call = function(func_name)
        private_darwin_project.add_c_call(selfobj, func_name)
    end

    selfobj.load_lib_from_c = function(lib_start_func, lua_obj)
        private_darwin_project.load_lib_from_c(selfobj, lib_start_func, lua_obj)
    end

    selfobj.generate_c_complex = function(props)
        return private_darwin_project.generate_c_complex(selfobj, props)
    end
    selfobj.generate_c_code = function(props)
        return private_darwin_project.generate_c_code(selfobj, props)
    end

    selfobj.generate_c_file = function(props)
        return private_darwin_project.generate_c_file(selfobj, props)
    end
    selfobj.generate_c_lib_complex = function(props)
        return private_darwin_project.generate_c_lib_complex(selfobj, props)
    end

    selfobj.generate_c_lib_code = function(props)
        return private_darwin_project.generate_c_lib_code(selfobj, props)
    end

    selfobj.generate_c_lib_file = function(props)
        return private_darwin_project.generate_c_lib_file(selfobj, props)
    end
end
