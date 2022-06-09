extends Control

var world_scene = "res://World/Apartment.tscn"

var wait_time = 5

onready var labels = [$Intro, $Time, $Levels]
var currentLabel = 0
var maxLabel = 3

func _on_Button_pressed():
	Music.fade_music_out()
	get_tree().change_scene(world_scene)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		pass

func _on_Timer_timeout():
	if currentLabel < maxLabel:
		$Timer.stop()
		$Timer.set_wait_time(wait_time)
		$Tween.interpolate_property(labels[currentLabel], "modulate",
					Color(1,1,1,0), Color(1,1,1,1), 1.5,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
		$Timer.start()
		currentLabel += 1
