# BaseState.gd
extends BaseState
class_name PlayerBaseState

func process(owner, delta):
	if Input.is_action_just_pressed("Attack") && not _state_name == "Attack":
		return "Attack"
	if Input.is_action_just_pressed("Dash") && not _state_name == "Dash":
		return "Dash"
	if Input.is_action_just_pressed("Climb") && owner.detect_climb():
		return "Climb"
	return null

func message(message):
	if message == "Damage":
		return "Damage"
	return null
