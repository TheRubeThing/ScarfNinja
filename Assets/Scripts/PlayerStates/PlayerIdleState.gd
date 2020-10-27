# PlayerIdleState.gd
extends PlayerGroundedState

class_name PlayerIdleState

func enter(owner, previous_state):
	_state_name = "Idle"
	owner.animated_sprite.play("Idle")
	.enter(owner, previous_state)
	
func process(owner, delta):
	owner._velocity.x = 0
	if Input.is_action_just_pressed("Left_direction") || Input.is_action_just_pressed("Right_direction"):
		return "Run"
		
	return .process(owner, delta)
