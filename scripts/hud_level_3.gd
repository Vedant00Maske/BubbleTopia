extends CanvasLayer

@onready var lives_label = $LivesLabel
@onready var restart_label = $Button

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	restart_label.hide()
	restart_label.pressed.connect(_on_restart_pressed)
	if player:
		player.lives_changed.connect(update_lives)

func update_lives(lives: int):
	lives_label.text = " " + str(lives)
	if lives == 0:
		restart_label.show()

func _on_restart_pressed():
	get_tree().reload_current_scene()
