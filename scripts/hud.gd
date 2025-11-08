extends CanvasLayer

@onready var hearts_container = $MarginContainer/HBoxContainer

func _ready():
	pass

func update_health(current_health: int, max_health: int):
	# Clear existing hearts
	for child in hearts_container.get_children():
		child.queue_free()
	
	# Create heart display
	for i in range(max_health):
		var heart = ColorRect.new()
		heart.custom_minimum_size = Vector2(16, 16)
		if i < current_health:
			heart.color = Color(1, 0, 0, 1)  # Red for filled hearts
		else:
			heart.color = Color(0.3, 0.3, 0.3, 1)  # Gray for empty hearts
		hearts_container.add_child(heart)

func show_game_over():
	var game_over_label = Label.new()
	game_over_label.text = "GAME OVER"
	game_over_label.position = Vector2(120, 80)
	add_child(game_over_label)
