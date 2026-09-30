-- ServerScriptService/BattleManager.luau
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobotTypes = require(ReplicatedStorage.Shared.Types.RobotTypes)

local BattleManager = {}

local function executeRandomAction(robot: RobotTypes.AnyRobot, allies: RobotTypes.TeamRobot, enemies: RobotTypes.TeamRobot)
	if robot:IsDead() then 
		return 
	end

	local aliveEnemies: RobotTypes.TeamRobot = {}
	for _, enemy in enemies do
		if not enemy:IsDead() then
			table.insert(aliveEnemies, enemy)
		end
	end

	local injuredAllies: RobotTypes.TeamRobot = {}
	for _, ally in allies do
		if not ally:IsDead() and (ally.Health.Current :: number) < (ally.Health.Max :: number) then
			table.insert(injuredAllies, ally)
		end
	end

	local dynRobot = robot :: any

	local randomEnemy = (#aliveEnemies > 0) and aliveEnemies[math.random(1, #aliveEnemies)] or nil
	local randomInjuredAlly = (#injuredAllies > 0) and injuredAllies[math.random(1, #injuredAllies)] or nil

	-- Duck Typing "ถ้ามันเดินเหมือนเป็ด ร้องเหมือนเป็ด และว่ายน้ำเหมือนเป็ด สิ่งนั้นก็คือเป็ด" 🥹🥹🤣🤣
	if dynRobot.Punch and randomEnemy then
		dynRobot:Punch(randomEnemy)

	elseif dynRobot.CastFireball and randomEnemy then
		dynRobot:CastFireball(randomEnemy)

	elseif dynRobot.HealTarget and randomInjuredAlly then
		dynRobot:HealTarget(randomInjuredAlly)

	elseif dynRobot.Slash and randomEnemy then
		if math.random() > 0.5 then
			dynRobot:Slash(randomEnemy)
		else
			dynRobot:Parry()
		end
	else
		print(`[{robot.Name}] stands ground...`)
	end
end

local function isTeamAlive(team: RobotTypes.TeamRobot): boolean
	for _, robot in team do
		if not robot:IsDead() then
			return true
		end
	end
	return false
end

function BattleManager.SimulateTeamBattle(teamA: RobotTypes.TeamRobot, teamB: RobotTypes.TeamRobot)
	print("========================================")
	print("        BATTLE SIMULATION STARTED       ")
	print("========================================")

	local round = 1

	while isTeamAlive(teamA) and isTeamAlive(teamB) do
		print(`\n--- ROUND {round} ---`)

		for _, attacker in teamA do
			if isTeamAlive(teamB) then
				executeRandomAction(attacker, teamA, teamB)
				task.wait(0.5)
			end
		end

		for _, attacker in teamB do
			if isTeamAlive(teamA) then
				executeRandomAction(attacker, teamB, teamA)
				task.wait(0.5)
			end
		end

		round += 1
		if round > 30 then
			print("\n[BattleManager] Match ended in Draw (Max rounds reached)!")
			return
		end
	end

	print("\n========================================")
	if isTeamAlive(teamA) then
		print("          TEAM A VICTORIOUS!            ")
	else
		print("          TEAM B VICTORIOUS!            ")
	end
	print("========================================")
end

return BattleManager