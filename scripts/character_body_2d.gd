extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed: int 
var input_dir: Vector2
var screen_size: Vector2


func _ready() -> void:
	speed = 200

func get_input():
	input_dir = Input.get_vector("left","right","up","down")
	velocity = speed * input_dir
	screen_size = get_viewport_rect().size
	
	# Handle animations based on movement direction
	if input_dir == Vector2.ZERO:
		animated_sprite.stop()
	elif input_dir.x != 0:
		animated_sprite.play("right" if input_dir.x > 0 else "left")
	elif input_dir.y != 0:
		animated_sprite.play("down" if input_dir.y > 0 else "up")
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	position = position.clamp(Vector2.ZERO,screen_size)
