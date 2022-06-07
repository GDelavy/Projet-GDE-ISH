extends StaticBody2D

onready var animation = $AnimatedSprite

var canTrigger = false
var isFull = false

func _process(delta):
	if canTrigger:
		if Input.is_action_just_pressed("interact"):
			if isFull:
				animation.play("empty")
				isFull = false
			else:
				animation.play("fill")
				isFull = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false


func _on_AnimatedSprite_animation_finished():
	animation.stop()
	if animation.animation == "fill":
		animation.frame = 6
	else:
		animation.frame = 8
