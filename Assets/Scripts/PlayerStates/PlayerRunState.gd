# PlayerRunState.gd
extends PlayerGroundedState

class_name PlayerRunState

var _transitioning = false

func process(owner, delta):	
	if Input.is_action_pressed("Right_direction"):
		owner._velocity.x = 1 * owner.move_speed
		owner.animated_sprite.scale.x = 1
	elif Input.is_action_pressed("Left_direction"):
		owner._velocity.x = -1 * owner.move_speed
		owner.animated_sprite.scale.x = -1
	else:
		#Movement smoothing
		owner._velocity.x -= owner._velocity.x * owner.grounded_drag

	if _transitioning:
		_transitioning = owner.animated_sprite.frames.get_frame_count("IdleRunTrans") - 1 == owner.animated_sprite.frame
	else:
		owner.animated_sprite.play("Run")
	
	if abs(owner._velocity.x) < 0.1:
		return "Idle"
	return .process(owner, delta)
	
func enter(owner, previous_state):
	_state_name = "Run"
	if Input.is_action_just_pressed("Right_direction"):
		owner.animated_sprite.scale.x = 1
	if Input.is_action_just_pressed("Left_direction"):
		owner.animated_sprite.scale.x = -1
	owner.animated_sprite.play("IdleRunTrans")
	_transitioning = true
	.enter(owner, previous_state)
