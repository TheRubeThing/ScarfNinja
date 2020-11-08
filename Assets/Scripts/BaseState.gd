# BaseState.gd
class_name BaseState

var _state_name = "Base"
var _previous_state = null

func process(owner, delta):
	return null

func physics_process(owner, delta):
	owner.move_and_slide(owner._velocity, Vector2.UP)

func enter(owner, previous_state):
	_previous_state = previous_state

	
func exit(owner, next_state):
	return _state_name
