extends KinematicBody2D
class_name CrawlerController

export(float) var move_speed = 25
export(float) var dash_speed = 200

var _grounded = false
var _landed = false
var _velocity = Vector2()
var _attacking = false

var _gravity = 0
var _jump_speed = 0

onready var STATES = {
	"Patrol": PatrolState.new()
}

onready var state = STATES["Patrol"]
onready var previous_state = null
onready var animated_sprite : AnimatedSprite = $AnimatedSprite
#onready var attack_shape : CollisionShape2D = $AnimatedSprite/Area2D/AttackShape

func _ready():
	state.enter(self, null)

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
		print("Enter: ", new_state, " from ", previous_state)
		state.enter(self, previous_state)
