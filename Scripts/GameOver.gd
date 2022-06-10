extends Control

func _ready():
	Time.stop()

func _on_Button_pressed():
	# Reset all relevant values
	Time.reset_values()
	GameParameters.reset_values()

	get_tree().change_scene("res://World/Apartment.tscn")
