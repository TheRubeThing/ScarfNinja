# PlayerIdleState.gd
extends PlayerGroundedState

class_name PlayerIdleState

func enter(owner, previous_state):
	.enter(owner, previous_state)
	_state_name = "Idle"
	owner.play_animation("Idle")
	
func process(owner, delta):
	owner._velocity = Vector2.ZERO
	if Input.is_action_pressed("Left_direction") || Input.is_action_pressed("Right_direction"):
		return "Run"
		
	return .process(owner, delta)
