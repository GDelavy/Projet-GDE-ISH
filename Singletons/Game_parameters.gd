extends Node

# Items possessed by player
var items = {"Raw Food": 2}

# Stress, Danger and Hunger bars

var stress = 0 setget modify_stress
var danger = 0 setget modify_danger
var hunger = 0 setget modify_hunger

var dangerIncrease = 1
var stressIncrease = 1.25
var hungerIncrease = 1.5

# Advice ID of the library
var currentId
var adviceId = [0,1,2,3,4,5]
# Used when the player has cycled through all the advices
var completeAdviceId = [0,1,2,3,4,5]
var dialog_path

# Used when player orders items on the computer
var orderTime = 0
var currentOrder = null
var currentQuantity = 1

# Last place visited. Used to know where to spawn player in hallway scene
var lastVisited = "Apartment"

# Apartment parameters
var isGason = true
var isElectricityOn = true
var isWaterOn = true

var taped_windows = [false,false,false]

# Completion marks
var completedObjectives = 0 setget is_won
var totalObjectives = 7

var hasDuctTape = false
var hasToolkit = false
var isCarBatteryOut = false
var isBasementMedkitTaken = false
var isBathtubFull = false

var isElectricityRestored = false
var isWaterAvailable = false
var isPassportSafe = false
var isClothingReady = false
var areWindowsSafe = false
var hasMedkit = false
var areRationsAvailable = false

# Randomizes seed so each run will give different random numbers
func _ready():
	randomize()
	choose_random_dialog()

# Used when launching a new run by Game Over screen
func reset_values():
	stress = 0
	danger = 0
	hunger = 0
	
	dangerIncrease = 1
	stressIncrease = 1.25
	hungerIncrease = 1.5
	
	items = {"Raw Food": 2}
	
	choose_random_dialog()

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

func choose_random_dialog():
	if adviceId.size() > 0:
		currentId = adviceId[randi() % adviceId.size()]
	# In case the player has cycled through all the advices
	else:
		currentId = completeAdviceId[randi() % completeAdviceId.size()]

	dialog_path = "res://Assets/Dialogs/Dialog" + str(currentId) +".json"

func check_if_all_windows_taped():
	for window in taped_windows:
		if window == false:
			return false
	return true

func is_won(value):
	completedObjectives = value
	if completedObjectives == totalObjectives:
		get_tree().change_scene("res://World/GameOver.tscn")
