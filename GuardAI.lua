-- GUARD AI
-- Controls guard behavior, patrol, and detection

local guard = script.Parent
local humanoid = guard:WaitForChild("Humanoid")
local rootPart = guard:WaitForChild("HumanoidRootPart")

-- Guard settings
local PATROL_SPEED = 15
local CHASE_SPEED = 30
local SIGHT_RANGE = 50
local HEARING_RANGE = 80
local ALERT_DURATION = 30

-- Guard states
local guardState = "PATROL" -- PATROL, ALERT, CHASE
local lastSeenPlayer = nil
local alertTimer = 0

-- Patrol waypoints
local waypoints = {
	Vector3.new(20, 3, 20),
	Vector3.new(-20, 3, 20),
	Vector3.new(-20, 3, -20),
	Vector3.new(20, 3, -20)
}
local currentWaypoint = 1

-- Detect player
local function DetectPlayer()
	local players = game:GetService("Players"):GetPlayers()
	
	for _, player in pairs(players) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local playerPos = player.Character.HumanoidRootPart.Position
			local guardPos = rootPart.Position
			local distance = (playerPos - guardPos).Magnitude
			
			-- Check sight
			if distance < SIGHT_RANGE then
				local direction = (playerPos - guardPos).Unit
				local rayOrigin = guardPos
				local ray = workspace:FindPartOnRay(Ray.new(rayOrigin, direction * SIGHT_RANGE), guard)
				
				if ray and ray.Parent == player.Character then
					print("👀 " .. guard.Name .. " spotted " .. player.Name .. "!")
					return player, "SIGHT"
				end
			end
			
			-- Check hearing
			if distance < HEARING_RANGE then
				-- Check if player is running
				if player.Character:FindFirstChild("Humanoid") then
					-- Simple hearing - if close enough, can hear
					if distance < HEARING_RANGE * 0.5 then
						print("👂 " .. guard.Name .. " heard " .. player.Name .. "!")
						return player, "HEARING"
					end
				end
			end
		end
	end
	
	return nil, nil
end

-- Chase player
local function ChasePlayer(targetPlayer)
	if not targetPlayer or not targetPlayer.Character then
		return false
	end
	
	local targetPos = targetPlayer.Character:FindFirstChild("HumanoidRootPart").Position
	humanoid:MoveTo(targetPos)
	humanoid.WalkSpeed = CHASE_SPEED
	
	-- Check if caught player
	local distance = (targetPos - rootPart.Position).Magnitude
	if distance < 10 then
		print("❌ " .. targetPlayer.Name .. " was caught by " .. guard.Name .. "!")
		targetPlayer.Character:MoveTo(Vector3.new(0, 10, 0))
		return true
	end
	
	return false
end

-- Patrol
local function Patrol()
	humanoid.WalkSpeed = PATROL_SPEED
	local waypoint = waypoints[currentWaypoint]
	humanoid:MoveTo(waypoint)
	
	-- Check if reached waypoint
	if (rootPart.Position - waypoint).Magnitude < 5 then
		currentWaypoint = currentWaypoint + 1
		if currentWaypoint > #waypoints then
			currentWaypoint = 1
		end
	end
end

-- Main loop
while true do
	wait(0.5)
	
	local detectedPlayer, detectionType = DetectPlayer()
	
	if detectedPlayer then
		guardState = "CHASE"
		lastSeenPlayer = detectedPlayer
		alertTimer = ALERT_DURATION
	end
	
	if guardState == "CHASE" and lastSeenPlayer then
		if ChasePlayer(lastSeenPlayer) then
			guardState = "PATROL"
			lastSeenPlayer = nil
		end
		
		alertTimer = alertTimer - 0.5
		if alertTimer <= 0 then
			guardState = "PATROL"
			lastSeenPlayer = nil
		end
	else
		guardState = "PATROL"
		Patrol()
	end
end
