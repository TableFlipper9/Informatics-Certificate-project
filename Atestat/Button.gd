extends Button
var cookie = 0
var number_of = 0

func _ready():
	pass 

func _process(_delta):
	pass

func _on_Button_pressed():
	number_of += 1 

func _on_Timer_timeout():
	cookie += cookie * number_of
