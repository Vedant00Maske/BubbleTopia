extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:	
		Audio.play_bubble()
		queue_free()
