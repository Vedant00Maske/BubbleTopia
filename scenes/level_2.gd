extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("level2_desc")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_switch_body_entered(body: CharacterBody2D) -> void:
	if $switch/AnimatedSprite2D.frame == 0:
		$switch/AnimatedSprite2D.frame = 1
		$door/AnimationPlayer.play("slidesideways")
		Audio.play_door()
		


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if $switch/AnimatedSprite2D.frame == 0:
		Dialogic.start("door_switch")
	else:
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
