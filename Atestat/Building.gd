extends MarginContainer

func init(titlu , cost , image):
	$Button/HBoxContainer/VBoxContainer/Label.text = titlu
	#$HBoxContainer/TextureRect.texture = image
	$Button/HBoxContainer/VBoxContainer/HBoxContainer/Label2.text = cost
	
func _ready():
	pass
