extends BaseState
class_name DamageState

var _dead = false
var _temp_velocity := Vector2.ZERO
func enter(owner: BaseController, previous_state):
	_state_name = "Damage"
	_previous_state = previous_state
	owner.play_animation("Damage")
	_temp_velocity = owner._velocity
	owner._velocity = Vector2.ZERO

func exit(owner: BaseController, new_state):
	owner._velocity = _temp_velocity
	return .exit(owner, new_state)
	
func message(message, data):
	if message == "AnimationFinished":
		if _dead:
			return "Die"
		if _previous_state == "Climb":
			return "Fall"
		return _previous_state
	if message == "Die":
		_dead = true
	return null
