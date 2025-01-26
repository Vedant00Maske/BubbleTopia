extends State

func enter():
	super.enter()
	animation_player.play("death")
	Audio.play_golemdead()
	
	# Delay for 2 seconds
	await get_tree().create_timer(0.8).timeout
	
	# Store tree reference before animation
	var tree = get_tree()
	await animation_player.animation_finished
	
	if is_instance_valid(self):
		Audio.stop_mus()
		tree.change_scene_to_file("res://scenes/outro_scene.tscn")
