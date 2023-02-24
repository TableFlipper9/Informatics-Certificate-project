extends Node2D

var screen_size
var cookies = 0
var X = 1 

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(cookies) + ' '

func _on_Enemy_death():
	cookies += 1 * X
