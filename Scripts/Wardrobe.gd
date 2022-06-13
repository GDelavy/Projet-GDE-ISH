extends StaticBody2D

onready var sprite = $Sprite

var canTrigger = false
var isFull = true

func _process(_delta):
	if canTrigger and !GameParameters.items.has("Clothes"):
		if Input.is_action_just_pressed("interact"):
			GameParameters.items["Clothes"] = 5
			owner.ui.refresh_inventory()
			owner.ui.show_popup("Gathered essential clothing", true)
			isFull = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)
