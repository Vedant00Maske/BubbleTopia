extends State
 
func enter():
	super.enter()
	animation_player.play("death")
	
	# Store tree reference before animation
	var tree = get_tree()
	
	await animation_player.animation_finished
	if is_instance_valid(self):
		tree.change_scene_to_file("res://scenes/outro_scene.tscn")
