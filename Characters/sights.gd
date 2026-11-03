extends Sprite2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return

	global_position += event.relative
	_clamp_to_gameplay_area()

func _clamp_to_gameplay_area() -> void:
	var viewport_rect := get_viewport_rect()
	var half_size := Vector2.ZERO
	if texture:
		half_size = texture.get_size() * 0.5 * global_scale.abs()

	global_position.x = clampf(
		global_position.x,
		viewport_rect.position.x + half_size.x,
		viewport_rect.end.x - half_size.x
	)
	global_position.y = clampf(
		global_position.y,
		viewport_rect.position.y + half_size.y,
		viewport_rect.end.y - half_size.y
	)
