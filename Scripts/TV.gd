extends TextureRect

onready var startScreen = $StartScreen
onready var TVScreen = $TVScreen
onready var gamesScreen = $GamesScreen
onready var offScreen = $OffScreen

func _on_TVButton_pressed():
	startScreen.visible = false
	offScreen.visible = false
	TVScreen.visible = true
	
	GameParameters.stress -= 15
	
	
	# Skip time. Make sure events aren't being missed
	var original_time = Time.time
	Time.start(Time.time_left - 30)
	Time.check_time_skip_signals(original_time)


func _on_GamesButton_pressed():
	startScreen.visible = false
	offScreen.visible = false
	gamesScreen.visible = true
	
	GameParameters.stress -= 30
	
	
	# Skip time. Make sure events aren't being missed
	var original_time = Time.time
	Time.start(Time.time_left - 60)
	Time.check_time_skip_signals(original_time)

func reset_display():
	startScreen.visible = true
	TVScreen.visible = false
	gamesScreen.visible = false
	offScreen.visible = false
	
func display_off():
	startScreen.visible = false
	TVScreen.visible = false
	gamesScreen.visible = false
	offScreen.visible = true
	
