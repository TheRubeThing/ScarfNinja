extends KinematicBody2D

export(float) var move_speed = 100
export(float) var jump_soeed = 500
export(float) var gravity = 100
export(float) var air_drag = 0.1
export(float) var grounded_drag = 0.9

var _grounded = false
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
	_grounded = test_move(transform, _velocity * delta + Vector2(0,0.1))
	print(_grounded)
	# Gravity
	if _grounded:
		_velocity.y = 0
	else:
		_velocity.y += gravity * delta
	
	# Move
	move_and_slide(_velocity)
