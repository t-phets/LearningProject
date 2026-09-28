--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Robot = require(ReplicatedStorage.Shared.Classes.Robot)

local Combatant = {}
Combatant.__index = Combatant

function Combatant.new(damage: number): Combatant
    local self = setmetatable({}, Combatant) :: Combatant
    self.Damage = damage
    return (self :: any) :: Combatant
end

function Combatant.Attack(self: Combatant, attacker: Robot.Robot, target: Robot.Robot)
    if target.IsBroke then
        target:Broke()
        return
    end

    target.Health:Damage(self.Damage)
    print(`{attacker.Name} attacks {target.Name} for {self.Damage} damage!`)
    print(`[{target.Name}] HP: {target.Health.Current}/{target.Health.Max}`)

    if target.Health.IsDepleted then
        target.IsBroke = true
        target:Broke()
    end
end

export type Combatant = typeof(setmetatable({} :: {
    Damage: number,
}, Combatant))

return Combatant