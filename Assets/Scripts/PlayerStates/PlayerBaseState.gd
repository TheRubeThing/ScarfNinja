# BaseState.gd
extends BaseState
class_name PlayerBaseState

func process(owner, delta):
	if Input.is_action_just_pressed("Attack") && not _state_name == "Attack":
		return "Attack"
	if Input.is_action_just_pressed("Dash") && not _state_name == "Dash":
		return "Dash"
	if Input.is_action_just_pressed("Climb"):
		return "Climb"
	return null
