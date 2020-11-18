extends BaseController
class_name WizardController

export(float) var dash_speed = 200.0

var _grounded = false
var _landed = false
var _can_attack = true

var _gravity = 0
var _jump_speed = 0

var _projectile := preload("res://Assets/Scenes/Projectile.tscn")
 
onready var detect_area : Area2D = $AnimatedSprite/PlayerDetectArea

func _ready():
	STATES = {
		"Patrol": PatrolState.new(),
		"Attack": AttackState.new([11],[12],0),
		"Damage": DamageState.new(),
		"Die": DieState.new()
	}
	state = STATES["Patrol"]
	previous_state = null
	state.enter(self, null)
	controller_name = "Wizard"
		
func take_damage(damage_amount: int):
	health -= damage_amount
	var new_state = state.message("Damage", null)
	state_transition(new_state)
	if health <= 0:
		new_state = state.message("Die", null)
		state_transition(new_state)

func detect_player() -> bool:
	var bodies = detect_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Player"):
			return true
	return false
	
func disable_collision():
	$CollisionShape2D.disabled = true

func _on_AnimatedSprite_animation_finished():
	var new_state = state.message("AnimationFinished", null)
	state_transition(new_state)

func start_attack(index = 0):
	if _can_attack: 
		var projectile = _projectile.instance()
		print("Instanced projectile")
		projectile.position = to_global($AnimatedSprite/SpellSpawn.position)
		projectile.set_start_direction(Vector2($AnimatedSprite.scale.x, 0))
		get_parent().add_child(projectile)
		_can_attack = false
		
func end_attack(index = 0):
	_can_attack = true

