# PlayerController.gd
extends KinematicBody2D

class_name PlayerController

export(float) var move_speed = 100
export(float) var dash_speed = 200
export(float) var climb_speed = 40
export(float) var dash_distance = 30
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

onready var STATES = {
	"Idle": PlayerIdleState.new(),
	"Run": PlayerRunState.new(),
	"Jump": PlayerJumpState.new(),
	"Fall": PlayerFallState.new(),
	"Attack": PlayerAttackState.new(),
	"Dash": PlayerDashState.new(),
	"Climb": PlayerClimbState.new()
}

onready var state = STATES["Idle"]
onready var previous_state = null
onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var attack_shape : CollisionShape2D = $AnimatedSprite/Area2D/AttackShape
onready var climb_shape : Area2D = $ClimbDetect
onready var ground_particles : Node2D = $GroundParticles
onready var dirt_particles = load("res://Assets/Scenes/GroundParticles/DirtParticles.tscn")

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
		state = STATES[new_state]
		state.enter(self, previous_state)

func _calculate_jump_parameters():
	_gravity = jump_height / (pow((jump_distance / move_speed), 2))
	_jump_speed = sqrt(2 * jump_height * _gravity)
	
func detect_climb():
	var climbables = get_tree().get_nodes_in_group("Climbable")
	for climbable in climbables:
		if climb_shape.overlaps_body(climbable):
			return true
	return false
		
	
