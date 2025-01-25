extends State

signal hit_p

func enter():
	super.enter()
	animation_player.play("melee_attack")
	hit_p.emit()
	
 
func transition():
	if owner.direction.length() > 230 and owner.direction.length() < 480:
		get_parent().change_state("Follow")
