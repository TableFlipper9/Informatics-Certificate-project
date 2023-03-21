extends Button
var price 
var id 
var cookies_per_second

func init(titlu , cost , image , x, y):
	cookies_per_second = y
	id = x
	price = int(cost)
	$HBoxContainer/VBoxContainer/Name.text = titlu
	$HBoxContainer/VBoxContainer/HBoxContainer/Price.text = cost
	#$HBoxContainer/TextureRect.texture = image

func _ready():
	pass 

func _process(_delta):
	pass

func _on_Button_pressed():
	if GM.cookies >= price:
		GM.cookies -= price 
		GM.number_of[id] += 1 
		GM.calculate()
		$HBoxContainer/NumberOf.text = str(GM.number_of[id])
	else: print("not enough")

