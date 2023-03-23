extends PopupPanel
var title
var description
var text

func _init(a,b,c):
	$MarginContainer/VBoxContainer/Label.text = a
	$MarginContainer/VBoxContainer/HBoxContainer/Label.text = b
	$MarginContainer/VBoxContainer/Label2.text = c

func change(b):
	$MarginContainer/VBoxContainer/HBoxContainer/Label.text = b

func _ready():
	pass 
