extends BaseState
class_name DieState

var delete_timer = 5

func enter(owner, previous_state):
	_state_name = "Die"
	owner._velocity.x = 0
	owner.disable_collision()
	owner.play_animation("Die")
	
func process(owner, delta):
	delete_timer -= delta
	if delete_timer < 0:
		owner.queue_free()
	
