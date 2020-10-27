# PlayerGroundedState.gd
extends BaseState

class_name PlayerGroundedState
	
func physics_process(owner, delta):
	owner._velocity.y = 0
	if Input.is_action_just_pressed("Jump"):
		return "Jump"
	if not owner.test_move(owner.transform, Vector2(0, 0.1)):
		return "Fall"
	return .physics_process(owner, delta)
