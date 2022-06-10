extends Control

onready var eventPanel = $CanvasLayer/EventPanel
onready var eventTween = $CanvasLayer/EventPanel/Tween

onready var danger = $CanvasLayer/Danger
onready var stress = $CanvasLayer/Stress
onready var hunger = $CanvasLayer/Hunger

onready var dangerTimer = $CanvasLayer/Danger/DangerTimer
onready var stressTimer = $CanvasLayer/Stress/StressTimer
onready var hungerTimer = $CanvasLayer/Hunger/HungerTimer

onready var inventory = $CanvasLayer/Panel/Inventory
var items = {"Food": 5, "Water": 3, "Batteries": 1}

onready var clock = $CanvasLayer/ClockPanel/Clock

func _ready():
	var i = 0
	refresh_inventory()
	update_bars()

# Takes items in singleton and displays them in the inventory
func refresh_inventory():
	var i = 0
	for item in GameParameters.items:
		inventory.get_child(i).text = item + " x" + str(GameParameters.items[item])
		i += 1

# Updates bars for when player moves to another screen
func update_bars():
	danger.value = GameParameters.danger
	stress.value = GameParameters.stress
	hunger.value = GameParameters.hunger


func _process(delta):
	# Updates clock every frame
	clock.text = str(Time.timeInMinutes) + " : " + str(Time.timeInSeconds)
	
	# Update bars every frame
	


func _on_DangerTimer_timeout():
	danger.value += GameParameters.dangerIncrease
	GameParameters.danger = danger.value
	
	if danger.value >= danger.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")


func _on_StressTimer_timeout():
	GameParameters.stress += GameParameters.stressIncrease
	stress.value = GameParameters.stress
	
	if stress.value >= stress.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")


func _on_HungerTimer_timeout():
	hunger.value += GameParameters.hungerIncrease
	GameParameters.hunger = hunger.value
	
	if hunger.value >= hunger.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")

# Fade event panel
func _on_Timer_timeout():
	eventTween.interpolate_property(eventPanel, "modulate",
				Color(1,1,1,0.91), Color(1,1,1,0), 1.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	eventTween.start()
