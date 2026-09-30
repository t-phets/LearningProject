-- Shared/Types/RobotTypes.luau
-- !strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(ReplicatedStorage.Shared.Classes.Robots.BaseRobot)

export type AnyRobot = BaseRobot.BaseRobot
export type TeamRobot = { AnyRobot }

return {}