extends Node2D

var building = preload ("res://Building.tscn")

var screen_size
var enemy_multiplier = 1 
var goals = [10, 50, 100, 500, 1000, 5000]
var current_goal = -1

func _ready():
	screen_size = get_viewport_rect().size
	check_thoes_cookies()

func _physics_process(_delta):
	$GUI/HBoxContainer/Bars/Bar/Count/Numbers.text = str(floor(GM.cookies)) + ' '

func check_thoes_cookies():
	return GM.cookies >= goals[current_goal + 1]

func _on_Enemy_death():
	GM.cookies += 1 * enemy_multiplier

func _on_Cookie_timer_timeout():
	GM.cookies += GM.building_baking
	if check_thoes_cookies():
		current_goal += 1 
		var a = building.instance()
		$Buildings/VBoxContainer.add_child(a)
		a.init("Tax payers","10","a",current_goal)
		a.show()
