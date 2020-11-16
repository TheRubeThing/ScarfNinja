# PlayerRunState.gd
extends PlayerGroundedState

class_name PlayerRunState

var _transitioning = false

func process(owner, delta):	
	if Input.is_action_pressed("Right_direction"):
		if owner._velocity.x < 0:
			_transitioning = true
			owner.play_animation("IdleRunTrans")
		owner._velocity.x = 1 * owner.move_speed
		owner.look_direction(1)
	elif Input.is_action_pressed("Left_direction"):
		if owner._velocity.x > 0:
			_transitioning = true
			owner.animated_sprite.play("IdleRunTrans")
		owner._velocity.x = -1 * owner.move_speed
		owner.look_direction(-1)
	else:
		#Movement smoothing
		owner._velocity.x -= owner._velocity.x * owner.grounded_drag

	if not _transitioning:
		owner.play_animation("Run")
	
	if abs(owner._velocity.x) < 0.1:
		return "Idle"
	return .process(owner, delta)
	
func enter(owner, previous_state):
	.enter(owner, previous_state)
	_state_name = "Run"
	if Input.is_action_just_pressed("Right_direction"):
		owner.look_direction(1)
	if Input.is_action_just_pressed("Left_direction"):
		owner.look_direction(-1)
	owner.play_animation("IdleRunTrans")
	_transitioning = true

func message(message, data):
	if message == "AnimationFinished":
		_transitioning = false
	return .message(message,data)
