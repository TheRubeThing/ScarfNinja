extends BaseState
class_name PatrolState

var direction: int = 1
var counter: float = 0
var counter_top: float = 10

func enter(owner: BaseController, previous_state):
	_state_name = "Patrol"
	owner._velocity = Vector2.ZERO
	owner.play_animation("Idle")
	
func process(owner: BaseController, delta):
	if Input.is_action_just_pressed("Enemy_attack"):
		return "Attack"
	
	if counter > counter_top:
		counter = 0
		counter_top = rand_range(0, 3)
		if rand_range(0,1) > 0.25:
			direction *= -1
			owner.play_animation("Walk")
			owner._velocity.x = direction * owner.move_speed
			owner.look_direction(direction)
		else:
			owner._velocity.x = 0
			owner.play_animation("Idle")
			
	counter += delta
	return null
	
func physics_process(owner: BaseController, delta):
	if owner.detect_player():
		return "Attack"
	if owner.test_move(owner.transform, Vector2(direction, 0)):
		direction *= -1
		owner._velocity.x = direction * owner.move_speed
		owner.look_direction(direction)
		
	return .physics_process(owner, delta)
	
func message(message, data):
	if message == "Damage":
		return "Damage"
	return null
