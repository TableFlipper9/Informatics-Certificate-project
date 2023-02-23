extends Position2D

var Health = 100
var dmg = 30;
var dead = 0 
signal attacked(dmg)

func _ready():
	pass

func _on_AnimatedSprite_animation_finished():
	if dead==1:
		$AnimatedSprite.play("Walk_player")
	else:
		$AnimatedSprite.play("Idle_player")

func _process(_delta):
	if Input.is_action_just_pressed("Attack") and $AnimatedSprite.animation == "Idle_player":
		$AnimatedSprite.play("Attack_player")
		emit_signal("attacked",dmg)

func _on_Enemy_death():
	$AnimatedSprite.play("Walk_player")
	dead=1

func _on_Enemy_respawn():
	dead=0
