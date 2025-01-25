extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_timer: Timer = $shootTimerAgain  # Ensure this timer node exists in the scene
@export var bullet_scene: PackedScene
@onready var main_scene: Node = get_tree().current_scene  # This connects to the current scene

var speed: int = 200
var can_shoot: bool = true
var input_dir: Vector2 = Vector2.ZERO

# Flash effect variables
@export var flash_duration: float = 0.1
@export var flash_count: int = 3
@export var flash_color: Color = Color(1, 0, 0, 1)
var is_flashing: bool = false
var original_modulate: Color

func _ready() -> void:
	if not bullet_scene:
		print("Bullet scene not assigned! Please set it in the Inspector.")
	
	# Initialize variables
	can_shoot = true
	original_modulate = $AnimatedSprite2D.modulate
	main_scene.connect("player_damaged", Callable(self, "_on_player_damaged"))

func get_input() -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

func _physics_process(delta: float) -> void:
	get_input()
	shoot_input()
	move_and_slide()

	# Player Rotation
	var mouse = get_local_mouse_position()
	var angle = snapped(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)

	animated_sprite.animation = "walk" + str(angle)

	if velocity.length() != 0:
		animated_sprite.play()
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1

func shoot() -> void:
	if not bullet_scene:
		print("Bullet scene is not assigned.")
		return
	
	# Instantiate the bullet
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	# Add the bullet to the current scene
	get_tree().current_scene.add_child(bullet)


func _on_shoot_timer_again_timeout() -> void:
	can_shoot = true

func shoot_input() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		shoot()
		can_shoot = false
		shoot_timer.start()
	
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
