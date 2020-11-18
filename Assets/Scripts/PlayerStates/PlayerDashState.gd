extends PlayerBaseState

class_name PlayerDashState

var _timer = 0
var _dash_time = 0

func enter(owner: BaseController, previous_state):
	_state_name = "Dash"
	_previous_state = previous_state
	
	var direction = 0
	if Input.is_action_pressed("Left_direction"):
		direction = -1
	if Input.is_action_pressed("Right_direction"):
		direction = 1
		
	owner._velocity = Vector2(direction * owner.dash_speed, 0)
	owner.look_direction(direction)
	owner.play_animation("Dash")
	
	_dash_time = owner.dash_distance / owner.dash_speed
	_timer = 0
	.enter(owner, previous_state)
	
func process(owner, delta):
	_timer += delta
	if _timer > _dash_time || Input.is_action_just_released("Dash"):
		if _previous_state == "Attack" || _previous_state == "Damage":
			return "Idle"
		return _previous_state
	return null
