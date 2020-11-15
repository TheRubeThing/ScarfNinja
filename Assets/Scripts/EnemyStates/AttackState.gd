extends BaseState
class_name AttackState

var _previous_velocity := Vector2.ZERO

func enter(owner, previous_state):
	_state_name = "Attack"
	owner.animated_sprite.play("Attack")
	owner.animated_sprite.offset.y = 1
	_previous_velocity = owner._velocity
	owner._velocity = Vector2.ZERO
	.enter(owner, previous_state)
	
func exit(owner, new_state):
	owner.attack_shape.set_disabled(true)
	owner.animated_sprite.offset.y = 0
	owner._velocity = _previous_velocity
	return .exit(owner, new_state)
	
func process(owner, delta):
	if owner.animated_sprite.frame == 4:
		owner.attack_shape.set_disabled(false)
	if owner.animated_sprite.frame == owner.animated_sprite.frames.get_frame_count("Attack") - 1:
		if _previous_state == "Damage":
			return "Patrol"
		return _previous_state
	return .process(owner, delta)

func player_detected():
	pass
	
func message(message):
	if message == "Damage":
		return "Damage"
	return null
