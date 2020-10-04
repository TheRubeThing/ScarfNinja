extends KinematicBody2D

export(float) var move_speed = 100
export(float) var jump_speed = 200
export(float) var gravity = 250
export(float) var air_drag = 0.1
export(float) var grounded_drag = 0.9

var _grounded = false
var _landed = false
var _velocity = Vector2()
var _attacking = false

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

	if Input.is_action_just_pressed("Attack"):
			_attacking = true

	#Animation control
	if _grounded:
				
		if _attacking:
			$AnimatedSprite.play("Attack")
			_velocity.x = 0
			if $AnimatedSprite.frame == 3:
				_attacking = false
		elif _landed:
			if abs(_velocity.x) > 20:
				$AnimatedSprite.play("IdleRunTrans")
				_landed = false
			else:
				$AnimatedSprite.play("Land")
				if $AnimatedSprite.frame == 2:
					_landed = false
		elif _velocity.x > 0.1:
			if Input.is_action_just_pressed("Right_direction") || ($AnimatedSprite.animation == "IdleRunTrans" && $AnimatedSprite.frame != 1):
				$AnimatedSprite.play("IdleRunTrans")
			else:
				$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
		elif _velocity.x < -0.1:
			if Input.is_action_just_pressed("Left_direction") || ($AnimatedSprite.animation == "IdleRunTrans" && $AnimatedSprite.frame != 1):
				$AnimatedSprite.play("IdleRunTrans")
			else:
				$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
		else:
			if Input.is_action_just_released("Left_direction") || Input.is_action_just_released("Right_direction"):
				$AnimatedSprite.play("IdleRunTrans")
			else:
				$AnimatedSprite.play("Idle")
	else:
		if _attacking:
			$AnimatedSprite.play("Attack")
			if $AnimatedSprite.frame == 3:
				_attacking = false
		elif _velocity.y < -60:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
			if _velocity.x > 0.1:
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true

func _physics_process(delta):
	#Ground test
	_grounded = test_move(transform, Vector2(0, 1))
	if _velocity.y > 0 && _grounded:
		_landed = true
	
	# Gravity
	if _grounded:
		_velocity.y = 0
	else:
		_velocity.y += gravity * delta

	# Jumping logic
	if Input.is_action_just_pressed("Jump") && _grounded:
		_velocity.y = -jump_speed

	if _velocity.y < 0 && Input.is_action_pressed("Jump") == false:
		_velocity.y -= _velocity.y * air_drag
		
	# Move
	move_and_slide(_velocity)
