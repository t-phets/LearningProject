--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Combatant = require(ReplicatedStorage.Shared.Components.Combatant)
local Robot = require(script.Parent.Robot)

local BossRobot = {}
BossRobot.__index = BossRobot
setmetatable(BossRobot, { __index = Robot })

function BossRobot.new(name: string, battery: number, damage: number, phase: number): BossRobot
    local self = Robot.new(name, battery)
    local bossSelf = setmetatable(self :: any, BossRobot) :: BossRobot
    bossSelf.Combatant = Combatant.new(damage)
    bossSelf.Phase = phase
    return bossSelf
end

function BossRobot.Attack(self: BossRobot, target: Robot.Robot)
    self.Combatant:Attack(self, target)
end

function BossRobot.SpecialAttack(self: BossRobot)
    self.Phase += 1
    self.Combatant.Damage *= 1.5
    print(`{self.Name} uses SPECIAL ATTACK! Entering phase {self.Phase}, damage now {self.Combatant.Damage}`)
end

function BossRobot.Broke(self: BossRobot)
    print(`{self.Name} defeated!`)
end

export type BossRobot = Robot.Robot & typeof(setmetatable({} :: {
    Combatant: Combatant.Combatant,
    Phase: number,
}, BossRobot))

return BossRobot