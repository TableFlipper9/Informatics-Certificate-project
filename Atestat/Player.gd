extends StaticBody2D

var Health = 100
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle_player")

func _process(delta):
	if Input.is_action_pressed("Attack"):
		$AnimatedSprite.play("Attack_player")
	
