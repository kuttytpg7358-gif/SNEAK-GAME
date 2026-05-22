-- DIGITAL CLOCK SYSTEM
-- Displays current time in multiple time zones

local Clock = {}

-- Time zone offsets (in hours from UTC)
local timeZoneOffsets = {
	UTC = 0,
	EST = -5,      -- Eastern Standard Time
	EDT = -4,      -- Eastern Daylight Time
	PST = -8,      -- Pacific Standard Time
	PDT = -7,      -- Pacific Daylight Time
	GMT = 0,       -- Greenwich Mean Time
	IST = 5.5,     -- Indian Standard Time
	JST = 9,       -- Japan Standard Time
	AEST = 10,     -- Australian Eastern Standard Time
	GST = 4,       -- Gulf Standard Time
	CET = 1,       -- Central European Time
	CST = 8,       -- China Standard Time
}

-- Get current UTC time
function Clock:GetUTCTime()
	return os.date("*t", os.time())
end

-- Get time in specific timezone
function Clock:GetTimeInZone(zoneName)
	local utcTime = self:GetUTCTime()
	local offset = timeZoneOffsets[zoneName]
	
	if not offset then
		return nil
	end
	
	-- Convert offset to seconds
	local offsetSeconds = offset * 3600
	local localTime = os.time(utcTime) + offsetSeconds
	
	return os.date("*t", localTime)
end

-- Format time as HH:MM:SS
function Clock:FormatTime(timeTable)
	if not timeTable then
		return "00:00:00"
	end
	
	local hours = string.format("%02d", timeTable.hour)
	local minutes = string.format("%02d", timeTable.min)
	local seconds = string.format("%02d", timeTable.sec)
	
	return hours .. ":" .. minutes .. ":" .. seconds
end

-- Get all timezones
function Clock:GetAllTimeZones()
	local zones = {}
	for zoneName, _ in pairs(timeZoneOffsets) do
		table.insert(zones, zoneName)
	end
	return zones
end

-- Get current time in all zones
function Clock:GetAllTimes()
	local times = {}
	for zoneName, _ in pairs(timeZoneOffsets) do
		times[zoneName] = self:GetTimeInZone(zoneName)
	end
	return times
end

-- Print current time in all zones (for debugging)
function Clock:PrintAllTimes()
	print("=== WORLD CLOCK ===")
	for zoneName, _ in pairs(timeZoneOffsets) do
		local timeTable = self:GetTimeInZone(zoneName)
		print(zoneName .. ": " .. self:FormatTime(timeTable))
	end
	print("==================")
end

return Clock
