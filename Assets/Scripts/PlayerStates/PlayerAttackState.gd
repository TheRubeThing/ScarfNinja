extends PlayerBaseState

class_name PlayerAttackState

var _prev_state = null
var _temp_velocity

func enter(owner, previous_state):
	_state_name = "Attack"
	owner.play_animation("Attack")
	_temp_velocity = owner._velocity
	owner._velocity = Vector2(0, 0.2 * _temp_velocity.y)
	owner.attack_shape.set_disabled(false)
	.enter(owner, previous_state)
	
func exit(owner, new_state):
	owner.attack_shape.set_disabled(true)
	owner._velocity = _temp_velocity
	if _previous_state == "Jump":
			owner._velocity.y = 0
	return .exit(owner, new_state)
	
func process(owner, delta):
	return .process(owner, delta)

func message(message, data):
	if message == "AnimationFinished":
		if _previous_state == "Jump":
			return "Fall"
		if _previous_state == "Damage" || _previous_state == "Dash":
			return "Idle"
		return _previous_state
	return null
