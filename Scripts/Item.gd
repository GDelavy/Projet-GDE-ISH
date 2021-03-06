extends Area2D
class_name Item

onready var sprite = $Sprite

var canTrigger = false
var isOrdered = false
export var item_name = "Book"
export var quantity = 1

func _ready():
	# Check if the sprite exists
	var path = "res://Assets/Icons/" + item_name + ".png"
	var file2Check = File.new()
	# If it does, load it
	if file2Check.file_exists(path):
		var texture = load(path)
		sprite.set_texture(texture)

func _process(_delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				get_parent().item_picked_up(item_name, quantity)
				if isOrdered:
					GameParameters.currentOrder = null
				if item_name == "Water Bottles":
					if !GameParameters.isBathtubFull:
						GameParameters.isWaterAvailable = true
						get_parent().ui.show_popup("Acquired reserve of water", true)
						GameParameters.danger -= 10
				elif item_name == "Rations":
					if !GameParameters.areRationsAvailable:
						GameParameters.areRationsAvailable = true
						get_parent().ui.show_popup("Acquired rations", true)
						GameParameters.danger -= 15
				elif item_name == "Medkit":
					if !GameParameters.hasMedkit:
						GameParameters.hasMedkit = true
						get_parent().ui.show_popup("Medkit Acquired", true)
						GameParameters.danger -= 20
						
					
				queue_free()

func _on_Item_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)


func _on_Item_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)
