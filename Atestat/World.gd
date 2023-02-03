extends Node2D

var cookies = 0

func _ready():
	pass 

func _process(delta):
	pass

func _on_Enemy_death():
	cookies += 1
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(cookies)
