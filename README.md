# SNEAK GAME - Roblox Stealth Game

A complete stealth/infiltration game for Roblox featuring sneaking mechanics, guard AI, and objectives.

## Game Features

- **Sneaking Mechanics**: Crouch and walk quietly to avoid detection
- **Guard AI**: Intelligent guards with patrol patterns and detection system
- **Detection System**: Guards detect based on line of sight and sound
- **Objectives**: Complete missions to win
- **Stealth Cover**: Hide behind objects to avoid guards
- **Sound System**: Make noise when running, stay quiet when crouching

## File Structure

```
SNEAK-GAME/
├── README.md
├── GameManager.lua          # Main game controller
├── PlayerController.lua      # Player movement & sneaking
├── GuardAI.lua             # Guard behavior & detection
├── DetectionSystem.lua      # Detection logic
├── GameConfig.lua          # Game settings & configuration
└── SpawnPoints.lua         # Spawn locations setup
```

## How to Use

1. Open Roblox Studio
2. Create a new game
3. In **ServerScriptService**, create scripts with names matching the files
4. Copy the code from each `.lua` file into the corresponding script
5. Place **GameManager** script in **ServerScriptService**
6. Place **PlayerController** script in **StarterPlayer > StarterCharacterScripts**
7. Create NPCs/Guards in your game world and attach **GuardAI** script
8. Adjust settings in **GameConfig** as needed

## Game Controls

- **WASD**: Move around
- **CTRL**: Crouch (walk quietly)
- **Shift**: Run (makes noise)
- **E**: Interact with objectives

## Installation Instructions

1. Copy all `.lua` files from this repository
2. Create corresponding scripts in Roblox Studio
3. Paste the code into each script
4. Test your game!

## Configuration

Edit `GameConfig.lua` to customize:
- Guard detection range
- Player noise level
- Guard patrol speed
- Objective locations
- Spawn points

Happy sneaking! 🕵️‍♂️
