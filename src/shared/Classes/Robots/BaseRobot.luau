-- Shared/Robots/BaseRobot.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StateResource = require(ReplicatedStorage.Shared.Components.StateResource)

local BaseRobot = {}
BaseRobot.__index = BaseRobot

type BaseRobotData = {
    Name: string,
    Health: StateResource.StateResource,
}

export type BaseRobot = typeof(setmetatable({} :: BaseRobotData, BaseRobot))

function BaseRobot.new(name: string, maxHealth: number): BaseRobot
    local self = setmetatable({
        Name = name,
        Health = StateResource.new(maxHealth),
    }, BaseRobot)
    return self
end

-- นำพฤติกรรม IDamageable มาไว้ที่นี่
function BaseRobot.TakeDamage(self: BaseRobot, amount: number)
    if self:IsDead() then return end
    
    self.Health:Reduce(amount)
    print(`[{self.Name}] took {amount} damage! HP: {self.Health.Current}/{self.Health.Max}`)
    
    if self:IsDead() then
        print(`[{self.Name}] has been destroyed!`)
    end
end

-- นำพฤติกรรม IHealable มาไว้ที่นี่
function BaseRobot.ReceiveHeal(self: BaseRobot, amount: number)
    if self:IsDead() then return end
    self.Health:Restore(amount)
    print(`[{self.Name}] received {amount} heal! HP: {self.Health.Current}/{self.Health.Max}`)
end

function BaseRobot.IsDead(self: BaseRobot): boolean
    return self.Health:IsDepleted()
end

return BaseRobot