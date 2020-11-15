extends BaseState
class_name PatrolState

var direction: int = 1
var counter: float = 0
var counter_top: float = 10

func enter(owner, previous_state):
	_state_name = "Patrol"
	owner._velocity.x = 0
	owner.animated_sprite.play("Idle")
	
func process(owner, delta):
	owner.animated_sprite.scale.x = direction
	
	if Input.is_action_just_pressed("Enemy_attack"):
		return "Attack"
	
	if counter > counter_top:
		counter = 0
		counter_top = rand_range(0, 3)
		if rand_range(0,1) > 0.25:
			direction *= -1
			owner._velocity.x = owner.move_speed * direction
			owner.animated_sprite.play("Walk")
		else:
			owner._velocity.x = 0
			owner.animated_sprite.play("Idle")
			
	counter += delta
	return null
	
func physics_process(owner: KinematicBody2D, delta):
	if owner.detect_player():
		return "Attack"
	if owner.test_move(owner.transform, Vector2(direction, 0)):
		direction *= -1
		owner._velocity.x = owner.move_speed * direction
		
	return .physics_process(owner, delta)
	
func message(message):
	if message == "Damage":
		return "Damage"
	return null
