extends Item

# Make sure the player hasn't picked up item
func _ready():
	if GameParameters.items.has("Passport"):
		queue_free()

func _process(_delta):
		if canTrigger:
			if Input.is_action_just_pressed("interact"):
				owner.item_picked_up(item_name, quantity)
				owner.ui.show_popup("Passport picked up")
				GameParameters.stressIncrease -= 0.1
				queue_free()
