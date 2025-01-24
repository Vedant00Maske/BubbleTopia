extends Node2D

@onready var main = get_node("/root/Main")

signal hit_p

var enenmy_scene := preload("res://scenes/enemy.tscn")
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:
		var spawn = spawn_points[randi() % spawn_points.size()]
		var enemy = enenmy_scene.instantiate()
		enemy.position = spawn.position
		enemy.hit_player.connect(hit)
		main.add_child(enemy)
		enemy.add_to_group("enemies")
	
func hit():
	hit_p.emit()
