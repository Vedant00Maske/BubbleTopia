extends CharacterBody2D

var speed: int

func _ready() -> void:
	speed = 100


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir*speed
	move_and_slide()
	
