extends Position2D

var rng = RandomNumberGenerator.new()
var X = -2
onready var enemy_position = position.x
signal death 
signal respawn

var types = ["skeleton", "orc", "demon"]
var weakness =["fire", "poison", "magic"]

class Enemy:
	var type 
	var weakness
	var health
	var move = false
	var dead = false
var enemy
 
func _ready():
	enemy = Enemy.new()
	enemy.dead = false
	rng.randomize()
	new_enemy()

func new_enemy():
	rng.randomize()
	enemy.type = types[rng.randi_range(0,2)]
	rng.randomize()
	enemy.weakness = weakness[rng.randi_range(0,2)]
	X = X + 2
	enemy.health = 100 + X*X

func respawn():
	new_enemy()
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)
	position.x = enemy_position + 300
	$AnimatedSprite.play("Walk_skeleton") 

func die():
	emit_signal("death")
	enemy.move = true
	enemy.dead = false

func _process(_delta):
	if enemy.move == true:
		position.x -= 3 
		if position.x < 0:
			respawn()
		if position.x == enemy_position:
				emit_signal("respawn")
				$AnimatedSprite.play("Idle_skeleton")
				enemy.move = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Walk_skeleton":
		$AnimatedSprite.play("Walk_skeleton")
	if  enemy.dead == true:
		die()
		$AnimatedSprite.play("Dead_skeleton")
	elif enemy.health == 0:
		$AnimatedSprite.play("Dead_skeleton")
	else:
		$AnimatedSprite.play("Idle_skeleton")

func _on_Player_attacked(dmg):
	enemy.health -= dmg
	if enemy.health < 0:
		enemy.health = 0
	if enemy.health == 0:
		$AnimatedSprite.play("Death_skeleton")
		enemy.dead = true
	else:
		$AnimatedSprite.play("Hit_skeleton")
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)
	$Health/VBoxContainer/ProgressBar.value = lerp($Health/VBoxContainer/ProgressBar.value, int ((enemy.health/5)*100),0.1)
