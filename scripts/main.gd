extends Node2D

@onready var player = $Player
@onready var hud = $HUD
@onready var camera = $Camera2D

func _ready():
	# Connect player signals
	player.health_changed.connect(_on_player_health_changed)
	player.player_died.connect(_on_player_died)
	
	# Initialize HUD with player health
	hud.update_health(player.current_health, player.max_health)
	
	# Add player to group for enemy detection
	player.add_to_group("player")

func _on_player_health_changed(new_health):
	hud.update_health(new_health, player.max_health)

func _on_player_died():
	hud.show_game_over()
	# Disable player input by removing from tree
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
