extends Area2D

var direction = Vector2.RIGHT
var speed = 500

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "GolemBoss":
		body.take_damage()
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
