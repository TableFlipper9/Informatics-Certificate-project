extends MarginContainer
var price 
var id 
var cookies_per_second
onready var a = info.instance()

var info = preload("res://Info.tscn")

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
		price += GM.number_of[id]  
		GM.calculate()
		$HBoxContainer/VBoxContainer/HBoxContainer/Price.text = str(price)
		$HBoxContainer/NumberOf.text = str(GM.number_of[id])
	else: print("not enough")

func _on_Button_mouse_entered():
	a.popup(10,10,10,10)

func _on_Button_mouse_exited():
	a.hide()
