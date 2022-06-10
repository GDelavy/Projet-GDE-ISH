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

func _ready():
	# Initialize countdown
	set_wait_time(countdownTime)

func _process(delta):
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
	else:
		time = 0
		
	#print (str(timeInMinutes) + ":" + str(timeInSeconds))

# Used when Game Over screen is loading a new run
func reset_values():
	gameOver = false
	start()

# Updates time whenever called
func clock_timer():
	time = int(get_time_left())
	timeInSeconds = time % 60
	timeInMinutes = (time/60) % 60
