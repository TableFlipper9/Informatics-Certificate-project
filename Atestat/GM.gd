extends Node

var cookies = 20
var building_baking = 0
var number_of = [0,0,0,0,0,0,0,0,0,0,0] 
var cookies_per_second = [0.1,0.5,1,5,10,50,100,500,1000]
onready var move = false

func calculate():
	building_baking = 0
	for i in range(len(cookies_per_second)):
		building_baking += number_of[i] * cookies_per_second[i]

func _ready():
	pass
