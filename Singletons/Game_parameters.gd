extends Node

var items = {"Food": 5, "Water": 3, "Batteries": 1}

var stress = 0
var danger = 0
var hunger = 0

var dangerIncrease = 1
var stressIncrease = 1
var hungerIncrease = 1

var currentOrder = null
var currentQuantity = 1

var lastVisited = "Apartment"

func _ready():
	pass
