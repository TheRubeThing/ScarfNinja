extends BaseState
class_name DamageState

var _dead = false
func enter(owner, previous_state):
	_state_name = "Damage"
	_previous_state = previous_state
	owner.animated_sprite.play("Damage")
	owner._velocity = Vector2.ZERO

func process(owner, delta):
	if owner.animated_sprite.frame == owner.animated_sprite.frames.get_frame_count("Damage") - 1:
		if _dead:
			return "Die"
		return _previous_state
	return null
	
func message(message):
	if message == "Die":
		_dead = true
