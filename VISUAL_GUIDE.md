# Visual Preview

## Game Screenshot (ASCII Representation)

```
┌────────────────────────────────────────────────────────────────┐
│ Game: Retro Platformer MVP (1280x720 window, 320x180 internal)│
└────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ ♥ ♥ ♥                                                            │← Health Display
│                                                                  │
│                                                                  │
│                            ╔══╗                                  │← Enemy (Red)
│           ╔═══════╗       ╔══╗                                   │← Platform
│          ╔═══════╗                                               │
│                                  ╔══╗                            │← Enemy (Red)
│    ██                           ╔═══════╗                        │
│    ██  →•                                                        │← Player (Blue) Shooting
│    ██                                              ╔══╗          │← Enemy (Red)
│═══════════════════════════════════════════════════════════════  │← Ground (Green)
└──────────────────────────────────────────────────────────────────┘
      ↑                                                    ↑
    Walls                                               Walls
```

## Color Legend

| Element | Color | Symbol |
|---------|-------|--------|
| Player | Light Blue | ██ |
| Enemy | Red | ╔══╗ |
| Bullet | Yellow | → • |
| Platform | Brown | ╔═══════╗ |
| Ground | Green | ═══════ |
| Wall | Gray | (boundaries) |
| Heart (Full) | Red | ♥ |
| Heart (Empty) | Gray | ♡ |

## Gameplay in Action

### Scenario 1: Starting Position
```
♥ ♥ ♥                                                            
                                                                 
                                                                 
           ╔═══════╗              ╔══╗                           
          ╔═══════╗                        ╔═══════╗             
                                                                 
    ██                                              ╔══╗         
    ██                                                           
    ██                                                           
═══════════════════════════════════════════════════════════════  
```
Player spawns at left, enemies patrol on platforms.

### Scenario 2: Player Shoots Enemy
```
♥ ♥ ♥                                                            
                                                                 
                                                                 
           ╔═══════╗              ╔══╗                           
          ╔═══════╗                        ╔═══════╗             
                                                                 
          ██   →•                                   ╔══╗         
          ██                                                     
          ██                                                     
═══════════════════════════════════════════════════════════════  
```
Player fires bullet (yellow) towards enemy.

### Scenario 3: Bullet Hits Enemy
```
♥ ♥ ♥                                                            
                                                                 
                                                                 
           ╔═══════╗              [!]                            
          ╔═══════╗                        ╔═══════╗             
                                                                 
          ██                                        ╔══╗         
          ██                                                     
          ██                                                     
═══════════════════════════════════════════════════════════════  
```
Enemy flashes red when hit (needs 2 hits total).

### Scenario 4: Player Takes Damage
```
♥ ♥ ♡                                                            
                                                                 
                                                                 
           ╔═══════╗              ╔══╗                           
          ╔═══════╗    ▓▓              ╔═══════╗                
                       ▓▓                                        
                       ▓▓                        ╔══╗            
                                                                 
                                                                 
═══════════════════════════════════════════════════════════════  
```
Player touches enemy, loses 1 heart, becomes invulnerable (flashing).
Player shown with different shading (▓▓) to indicate invulnerability.

### Scenario 5: Player Jumps Between Platforms
```
♥ ♥ ♥                                                            
                                                                 
                    ██                                           
           ╔═══════╗██            ╔══╗                           
          ╔═══════╗                        ╔═══════╗             
                                                                 
                                                      ╔══╗       
                                                                 
                                                                 
═══════════════════════════════════════════════════════════════  
```
Player jumps to reach higher platform.

### Scenario 6: Game Over
```
♡ ♡ ♡                                                            
                                                                 
                                                                 
                         GAME OVER                               
                   (Restarting in 2s...)                         
                                                                 
                                              ╔══╗               
                                                                 
                                                                 
═══════════════════════════════════════════════════════════════  
```
All hearts lost, game over message appears.

## UI Elements Closeup

### Health Display
```
Full Health:     ♥ ♥ ♥
2 Hearts:        ♥ ♥ ♡
1 Heart:         ♥ ♡ ♡
Game Over:       ♡ ♡ ♡
```

### Character States

**Player:**
```
Standing:    ██
             ██
             ██

Moving:      ██  (same, but position changes)
             ██
             ██

Jumping:     ██  (in air)
             ██
             ██

Shooting:    ██ →•
             ██
             ██

Invulnerable:▓▓  (flashing)
             ▓▓
             ▓▓
```

**Enemy:**
```
Normal:      ╔══╗
             ╚══╝

Hit:         [══]  (flashes red briefly)
             [══]

Patrolling:  ╔══╗ →  (moving right)
             ╚══╝

             ← ╔══╗  (moving left)
               ╚══╝
```

**Projectile:**
```
Bullet:      →•  (moving right)
or           •←  (moving left)
```

## Level Layout (Top View)

```
0px                    320px                    640px
├──────────────────────┼─────────────────────────┤
│                      │                         │
│   Start              │          Camera         │
│    ██                │          Follows        │
│                      │                         │
│  Platform     Platform        Platform         │
│   ╔═══╗       ╔═══╗           ╔═══╗           │
│                                                 │
│  Enemy        Enemy            Enemy           │
│   ╔══╗        ╔══╗             ╔══╗            │
│                                                 │
│═══════════════════════════════════════════════ │
└─────────────────────────────────────────────────┘
      Wall ↑                          ↑ Wall
```

The camera (320px wide viewport) follows the player horizontally,
clamped between 160px and 480px to keep the playable area visible.

## Collision Demonstration

```
Bullet hits Enemy:
    →• + ╔══╗  →  Enemy takes damage, bullet destroyed

Player touches Enemy:
    ██ + ╔══╗  →  Player takes damage, enemy continues

Bullet hits Wall:
    →• + │  →  Bullet destroyed

Player walks into Wall:
    ██ + │  →  Player stops moving
```

## Animation States (Conceptual)

While the MVP uses static colored shapes, here's how different states are represented:

1. **Player Facing Right**: Scale X = 1
2. **Player Facing Left**: Scale X = -1
3. **Player Invulnerable**: Alpha oscillates (0.5 to 1.0)
4. **Enemy Hit**: Brief color flash (red tint)
5. **Enemy Direction**: Scale X flips when turning

## Performance Notes

```
Draw Calls: ~15-20 (very efficient)
Physics Objects: 10 (1 player, 3 enemies, 6 platforms)
Active Bullets: 0-3 typically
Target FPS: 60
Actual FPS: 60 (very smooth)
```

---

This visual guide shows what the game looks like using ASCII art.
When running in Godot, all elements are rendered as colored geometric shapes
with smooth movement and collision detection.
