extends Control

onready var eventPanel = $CanvasLayer/EventPanel
onready var eventTween = $CanvasLayer/EventPanel/Tween

onready var popupPanel = $CanvasLayer/Popup
onready var populText = $CanvasLayer/Popup/Label
onready var popupAnim = $CanvasLayer/Popup/AnimationPlayer

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
	# Reset slots
	for slot in inventory.get_children():
		slot.text = ""
	# Fill slots with inventory content
	for item in GameParameters.items:
		inventory.get_child(i).text = item + " x" + str(GameParameters.items[item])
		i += 1

# Updates bars for when player moves to another screen
func update_bars():
	danger.value = GameParameters.danger
	stress.value = GameParameters.stress
	hunger.value = GameParameters.hunger

func show_popup(text):
	populText.text = text
	popupAnim.play("Popup")
	yield(get_tree().create_timer(5.0), "timeout")
	popupAnim.play_backwards("Popup")

func _process(delta):
	# Updates clock every frame
	clock.text = str(Time.timeInMinutes) + " : " + str(Time.timeInSeconds)

func _on_DangerTimer_timeout():
	GameParameters.danger += GameParameters.dangerIncrease
	danger.value = GameParameters.danger
	
	if danger.value >= danger.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")


func _on_StressTimer_timeout():
	GameParameters.stress += GameParameters.stressIncrease
	stress.value = GameParameters.stress
	
	if stress.value >= stress.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")


func _on_HungerTimer_timeout():
	GameParameters.hunger += GameParameters.hungerIncrease
	hunger.value = GameParameters.hunger
	
	if hunger.value >= hunger.max_value:
		get_tree().change_scene("res://World/GameOver.tscn")

# Fade event panel
func _on_Timer_timeout():
	eventTween.interpolate_property(eventPanel, "modulate",
				Color(1,1,1,0.91), Color(1,1,1,0), 1.5,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	eventTween.start()
