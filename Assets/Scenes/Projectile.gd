extends Sprite

export(float) var life_time = 5
export(float) var speed = 40
export(float) var targeting_speed = 0.05

var _old_direction = Vector2.ZERO
func _physics_process(delta):
	var player_position = get_node("../Player").position
	var direction = (1 - targeting_speed) * _old_direction + targeting_speed * (player_position - position).normalized()
	_old_direction = direction
	position += direction * speed * delta
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("Player"):
			body.take_damage(1)
			queue_free()
			
	life_time -= delta
	if life_time <= 0:
		queue_free()
		
func set_start_direction(direction):
	_old_direction = direction
