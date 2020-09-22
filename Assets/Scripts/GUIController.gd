extends KinematicBody2D

var _stretch = Vector2()
var _squash = Vector2()

func _on_StretchXSlider_value_changed(value : float):
	_stretch.x = value
	get_node("Sprite").set_stretch(_stretch)

func _on_StretchYSlider_value_changed(value : float):
	_stretch.y = value
	get_node("Sprite").set_stretch(_stretch)

func _on_SquashXSlider_value_changed(value : float):
	_squash.x = value
	get_node("Sprite").set_squash(_squash)

func _on_SquashYSlider_value_changed(value : float):
	_squash.y = value
	get_node("Sprite").set_squash(_squash)