extends State

@onready var pivot = $"../../Pivot"
var can_transition: bool = false

signal hit_l

func enter():
	super.enter()
	await play_animation("laser_cast")
	Audio.play_laser()
	await play_animation("laser")
	hit_l.emit()
	can_transition = true
 
func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
 
func set_target():
	# Add a vertical offset to aim lower
	var target_position = owner.direction
	# Adjust this value to aim lower. Positive values move the aim down
	var vertical_offset = Vector2(0, 40)  # Adjust the Y value (20) to aim higher or lower
	
	# Calculate angle with the offset
	pivot.rotation = (target_position + vertical_offset - pivot.position).angle()
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
