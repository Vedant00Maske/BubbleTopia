extends Area2D

var speed: int = 500
var direction: Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += speed * direction * delta


func _on_bullet_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "World":
		queue_free()
	else:
		if body.alive:
			body.die()
			queue_free()
