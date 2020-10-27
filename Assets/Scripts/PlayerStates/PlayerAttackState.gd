extends BaseState

class_name PlayerAttackState

var _prev_state = null
var _temp_velocity

func enter(owner, previous_state):
	_state_name = "Attack"
	owner.animated_sprite.play("Attack")
	_temp_velocity = owner._velocity
	owner._velocity = Vector2(0, 0.5 * _temp_velocity.y)
	owner.attack_shape.set_disabled(false)
	.enter(owner, previous_state)
	
func exit(owner, new_state):
	owner.attack_shape.set_disabled(true)
	.exit(owner, new_state)
	
func process(owner, delta):
	if owner.animated_sprite.frame == owner.animated_sprite.frames.get_frame_count("Attack") - 1:
		owner._velocity = _temp_velocity
		return _previous_state
	return .process(owner, delta)
