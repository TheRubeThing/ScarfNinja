extends Sprite


export(float) var amplitude = 2
export(float) var freq = 1
var _og_pos = Vector2.ZERO
var _time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_og_pos = position

func _process(delta):
	_time += delta
	position.y = _og_pos.y + sin(_time * 2 * PI * freq) * amplitude
