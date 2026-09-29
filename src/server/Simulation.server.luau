-- ServerScriptService/Simulation.server.luau
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BoxingRobot = require(ReplicatedStorage.Shared.Classes.Robots.BoxingRobot)
local MedicalRobot = require(ReplicatedStorage.Shared.Classes.Robots.MedicalRobot)
local SwordsmanRobot = require(ReplicatedStorage.Shared.Classes.Robots.SwordsmanRobot)
local WizardRobot = require(ReplicatedStorage.Shared.Classes.Robots.WizardRobot)

local BattleManager = require(script.Parent.BattleManager)

-- สร้างตารางโดยบังคับ Type ให้หลวมขึ้นเพื่อป้องกัน Luau Type Intersection Error
local teamA: { any } = {
	(SwordsmanRobot :: any).new("Arthur (Swordsman)", 120, 100, 25),
	(MedicalRobot :: any).new("Mercy (Doc)", 80, 100, 20),
}

local teamB: { any } = {
	(BoxingRobot :: any).new("Tyson (Boxer)", 100, 100, 20),
	(WizardRobot :: any).new("Gandalf (Wizard)", 70, 100, 35),
}

task.wait(2)
-- ส่งเข้าฟังก์ชันสู้รบตามปกติ
BattleManager.SimulateTeamBattle(teamA :: any, teamB :: any)