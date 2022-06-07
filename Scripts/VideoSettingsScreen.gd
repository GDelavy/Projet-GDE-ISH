extends ScreenManager

var textVsync = null

func _ready():
	# Creates all selectors we want
	var selectorFullscreen = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
	var selectorVsync = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
	var selectorBack = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
	
	textVsync = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/OptionName
	if OS.vsync_enabled == true:
		textVsync.text = "Vsync: On"
	else:
		textVsync.text = "Vsync: Off"
	# Creates an array with all selectors, and set selection to first element
	selectorArray = [selectorFullscreen, selectorVsync, selectorBack]
	set_current_selection(0)

# Does action based on where the cursor is
func handle_selection(_currentSelection):
	if _currentSelection == 0:
		if OS.window_fullscreen == true:
			OS.window_fullscreen = false
		else:
			OS.window_fullscreen = true
	elif _currentSelection == 1:
		if OS.vsync_enabled == true:
			OS.vsync_enabled = false
			textVsync.text = "Vsync: Off"
		else:
			OS.vsync_enabled = true
			textVsync.text = "Vsync: On"
	elif _currentSelection == 2:
		get_tree().change_scene("res://World/OptionsScreen.tscn")
