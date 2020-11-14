extends PlayerBaseState
class_name PlayerDieState

var delete_timer = 5

func enter(owner, previous_state):
	_state_name = "Die"
	owner.disable_collision()
	owner.animated_sprite.play("Die")
	
func process(owner, delta):
	delete_timer -= delta
	if delete_timer < 0:
		owner.get_tree().reload_current_scene()
