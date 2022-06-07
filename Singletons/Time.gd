extends Timer

# Global Variables
var danger = 0
var stress = 0
var hunger = 0

var inventory = {"Food" : 4, "Water" : 2} setget inventory_changed

# Time
var time = 0
var timeMult = 1.0

var timeInSeconds
var timeInMinutes
var timeInHours
var currentTime = "Dawn"

var gameOver = false

signal isAfternoon
signal isEvening
signal isNight

func _process(delta):
	if !gameOver:
		clock_timer()
		# Game Over
		if timeInMinutes == 4:
			gameOver = true
			currentTime = "Dawn"
			get_tree().change_scene("res://World/GameOver.tscn")
			
		# Time is Afternoon
		if timeInMinutes == 3 and timeInSeconds == 0:
			emit_signal("isAfternoon")
			currentTime = "Afternoon"
			
		# Time is Evening
		if timeInMinutes == 2 and timeInSeconds == 0:
			emit_signal("isEvening")
			currentTime = "Evening"
		
		# Time is Night
		if timeInMinutes == 1 and timeInSeconds == 0:
			emit_signal("isNight")
			currentTime = "Night"
	else:
		time = 0
		
	#print (str(timeInMinutes) + ":" + str(timeInSeconds))



func clock_timer():
	time = int(get_time_left())
	timeInSeconds = time % 60
	timeInMinutes = (time/60) % 60

func inventory_changed(inventory):
	pass
