extends Camera2D

export(float) var smoothing = 1.2
export(Vector2) var target_offset = Vector2.ZERO

onready var player = get_node("../Player")

var _target_position := Vector2.ZERO

func _ready():
	_target_position = player.position + target_offset
	position = player.position + target_offset

func _process(delta):
	_target_position = player.position - position + target_offset
	var distance = (_target_position).length() / (get_viewport_rect().size.y * 0.25)
	var coeff = pow(distance / smoothing, 2) * 10
	position += _target_position.normalized() * coeff
	align()
