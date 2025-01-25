extends Node  # Or `Node2D` depending on your main scene's root node type

# This function will be triggered when the bullet's signal is emitted
signal player_damaged


func _on_golem_boss_hit_player_3() -> void:
	emit_signal("player_damaged")
