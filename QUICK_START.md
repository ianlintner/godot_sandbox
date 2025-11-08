# Quick Start Guide

## What is This?

This is a complete, playable 2D platformer game inspired by classic NES games like Mega Man and Duck Tales. It's built in Godot Engine 4.2+.

## Features in This MVP

✅ **Player Controls**: Walk, jump, and shoot
✅ **Enemies**: 3 patrolling enemies that damage you on contact  
✅ **Combat**: Shoot enemies to defeat them (2 hits each)
✅ **Health System**: 3 hearts displayed at top-left
✅ **Level Design**: Platforms to jump on, scrolling camera
✅ **Game Over**: Lose all hearts → restart level

## How to Play

### Option 1: Using Godot Editor (Recommended)

1. **Download Godot Engine**
   - Go to https://godotengine.org/download
   - Download Godot 4.2 or newer
   - Install/extract it

2. **Open the Project**
   - Launch Godot
   - Click "Import"
   - Navigate to this folder
   - Select `project.godot`
   - Click "Import & Edit"

3. **Run the Game**
   - Press F5 or click the Play button (▶) at top-right
   - Game window will open

### Option 2: Export as Executable (Advanced)

1. Open project in Godot
2. Go to Project → Export
3. Add export template for your platform
4. Export the game
5. Run the exported executable

## Controls

| Key | Action |
|-----|--------|
| **A** or **←** | Move Left |
| **D** or **→** | Move Right |
| **W** or **Space** | Jump |
| **X** or **J** | Shoot |

## Gameplay Tips

1. **Jump on platforms** to reach higher areas and avoid enemies
2. **Shoot enemies twice** to defeat them (they flash red when hit)
3. **Avoid enemy contact** - they take away 1 heart
4. **After taking damage**, you're invulnerable for 1.5 seconds (you'll flash)
5. **Watch your hearts** at the top-left corner
6. **Lose all hearts** = Game Over (auto-restarts after 2 seconds)

## Visual Guide

```
YOU:  [Blue rectangle]  - The player character
ENEMIES: [Red squares] - Patrol back and forth
BULLETS: [Yellow squares] - Your projectiles
PLATFORMS: [Brown rectangles] - Jump on these
HEARTS: [Red squares] - Your health (top-left)
```

## Troubleshooting

### Game won't run?
- Make sure you have Godot 4.2 or newer
- Make sure all files are in the correct folders
- Check that `project.godot` is in the root folder

### Can't control the character?
- Make sure the game window has focus
- Try clicking on the game window
- Check that you're pressing the correct keys

### Enemies won't die?
- They need 2 hits each
- Make sure bullets are hitting them
- Look for the red flash when they take damage

### Fell off the world?
- There are walls on left and right
- If you die, game restarts automatically

## File Structure

```
godot_sandbox/
├── project.godot       - Main project file (open this in Godot)
├── README.md          - Project overview
├── GAME_README.md     - Detailed game documentation
├── DESIGN.md          - Game design document
├── QUICK_START.md     - This file!
├── icon.svg           - Project icon
├── scenes/            - Game scenes (.tscn files)
│   ├── main.tscn      - Main level
│   ├── player.tscn    - Player character
│   ├── enemy.tscn     - Enemy character
│   ├── bullet.tscn    - Projectile
│   └── hud.tscn       - Health display
└── scripts/           - Game code (.gd files)
    ├── main.gd        - Level controller
    ├── player.gd      - Player logic
    ├── enemy.gd       - Enemy AI
    ├── bullet.gd      - Projectile behavior
    └── hud.gd         - UI controller
```

## What's Next?

This is an MVP (Minimum Viable Product). Possible enhancements:

- Add sound effects and music
- Create proper sprite graphics
- Add more enemy types
- Create multiple levels
- Add power-ups and collectibles
- Implement boss battles
- Add a score system
- Create a main menu

## Need Help?

- **Godot Documentation**: https://docs.godotengine.org/
- **GDScript Basics**: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- **Check the code**: All scripts are commented and in the `scripts/` folder

## License

Created for educational and demonstration purposes. Free to use and modify.

---

**Enjoy the game! Happy platforming! 🎮**
