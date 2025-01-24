extends Node

var max_enemies: int
var level: int
var lives: int

func _ready() -> void:
	level = 1
	lives = 2
	max_enemies = 20
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
	$HUD_Level1/EnemiesLabel.text = "X " + str(max_enemies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawner_hit_p() -> void:
	lives -= 1
	$HUD_Level1/LivesLabel.text = "X " + str(lives)
