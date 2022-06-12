extends Node2D

onready var ui = $UI

func _ready():
	if Time.time_left <= GameParameters.orderTime:
		if GameParameters.currentOrder != null:
			var item = load("res://Prefabs/Item.tscn")
			var instance = item.instance()
			instance.position = Vector2(168,224)
			instance.item_name = GameParameters.currentOrder
			instance.quantity = GameParameters.currentQuantity
			instance.owner = self
			add_child(instance)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GameParameters.lastVisited = get_tree().get_current_scene().get_name()
		get_tree().change_scene("res://World/Hallways.tscn")

func item_picked_up(item_name, quantity):
	GameParameters.items[item_name] = quantity
	ui.refresh_inventory()
