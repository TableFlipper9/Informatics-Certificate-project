extends Panel
var title
var description
var text

func init(a,b,c):
	$MarginContainer/VBoxContainer/Label.text = a
	$MarginContainer/VBoxContainer/Label3.text = b
	$MarginContainer/VBoxContainer/Label2.text = c

func change(b):
	$MarginContainer/VBoxContainer/Label3.text = b

func _ready():
	pass 

func _process(_delta):
	if(get_global_mouse_position().x < 230):
		rect_position.x = get_global_mouse_position().x
	else:
		rect_position.x = get_global_mouse_position().x - 180
	rect_position.y = get_global_mouse_position().y + 10
