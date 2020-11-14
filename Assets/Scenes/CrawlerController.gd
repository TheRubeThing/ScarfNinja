extends KinematicBody2D
class_name CrawlerController

export(float) var move_speed = 25
export(float) var dash_speed = 200
export(float) var health = 50

var _grounded = false
var _landed = false
var _velocity = Vector2()
var _attacking = false

var _gravity = 0
var _jump_speed = 0


onready var STATES = {
	"Patrol": PatrolState.new(),
	"Attack": AttackState.new(),
	"Damage": DamageState.new(),
	"Die": DieState.new()
}

onready var state = STATES["Patrol"]
onready var previous_state = null
onready var animated_sprite : AnimatedSprite = $AnimatedSprite
onready var attack_shape : CollisionShape2D = $AnimatedSprite/AttackArea/AttackShape
onready var detect_area : Area2D = $AnimatedSprite/PlayerDetectArea

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
		
func take_damage(damage_amount: int):
	health -= damage_amount
	var new_state = state.message("Damage")
	state_transition(new_state)
	if health <= 0:
		new_state = state.message("Die")
		state_transition(new_state)

func _on_AttackArea_body_entered(body):
	print("Attack shape collided")
	if body.is_in_group("Player"):
		body.take_damage(1)

func detect_player() -> bool:
	var bodies = detect_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Player"):
			return true
	return false
	
func disable_collision():
	$CollisionShape2D.disabled = true
	attack_shape.disabled = true
