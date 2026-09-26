local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tank = require(ReplicatedStorage.Shared.Classes.Tank)

local tank1 = Tank.new("Tiger", 300, "Cannon", 50, 5)
local tank2 = Tank.new("Abarns", 200, "Cannon", 50, 5)

tank1:getStatus()
tank2:getStatus()

print("-------------------")
tank1:attack(tank2)
tank2:attack(tank1)

print("-------------------")
tank1:getStatus()
tank2:getStatus()