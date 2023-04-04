extends Position2D

var rng = RandomNumberGenerator.new()
var X = -2
onready var enemy_position = position.x
signal death 
signal respawn
var counter_boss = 1

var types_minions = ["ghost", "demon","skeleton"]
var types_bosses =["Boss_demon"]
var weakness =["fire", "poison", "magic"]

class Enemy:
	var type 
	var weakness
	var health
	var dead = false
var enemy
 
func set_boss():
	position.y -= 21
	position.x += 99

func set_minion():
	position.y += 21
	position.x -= 99

func _ready():
	enemy = Enemy.new()
	enemy.dead = false
	rng.randomize()
	new_enemy()

func new_enemy():
	counter_boss -= 1 
	if(counter_boss == 0 ):
		rng.randomize()
		enemy.type = types_bosses[rng.randi_range(0,0)]
		enemy.health = floor(100 + X * 10)
		counter_boss = 1
		set_boss()
		if $Attack_boss:
			$Attack_boss.start()
	elif ( counter_boss == 4):
		set_minion()
	else:
		rng.randomize()
		enemy.type = types_minions[rng.randi_range(0,2)]
		X = X + 2
		enemy.health = floor(100 + X * 1.82)
	
	rng.randomize()
	enemy.weakness = weakness[rng.randi_range(0,2)]
	$Health/VBoxContainer/ProgressBar.max_value = enemy.health

func respawn():
	new_enemy()
	$Health.visible = true
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)
	position.x = enemy_position + 750
	$AnimatedSprite.play("Walk_%s"%enemy.type) 

func die():
	$Attck_boss.stop()
	emit_signal("death")
	GM.move = true
	enemy.dead = false
	$Health.visible = false

func _process(_delta):
	$Health/VBoxContainer/ProgressBar.value = lerp($Health/VBoxContainer/ProgressBar.value, int((enemy.health)), 0.1)
	if GM.move == true:
		position.x -= 6
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

func _on_Attck_boss_timeout():
	$AnimatedSprite.play("Attack_%s"%enemy.type)

func _on_Attck_boss_tree_entered():
	$Attck_boss.start()
