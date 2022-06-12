extends TextureRect

onready var orderScreen = $OrderScreen
onready var startScreen = $StartScreen
onready var thanksScreen = $ThanksScreen
onready var wikiScreen = $WikiScreen
onready var newsScreen = $NewsScreen
onready var waitScreen = $WaitScreen

# Labels telling the player if their research made them feel better or worse
onready var newsScreenLabel = $NewsScreen/Label2
onready var wikiScreenLabel = $WikiScreen/Label2
onready var waitScreenLabel = $WaitScreen/TimeLabel

onready var waitScreenTimer = $WaitScreen/Timer

onready var amazonButton = $StartScreen/Amazon
onready var wikipediaButton = $StartScreen/Wikipedia

func _process(_delta):
	# Display time before order is there
	waitScreenLabel.text = str(ceil(waitScreenTimer.time_left))

func _on_Wikipedia_pressed():
	wikiScreen.visible = true
	startScreen.visible = false
	
	# Return value between 0 and 100
	var random = randi()%101
	if random <= 45:
		wikiScreenLabel.text = "You find useful information and feel better informed! You relax a little bit."
		GameParameters.stress -= 10
	else:
		wikiScreenLabel.text = "The information you found worries you. Your stress goes up."
		GameParameters.stress += 15

func _on_Amazon_pressed():
	if GameParameters.currentOrder == null:
		orderScreen.visible = true
		startScreen.visible = false
	else:
		waitScreen.visible = true
		startScreen.visible = false

func _on_News_pressed():
	newsScreen.visible = true
	startScreen.visible = false
	
	# Return value between 0 and 100
	var random = randi()%101
	if random <= 25:
		newsScreenLabel.text = "You find some uplifting news! You feel a bit better."
		GameParameters.stress -= 15
	else:
		newsScreenLabel.text = "You find the news depressing, your stress levels go up."
		GameParameters.stress += 25

func _on_Food_pressed():
	GameParameters.currentOrder = "Food"
	Display_Thanks()

func _on_Batteries_pressed():
	GameParameters.currentOrder = "Batteries"
	Display_Thanks()

func _on_Rations_pressed():
	GameParameters.currentOrder = "Rations"
	Display_Thanks()

func _on_Candy_pressed():
	GameParameters.currentOrder = "Candies"
	Display_Thanks()

func _on_PowerKit_pressed():
	GameParameters.currentOrder = "PowerKit"
	Display_Thanks()

func _on_MedKit_pressed():
	GameParameters.currentOrder = "Medkit"
	Display_Thanks()

func Display_Thanks():
	waitScreenTimer.start()
	newsScreen.visible = false
	startScreen.visible = false
	orderScreen.visible = false
	wikiScreen.visible = false
	thanksScreen.visible = false
	waitScreen.visible = true

func display_wiki():
	newsScreen.visible = false
	startScreen.visible = false
	orderScreen.visible = false
	wikiScreen.visible = true
	thanksScreen.visible = false
	waitScreen.visible = false

func reset_display():
	newsScreen.visible = false
	startScreen.visible = true
	orderScreen.visible = false
	thanksScreen.visible = false
	wikiScreen.visible = false
	waitScreen.visible = false


func _on_Timer_timeout():
	GameParameters.orderReady = true
