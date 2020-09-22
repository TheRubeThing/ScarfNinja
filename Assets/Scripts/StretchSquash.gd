extends Sprite

func set_stretch(stretch : Vector2):
	stretch += Vector2(1,1)
	var stretch_factor = stretch.x / stretch.y
	self.scale = Vector2(stretch_factor, 1 / stretch_factor)

func set_squash(squash : Vector2):
	var squash_factor = (abs(squash.x) + 1) / (abs(squash.y) + 1)
	self.scale = Vector2(1 / squash_factor, squash_factor)
	if abs(squash.y) > abs(squash.x):
		squash_factor = 1 / squash_factor
	self.position = squash * squash_factor / 2
