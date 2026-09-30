-- Shared/Robots/WizardRobot.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(script.Parent.BaseRobot)
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)
local CombatInterfaces = require(ReplicatedStorage.Shared.Interfaces.CombatInterfaces)

local WizardRobot = {}
WizardRobot.__index = WizardRobot
setmetatable(WizardRobot, { __index = BaseRobot })

type WizardRobotData = {
    Mana: StateResource.StateResource,
    MagicDamage: number,
}
export type WizardRobot = BaseRobot.BaseRobot & typeof(setmetatable({} :: WizardRobotData, WizardRobot))

function WizardRobot.new(name: string, health: number, mana: number, magicDamage: number): WizardRobot
    local self = setmetatable(BaseRobot.new(name, health) :: any, WizardRobot) :: WizardRobot
    self.Mana = StateResource.new(mana)
    self.MagicDamage = magicDamage
    return self
end

function WizardRobot.CastFireball(self: WizardRobot, target: CombatInterfaces.IDamageable)
    if self:IsDead() then return end
    
    local manaCost = 25
    if not self.Mana:HasEnough(manaCost) then
        print(`[{self.Name}] out of mana!`)
        return
    end

    self.Mana:Reduce(manaCost)
    print(`[{self.Name}] casts Fireball!`)
    target:TakeDamage(self.MagicDamage)
end

return WizardRobot