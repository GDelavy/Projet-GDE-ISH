extends KinematicBody2D

const MAX_SPEED = 200
const ACCELERATION = 1200
const FRICTION = 1200

var velocity = Vector2.ZERO
var canMove = true

onready var timer = $Timer
onready var audio = $AudioStreamPlayer
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	if canMove:
		# Creates a vector that stores player input
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		# Normalize to prevent diagonal movement from being faster
		input_vector = input_vector.normalized()
		
		# If player is actually moving
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			animationTree.set("parameters/Idle/blend_position", input_vector)
			animationTree.set("parameters/Run/blend_position", input_vector)
			animationState.travel("Run")
			# Footsteps sounds
			if timer.time_left <= 0:
				audio.pitch_scale = rand_range(0.8, 1.2)
				audio.play()
				timer.start(0.2)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationState.travel("Idle")

		velocity = move_and_slide(velocity)
