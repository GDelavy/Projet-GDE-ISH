extends Panel

# Original Dialog Box Script by Afely
# Source code: https://pastebin.com/LeMbpmNC
# Video tutorial: https://www.youtube.com/watch?v=GzPvN5wsp7Y

export var dialogPath = ""
export(float) var textSpeed = 0.02

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed

func start_dialog(dialogFile):
	finished = false
	phraseNum = 0
	$Text.bbcode_text = ""
	dialogPath = dialogFile
	visible = true
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

# Move to next phrase
func nextPhrase() -> void:
	# If there are no more phrases left
	if phraseNum >= len(dialog):
		visible = false
		return
	
	finished = false
	
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
