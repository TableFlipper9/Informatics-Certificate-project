extends Button
var number_of = 0
var cookie_per_second = 0;
signal increment(cookie_per_second)

func _ready():
	pass 

func _process(_delta):
	pass

func _on_Button_pressed():
	number_of += 1 
	emit_signal("increment",cookie_per_second)

