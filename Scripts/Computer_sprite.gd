extends StaticBody2D

onready var sprite = $Sprite

var canTrigger = false
var library_dialogue = Dialogic.start("LibraryAdvice")

func _process(delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				get_parent().get_parent().set_computer_visible()

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)
