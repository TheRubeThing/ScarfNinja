extends BaseState

class_name PlayerDashState

var _timer = 0
var _dash_time = 0
func enter(owner, previous_state):
	_state_name = "Dash"
	if Input.is_action_pressed("Left_direction"):
		owner._velocity = Vector2(-owner.dash_speed, 0)
		owner.animated_sprite.scale.x = -1
	if Input.is_action_pressed("Right_direction"):
		owner._velocity = Vector2(owner.dash_speed, 0)
		owner.animated_sprite.scale.x = 1
	_dash_time = owner.dash_distance / owner.dash_speed
	owner.animated_sprite.play("Dash")
	_timer = 0
	.enter(owner, previous_state)
	
func process(owner, delta):
	_timer += delta
	if _timer > _dash_time || Input.is_action_just_released("Dash"):
		return _previous_state
	return null
