extends MarginContainer

var price 
var id 
onready var Info = $"/root/World/Info"

func init(titlu , cost , image , x):
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
	Info.init($HBoxContainer/VBoxContainer/Name.text,"You are making "+ str(GM.cookies_per_second[id] * GM.number_of[id]) +" cookies every second from taxes", "Make 'em pay")
	Info.show()

func _on_Button_mouse_exited():
	Info.hide()
