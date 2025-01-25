extends Node
var max_enemies: int
var level: int
var lives: int
var current_enemies: int
var can_transition: bool = false
signal player_damaged
signal enemy_killed

var is_in_door: bool = false



func _ready() -> void:
	level = 1
	lives = 3
	max_enemies = 1

	current_enemies = max_enemies
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	connect("enemy_killed", Callable(self, "_on_enemy_killed"))


func _on_enemy_killed() -> void:
	current_enemies -= 1
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	
	# Allow transition only when all enemies are killed
	if current_enemies <= 0:
		$Label.set_deferred("visible",true)
		can_transition = true

func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	emit_signal("player_damaged")

func _on_door_to_lvl_2_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("player"):
		is_in_door = true


func _process(delta: float) -> void:
	if is_in_door and can_transition and Input.is_action_just_pressed("e"):
		print("Transitioning to level 2")
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
