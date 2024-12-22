local calc = require("src/calc")
local args = require("src/args_entrie")

function main()
    if arg[2] == "help" then
        print(help)
        return
    end
    local x = args.get_arg_number(2)
    if not x then
        print("arg 2 not passed or its not a number")
        return
    end
    local operator = args.get_operator()
    if not operator then
        print("operator not passed or not in (+-x/) ")
        return
    end
    local y = args.get_arg_number(4)
    if not y then
        print("arg 2 not passed or its not a number")
        return
    end
    if operator == "+" then
        print(calc.add(x, y))
    end
    if operator == "-" then
        print(calc.sub(x, y))
    end
    if operator == "x" then
        print(calc.mul(x, y))
    end
    if operator == "/" then
        print(calc.div(x, y))
    end
end
