extends Control

func _ready():
	Time.stop()

func _on_Button_pressed():
	Time.gameOver = false
	Time.start()
	
	GameParameters.danger = 0
	GameParameters.stress = 0
	GameParameters.hunger = 0

	get_tree().change_scene("res://World/Apartment.tscn")
