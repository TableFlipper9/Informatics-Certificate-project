extends Node2D

var screen_size
var cookies = 0
var enemy_multiplier = 1 
var building_baking = 0
signal next_building 

var goals = [0, 100, 500, 1000]
var current_goal = -1

func _ready():
	screen_size = get_viewport_rect().size
	check_thoes_cookies()

func check_thoes_cookies():
	return cookies >= goals[current_goal + 1]

func _process(_delta):
	pass

func _on_Enemy_death():
	cookies += 1 * enemy_multiplier
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(cookies) + ' '

func _on_Cookie_timer_timeout():
	cookies += building_baking
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(cookies) + ' '
	if check_thoes_cookies():
		current_goal += 1 
		emit_signal("next_building")
