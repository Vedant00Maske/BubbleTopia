extends Node

var max_enemies: int
var level: int
var lives: int
var current_enemies: int
var can_transition: bool = false
var is_in_door: bool = false
var is_game_over: bool = false

signal player_damaged
signal enemy_killed

func _ready() -> void:
	$Level1Over.get_node("Level1Restart").pressed.connect(new_game)
	$Level1Over.hide()
	if is_game_over == false:
		Dialogic.start("level1_desc")
		Dialogic.timeline_ended.connect(_on_dialog_ended)
	level = 1
	lives = 5
	max_enemies = 35
	current_enemies = max_enemies
	update_hud()
	connect("enemy_killed", Callable(self, "_on_enemy_killed"))

func update_hud() -> void:
	$HUD_Level1.show()  # Ensure HUD is visible
	$Level1Over.hide()
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)

func _on_enemy_killed() -> void:
	current_enemies -= 1
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	if current_enemies <= 0:
		Dialogic.start("level_1_over")
		can_transition = true

func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	lives = max(0, lives)  # Ensure lives never go below 0
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	Audio.play_hit()
	emit_signal("player_damaged")

	if lives <= 0:
		$PlayerDead.set_deferred("visible", true)
		is_game_over = true
		$Level1Over.show()
		# Stop all game objects
		get_tree().call_group("game_objects", "set_process", false)
		get_tree().call_group("game_objects", "set_physics_process", false)

func _on_door_to_lvl_2_body_entered(body: Node2D) -> void:
	is_in_door = true

func _process(delta: float) -> void:
	if is_game_over:
		return
	if is_in_door and can_transition and Input.is_action_just_pressed("ui_accept"):
		print("Transitioning to level 2")
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func new_game() -> void:
	# Reset game variables
	is_game_over = false
	level = 1
	lives = 5
	max_enemies = 40
	current_enemies = max_enemies
	# Update the HUD and show it
	update_hud()
	$Level1Over.hide()

	# Reload the current scene
	get_tree().reload_current_scene()

func _on_dialog_ended():
	pass
