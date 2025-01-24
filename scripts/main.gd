# In Main Script
extends Node

var max_enemies: int
var level: int
var lives: int
var current_enemies: int
signal player_damaged  # New signal for damage
signal enemy_killed

func _ready() -> void:
	level = 1
	lives = 50
	max_enemies = 10
	current_enemies = max_enemies
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)
	connect("enemy_killed", Callable(self, "_on_enemy_killed"))

func _on_enemy_killed() -> void:
	current_enemies -= 1
	$HUD_Level1/EnemiesLabel.text = "X " + str(current_enemies)

func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	emit_signal("player_damaged")  # Emit signal when player is hit
