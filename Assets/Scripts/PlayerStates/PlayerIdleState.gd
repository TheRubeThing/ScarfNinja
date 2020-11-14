# PlayerIdleState.gd
extends PlayerGroundedState

class_name PlayerIdleState

func enter(owner, previous_state):
	.enter(owner, previous_state)
	_state_name = "Idle"
	owner.animated_sprite.play("Idle")
	
func process(owner, delta):
	owner._velocity.x = 0
	if Input.is_action_pressed("Left_direction") || Input.is_action_pressed("Right_direction"):
		return "Run"
		
	return .process(owner, delta)
