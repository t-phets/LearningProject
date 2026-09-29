--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Damageable = require(ReplicatedStorage.Shared.Types.Damageable)

local Combat = {}
Combat.__index = Combat

type CombatData = {
    Damage: number,
}

export type Combat = typeof(setmetatable(
    {} :: CombatData, Combat)
)

-- export type Damageable = {
--     StateResource: {
--         Reduce: (self: any, amount: number) -> (),
--     },
-- }

function Combat.new(damage: number): Combat
    local self = setmetatable({
        Damage = damage,
    }, Combat)

    return self :: Combat
end

function Combat.Attack(self: Combat, target: Damageable)
    target.StateResource:Reduce(self.Damage)
end

return Combat