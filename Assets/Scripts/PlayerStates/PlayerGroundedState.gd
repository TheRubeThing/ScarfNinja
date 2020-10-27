# PlayerGroundedState.gd
extends BaseState

class_name PlayerGroundedState
	
func physics_process(owner, delta):
	owner._velocity.y = 0
	if Input.is_action_just_pressed("Jump"):
		var particles = owner.dirt_particles.instance()
		particles.position = owner.ground_particles.global_position
		owner.get_parent().add_child(particles)
		particles.set_emitting(true)
		return "Jump"
	if not owner.test_move(owner.transform, Vector2(0, 0.1)):
		return "Fall"
	return .physics_process(owner, delta)
