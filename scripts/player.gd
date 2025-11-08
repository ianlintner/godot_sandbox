extends CharacterBody2D

# Player constants
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 800.0
const SHOOT_COOLDOWN = 0.3

# Health system
@export var max_health = 3
var current_health = max_health
var is_invulnerable = false
var invulnerability_timer = 0.0
const INVULNERABILITY_DURATION = 1.5

# Shooting system
var can_shoot = true
var shoot_timer = 0.0
var bullet_scene = preload("res://scenes/bullet.tscn")

# References
@onready var sprite = $Sprite2D

signal health_changed(new_health)
signal player_died

func _ready():
	current_health = max_health
	emit_signal("health_changed", current_health)

func _physics_process(delta):
	# Handle invulnerability timer
	if is_invulnerable:
		invulnerability_timer -= delta
		if invulnerability_timer <= 0:
			is_invulnerable = false
			modulate.a = 1.0
		else:
			# Flashing effect
			modulate.a = 0.5 + 0.5 * sin(invulnerability_timer * 20)
	
	# Handle shoot cooldown
	if not can_shoot:
		shoot_timer -= delta
		if shoot_timer <= 0:
			can_shoot = true
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on direction
		if direction > 0:
			sprite.scale.x = 1
		else:
			sprite.scale.x = -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	move_and_slide()

func shoot():
	can_shoot = false
	shoot_timer = SHOOT_COOLDOWN
	
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	
	# Position bullet in front of player
	var offset = 20 if sprite.scale.x > 0 else -20
	bullet.global_position = global_position + Vector2(offset, 0)
	
	# Set bullet direction
	bullet.direction = 1 if sprite.scale.x > 0 else -1

func take_damage(amount: int = 1):
	if is_invulnerable:
		return
	
	current_health -= amount
	emit_signal("health_changed", current_health)
	
	if current_health <= 0:
		die()
	else:
		is_invulnerable = true
		invulnerability_timer = INVULNERABILITY_DURATION
		# Knockback effect
		velocity.y = JUMP_VELOCITY * 0.5

func die():
	emit_signal("player_died")
	# Play death animation/effect
	queue_free()

func heal(amount: int = 1):
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", current_health)
