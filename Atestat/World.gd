extends Node2D

var screen_size
var cookies = 0

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	pass

func _on_Enemy_death():
	cookies += 1
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(cookies) + ' '
