-- GAME MANAGER
-- Manages game objectives, guards, and overall game state

local GameManager = {}

-- Game configuration
local NUM_OBJECTIVES = 5
local NUM_GUARDS = 3
local OBJECTIVE_SPAWN_RADIUS = 50

-- Spawn objectives (green spheres)
function GameManager:SpawnObjectives()
	print("🎯 Spawning objectives...")
	
	for i = 1, NUM_OBJECTIVES do
		local objective = Instance.new("Part")
		objective.Name = "Objective"
		objective.Shape = Enum.PartType.Ball
		objective.Size = Vector3.new(2, 2, 2)
		objective.Color = Color3.fromRGB(0, 255, 0) -- Green
		objective.Material = Enum.Material.Neon
		objective.CanCollide = true
		objective.TopSurface = Enum.SurfaceType.Smooth
		objective.BottomSurface = Enum.SurfaceType.Smooth
		
		-- Random spawn position
		local spawnX = math.random(-OBJECTIVE_SPAWN_RADIUS, OBJECTIVE_SPAWN_RADIUS)
		local spawnZ = math.random(-OBJECTIVE_SPAWN_RADIUS, OBJECTIVE_SPAWN_RADIUS)
		objective.Position = Vector3.new(spawnX, 5, spawnZ)
		
		objective.Parent = workspace
		print("✅ Objective " .. i .. " spawned at " .. tostring(objective.Position))
		
		-- Handle collection
		local touched = false
		objective.Touched:Connect(function(hit)
			if not touched and hit.Parent:FindFirstChild("Humanoid") then
				touched = true
				print("🎉 Objective collected!")
				objective:Destroy()
			end
		end)
	end
end

-- Spawn guards (red humanoids)
function GameManager:SpawnGuards()
	print("👿 Spawning guards...")
	
	local GuardAI = game.ServerScriptService:WaitForChild("GuardAI")
	
	for i = 1, NUM_GUARDS do
		-- Create guard character
		local guard = Instance.new("Model")
		guard.Name = "Guard_" .. i
		
		-- Create humanoid root part
		local rootPart = Instance.new("Part")
		rootPart.Name = "HumanoidRootPart"
		rootPart.Shape = Enum.PartType.Block
		rootPart.Size = Vector3.new(2, 2, 1)
		rootPart.CanCollide = false
		rootPart.Transparency = 1
		rootPart.Parent = guard
		
		-- Create head
		local head = Instance.new("Part")
		head.Name = "Head"
		head.Shape = Enum.PartType.Ball
		head.Size = Vector3.new(1, 1, 1)
		head.Color = Color3.fromRGB(255, 0, 0) -- Red
		head.TopSurface = Enum.SurfaceType.Smooth
		head.BottomSurface = Enum.SurfaceType.Smooth
		head.Parent = guard
		
		-- Create body
		local body = Instance.new("Part")
		body.Name = "Torso"
		body.Shape = Enum.PartType.Block
		body.Size = Vector3.new(2, 2, 1)
		body.Color = Color3.fromRGB(200, 0, 0) -- Dark red
		body.TopSurface = Enum.SurfaceType.Smooth
		body.BottomSurface = Enum.SurfaceType.Smooth
		body.Parent = guard
		
		-- Position parts
		rootPart.Position = Vector3.new(math.random(-30, 30), 3, math.random(-30, 30))
		head.Position = rootPart.Position + Vector3.new(0, 1.5, 0)
		body.Position = rootPart.Position
		
		-- Add humanoid
		local humanoid = Instance.new("Humanoid")
		humanoid.Parent = guard
		
		-- Weld parts together
		local weld1 = Instance.new("WeldConstraint")
		weld1.Part0 = rootPart
		weld1.Part1 = body
		weld1.Parent = body
		
		local weld2 = Instance.new("WeldConstraint")
		weld2.Part0 = body
		weld2.Part1 = head
		weld2.Parent = head
		
		guard.Parent = workspace
		print("✅ Guard " .. i .. " spawned at " .. tostring(rootPart.Position))
		
		-- Clone GuardAI script to guard
		local guardScript = GuardAI:Clone()
		guardScript.Parent = guard
		guardScript.Disabled = false
	end
end

-- Check win condition
function GameManager:CheckWinCondition()
	while true do
		wait(1)
		
		local objectiveCount = 0
		for _, obj in pairs(workspace:GetChildren()) do
			if obj.Name == "Objective" then
				objectiveCount = objectiveCount + 1
			end
		end
		
		if objectiveCount == 0 then
			print("🎉🎉🎉 ALL OBJECTIVES COLLECTED! YOU WIN! 🎉🎉🎉")
		end
	end
end

-- Initialize game
function GameManager:Initialize()
	print("🎮 SNEAK GAME - Starting...")
	self:SpawnObjectives()
	wait(1)
	self:SpawnGuards()
	wait(1)
	self:CheckWinCondition()
end

-- Start the game
GameManager:Initialize()
