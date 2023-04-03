extends ParallaxBackground


func _ready():
	pass

func _process(_delta):
	if(GM.move == true):
		scroll_base_offset -= Vector2(3,0)
		#Vector2(100,0) * delta * 2

