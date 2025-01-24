extends CharacterBody2D

var screen_size : Vector2
var speed: int

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	speed = 1000

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	position = position.clamp(Vector2.ZERO, screen_size)
