extends CharacterBody2D

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

var explosion_scene := preload("res://scenes/enemy_explosion.tscn")

signal hit_player 

var alive: bool = true
var entered: bool = false
var speed: int = 180
var direction: Vector2

func _ready() -> void:
	var screen_rect = get_viewport_rect()
	var dist = screen_rect.get_center() - position
	set_initial_direction(dist)

func set_initial_direction(dist: Vector2):
	if abs(dist.x) > abs(dist.y):
		direction.x = dist.x
		direction.y = 0
	else:
		direction.x = 0
		direction.y = dist.y

func _physics_process(delta: float) -> void:
	if alive:
		$AnimatedSprite2D.animation = "swim"
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0

func die():
	alive = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "die"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	var explosion = explosion_scene.instantiate()
	explosion.position = position
	main.add_child(explosion)
	explosion.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_entrance_timer_timeout() -> void:
	entered = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()
