-- CLOCK GUI SETUP
-- Creates and manages the clock display interface in Roblox

local Clock = require(game.ServerScriptService:WaitForChild("Clock"))

local ClockGUI = {}

-- Create clock display GUI
function ClockGUI:CreateClockDisplay()
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Create ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ClockGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui
	
	-- Create main frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "ClockFrame"
	mainFrame.Size = UDim2.new(0, 400, 0, 300)
	mainFrame.Position = UDim2.new(0.5, -200, 0, 10)
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	mainFrame.BorderSizePixel = 2
	mainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
	mainFrame.Parent = screenGui
	
	-- Title
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, 0, 0, 40)
	title.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Text = "⏰ WORLD CLOCK"
	title.TextSize = 20
	title.Font = Enum.Font.GothamBold
	title.Parent = mainFrame
	
	-- Create clock labels for each timezone
	local timeZones = {"UTC", "EST", "PST", "GMT", "IST", "JST"}
	local yPosition = 50
	
	for _, zoneName in ipairs(timeZones) do
		-- Zone Label
		local zoneLabel = Instance.new("TextLabel")
		zoneLabel.Name = zoneName .. "Label"
		zoneLabel.Size = UDim2.new(0, 150, 0, 35)
		zoneLabel.Position = UDim2.new(0, 10, 0, yPosition)
		zoneLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		zoneLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		zoneLabel.Text = zoneName
		zoneLabel.TextSize = 14
		zoneLabel.Font = Enum.Font.Gotham
		zoneLabel.Parent = mainFrame
		
		-- Time Display
		local timeLabel = Instance.new("TextLabel")
		timeLabel.Name = zoneName .. "Time"
		timeLabel.Size = UDim2.new(0, 220, 0, 35)
		timeLabel.Position = UDim2.new(0, 170, 0, yPosition)
		timeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		timeLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
		timeLabel.Text = "00:00:00"
		timeLabel.TextSize = 16
		timeLabel.Font = Enum.Font.GothamMonospace
		timeLabel.Parent = mainFrame
		
		yPosition = yPosition + 40
	end
	
	return screenGui
end

-- Update all clock displays
function ClockGUI:UpdateAllClocks(screenGui)
	local timeZones = {"UTC", "EST", "PST", "GMT", "IST", "JST"}
	
	while true do
		for _, zoneName in ipairs(timeZones) do
			local timeLabel = screenGui:FindFirstChild("ClockFrame"):FindFirstChild(zoneName .. "Time")
			if timeLabel then
				local timeTable = Clock:GetTimeInZone(zoneName)
				if timeTable then
					timeLabel.Text = Clock:FormatTime(timeTable)
				end
			end
		end
		wait(1) -- Update every second
	end
end

return ClockGUI
