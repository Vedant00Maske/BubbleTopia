extends State

@export var bullet_node: PackedScene
var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("ranged_attack")
	await animation_player.animation_finished
	shoot()
	can_transition = true
 
func shoot():
	if !is_instance_valid(player):
		return
		
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position
	
	# Make sure the bullet has the necessary properties
	if bullet.has_method("init"):
		bullet.init(player)
	
	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
