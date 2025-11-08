extends Node2D

@onready var player = $Player
@onready var hud = $HUD
@onready var camera = $Camera2D
@onready var treasure = $Treasure

var level_complete = false

func _ready():
	# Connect player signals
	player.health_changed.connect(_on_player_health_changed)
	player.player_died.connect(_on_player_died)
	
	# Connect treasure signal
	treasure.treasure_collected.connect(_on_treasure_collected)
	
	# Initialize HUD with player health
	hud.update_health(player.current_health, player.max_health)
	
	# Add player to group for enemy detection
	player.add_to_group("player")

func _process(_delta):
	# Make camera follow player horizontally
	camera.position.x = clamp(player.position.x, 160, 480)

func _on_player_health_changed(new_health):
	hud.update_health(new_health, player.max_health)

func _on_player_died():
	hud.show_game_over()
	# Disable player input by removing from tree
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func _on_treasure_collected():
	level_complete = true
	hud.show_level_complete()
	# Disable player movement
	player.set_physics_process(false)
	# Wait a bit then reload or go to next level
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()
