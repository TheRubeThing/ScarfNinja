extends BaseState

class_name PlayerClimbState

func process(owner, delta):
	owner.animated_sprite.play("Climb")
	owner._velocity = Vector2.ZERO
	if Input.is_action_pressed("Up_direction"):
		owner._velocity.y = -owner.climb_speed
	if Input.is_action_pressed("Down_direction"):
		owner._velocity.y = owner.climb_speed
	if Input.is_action_pressed("Left_direction"):
		owner._velocity.x = -owner.climb_speed
	if Input.is_action_pressed("Right_direction"):
		owner._velocity.x = owner.climb_speed
	
	if owner._velocity == Vector2.ZERO:
		owner.animated_sprite.stop()
		
	if Input.is_action_just_pressed("Jump") || not owner.detect_climb():
		return "Fall"
	return null

