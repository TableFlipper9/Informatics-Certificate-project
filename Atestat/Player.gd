extends Position2D

var Health = 100
var dmg = 30;
signal attacked(dmg)

func _ready():
	pass

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == ("Walk_player"):
		$AnimatedSprite.play("Walk_player")
	else:
		$AnimatedSprite.play("Idle_player")

func _process(_delta):
	if Input.is_action_just_pressed("Attack") and $AnimatedSprite.animation == "Idle_player":
		$AnimatedSprite.play("Attack_player")
		emit_signal("attacked",dmg)

func _on_Enemy_death():
	$AnimatedSprite.play("Walk_player")

func _on_Enemy_respawn():
	$AnimatedSprite.play("Idle_player")
