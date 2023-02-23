extends ParallaxBackground

var move=0

func _ready():
	pass

func _on_Enemy_death():
	move = 150

func _process(delta):
	if(move > 0):
		scroll_base_offset -= Vector2(100,0) * delta * 2
		move = move-1
