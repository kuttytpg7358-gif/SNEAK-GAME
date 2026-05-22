-- PLAYER CONTROLLER
-- Handles player movement, crouch mechanics, and HUD display

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Player states
local isCrouching = false
local isRunning = false

-- Original speeds
local normalSpeed = 16
local crouchSpeed = 8
local runSpeed = 25

-- Create HUD
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0, 300, 0, 100)
statusLabel.Position = UDim2.new(0, 10, 0, 10)
statusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.BackgroundTransparency = 0.5
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: READY"
statusLabel.Parent = screenGui

-- Objective counter label
local objectiveLabel = Instance.new("TextLabel")
objectiveLabel.Name = "ObjectiveLabel"
objectiveLabel.Size = UDim2.new(0, 200, 0, 50)
objectiveLabel.Position = UDim2.new(0, 10, 0.5, 10)
objectiveLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
objectiveLabel.BackgroundTransparency = 0.5
objectiveLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
objectiveLabel.TextSize = 16
objectiveLabel.Font = Enum.Font.GothamBold
objectiveLabel.Text = "🎯 Objectives: 0/5"
objectiveLabel.Parent = screenGui

-- Handle crouch input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.LeftControl then
		isCrouching = true
		humanoid.WalkSpeed = crouchSpeed
		statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWADS - Move\n\nStatus: CROUCHING (QUIET) 🤫"
		print("🤫 Player is crouching (quiet)")
	end
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isRunning = true
		humanoid.WalkSpeed = runSpeed
		statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: RUNNING (LOUD) 🏃"
		print("🏃 Player is running (loud)")
	end
end)

-- Handle input ended
UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		isCrouching = false
		if not isRunning then
			humanoid.WalkSpeed = normalSpeed
			statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: WALKING (NORMAL)"
			print("👣 Player is walking")
		end
	end
	
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isRunning = false
		if not isCrouching then
			humanoid.WalkSpeed = normalSpeed
			statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: WALKING (NORMAL)"
			print("👣 Player is walking")
		else
			humanoid.WalkSpeed = crouchSpeed
			statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: CROUCHING (QUIET) 🤫"
		end
	end
end)

-- Update objective counter
local objectiveCount = 0
RunService.Heartbeat:Connect(function()
	-- Count remaining objectives
	local objectives = workspace:FindFirstChildOfClass("Part")
	if objectives then
		local count = 0
		for _, obj in pairs(workspace:GetChildren()) do
			if obj.Name == "Objective" then
				count = count + 1
			end
		end
		if count ~= objectiveCount then
			objectiveCount = count
			objectiveLabel.Text = "🎯 Objectives: " .. (5 - objectiveCount) .. "/5"
		end
	end
end)

-- Clean up on death
humanoid.Died:Connect(function()
	print("💀 Player died!")
	statusLabel.Text = "🎮 SNEAK GAME\n\nControls:\nCTRL - Crouch\nShift - Run\nWASD - Move\n\nStatus: DEAD ❌"
end)
