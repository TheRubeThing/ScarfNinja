extends BaseState
class_name AttackState

var _previous_velocity := Vector2.ZERO
var _attack_trigger_frames = []
var _attack_end_frames = []
var _attack_index = 0

func _init(AttackTriggerFrames, AttackEndFrames, AttackIndex):
	_attack_trigger_frames = AttackTriggerFrames
	_attack_end_frames = AttackEndFrames
	_attack_index = AttackIndex

func enter(owner, previous_state):
	_state_name = "Attack"
	owner.play_animation("Attack")
	_previous_velocity = owner._velocity
	owner._velocity = Vector2.ZERO
	.enter(owner, previous_state)
	
func exit(owner, new_state):
	owner._velocity = _previous_velocity
	return .exit(owner, new_state)
	
func process(owner, delta):
	if owner.animated_sprite.frame in _attack_trigger_frames:
		owner.start_attack(_attack_index)
	if owner.animated_sprite.frame in _attack_end_frames:
		owner.end_attack(_attack_index)
	return .process(owner, delta)
	
func message(message, data):
	if message == "Damage":
		return "Damage"
	if message == "AnimationFinished":
		if _previous_state == "Damage":
			return "Patrol"
		return _previous_state
	return null
