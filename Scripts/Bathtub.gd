extends StaticBody2D

onready var sprite = $AnimatedSprite
onready var animation = $AnimatedSprite

var canTrigger = false
var isFull = false

func _process(_delta):
	if canTrigger and !isFull:
		if Input.is_action_just_pressed("interact"):
			get_parent().get_parent().get_node("UI").show_popup("Bathtub filled")
			animation.play("fill")
			AudioManager.play("res://Assets/Audio/water.ogg")
			isFull = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)


func _on_AnimatedSprite_animation_finished():
	animation.stop()
	animation.frame = 7
