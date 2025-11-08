extends Area2D

const SPEED = 200.0
var direction = 1

func _ready():
	# Connect to body entered signal
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position.x += direction * SPEED * delta

func _on_body_entered(body):
	# Hit a wall or platform
	if body.is_in_group("world"):
		queue_free()

func _on_area_entered(area):
	# Hit an enemy
	if area.is_in_group("enemy"):
		if area.has_method("take_damage"):
			area.take_damage(1)
		queue_free()

func _on_screen_exited():
	queue_free()
