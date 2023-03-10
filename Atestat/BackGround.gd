extends ParallaxBackground

var move=0

func _ready():
	pass

func _on_Enemy_death():
	move = 1

func _on_Enemy_respawn():
	move = 0 

func _process(_delta):
	if(move > 0):
		scroll_base_offset -= Vector2(3,0)
		#Vector2(100,0) * delta * 2

