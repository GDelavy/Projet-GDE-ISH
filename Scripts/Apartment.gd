extends Node2D

onready var ui = $UI

onready var television = $UI/CanvasLayer/TV
onready var computer = $UI/CanvasLayer/Computer
onready var player = $Player

var canAccessTV = false
var canAccessRadio = false
var canAccessPC = false
var canAccessPhone = false
var canAccessLibrary = false

var library_dialogue = Dialogic.start("LibraryAdvice")

# Triggered when the player picks up an item
func item_picked_up(item_name, quantity):
	if GameParameters.items.has(item_name):
		GameParameters.items[item_name] += quantity
	else:
		GameParameters.items[item_name] = quantity
	ui.refresh_inventory()

# Called when TV is toggled by player
func set_tv_visible():
	if television.visible:
		television.visible = false
		player.canMove = true
		television.reset_display()
	else:
		television.visible = true
		player.canMove = false

# Called when Computer is toggled by player
func set_computer_visible():
	if computer.visible:
		computer.visible = false
		player.canMove = true
		computer.reset_display()
	else:
		computer.visible = true
		player.canMove = false

# Exit scene to hallway
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GameParameters.lastVisited = get_tree().get_current_scene().get_name()
		get_tree().change_scene("res://World/Hallways.tscn")
