extends Node  # Or Node2D depending on your main scene's root node type

# This function will be triggered when the bullet's signal is emitted
signal player_damaged

# In Level3 scene
func _ready():
	# Your existing code...
	Dialogic.start("level3_desc")
	var player = $Player3  # Adjust path as needed
	var ui = $HUD_Level_3  # Adjust path as needed
	player.lives_changed.connect(ui.update_lives)
	

func _on_golem_boss_hit_player_3() -> void:
	emit_signal("player_damaged")
	



func _on_golem_boss_hit_laser() -> void:
	emit_signal("player_damaged")
