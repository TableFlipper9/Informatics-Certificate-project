extends Position2D

var health = 100
var move = false
var dead = false
var X = 1
onready var enemy_position = position.x
signal death 
signal respawn
 
func _ready():
	dead = false

func new_enemy():
	X = X + 2
	health = 100 + X*X

func respawn():
	new_enemy()
	$Health/VBoxContainer/HBoxContainer/Label.text = str(health)
	position.x = enemy_position + 300
	$AnimatedSprite.play("Walk_skeleton") 

func die():
	emit_signal("death")
	move = true
	dead = false

func _process(_delta):
	if move == true:
		position.x -= 3 
		if position.x < 0:
			respawn()
		if position.x == enemy_position:
				emit_signal("respawn")
				$AnimatedSprite.play("Idle_skeleton")
				move = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Walk_skeleton":
		$AnimatedSprite.play("Walk_skeleton")
	if  dead == true:
		die()
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
		dead = true
	else:
		$AnimatedSprite.play("Hit_skeleton")
	$Health/VBoxContainer/HBoxContainer/Label.text = str(health)
	$Health/ProgressBar.value = lerp($Health/ProgressBar.value, int ((health/5)*100),0.1)
