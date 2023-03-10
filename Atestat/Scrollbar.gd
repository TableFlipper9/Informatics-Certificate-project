extends ScrollContainer

var building = preload ("res://Building.tscn")
export var buttons: int

func _ready():
	pass

func _process(_delta):
	pass

func _on_World_next_building():
	var a = building.instance()
	$VBoxContainer.add_child(a)
	a.init("Tax payers","10","a")
	a.show()
