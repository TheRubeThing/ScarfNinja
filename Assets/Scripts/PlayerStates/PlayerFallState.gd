extends PlayerBaseState

class_name PlayerFallState

func enter(owner, previous_state):
	.enter(owner, previous_state)
	_state_name = "Fall"
	owner.play_animation("Fall")
	
func process(owner, delta):
	if Input.is_action_pressed("Right_direction"):
		owner._velocity.x = 1 * owner.move_speed
		owner.look_direction(1)
	elif Input.is_action_pressed("Left_direction"):
		owner._velocity.x = -1 * owner.move_speed
		owner.look_direction(-1)
	else:
		#Movement smoothing
		owner._velocity.x -= owner._velocity.x * owner.air_drag
		
	return .process(owner, delta)
	
func physics_process(owner, delta):
	owner._velocity.y += owner._gravity * delta
	var next_state = .physics_process(owner, delta)
	if owner.test_move(owner.transform, Vector2(0, 0.1)):
		if abs(owner._velocity.x) > 0:
			return "Run"
		return "Idle"
	return next_state
