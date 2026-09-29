--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)

local ParentRobot = {}
ParentRobot.__index = {}

type ParentRobotData = {
    Name: string,
    Health: number,
}

expor type ParentRobot = typeof(setmetatable(
    {} :: ParentRobotData, ParentRobot
))

function ParentRobot.new(name: string, health: number): ParentRobot
    local self = setmetatable({
        Name = name,
        Health = StateResource.new(health),
    }, ParentRobot)
    return self
end

function ParentRobot.Move(self: ParentRobot)
    print(`{self.Name} is moving...`)
end

function ParentRobot.Broken(self: ParentRobot, text: string?)
    text = text or ""
    print(`{self.Name} is broken! {text}`)
end

function ParentRobot.TakeDamage(self: ParentRobot, amount: number)
    if self.Health:IsDepleted() then
        self:Broken("It cannot be attacked anymore.")
        return
    end

    self.Health:Reduce(amount)

    if self.Health:IsDepleted() then
        self:Broken()
    end
end

function ParentRobot.Destroy(self: ParentRobot)
    if self.Health:IsDepleted then
        self:Broken("It cannot be destroyed.")
        return
    end

    self:TakeDamage(self.Health.Max)
    print(`{self.Name} has been destroyed!`)
end

return ParentRobot