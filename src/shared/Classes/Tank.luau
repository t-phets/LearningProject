local Weapon = require(script.Parent.Weapon)

local Tank = {}
local TankMethods = {}
TankMethods.__index = TankMethods

type TankData = {
    name: string,
    health: number,
    maxHealth: number,
    weapon: Weapon.WeaponObject,
}

export type TankObject = typeof(setmetatable({} :: TankData, TankMethods))

function Tank.new(name: string, health: number, weaponName: string, damage: number, ammo: number): TankObject
    return setmetatable({
        name = name,
        health = health,
        maxHealth = health,
        weapon = Weapon.new(weaponName, damage, ammo),
    }, TankMethods)
end

function TankMethods.takeDamage(self: TankData, amount: number)
    self.health = math.clamp(self.health - amount, 0, self.maxHealth)
    print(self.name .. " took " .. amount .. " damage! HP: " .. self.health)
end

function TankMethods.attack(self: TankData, target: TankObject)
    print(self.name .. " fires at " .. target.name .. "!")
    local success, damage = self.weapon:fire()
    
    if success then
        target:takeDamage(damage)
    end
end

function TankMethods.getStatus(self: TankData)
    print(string.format("[%s] HP: %d/%d | Ammo: %d", self.name, self.health, self.maxHealth, self.weapon.ammo))
end

return Tank