darwin.create_project = function(project_name)
    local selfobj = {}
    selfobj.project_name = project_name
    selfobj.embed_global = function(name, value)
        private_darwin_project.embed_global(selfobj, name, value)
    end

    private_darwin_project.construct_globals(selfobj)
    private_darwin_project.add_lua_methods(selfobj)
    private_darwin_project.embed_global(selfobj,
    "PRIVATE_DARWIN_"..selfobj.project_name.."_SO_INCLUDED",
     selfobj.so_includeds
    )

    return selfobj
end
