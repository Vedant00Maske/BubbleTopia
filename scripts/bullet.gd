extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player3")
@onready var main_scene = get_tree().current_scene

var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var bullet_speed: float = 1000  # New variable to control bullet speed

func _ready() -> void:
	var timer = get_tree().create_timer(5.0)
	await timer.timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if !is_instance_valid(player):
		queue_free()
		return

	acceleration = (player.position - position).normalized() * bullet_speed
	velocity += acceleration * delta
	rotation = velocity.angle()
	#velocity = velocity.limit_length(150)
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player3":
		if main_scene.has_signal("player_damaged"):
			main_scene._on_golem_boss_hit_player_3()
		queue_free()
	elif body.name == "Level3BulletPlayer":
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
