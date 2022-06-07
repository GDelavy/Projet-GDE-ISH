extends Node2D



func _ready():
	if GameParameters.currentOrder != null:
		var item = load("res://Prefabs/Item.tscn")
		var instance = item.instance()
		instance.position = Vector2(384,256)
		#instance.item_name = GameParameters.currentOrder
		instance.quantity = GameParameters.currentQuantity
		add_child(instance)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		GameParameters.lastVisited = get_tree().get_current_scene().get_name()
		get_tree().change_scene("res://World/Hallways.tscn")

