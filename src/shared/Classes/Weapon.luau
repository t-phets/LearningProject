local Weapon = {}
local WeaponMethods = {}
WeaponMethods.__index = WeaponMethods

type WeaponData = {
    name: string,
    damage: number,
    ammo: number,
    maxAmmo: number,
}

export type WeaponObject = typeof(setmetatable({} :: WeaponData, WeaponMethods))

function Weapon.new(name: string, damage: number, maxAmmo: number): WeaponObject
    return setmetatable({
        name = name,
        damage = damage,
        ammo = maxAmmo,
        maxAmmo = maxAmmo,
    }, WeaponMethods)
end

function WeaponMethods.fire(self: WeaponData): (boolean, number)
    if self.ammo <= 0 then
        print(self.name .. " out of ammo!")
        return false, 0
    end

    self.ammo -= 1
    return true, self.damage
end

return Weapon