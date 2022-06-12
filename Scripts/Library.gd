extends StaticBody2D

onready var sprite = $Sprite

var canTrigger = false

func _ready():
	Dialogic.set_variable("AdviceID", GameParameters.adviceId)

func _process(_delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				pass

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)
