# 🕵️ SNEAK GAME - Complete Setup Guide

## 📖 Installation Instructions

### **Step 1: In Roblox Studio**

1. Open **Roblox Studio**
2. Create a new game (**File → New → Baseplate**)

### **Step 2: Add GameConfig Script**

1. In Explorer (left panel), find **ServerScriptService**
2. Right-click → **Insert Object** → **Script**
3. Name it: **GameConfig**
4. Delete default code
5. Copy all code from **GameConfig.lua** file
6. Paste into the script

### **Step 3: Add GuardAI Script**

1. In Explorer, find **ServerScriptService**
2. Right-click → **Insert Object** → **Script**
3. Name it: **GuardAI**
4. Delete default code
5. Copy all code from **GuardAI.lua** file
6. Paste into the script
7. ⚠️ **DON'T run it yet** - it will be cloned to guards

### **Step 4: Add GameManager Script**

1. In Explorer, find **ServerScriptService**
2. Right-click → **Insert Object** → **Script**
3. Name it: **GameManager**
4. Delete default code
5. Copy all code from **GameManager.lua** file
6. Paste into the script

### **Step 5: Add PlayerController Script**

1. In Explorer, find **StarterPlayer** → **StarterCharacterScripts**
2. Right-click → **Insert Object** → **LocalScript**
3. Name it: **PlayerController**
4. Delete default code
5. Copy all code from **PlayerController.lua** file
6. Paste into the script

### **Step 6: Build Your Level**

Create obstacles and terrain:

1. Click **Insert** menu
2. Add **Parts** to create:
   - Walls
   - Platforms
   - Cover objects
   - Floors

Position them around your game world to create a sneaking area.

### **Step 7: Test the Game**

1. Click **PLAY** button (▶️) at the top
2. The game will:
   - Spawn 5 green objectives (spheres)
   - Spawn 3 red guards
   - Show your HUD on screen
3. Try to collect the green spheres while avoiding red guards!

---

## 🎮 Game Controls

| Key | Action |
|-----|--------|
| **W/A/S/D** | Move around |
| **CTRL** | Crouch (walk quietly) |
| **Shift** | Run (make noise) |
| **Space** | Jump |

---

## 🎯 Game Objective

✅ Collect all **5 green spheres**  
✅ Avoid **3 red guards**  
✅ Don't get caught!  
✅ Reach the exit

---

## 🕵️ How to Play

1. **Crouch (CTRL)** when guards are near
2. **Plan your route** to objectives
3. **Hide behind cover** to avoid guards
4. **Collect green spheres** quietly
5. **Don't run** unless necessary (makes noise)
6. **Win** by collecting all objectives

---

## ⚙️ Customization

Edit **GameConfig.lua** to change:
- Guard sight range: `GUARD_SIGHT_RANGE = 50`
- Guard hearing range: `GUARD_HEARING_RANGE = 80`
- Number of objectives: `NUMBER_OF_OBJECTIVES = 5`
- Player speeds: `PLAYER_WALK_SPEED`, `PLAYER_RUN_SPEED`, `PLAYER_CROUCH_SPEED`

---

## 📝 File Descriptions

- **GameManager.lua** - Spawns objectives and guards, manages game state
- **PlayerController.lua** - Handles player movement and crouch mechanics
- **GuardAI.lua** - Controls guard patrol and detection
- **GameConfig.lua** - All customizable game settings
- **Clock.lua** - Digital clock system (optional)
- **ClockGUI.lua** - Clock display interface (optional)

---

## 🐛 Troubleshooting

**❌ Game won't start?**
- Make sure all 3 scripts are in ServerScriptService
- Check the Output window (View → Output) for errors

**❌ Guards not spawning?**
- Make sure GuardAI script is named exactly "GuardAI"
- Make sure it's in ServerScriptService

**❌ Player controller not working?**
- Make sure PlayerController is in StarterCharacterScripts
- Not ServerScriptService!

**❌ Objectives won't collect?**
- Green spheres spawn automatically
- Walk over them to collect
- They should disappear when collected

---

## 🚀 Next Steps

1. **Build your level** with obstacles
2. **Test and play** to check mechanics
3. **Adjust difficulty** in GameConfig.lua
4. **Publish to Roblox** when ready
5. **Share with friends!**

---

Happy sneaking! 🕵️‍♂️
