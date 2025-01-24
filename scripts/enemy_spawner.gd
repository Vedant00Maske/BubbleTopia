extends Node2D
@onready var main = get_node("/root/Main")
signal hit_p

var enemy_scenes := [
	preload("res://scenes/enemy.tscn"),
	preload("res://scenes/enemy_2.tscn"),
	preload("res://scenes/enemy_3.tscn")
]
var spawn_points := []

func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:
		var spawn = spawn_points[randi() % spawn_points.size()]
		var enemy = enemy_scenes[randi() % enemy_scenes.size()].instantiate()
		enemy.position = spawn.position
		enemy.hit_player.connect(hit)
		main.add_child(enemy)
		enemy.add_to_group("enemies")

func hit():
	hit_p.emit()
