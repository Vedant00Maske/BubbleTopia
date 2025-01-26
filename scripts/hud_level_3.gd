extends CanvasLayer

@onready var lives_label = $LivesLabel

func _ready():
	# Get the player node and connect its signal
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.lives_changed.connect(update_lives)

func update_lives(lives: int):
	if lives == 0:
		get_tree().reload_current_scene()
	else:
		lives_label.text = " " + str(lives)
