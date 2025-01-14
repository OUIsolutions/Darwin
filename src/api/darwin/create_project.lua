darwin.create_project = function()
    local selfobj = {}
    selfobj.embed_global = function(name, value)
        private_darwin_project.embed_global(selfobj, name, value)
    end

    private_darwin_project.construct_globals(selfobj)
    private_darwin_project.add_lua_methods(selfobj)
    private_darwin_project.embed_global(selfobj,"PRIVATE_DARWIN_SO_INCLUDED", selfobj.so_includeds)

    return selfobj
end
