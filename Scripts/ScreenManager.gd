extends MarginContainer

class_name ScreenManager

var currentSelection = 0
var selectorArray = null

# MUST BE OVERRIDEN WHEN CREATING NEW SCREEN
func _ready():
	# Creates all selectors we want
	var selectorStart = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
	var selectorOptions = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
	var selectorExit = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
	
	# Creates an array with all selectors, and set selection to first element
	selectorArray = [selectorStart, selectorOptions, selectorExit]
	set_current_selection(0)

# Does action based on where the cursor is. MUST BE OVERRIDEN ON NEW SCREEN
func handle_selection(_currentSelection):
	if _currentSelection == 0:
		get_tree().change_scene("res://World/Apartment.tscn")
	elif _currentSelection == 1:
		get_tree().change_scene("res://World/OptionsScreen.tscn")
	elif _currentSelection == 2:
		get_tree().quit()

func _process(delta):
	# Checks for user input reacts accordingly
	if Input.is_action_just_pressed("ui_down") and currentSelection < selectorArray.size() - 1:
		currentSelection += 1
		set_current_selection(currentSelection)
	if Input.is_action_just_pressed("ui_up") and currentSelection > 0:
		currentSelection -= 1
		set_current_selection(currentSelection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(currentSelection)

func set_current_selection(_currentSelection):
	# Clears all selectors text
	for element in selectorArray:
		element.text = ""

	# Sets a ">" in front of the selected option
	selectorArray[_currentSelection].text = ">"
