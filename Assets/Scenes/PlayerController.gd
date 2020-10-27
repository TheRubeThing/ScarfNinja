extends KinematicBody2D

export(float) var move_speed = 100
export(float) var jump_height = 200
export(float) var jump_distance = 200
export(float) var air_drag = 0.1
export(float) var grounded_drag = 0.9

var _grounded = false
var _landed = false
var _velocity = Vector2()
var _attacking = false

var _gravity = 0
var _jump_speed = 0

const STATES = {
	"Idle": PlayerIdleState,
	"Run": PlayerRunState,
	"Jump": PlayerJumpState,
	"Fall": PlayerFallState,
	"Attack": PlayerAttackState
}

onready var state = STATES["Idle"].new()
onready var previous_state = null
onready var animated_sprite = $AnimatedSprite
onready var attack_shape = $AnimatedSprite/Area2D/AttackShape

func _ready():
	state.enter(self, null)

func _process(delta):
	var new_state = state.process(self, delta)
	state_transition(new_state)

func _physics_process(delta):
	_calculate_jump_parameters()
	var new_state = state.physics_process(self, delta)
	state_transition(new_state)

func state_transition(new_state):
	if new_state != null:
		previous_state = state.exit(self, new_state)
		state = STATES[new_state].new()
		state.enter(self, previous_state)

func _calculate_jump_parameters():
	_gravity = jump_height / (pow((jump_distance / move_speed), 2))
	_jump_speed = sqrt(2 * jump_height * _gravity)
