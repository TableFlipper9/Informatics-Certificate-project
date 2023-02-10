extends Position2D

var health = 100
signal death

func _ready():
	pass 
	
func _process(delta):
	pass
	
func _on_AnimatedSprite_animation_finished():
	if health <= 0 :
		$AnimatedSprite.play("Dead")
	else:
		$AnimatedSprite.play("Idle_skeleton")

func _on_Player_attacked(dmg):
	health -= dmg
	$Health/VBoxContainer/HBoxContainer/Label.text = str(health)
	if health <= 0:
		$AnimatedSprite.play("Death_skeleton")
		emit_signal("death")
