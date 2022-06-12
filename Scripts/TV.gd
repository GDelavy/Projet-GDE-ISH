extends TextureRect

onready var startScreen = $StartScreen
onready var TVScreen = $TVScreen
onready var gamesScreen = $GamesScreen

func _on_TVButton_pressed():
	startScreen.visible = false
	TVScreen.visible = true
	
	GameParameters.stress -= 15
	Time.start(Time.time_left - 30)


func _on_GamesButton_pressed():
	startScreen.visible = false
	gamesScreen.visible = true
	
	GameParameters.stress -= 30
	Time.start(Time.time_left - 60)

func reset_display():
	startScreen.visible = true
	TVScreen.visible = false
	gamesScreen.visible = false
