extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player3")  # Player reference for movement logic
@onready var main_scene = get_tree().current_scene

var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Add lifetime timer for cleanup
	var timer = get_tree().create_timer(5.0)
	await timer.timeout
	queue_free()

# Process the bullet movement
func _physics_process(delta: float) -> void:
	if !is_instance_valid(player):
		queue_free()
		return
		
	# Move the bullet towards the player
	acceleration = (player.position - position).normalized() * 700
	velocity += acceleration * delta
	rotation = velocity.angle()
	velocity = velocity.limit_length(150)
	position += velocity * delta

# Detect collision with player or other objects
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player3":  # If it hits the player
		# Emit the damage signal through the main scene
		if main_scene.has_signal("player_damaged"):
			main_scene._on_golem_boss_hit_player_3()
		queue_free()  # Free the bullet after the collision
	elif body.name == "Level3BulletPlayer":
		# If it hits another object, free the bullet
		queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
