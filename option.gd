extends Control


# Called when the node enters the scene tree for the first time.



func _on_volume_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
