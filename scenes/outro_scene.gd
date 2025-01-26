extends Node2D

func _ready():
	# Properly start Dialogic without manually adding the child
	Dialogic.start("outro_story")
	# Connect to the timeline finished signal
	Dialogic.timeline_ended.connect(_on_dialog_ended)

func _on_dialog_ended():
	get_tree().change_scene_to_file("res://scenes/credit_scene.tscn")
