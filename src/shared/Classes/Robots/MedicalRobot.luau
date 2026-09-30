-- Shared/Robots/MedicalRobot.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(script.Parent.BaseRobot)
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)
local CombatInterfaces = require(ReplicatedStorage.Shared.Interfaces.CombatInterfaces)

local MedicalRobot = {}
MedicalRobot.__index = MedicalRobot
setmetatable(MedicalRobot, { __index = BaseRobot })

type MedicalRobotData = {
    Energy: StateResource.StateResource,
    HealAmount: number,
}
export type MedicalRobot = BaseRobot.BaseRobot & typeof(setmetatable({} :: MedicalRobotData, MedicalRobot))

function MedicalRobot.new(name: string, health: number, energy: number, healAmount: number): MedicalRobot
    local self = setmetatable(BaseRobot.new(name, health) :: any, MedicalRobot) :: MedicalRobot
    self.Energy = StateResource.new(energy)
    self.HealAmount = healAmount
    return self
end

function MedicalRobot.HealTarget(self: MedicalRobot, target: CombatInterfaces.IHealable)
    if self:IsDead() then return end
    if target:IsDead() then 
        print(`[{self.Name}] cannot heal a destroyed robot!`)
        return
    end
    
    local energyCost = 15
    if not self.Energy:HasEnough(energyCost) then
        print(`[{self.Name}] needs to recharge energy!`)
        return
    end

    self.Energy:Reduce(energyCost)
    print(`[{self.Name}] uses Healing Beam!`)
    target:ReceiveHeal(self.HealAmount) -- เป้าหมายจัดการเพิ่มเลือดของตัวเอง
end

return MedicalRobot