extends Control

var prologue_scene = "res://World/Menus/PrologueMenu.tscn"
var world_scene = "res://World/Apartment.tscn"
var tutorial_scene = "res://World/Menus/TutorialMenu.tscn"
var credits_scene = "res://World/Menus/CreditsMenu.tscn"

var tutorial
var credits

onready var buttons = $Buttons

func _ready():
	# Preselects the start button
	$Buttons/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene(prologue_scene)

func _on_TutorialButton_pressed():
	tutorial = load(tutorial_scene).instance()
	remove_child(buttons)
	add_child(tutorial)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	credits = load(credits_scene).instance()
	remove_child(buttons)
	add_child(credits)

# Triggered by other menus to go back to main menu
func add_main_menu():
	add_child(buttons)
