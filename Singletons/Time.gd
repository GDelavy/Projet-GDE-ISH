extends Timer

# Time to countdown in seconds
var countdownTime = 240

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

signal waterShutOff
signal electricityShutOff

func _ready():
	# Initialize countdown
	set_wait_time(countdownTime)

func _process(_delta):
	if !gameOver:
		clock_timer()
		# Game Over
		if timeInMinutes >= 4:
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
			
		# Water has been shut off
		if timeInMinutes == 3 and timeInSeconds == 30:
			if GameParameters.isWaterOn:
				emit_signal("waterShutOff")
			GameParameters.isWaterOn = false
			
		# Electricity has been shut off
		if timeInMinutes == 2 and timeInSeconds == 30:
			if GameParameters.isElectricityOn:
				emit_signal("electricityShutOff")
			GameParameters.isElectricityOn = false
			
	else:
		time = 0
		
	#print (str(timeInMinutes) + ":" + str(timeInSeconds))

# Used when Game Over screen is loading a new run
func reset_values():
	gameOver = false
	set_wait_time(countdownTime)
	start()
	currentTime = "Dawn"

# Updates time whenever called
func clock_timer():
	time = int(get_time_left())
	timeInSeconds = time % 60
	timeInMinutes = (time/60) % 60

# Makes sure that timeskips don't skip events (color change, current down, etc)
func check_time_skip_signals(original_time):
	print(original_time)
	print(time_left)
	# If skipped time change
	if original_time > 180 and time_left < 180:
		emit_signal("isAfternoon")
		currentTime = "Afternoon"
	elif original_time > 120 and time_left < 120:
		emit_signal("isEvening")
		currentTime = "Evening"
	elif original_time > 60 and time_left < 60:
		emit_signal("isNight")
		currentTime = "Night"

	# If skipped water shut off
	if original_time > 210 and time_left < 210:
		emit_signal("waterShutOff")
		GameParameters.isWaterOn = false
	elif original_time > 150 and time_left < 150:
		emit_signal("electricityShutOff")
		GameParameters.isElectricityOn = false
