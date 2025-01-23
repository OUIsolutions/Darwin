function Default_execution()
    local main_file = darwin.argv.get_arg_by_index(3)
    if not main_file then
        private_darwin.print_red("file not passed")
        return
    end
end
