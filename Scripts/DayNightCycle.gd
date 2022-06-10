extends CanvasModulate

const DAWN_COLOR = Color("#c4b28f")
const DAY_COLOR = Color("#ffffff")
const EVE_COLOR = Color("#9b877b")
const NIGHT_COLOR = Color("#091d3a")

export var sunsetDuration = 2

onready var colorTransition = $ColorTransition

func _ready():
	Time.connect("isAfternoon", self, "on_Afternoon_Start")
	Time.connect("isEvening", self, "on_Evening_Start")
	Time.connect("isNight", self, "on_Night_Start")
	
	if Time.currentTime == "Dawn":
		color = DAWN_COLOR
	elif Time.currentTime == "Afternoon":
		color = DAY_COLOR
	elif Time.currentTime == "Evening":
		color = EVE_COLOR
	else:
		color = NIGHT_COLOR

# Transition from one color to another
func sunset_transition(current_color, new_color):
	colorTransition.interpolate_property(self,"color",current_color,new_color,sunsetDuration,Tween.TRANS_SINE,Tween.EASE_OUT)
	colorTransition.start()
	
func on_Afternoon_Start():
	sunset_transition(DAWN_COLOR, DAY_COLOR)

func on_Evening_Start():
	sunset_transition(DAY_COLOR, EVE_COLOR)

func on_Night_Start():
	sunset_transition(EVE_COLOR, NIGHT_COLOR)
