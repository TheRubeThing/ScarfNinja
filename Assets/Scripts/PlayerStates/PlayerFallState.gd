extends BaseState

class_name PlayerFallState

func enter(owner, previous_state):
	_state_name = "Fall"
	owner.animated_sprite.play("Fall")
	
func process(owner, delta):
	if Input.is_action_pressed("Right_direction"):
		owner._velocity.x = 1 * owner.move_speed
		owner.animated_sprite.scale.x = 1
	elif Input.is_action_pressed("Left_direction"):
		owner._velocity.x = -1 * owner.move_speed
		owner.animated_sprite.scale.x = -1
	else:
		#Movement smoothing
		owner._velocity.x -= owner._velocity.x * owner.air_drag
		
	return .process(owner, delta)
	
func physics_process(owner, delta):
	owner._velocity.y += owner._gravity * delta
	.physics_process(owner, delta)
	if owner.test_move(owner.transform, Vector2(0, 0.1)):
		if abs(owner._velocity.x) > 0:
			return "Run"
		return "Idle"
	return null
