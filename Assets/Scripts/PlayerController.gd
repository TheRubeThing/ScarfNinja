# PlayerController.gd
extends BaseController

class_name PlayerController

export(float) var dash_speed = 80.0
export(float) var climb_speed = 10.0
export(float) var dash_distance = 200.0
export(float) var jump_height = 38.0
export(float) var jump_distance = 20.0
export(float) var air_drag = 0.1
export(float) var grounded_drag = 0.9

var _grounded = false
var _landed = false
var _attacking = false

var _gravity = 0.0
var _jump_speed = 0.0

onready var attack_shape : CollisionShape2D = $AnimatedSprite/Area2D/AttackShape
onready var climb_shape : Area2D = $ClimbDetect
onready var ground_particles : Node2D = $GroundParticles
onready var dirt_particles = load("res://Assets/Scenes/GroundParticles/DirtParticles.tscn")

func _ready():
	STATES = {
		"Idle": PlayerIdleState.new(),
		"Run": PlayerRunState.new(),
		"Jump": PlayerJumpState.new(),
		"Fall": PlayerFallState.new(),
		"Attack": PlayerAttackState.new(),
		"Dash": PlayerDashState.new(),
		"Climb": PlayerClimbState.new(),
		"Damage": DamageState.new(),
		"Die": PlayerDieState.new()
	}
	state = STATES["Idle"]
	previous_state = null
	controller_name = "Player"
	
func _physics_process(delta):
	_calculate_jump_parameters()
	._physics_process(delta)

func _calculate_jump_parameters():
	_gravity = jump_height / pow((jump_distance / move_speed), 2)
	_jump_speed = sqrt(2 * jump_height * _gravity)
	
func detect_climb():
	var climbables = get_tree().get_nodes_in_group("Climbable")
	for climbable in climbables:
		if climb_shape.overlaps_body(climbable):
			return true
	return false
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemies"):
		body.take_damage(10)
		
func take_damage(damage_amount : int):
	health -= damage_amount
	var new_state = state.message("Damage", null)
	state_transition(new_state)
	if health <= 0:
		new_state = state.message("Die", null)
		state_transition(new_state)

func disable_collision():
	$CollisionShape2D.disabled = true
	attack_shape.disabled = true

func _on_AnimatedSprite_animation_finished():
	var new_state = state.message("AnimationFinished", null)
	state_transition(new_state)
	
func start_attack(index = 0):
	attack_shape.disabled = false
	
func end_attack(index = 0):
	attack_shape.disabled = true
