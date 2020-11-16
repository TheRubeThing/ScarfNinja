extends PlayerBaseState

class_name PlayerClimbState

func process(owner, delta):
	owner.play_animation("Climb")
	var direction = Vector2.ZERO
	if Input.is_action_pressed("Up_direction"):
		direction.y += -1
	if Input.is_action_pressed("Down_direction"):
		direction.y += 1
	if Input.is_action_pressed("Left_direction"):
		direction.x += -1
	if Input.is_action_pressed("Right_direction"):
		direction.x += 1
		
	direction = direction.normalized()
	owner._velocity = direction * owner.climb_speed
	
	if owner._velocity == Vector2.ZERO:
		owner.stop_animation()
		
	if Input.is_action_just_pressed("Jump") || not owner.detect_climb():
		return "Fall"
	return null

