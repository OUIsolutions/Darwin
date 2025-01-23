
function handle_unused()
    local unused_index = darwin.argv.get_next_unused_index()
    if unused_index then
        local unused_arg = darwin.argv.get_arg_by_index(unused_index)
        local msg = "arg:" .. unused_arg .. " at index: " .. unused_index .. "its unused"
        private_darwin.print_red(msg)
        return false 
    end
    return true
end