-- Shared/Robots/BoxingRobot.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(script.Parent.BaseRobot)
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)
local Types = require(ReplicatedStorage.Shared.Interfaces.Types)

local BoxingRobot = {}
BoxingRobot.__index = BoxingRobot
setmetatable(BoxingRobot, { __index = BaseRobot })

type BoxingRobotData = {
    Stamina: StateResource.StateResource,
    Damage: number,
}

export type BoxingRobot = BaseRobot.BaseRobot & typeof(setmetatable({} :: BoxingRobotData, BoxingRobot))

function BoxingRobot.new(name: string, health: number, stamina: number, damage: number): BoxingRobot
    local self = setmetatable(BaseRobot.new(name, health) :: any, BoxingRobot) :: BoxingRobot
    self.Stamina = StateResource.new(stamina)
    self.Damage = damage
    return self
end

function BoxingRobot.Punch(self: BoxingRobot, target: Types.IDamageable)
    if self:IsDead() then return end
    
    local staminaCost = 10
    if not self.Stamina:HasEnough(staminaCost) then
        print(`[{self.Name}] is out of breath!`)
        return
    end

    self.Stamina:Reduce(staminaCost)
    print(`[{self.Name}] punches!`)
    target:TakeDamage(self.Damage) -- It doesn't matter what the target is; just know it can take damage
end

return BoxingRobot