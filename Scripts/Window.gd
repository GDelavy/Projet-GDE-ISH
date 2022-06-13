extends Node2D

export var window_id = 0

onready var sprite = $Sprite

var canTrigger = false
var isTaped = false

# Make sure windows are still taped if player leaves the room and reenters
func _ready():
	if GameParameters.taped_windows[window_id] == true:
		sprite.set_texture(load("res://Assets/taped_window.png"))

func _process(_delta):
		if canTrigger and !isTaped:
			if GameParameters.items.has("Duct Tape"):
				if Input.is_action_just_pressed("interact"):
					sprite.set_texture(load("res://Assets/taped_window.png"))
					AudioManager.play("res://Assets/Audio/Duct_tape.wav")
					GameParameters.taped_windows[window_id] = true
					if GameParameters.check_if_all_windows_taped():
						GameParameters.danger -= 20
						owner.ui.show_popup("Secured all windows", true)
						GameParameters.items.erase("Duct Tape")
						owner.ui.refresh_inventory()
					isTaped = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		canTrigger = false
		sprite.material.set_shader_param("width", 0)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		canTrigger = true
		sprite.material.set_shader_param("width", 2)
