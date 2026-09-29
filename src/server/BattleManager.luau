--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseRobot = require(ReplicatedStorage.Shared.Classes.Robots.BaseRobot)

local BattleManager = {}

-- กำหนด Type พื้นฐาน และใช้ Type Casting ในจุดที่ต้องการความยืดหยุ่น
type AnyRobot = BaseRobot.BaseRobot

local function executeRandomAction(robot: AnyRobot, allies: {AnyRobot}, enemies: {AnyRobot})
	if robot:IsDead() then return end

	local aliveEnemies: {AnyRobot} = {}
	for _, enemy in enemies do
		if not enemy:IsDead() then
			table.insert(aliveEnemies, enemy)
		end
	end

	local injuredAllies: {AnyRobot} = {}
	for _, ally in allies do
		-- แก้ปัญหา Type any & number cannot be compared โดยการ Cast เป็น number
		if not ally:IsDead() and (ally.Health.Current :: number) < (ally.Health.Max :: number) then
			table.insert(injuredAllies, ally)
		end
	end

	-- แปลงเป็น any เพื่อเรียกใช้ความสามารถเฉพาะตัว (Duck Typing) โดยไม่ติด Error Strict Type
	local dynRobot = robot :: any

	if dynRobot.Punch and #aliveEnemies > 0 then
		local target = aliveEnemies[math.random(1, #aliveEnemies)]
		dynRobot:Punch(target)

	elseif dynRobot.CastFireball and #aliveEnemies > 0 then
		local target = aliveEnemies[math.random(1, #aliveEnemies)]
		dynRobot:CastFireball(target)

	elseif dynRobot.HealTarget and #injuredAllies > 0 then
		local target = injuredAllies[math.random(1, #injuredAllies)]
		dynRobot:HealTarget(target)

	elseif dynRobot.Slash and #aliveEnemies > 0 then
		local target = aliveEnemies[math.random(1, #aliveEnemies)]
		if math.random() > 0.5 then
			dynRobot:Slash(target)
		else
			dynRobot:Parry()
		end
	else
		print(`[{robot.Name}] stands ground...`)
	end
end

local function isTeamAlive(team: {AnyRobot}): boolean
	for _, robot in team do
		if not robot:IsDead() then
			return true
		end
	end
	return false
end

function BattleManager.SimulateTeamBattle(teamA: {AnyRobot}, teamB: {AnyRobot})
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