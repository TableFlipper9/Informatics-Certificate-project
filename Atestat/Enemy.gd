extends Position2D

var rng = RandomNumberGenerator.new()
var X = -2
onready var enemy_position = position.x
signal death 
signal respawn
var counter_boss = 5

var types_minions = ["ghost","skeleton","demon"]
var types_bosses =["Boss_demon"]
var weakness =["fire", "poison", "magic"]

class Enemy:
	var type 
	var weakness
	var health
var enemy

func _ready():
	enemy = Enemy.new()
	rng.randomize()
	new_enemy()
	$AnimationPlayer.play("Idle_%s"%enemy.type)

func new_enemy():
	counter_boss -= 1 
	if(counter_boss == 0 ):
		rng.randomize()
		enemy.type = types_bosses[rng.randi_range(0,0)]
		enemy.health = floor(100 + X * 50)
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
	if $AnimationPlayer.has_animation("Walk_%s"%enemy.type) == true:
		$AnimationPlayer.play("Walk_%s"%enemy.type) 
	else:
		$AnimationPlayer.play("Spawn_%s"%enemy.type)

func _process(_delta):
	$Health/VBoxContainer/ProgressBar.value = lerp($Health/VBoxContainer/ProgressBar.value, int((enemy.health)), 0.1)
	if GM.move == true:
		position.x -= GM.speed
		if position.x < 0:
			respawn()
		if position.x == enemy_position:
			emit_signal("respawn")
			$AnimationPlayer.play("Idle_%s"%enemy.type)
			GM.move = false
			if(counter_boss == 0):
				$Attack_boss.start()
				counter_boss = 2

func die():
	$AnimationPlayer.play("Dead_%s"%enemy.type)
	$Attack_boss.stop()
	emit_signal("death")
	GM.move = true
	$Health.visible = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Death_%s"%enemy.type:
		die()
		GM.hero_lock = false
	elif $AnimatedSprite.animation == "Hit_%s"%enemy.type:
		GM.hero_lock = false
		$AnimationPlayer.play("Idle_%s"%enemy.type)
	elif $AnimatedSprite.animation == "Attack_%s"%enemy.type:
		GM.cookies -= 2
		$AnimationPlayer.play("Idle_%s"%enemy.type)
		GM.hero_lock = false
	elif $AnimatedSprite.animation == "Spawn_%s"%enemy.type:
		$AnimationPlayer.play("Idle_%s"%enemy.type)

func _on_Player_attacked(dmg):
	enemy.health -= dmg
	if enemy.health < 0:
		enemy.health = 0
	if enemy.health == 0:
		$AnimationPlayer.play("Death_%s"%enemy.type)
		GM.hero_lock = true
	else:
		$AnimationPlayer.play("Hit_%s"%enemy.type)
		GM.hero_lock = true 
	$Health/VBoxContainer/HBoxContainer/Label.text = str(enemy.health)

func _on_Attack_boss_timeout():
	if($AnimatedSprite.animation != "Death_%s"%enemy.type):
		$AnimationPlayer.play("Attack_%s"%enemy.type)
		GM.hero_lock = true
