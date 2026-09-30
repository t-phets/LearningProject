-- ServerScriptService/Simulation.server.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BoxingRobot = require(ReplicatedStorage.Shared.Classes.Robots.BoxingRobot)
local MedicalRobot = require(ReplicatedStorage.Shared.Classes.Robots.MedicalRobot)
local SwordsmanRobot = require(ReplicatedStorage.Shared.Classes.Robots.SwordsmanRobot)
local WizardRobot = require(ReplicatedStorage.Shared.Classes.Robots.WizardRobot)
local RobotTypes = require(ReplicatedStorage.Shared.Types.RobotTypes)

local BattleManager = require(script.Parent.BattleManager)

local teamA: RobotTypes.TeamRobot = {
	(SwordsmanRobot :: any).new("Arthur (Swordsman)", 120, 100, 25),
	(MedicalRobot :: any).new("Mercy (Doc)", 80, 100, 20),
}

local teamB: RobotTypes.TeamRobot = {
	(BoxingRobot :: any).new("Tyson (Boxer)", 100, 100, 20),
	(WizardRobot :: any).new("Gandalf (Wizard)", 70, 100, 35),
}

task.wait(2)
BattleManager.SimulateTeamBattle(teamA, teamB)