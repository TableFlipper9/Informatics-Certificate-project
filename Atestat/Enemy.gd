extends Position2D

var health = 100
signal death

func _ready():
	pass 
	
func _process(delta):
	pass

func _on_Player_attacked(dmg):
	health -= dmg
	print(health)
	if health == 0:
		health = 100
		emit_signal("death")
