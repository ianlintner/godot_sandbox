extends Area2D

# Enemy constants
const SPEED = 30.0
const PATROL_DISTANCE = 80.0

# Health system
@export var max_health = 2
var current_health = max_health

# Movement
var direction = 1
var start_position = Vector2.ZERO

func _ready():
	start_position = global_position
	add_to_group("enemy")
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	# Simple patrol AI
	global_position.x += direction * SPEED * delta
	
	# Check if we've moved too far from start position
	var distance = global_position.x - start_position.x
	if abs(distance) > PATROL_DISTANCE:
		direction *= -1
		$Sprite2D.scale.x = -direction

func _on_body_entered(body):
	# Damage player on contact
	if body.is_in_group("player") or body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(1)

func take_damage(amount: int = 1):
	current_health -= amount
	
	# Flash effect
	modulate = Color(1, 0.5, 0.5)
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1, 1, 1)
	
	if current_health <= 0:
		die()

func die():
	queue_free()
