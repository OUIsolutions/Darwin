
private_darwin_project.add_c_methods = function (selfobj)

    
    selfobj.generate_c_complex = function(props)
        return private_darwin_project.generate_c_complex(selfobj, props)
    end
    selfobj.generate_c_code = function(props)
        return private_darwin_project.generate_c_code(selfobj, props)
    end

    selfobj.generate_c_file = function(props)
        return private_darwin_project.generate_c_file(selfobj, props)
    end


end 