extends BaseController
class_name CrawlerController

var _grounded = false
var _landed = false
var _attacking = false

var _gravity = 0.0
var _jump_speed = 0.0

onready var attack_shape : CollisionShape2D = $AnimatedSprite/AttackArea/AttackShape
onready var detect_area : Area2D = $AnimatedSprite/PlayerDetectArea

func _ready():
	STATES = {
		"Patrol": PatrolState.new(),
		"Attack": AttackState.new([4], [5], 0),
		"Damage": DamageState.new(),
		"Die": DieState.new()
	}
	state = STATES["Patrol"]
	previous_state = null
	state.enter(self, null)
	controller_name = "Crawler"
		
func take_damage(damage_amount: int):
	health -= damage_amount
	var new_state = state.message("Damage", null)
	state_transition(new_state)
	if health <= 0:
		new_state = state.message("Die", null)
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

func _on_AnimatedSprite_animation_finished():
	var new_state = state.message("AnimationFinished", null)
	state_transition(new_state)

func start_attack(index = 0):
	attack_shape.disabled = false
	
func end_attack(index = 0):
	attack_shape.disabled = true
