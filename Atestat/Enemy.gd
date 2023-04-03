extends Position2D

var rng = RandomNumberGenerator.new()
var X = -2
onready var enemy_position = position.x
signal death 
signal respawn

var types = ["ghost", "demon","skeleton"]
var weakness =["fire", "poison", "magic"]

class Enemy:
	var type 
	var weakness
	var health
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
	enemy.health = floor(100 + X * 1.82)
	$Health/VBoxContainer/ProgressBar.max_value = enemy.health

func respawn():
	new_enemy()
	$Health.visible = true
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)
	position.x = enemy_position + 750
	$AnimatedSprite.play("Walk_%s"%enemy.type) 

func die():
	emit_signal("death")
	GM.move = true
	enemy.dead = false
	$Health.visible = false

func _process(_delta):
	$Health/VBoxContainer/ProgressBar.value = lerp($Health/VBoxContainer/ProgressBar.value, int((enemy.health)), 0.1)
	if GM.move == true:
		position.x -= 3 
		if position.x < 0:
			respawn()
		if position.x == enemy_position:
				emit_signal("respawn")
				$AnimatedSprite.play("Idle_%s"%enemy.type)
				GM.move = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Walk_%s"%enemy.type:
		$AnimatedSprite.play("Walk_%s"%enemy.type)
	if  enemy.dead == true:
		die()
		$AnimatedSprite.play("Dead_%s"%enemy.type)
	elif enemy.health == 0:
		$AnimatedSprite.play("Dead_%s"%enemy.type)
	else:
		$AnimatedSprite.play("Idle_%s"%enemy.type)

func _on_Player_attacked(dmg):
	enemy.health -= dmg
	if enemy.health < 0:
		enemy.health = 0
	if enemy.health == 0:
		$AnimatedSprite.play("Death_%s"%enemy.type)
		enemy.dead = true
	else:
		$AnimatedSprite.play("Hit_%s"%enemy.type)
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)
	
