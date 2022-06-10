extends Node

# Items possessed by player
var items = {"Food": 5, "Water": 3, "Batteries": 1}

var stress = 0 setget modify_stress
var danger = 0 setget modify_danger
var hunger = 0 setget modify_hunger

var dangerIncrease = 1
var stressIncrease = 1
var hungerIncrease = 1

# Whichever advice the player will get
var adviceId = [0,1,2,3,4]

# Used when player orders items on the computer
var currentOrder = null
var currentQuantity = 1

# Last place visited. Used to know where to spawn player in hallway scene
var lastVisited = "Apartment"

# Randomizes seed so each run will give different random numbers
func _ready():
	randomize()
	adviceId = randi()%5
	Dialogic.set_variable("AdviceID", adviceId)

# Used when launching a new run by Game Over screen
func reset_values():
	stress = 0
	danger = 0
	hunger = 0
	
	dangerIncrease = 1
	stressIncrease = 1
	hungerIncrease = 1
	
	items = {"Food": 5, "Water": 3, "Batteries": 1}
	
	adviceId = randi()%5
	Dialogic.set_variable("AdviceID", adviceId)

# Setters to prevent negative values
func modify_stress(value):
	stress = value
	if stress < 0:
		stress = 0
		
func modify_danger(value):
	danger = value
	if danger < 0:
		danger = 0
		
func modify_hunger(value):
	hunger = value
	if hunger < 0:
		hunger = 0
