function is_arg_present(arg_name)
    for i = 1, #arg do
        if arg[i] == arg_name then
            return true
        end
    end
    return false
end
