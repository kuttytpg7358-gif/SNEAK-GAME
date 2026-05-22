-- SNEAK GAME CONFIGURATION
-- Edit these values to customize your game

local GameConfig = {}

-- Player Settings
GameConfig.PLAYER_WALK_SPEED = 16
GameConfig.PLAYER_RUN_SPEED = 25
GameConfig.PLAYER_CROUCH_SPEED = 8
GameConfig.CROUCH_KEY = Enum.KeyCode.LeftControl

-- Noise System
GameConfig.RUN_NOISE_LEVEL = 100
GameConfig.WALK_NOISE_LEVEL = 50
GameConfig.CROUCH_NOISE_LEVEL = 10
GameConfig.IDLE_NOISE_LEVEL = 0

-- Guard Settings
GameConfig.GUARD_SPEED = 20
GameConfig.GUARD_PATROL_SPEED = 15
GameConfig.GUARD_CHASE_SPEED = 35

-- Detection Settings
GameConfig.GUARD_SIGHT_RANGE = 50
GameConfig.GUARD_SIGHT_ANGLE = 120 -- degrees
GameConfig.GUARD_HEARING_RANGE = 80
GameConfig.GUARD_ALERT_DURATION = 30 -- seconds

-- Game Settings
GameConfig.WIN_CONDITION = "COLLECT_ALL_OBJECTIVES" -- or "REACH_EXIT"
GameConfig.NUMBER_OF_OBJECTIVES = 5
GameConfig.GAME_TIME_LIMIT = 300 -- seconds (0 = no limit)

-- UI Settings
GameConfig.SHOW_DETECTION_RADIUS = false
GameConfig.SHOW_GUARD_VISION = false

return GameConfig
