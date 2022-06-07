extends ScreenManager

func _ready():
	# Creates all selectors we want
	var selectorVideo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
	var selectorAudio = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
	var selectorControls = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
	var selectorBack = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector
	
	# Creates an array with all selectors, and set selection to first element
	selectorArray = [selectorVideo, selectorAudio, selectorControls, selectorBack]
	set_current_selection(0)

# Does action based on where the cursor is
func handle_selection(_currentSelection):
	if _currentSelection == 0:
		get_tree().change_scene("res://World/VideoSettingsScreen.tscn")
	elif _currentSelection == 1:
		get_tree().change_scene("res://World/AudioSettingsScreen.tscn")
	elif _currentSelection == 2:
		print("...g pas fait non plus :(")
	elif _currentSelection == 3:
		get_tree().change_scene("res://World/MainMenu.tscn")
