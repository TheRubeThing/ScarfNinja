extends HBoxContainer


var healthSprite := preload("res://Assets/Sprites/GUI/HealthSprite.tscn")
onready var player : PlayerController = get_node("/root/Node2D/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	for idx in range(player.Max_health):
		var sprite = healthSprite.instance()
		add_child(sprite)

func _process(delta):
	for idx in get_child_count():
		if idx >= player.health:
			get_child(idx).visible = false
		else:
			get_child(idx).visible = true
