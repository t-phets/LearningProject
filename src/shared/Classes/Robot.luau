--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Health = require(ReplicatedStorage.Shared.Components.Health)

local Robot = {}
Robot.__index = Robot

function Robot.new(name: string, battery: number): Robot
    local self = setmetatable({}, Robot) :: Robot
    self.Name = name
    self.Health = Health.new(battery)
    self.IsBroke = false
    return (self :: any) :: Robot
end

function Robot.Move(self: Robot)
    print(`{self.Name} is moving...`)
end

function Robot.Charge(self: Robot)
    self.Health:Restore()
    print(`[{self.Name}] Charged, bettery max!`)
end

function Robot.Broke(self: Robot)
    print(`{self.Name} Broke!`)
end

export type Robot = typeof(setmetatable({} :: {
    Name: string,
    Health: Health.Health,
    IsBroke: boolean,
}, Robot))

return Robot