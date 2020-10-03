extends KinematicBody2D

export(float) var move_speed = 100
export(float) var jump_soeed = 500
export(float) var gravity = 10
export(float) var air_drag = 0.5
export(float) var grounded_drag = 0.1

var _grounded = true
var _velocity = Vector2()

func _process(delta):
	# Input processing
	if Input.is_action_pressed("Right_direction"):
		_velocity.x = 1 * move_speed
	elif Input.is_action_pressed("Left_direction"):
		_velocity.x = -1 * move_speed
	else:
		#Movement smoothing
		if _grounded:
			_velocity.x -= _velocity.x * grounded_drag
		else:
			_velocity.x -= _velocity.x * air_drag

	

		
	print(_velocity)

	#Animation control
	if _grounded:
		if _velocity.x > 0.1:
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
		elif _velocity.x < -0.1:
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.play("Idle")

func _physics_process(delta):
	# Ground check

	# Gravity

	# Move
	move_and_slide(_velocity)
