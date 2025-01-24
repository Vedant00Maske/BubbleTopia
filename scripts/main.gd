extends Node
var max_enemies: int
var level: int
var lives: int
var current_enemies: int
var can_transition: bool = false
signal player_damaged
signal enemy_killed

func _ready() -> void:
	level = 1
	lives = 3
	max_enemies = 30
	current_enemies = max_enemies
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	connect("enemy_killed", Callable(self, "_on_enemy_killed"))

func _on_enemy_killed() -> void:
	current_enemies -= 1
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	
	# Allow transition only when all enemies are killed
	if current_enemies <= 0:
		can_transition = true

func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	emit_signal("player_damaged")

func _on_door_to_lvl_2_body_entered(body: Node2D) -> void:
	# Only change scene if all enemies are killed
	if can_transition:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
