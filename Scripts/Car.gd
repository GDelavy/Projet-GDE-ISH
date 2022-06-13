extends StaticBody2D

onready var sprite = $Sprite

var canTrigger = false

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if GameParameters.items.has("Toolkit"):
			if canTrigger and !GameParameters.isCarBatteryOut:
				GameParameters.items["Car Battery"] = 1
				AudioManager.play("res://Assets/Audio/Tools.wav")
				owner.ui.refresh_inventory()
				# Remove toolkit
				GameParameters.items.erase("Toolkit")
				owner.ui.refresh_inventory()
				
				GameParameters.isCarBatteryOut = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)
