extends CharacterBody2D

var speed: int
var can_shoot: bool
var screen_size: Vector2

# Flash effect variables
@export var flash_duration: float = 0.1
@export var flash_count: int = 3
@export var flash_color: Color = Color(1, 0, 0, 1)
var is_flashing: bool = false
var original_modulate: Color

signal shoot

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	speed = 200
	can_shoot = true
	original_modulate = $AnimatedSprite2D.modulate
	
	# Connect to the main scene's player_damaged signal
	# Get reference to the main scene and connect to its signal
	var main_scene =$".."  # or get_node("/root/Main") if that's your main scene path
	main_scene.connect("player_damaged", Callable(self, "_on_player_damaged"))
	
func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position,dir)
		Audio.play_bubble()
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
func player():
	pass
func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func flash_damage():
	if is_flashing:
		return
		
	is_flashing = true
	var tween = create_tween()
	
	for i in flash_count:
		# Flash to red
		tween.tween_property($AnimatedSprite2D, "modulate", flash_color, flash_duration)
		# Flash back to normal
		tween.tween_property($AnimatedSprite2D, "modulate", original_modulate, flash_duration)
	
	# Reset flashing state when done
	tween.tween_callback(func(): is_flashing = false)

# Signal handler for when player takes damage
func _on_player_damaged():
	flash_damage()
