extends CharacterBody2D

var speed: int
var can_shoot: bool
var screen_size: Vector2

signal shoot

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	speed = 200
	can_shoot = true
	
	
func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position,dir)
		can_shoot = false
		$ShootTimer.start()
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# player Rotation
	var mouse = get_local_mouse_position()
	var angle = snapped(mouse.angle(), PI / 4) / (PI/4)
	angle = wrapi(int(angle),0,8)
	
	$AnimatedSprite2D.animation = "walk" + str(angle)
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1


func _on_shoot_timer_timeout() -> void:
	can_shoot = true
