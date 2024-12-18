private_darwin.ask_yes_or_no = function(question)
    while true do
        private_darwin.print_blue(question .. ":")
        local result = io.read("l")
        if result == "y" or result == "yes" then
            return true
        end
        if result == "n" or result == "no" then
            return false
        end
        private_darwin.print_red("invalid answer\n")
    end
end
