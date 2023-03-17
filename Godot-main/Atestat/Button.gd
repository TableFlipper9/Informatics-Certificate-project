extends Button
var number_of = 0
var cookie_per_second = 0;
signal increment(cookie_per_second)
var price 

func init(titlu , cost , image):
	price = int(cost)
	$HBoxContainer/VBoxContainer/Name.text = titlu
	$HBoxContainer/VBoxContainer/HBoxContainer/Price.text = cost
	#$HBoxContainer/TextureRect.texture = image

func _ready():
	pass 

func _process(_delta):
	pass

func _on_Button_pressed():
	print(GM.cookies)
	if GM.cookies >= price:
		GM.cookies -= price 
		number_of += 1 
		emit_signal("increment",cookie_per_second)
	else: print("not enough")

