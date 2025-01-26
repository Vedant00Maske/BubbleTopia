extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_switch_body_entered(body: CharacterBody2D) -> void:
	if $switch/AnimatedSprite2D.frame == 0:
		$switch/AnimatedSprite2D.frame = 1
		$door/AnimationPlayer.play("slidesideways")
		


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if $switch/AnimatedSprite2D.frame == 0:
		Dialogic.start("door_switch")
	else:
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
