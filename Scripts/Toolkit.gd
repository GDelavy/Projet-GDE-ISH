extends Area2D

onready var sprite = $Sprite

var canTrigger = false

func _ready():
	if GameParameters.hasToolkit:
		queue_free()

func _process(_delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				GameParameters.items["Toolkit"] = 1
				owner.ui.refresh_inventory()
				GameParameters.hasToolkit = true
				queue_free()

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)
