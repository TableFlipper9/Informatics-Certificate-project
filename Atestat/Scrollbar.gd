extends ScrollContainer

var building = preload ("res://Building.tscn")

func _ready():
	pass

func _process(_delta):
	pass

func _on_World_next_building():
	var a = building.instance()
	$VBoxContainer/MarginContainer.add_child(a)
	a.init("Tax payers","10","a")
	a.cookie_per_second = 1
	a.show()
