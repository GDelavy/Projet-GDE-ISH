extends Node2D

onready var ui = $UI

func item_picked_up(item_name, quantity):
	if GameParameters.items.has(item_name):
		GameParameters.items[item_name] += quantity
	else:
		GameParameters.items[item_name] = quantity
	ui.refresh_inventory()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GameParameters.lastVisited = get_tree().get_current_scene().get_name()
		get_tree().change_scene("res://World/Hallways.tscn")
