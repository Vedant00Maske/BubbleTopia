# In Bullet Script
extends Area2D

@onready var main = get_node("/root/Main")
@onready var hud = get_node("/root/Main/HUD_Level1")

var speed: int = 500
var direction: Vector2

func _process(delta: float) -> void:
	position += speed * direction * delta

func _on_bullet_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "World":
		queue_free()
	else:
		if body.alive:
			main.emit_signal("enemy_killed")
			body.die()
			queue_free()
