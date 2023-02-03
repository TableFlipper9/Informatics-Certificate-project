extends Position2D

var Health = 100
var screen_size
var dmg = 10;
signal attacked(dmg)

func _ready():
	screen_size = get_viewport_rect().size

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle_player")

func _process(delta):
	if Input.is_action_just_pressed("Attack") and $AnimatedSprite.animation != "Attack_player":
		$AnimatedSprite.play("Attack_player")
		emit_signal("attacked",dmg)
