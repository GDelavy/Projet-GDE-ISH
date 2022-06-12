extends Node

var apartmentInstance
var hallwayInstance
var outsideInstance

func _ready():
	# Initialize countdown
	set_wait_time(countdownTime)
	
	apartmentInstance = load("res://World/Apartment.tscn").instance()
