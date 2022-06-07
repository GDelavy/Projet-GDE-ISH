extends Node2D

onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameParameters.lastVisited == "Apartment":
		player.position = Vector2(304, 157)
	elif GameParameters.lastVisited == "Outside":
		player.position = Vector2(224, 585)
	elif GameParameters.lastVisited == "Basement":
		player.position = Vector2(79, 539)
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World/Basement.tscn")


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World/Apartment.tscn")


func _on_Outside_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World/Outside.tscn")
