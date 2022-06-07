extends Area2D

onready var sprite = $Sprite

var canTrigger = false
var item_name = "Book"
var quantity = 1

func _ready():
	var path = "res://Assets/Icons/" + item_name + ".png"
	var texture =  load(path)
	sprite.set_texture(texture)

func _process(delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				owner.item_picked_up(item_name, quantity)
				queue_free()

func _on_Item_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Item_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)