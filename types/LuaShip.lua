---@class LuaShipStartProps
---@class flags string[]
---@class volumes string[]string[]
---@class command string


---@class LuaShipMachine
---@field provider "podman"| "docker"
---@field docker_file string
---@field add_comptime_command fun(command:string)
---@field copy fun(host_data:string,dest_data:string)
---@field env fun(name:string,value:string)
---@field save_to_file fun(filename:string)
---@field start fun(props:LuaShipStartProps)


---@class LuaShip
---@field create_machine fun(distro:string):LuaShipMachine
---@field open fun(filename:string,mode:string)
---@field os_execute fun(command:string):boolean
---@field os_remove fun(filename:string)
---@field error fun(errror:string)
