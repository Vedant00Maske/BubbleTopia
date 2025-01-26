extends CharacterBody2D

@onready var player = get_parent().find_child("Player3")
@onready var sprite = $Sprite2D
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var melee_need = get_node("FiniteStateMachine/MeleeAttack")
@onready var laser_need = get_node("FiniteStateMachine/LaserBeam")

signal hit_player3
signal hit_laser

var direction: Vector2
var DEF = 0

var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff") 
	

func _ready():
	# Connect melee attack
	melee_need.hit_p.connect(hit)
	laser_need.hit_l.connect(hit_l)
	set_physics_process(false)

	# Find all bullets and connect their signals dynamically
	for bullet in get_tree().get_nodes_in_group("bullets"):  # Ensure all bullets are in the "bullets" group
		bullet.connect("player_hit_bullet", Callable(self, "take_damage"))

func _process(delta):
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage():
	health -= 1
	

func hit():
	emit_signal("hit_player3")
	
func hit_l():
	emit_signal("hit_laser")
