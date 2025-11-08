# Game Design Document - Retro Platformer MVP

## Visual Layout

```
Game Window (1280x720 scaled from 320x180)
┌─────────────────────────────────────────────────────┐
│ ❤ ❤ ❤                                              │ HUD (Hearts)
│                                                     │
│                                                     │
│                          [Enemy]                    │
│        [Platform]    ─────────────                  │
│    ─────────────                                    │
│                              [Enemy]                │
│   [Player]                ─────────────             │
│     ▓▓                                              │
│     ▓▓                                    [Enemy]   │
│═══════════════════════════════════════════════════  │ Ground
└─────────────────────────────────────────────────────┘
```

## Game Elements

### Player Character (Blue Rectangle)
- **Size**: 16x24 pixels
- **Color**: Light blue (0.3, 0.6, 1.0)
- **Capabilities**:
  - Walk left/right at 100 px/s
  - Jump with velocity -300 px/s
  - Shoot projectiles every 0.3 seconds
  - 3 hearts of health
  - Invulnerability frames with flashing effect

### Enemies (Red Squares)
- **Size**: 16x16 pixels
- **Color**: Red (1.0, 0.2, 0.2)
- **Behavior**:
  - Patrol back and forth (80 pixels range)
  - Move at 30 px/s
  - 2 health points
  - Flash when hit
  - Damage player on contact

### Projectiles (Yellow Squares)
- **Size**: 8x8 pixels (circular hitbox)
- **Color**: Yellow (1.0, 1.0, 0.0)
- **Behavior**:
  - Travel at 200 px/s
  - Destroy on impact
  - Disappear off-screen

### Level Components
- **Ground**: Green platform (0.4, 0.8, 0.4) - Full width
- **Platforms**: Brown rectangles (0.6, 0.4, 0.2) - 100x20 pixels each
- **Walls**: Gray barriers (0.3, 0.3, 0.3) - Contain the play area
- **Level Width**: 640 pixels (scrolls with camera)
- **Level Height**: 180 pixels

## Gameplay Flow

```
Start Game
    ↓
Player spawns at (50, 100)
    ↓
[GAMEPLAY LOOP]
├─ Move & Jump
├─ Shoot at enemies
├─ Take damage from enemies
├─ Lose hearts
└─ All hearts lost?
    ├─ NO → Continue playing
    └─ YES → Game Over
         ↓
    Show "GAME OVER"
         ↓
    Wait 2 seconds
         ↓
    Restart level
```

## Input Mapping

| Action | Keys | Function |
|--------|------|----------|
| Move Left | A, Left Arrow | Walk left |
| Move Right | D, Right Arrow | Walk right |
| Jump | W, Space | Jump (only on ground) |
| Shoot | X, J | Fire projectile |

## Physics & Collision

### Collision Layers
1. **Layer 1 (World)**: Platforms, walls, ground
2. **Layer 2 (Player)**: Player character
3. **Layer 3 (Enemy)**: Enemy characters
4. **Layer 4 (PlayerProjectile)**: Player bullets
5. **Layer 5 (EnemyProjectile)**: Reserved for future use

### Collision Matrix
```
           World  Player  Enemy  P.Proj  E.Proj
World       ✓      ✓       ✓       ✓       ✓
Player      ✓      -       ✓       -       ✓
Enemy       ✓      ✓       -       ✓       -
P.Proj      ✓      -       ✓       -       -
E.Proj      ✓      ✓       -       -       -
```

### Physics Values
- **Gravity**: 800 px/s²
- **Player Speed**: 100 px/s (horizontal)
- **Jump Velocity**: -300 px/s (upward)
- **Enemy Speed**: 30 px/s (horizontal)
- **Bullet Speed**: 200 px/s (horizontal)

## Camera Behavior

The camera follows the player horizontally with bounds:
- **Camera View**: 320x180 pixels
- **Follow Target**: Player X position
- **Bounds**: X clamped between 160 and 480 pixels
- **Y Position**: Fixed at 90 pixels
- **Behavior**: Smooth tracking within bounds

This ensures the camera shows the playable area (640px wide) as the player moves, without showing areas outside the level.

## UI/HUD Layout

```
┌─────────────────────────────────────────┐
│ ❤ ❤ ❤                                  │ Health Hearts
│                                         │ (Top-left corner)
│                                         │
│                                         │
│           [GAME SCREEN]                 │
│                                         │
│                                         │
│              GAME OVER                  │ Game Over Text
│                                         │ (Center, on death)
└─────────────────────────────────────────┘
```

Hearts:
- **Filled**: Red (1.0, 0.0, 0.0) - Current health
- **Empty**: Gray (0.3, 0.3, 0.3) - Lost health
- **Size**: 16x16 pixels each
- **Spacing**: 4 pixels between hearts

## Game States

### Playing State
- Player can move, jump, and shoot
- Enemies patrol and damage player on contact
- HUD shows current health
- Camera follows player

### Damaged State
- Player flashes for 1.5 seconds
- Player cannot take additional damage
- Slight upward knockback applied
- Alpha oscillates between 0.5 and 1.0

### Game Over State
- "GAME OVER" text displayed
- Input disabled
- 2-second delay
- Level automatically restarts
- Health reset to maximum

## Enemy AI States

### Patrol State (Default)
```
Moving Right
    ↓
Reached patrol distance?
    ├─ NO → Continue right
    └─ YES → Turn around
         ↓
    Moving Left
         ↓
    Reached patrol distance?
        ├─ NO → Continue left
        └─ YES → Turn around
             ↓
        [Loop]
```

### Hit State
- Flash red briefly (0.1 seconds)
- Reduce health by 1
- Check if health <= 0
  - If yes: Remove from scene
  - If no: Continue patrol

### Contact State
- When touching player
- Call player.take_damage(1)
- Continue patrol (no state change)

## Win Conditions
*Not implemented in MVP*
- Current version: Endless survival
- Future: Defeat all enemies or reach goal

## Lose Conditions
- Player health reaches 0
- Triggers Game Over state
- Level restarts after 2 seconds

## NES Capcom Inspiration

### Borrowed from Mega Man:
- ✅ Shooting mechanic with cooldown
- ✅ Side-scrolling platformer
- ✅ Simple enemy patterns
- ✅ Health display with segments
- ✅ Invulnerability frames after damage

### Borrowed from Duck Tales:
- ✅ Platform jumping gameplay
- ✅ Simple, colorful visuals
- ✅ Tight controls
- ⭕ (Future) Pogo-stick mechanic equivalent

### General NES Era Features:
- ✅ Pixel-perfect rendering
- ✅ Limited color palette aesthetic
- ✅ Simple geometric shapes
- ✅ Challenging but fair gameplay
- ✅ Instant restart on death
- ✅ No hand-holding or tutorials

## Performance Notes

- Target: 60 FPS
- No complex shaders or effects
- Simple collision detection
- Minimal draw calls (geometric shapes)
- Should run smoothly on any modern hardware
