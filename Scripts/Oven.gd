extends StaticBody2D

onready var sprite = $Sprite

var canTrigger = false

func _process(delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				# Checks if the player has food in inventory
				if GameParameters.items.has("Raw Food"):
					AudioManager.play("res://Assets/Audio/Cooking.ogg")
					# Deletes food entry from inventory if food about to be empty
					if GameParameters.items["Raw Food"] == 1:
						GameParameters.items.erase("Raw Food")
					else:
						GameParameters.items["Raw Food"] -= 1
					get_parent().get_parent().get_node("UI").show_popup("Prepared meal, hunger decreased")
					get_parent().get_parent().get_node("UI").refresh_inventory()
					GameParameters.hunger -= 35

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)
