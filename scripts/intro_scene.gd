extends Node2D

func _ready():
	# Properly start Dialogic without manually adding the child
	Dialogic.start("intro_story")
	
	# Connect to the timeline finished signal
	Dialogic.timeline_ended.connect(_on_dialog_ended)

func _on_dialog_ended():
	# Change to main game scene when dialogue ends
	get_tree().change_scene_to_file("res://scenes/main.tscn")
