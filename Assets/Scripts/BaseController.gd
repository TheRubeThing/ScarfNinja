extends KinematicBody2D
class_name BaseController

export(float) var move_speed = 40
export(float) var Max_health = 50

var _velocity = Vector2()
var _previous_velocity = Vector2()

onready var health = Max_health
onready var animated_sprite : AnimatedSprite = $AnimatedSprite

var STATES
var state
var previous_state
onready var controller_name := "Base"

func _process(delta):
	var new_state = state.process(self, delta)
	state_transition(new_state)

func _physics_process(delta):
	var new_state = state.physics_process(self, delta)
	state_transition(new_state)

func state_transition(new_state):
	if new_state != null:
		previous_state = state.exit(self, new_state)
		state = STATES[new_state]
		print(get_name(), " Enter: ", new_state, " from ", previous_state)
		state.enter(self, previous_state)

func play_animation(animation_name : String) -> bool:
	animated_sprite.play(animation_name)
	return animated_sprite.is_playing()
	
func stop_animation() -> void:
	animated_sprite.stop()
	
func look_direction(direction: int = 1) -> void:
	if direction != 0:
		animated_sprite.scale.x = sign(direction) * 1
		
func start_attack(idx = 0):
	pass
	
func end_attack(idx = 0):
	pass
	
