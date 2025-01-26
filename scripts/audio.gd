extends Node2D


@export var mute: bool = false

func _ready() -> void:
	if not mute:
		play_music()

func play_music():
	if not mute:
		$Music.play()
		
func play_bubble():
	if not mute:
		$Bubble.play()
		
func play_switch():
	if not mute:
		$DoorSwitch.play()
		
func play_hit():
	if not mute:
		$Hit.play()
		
func play_door():
	if not mute:
		$Door.play()
		
func play_golemdead():
	if not mute:
		$GolemDead.play()

func play_laser():
	if not mute:
		$Laser.play()

func stop_mus():
	if not mute:
		$Music.stop()
