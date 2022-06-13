extends Control


func _ready():
	Time.stop()
	# If the player wins
	if GameParameters.completedObjectives >= GameParameters.totalObjectives:
		$GameOver.text = "Congratulations!"
		$Comment.text = "You completed all the tasks"
		$Tasks.text = ""
		$Button.text = "Play Again"
	else:
		$Tasks.text = "You completed " + str(GameParameters.completedObjectives) + "/" + str(GameParameters.totalObjectives) + " tasks!"

func _on_Button_pressed():
	# Reset all relevant values
	Time.reset_values()
	GameParameters.reset_values()

	get_tree().change_scene("res://World/Apartment.tscn")
