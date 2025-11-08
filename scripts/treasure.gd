extends Area2D

# Signal emitted when treasure is collected
signal treasure_collected

func _ready():
	add_to_group("treasure")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Check if player touched the treasure
	if body.is_in_group("player") or body.name == "Player":
		collect()

func collect():
	# Emit signal for level completion
	emit_signal("treasure_collected")
	
	# Visual feedback - scale up briefly before disappearing
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_callback(queue_free)
