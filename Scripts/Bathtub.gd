extends StaticBody2D

onready var animation = $AnimatedSprite

var canTrigger = false
var isFull = false

func _process(delta):
	if canTrigger and !isFull:
		if Input.is_action_just_pressed("interact"):
			animation.play("fill")
			AudioManager.play("res://Assets/Audio/water.ogg")
			isFull = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false


func _on_AnimatedSprite_animation_finished():
	animation.stop()
	animation.frame = 7
