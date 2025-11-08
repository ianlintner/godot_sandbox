# Retro Platformer MVP

A 2D platformer inspired by classic NES Capcom games like Duck Tales and Mega Man.

## Features

### Core Gameplay
- **Player Character**: Control a blue character that can move, jump, and shoot
- **Shooting Mechanic**: Fire projectiles to defeat enemies (X or J key)
- **Enemy System**: Red enemies patrol back and forth, damaging player on contact
- **Health System**: Player starts with 3 hearts/lives
- **Level Design**: Platforms to navigate, walls to contain the action
- **Hit Detection**: Projectiles destroy enemies, enemies damage player on contact
- **Invulnerability Frames**: After taking damage, player briefly becomes invulnerable with flashing effect

## Controls

- **A / Left Arrow**: Move left
- **D / Right Arrow**: Move right  
- **W / Space**: Jump
- **X / J**: Shoot

## Game Mechanics

### Player
- Movement speed: 100 pixels/second
- Jump height: Moderate arc for platforming
- Shoot cooldown: 0.3 seconds between shots
- Health: 3 hearts
- Invulnerability: 1.5 seconds after taking damage

### Enemies
- Patrol AI: Move back and forth in a set distance
- Health: 2 hits to defeat
- Contact damage: 1 heart to player
- Visual feedback: Flash red when hit

### Projectiles
- Speed: 200 pixels/second
- Damage: 1 hit point to enemies
- Auto-destroy: On impact or when off-screen

## Technical Details

### Project Structure
```
godot_sandbox/
├── scenes/
│   ├── main.tscn        # Main game level
│   ├── player.tscn      # Player character
│   ├── enemy.tscn       # Enemy character
│   ├── bullet.tscn      # Projectile
│   └── hud.tscn         # UI/Health display
├── scripts/
│   ├── main.gd          # Game manager
│   ├── player.gd        # Player controller
│   ├── enemy.gd         # Enemy AI
│   ├── bullet.gd        # Projectile behavior
│   └── hud.gd           # UI controller
└── project.godot        # Project configuration
```

### Collision Layers
1. **World**: Static platforms and walls
2. **Player**: Player character
3. **Enemy**: Enemy characters  
4. **PlayerProjectile**: Player bullets
5. **EnemyProjectile**: (Reserved for future enemy projectiles)

### Display Settings
- Internal resolution: 320x180 (retro pixel look)
- Window size: 1280x720 (4x scale)
- Viewport stretch mode for pixel-perfect scaling
- Nearest-neighbor texture filtering (no blur)

## How to Run

1. Install [Godot Engine 4.2+](https://godotengine.org/download)
2. Open Godot and import this project
3. Press F5 or click "Run Project" to play

## Development Notes

### MVP Status
This is a Minimum Viable Product with core features:
- ✅ Basic game level with platforms
- ✅ Player character with movement and jumping
- ✅ Shooting mechanic
- ✅ Enemy AI with patrol behavior
- ✅ Hit detection (projectile vs enemy, enemy vs player)
- ✅ Health/life system with hearts display
- ✅ Camera following the player
- ✅ Scrolling level (640px wide)
- ✅ Game over state

### Future Enhancements
Potential additions beyond MVP:
- Multiple levels with different layouts
- Power-ups and collectibles
- Enemy variety (shooting enemies, flying enemies)
- Boss battles
- Sound effects and music
- More complex player animations
- Score system
- Checkpoints and lives counter
- Particle effects for hits/explosions

## Art Style

Current MVP uses simple colored geometric shapes:
- **Player**: Blue rectangle (16x24 pixels)
- **Enemies**: Red squares (16x16 pixels)
- **Bullets**: Yellow squares (8x8 pixels)
- **Platforms**: Brown rectangles
- **Ground**: Green rectangle
- **Walls**: Gray rectangles

This placeholder art can be easily replaced with sprite sheets for a more polished look.

## License

This project is created for educational and demonstration purposes.
