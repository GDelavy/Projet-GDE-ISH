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

func item_picked_up(item_name, quantity):
	ui.items[item_name] = quantity
	ui.refresh_inventory()

func set_tv_visible():
	if television.visible:
		television.visible = false
		player.canMove = true
	else:
		television.visible = true
		player.canMove = false

func set_computer_visible():
	if computer.visible:
		computer.visible = false
		player.canMove = true
		computer.reset_display()
	else:
		computer.visible = true
		player.canMove = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GameParameters.lastVisited = get_tree().get_current_scene().get_name()
		get_tree().change_scene("res://World/Hallways.tscn")


func _on_TV_Area_body_entered(body):
	if body.is_in_group("player"):
		canAccessTV = true


func _on_TV_Area_body_exited(body):
	if body.is_in_group("player"):
		canAccessTV = false


func _on_Computer_body_entered(body):
	if body.is_in_group("player"):
		canAccessPC = true


func _on_Computer_body_exited(body):
	if body.is_in_group("player"):
		canAccessPC = false
