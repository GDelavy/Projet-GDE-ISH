extends Node2D

onready var sprite = $Sprite

var canTrigger = false

func _ready():
	if GameParameters.isElectricityRestored:
		sprite.texture = load("res://Assets/plugged_battery.png")
		

func _process(_delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				if !GameParameters.isElectricityOn:
					if GameParameters.items.has("Car Battery"):
						if GameParameters.items.has("Power Kit"):
							GameParameters.items.erase("Car Battery")
							GameParameters.items.erase("Power Kit")
							owner.ui.show_popup("Power back on", true)
							GameParameters.danger -= 20
							GameParameters.isElectricityRestored = true
							GameParameters.isElectricityOn = true
							sprite.texture = load("res://Assets/plugged_battery.png")
						else:
							owner.ui.show_popup("Power Kit needed")
					else:
						owner.ui.show_popup("Power source needed")
				else:
					owner.ui.show_popup("Power already on")

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)
