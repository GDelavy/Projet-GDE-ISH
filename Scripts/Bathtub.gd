extends StaticBody2D

onready var sprite = $AnimatedSprite
onready var animation = $AnimatedSprite

var canTrigger = false

func _ready():
	if GameParameters.isBathtubFull:
		sprite.frame = 7

func _process(_delta):
	if canTrigger and !GameParameters.isBathtubFull:
		if Input.is_action_just_pressed("interact"):
			if GameParameters.isWaterOn:
				animation.play("fill")
				AudioManager.play("res://Assets/Audio/water.ogg")
				GameParameters.isBathtubFull = true
				GameParameters.isWaterAvailable = true
				if !GameParameters.items.has("Water Bottles"):
					owner.ui.show_popup("Acquired reserve of water", true)
					GameParameters.danger -= 10
			else:
				owner.ui.show_popup("Water has been shut off")

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
