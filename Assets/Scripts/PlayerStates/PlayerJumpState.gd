extends PlayerFallState

class_name PlayerJumpState


func enter(owner, previous_state):
	.enter(owner, previous_state)
	_state_name = "Jump"
	owner.play_animation("Jump")
	if previous_state != "Attack":

		owner._velocity.y -= owner._jump_speed
	
func process(owner, delta):
	var next_state = .process(owner, delta)
	if  not Input.is_action_pressed("Jump") || owner.test_move(owner.transform, Vector2(0, -0.1)):
		owner._velocity.y *= 0.3
	if owner._velocity.y > - 0.5 * owner._jump_speed:
		return "Fall"
	return next_state
