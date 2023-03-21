extends Node2D

var building = preload ("res://Building.tscn")

var screen_size
var enemy_multiplier = 1 

var goals = [0, 100, 500, 1000]
var current_goal = -1

func _ready():
	screen_size = get_viewport_rect().size
	check_thoes_cookies()

func _physics_process(delta):
	pass

func check_thoes_cookies():
	return GM.cookies >= goals[current_goal + 1]

func _on_Enemy_death():
	GM.cookies += 1 * enemy_multiplier
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(GM.cookies) + ' '

func _on_Cookie_timer_timeout():
	print(GM.building_baking)
	GM.cookies += GM.building_baking
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(GM.cookies) + ' '
	if check_thoes_cookies():
		current_goal += 1 
		var a = building.instance()
		$Scroll/VBoxContainer/MarginContainer.add_child(a)
		a.init("Tax payers","10","a",current_goal,GM.cookies_per_second[current_goal])
		a.show()
