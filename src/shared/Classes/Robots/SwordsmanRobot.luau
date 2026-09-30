-- Shared/Robots/SwordsmanRobot.luau
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(script.Parent.BaseRobot)
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)
local CombatInterfaces = require(ReplicatedStorage.Shared.Interfaces.CombatInterfaces)

local SwordsmanRobot = {}
SwordsmanRobot.__index = SwordsmanRobot
setmetatable(SwordsmanRobot, { __index = BaseRobot })

type SwordsmanRobotData = {
	Stamina: StateResource.StateResource,
	SwordDamage: number,
	IsBlocking: boolean,
}

export type SwordsmanRobot = BaseRobot.BaseRobot & typeof(setmetatable({} :: SwordsmanRobotData, SwordsmanRobot))

function SwordsmanRobot.new(name: string, health: number, stamina: number, swordDamage: number): SwordsmanRobot
	local self = setmetatable(BaseRobot.new(name, health) :: any, SwordsmanRobot) :: SwordsmanRobot
	self.Stamina = StateResource.new(stamina)
	self.SwordDamage = swordDamage
	self.IsBlocking = false
	return self
end

function SwordsmanRobot.Slash(self: SwordsmanRobot, target: CombatInterfaces.IDamageable)
	if self:IsDead() then return end
	self.IsBlocking = false
	
	local staminaCost = 15
	if not self.Stamina:HasEnough(staminaCost) then
		print(`[{self.Name}] is too exhausted to slash!`)
		return
	end

	self.Stamina:Reduce(staminaCost)
	print(`[{self.Name}] slashes with their sword!`)
	target:TakeDamage(self.SwordDamage)
end

function SwordsmanRobot.Parry(self: SwordsmanRobot)
	if self:IsDead() then return end
	local staminaCost = 10
	if self.Stamina:HasEnough(staminaCost) then
		self.Stamina:Reduce(staminaCost)
		self.IsBlocking = true
		print(`[{self.Name}] raises sword to guard!`)
	end
end

-- Override TakeDamage to reduce damage by half if guarding
function SwordsmanRobot.TakeDamage(self: SwordsmanRobot, amount: number)
	if self.IsBlocking then
		amount = math.floor(amount * 0.5)
		print(`[{self.Name}] blocked part of the damage!`)
		self.IsBlocking = false
	end
	BaseRobot.TakeDamage(self, amount)
end

return SwordsmanRobot