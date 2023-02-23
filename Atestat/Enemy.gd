extends Position2D

var health = 100
var move = 0
var dead = 0
signal death 
signal respawn
 
func _ready():
	dead = 0 

func respawn():
	pass

func _process(delta):
	if move > 0 :
		position.x -= 100 * delta * 2
		move -= 1
		if move == 0:
			respawn()
			emit_signal("respawn")

func _on_AnimatedSprite_animation_finished():
	if  dead == 1:
		emit_signal("death")
		move=150
		dead=0
		$AnimatedSprite.play("Dead_skeleton")
	elif health == 0:
		$AnimatedSprite.play("Dead_skeleton")
	else:
		$AnimatedSprite.play("Idle_skeleton")

func _on_Player_attacked(dmg):
	health -= dmg
	if health < 0:
		health = 0
	if health == 0:
		$AnimatedSprite.play("Death_skeleton")
		dead = 1
	else :
		$AnimatedSprite.play("Hit_skeleton")
	$Health/VBoxContainer/HBoxContainer/Label.text = str(health)
