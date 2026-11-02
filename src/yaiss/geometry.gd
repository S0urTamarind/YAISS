extends RefCounted

# TODO: This is AI-generated and needs to be replaced once we declare objects to have colliders first,
# 		then fit a texture to it
static func collision_radius(target: Node2D, fallback: float = 120.0) -> float:
	if not is_instance_valid(target):
		return fallback

	var radius := -1.0
	for child in target.get_children():
		if not child is CollisionShape2D or not child.shape:
			continue

		var shape = child.shape
		var shape_radius: float
		if shape is CircleShape2D:
			shape_radius = shape.radius
		elif shape is RectangleShape2D:
			shape_radius = shape.size.length() * 0.5
		elif shape is CapsuleShape2D:
			shape_radius = maxf(shape.radius, shape.height * 0.5)
		else:
			continue

		var max_scale := maxf(absf(child.global_scale.x), absf(child.global_scale.y))
		var offset := target.global_position.distance_to(child.global_position)
		radius = maxf(radius, offset + shape_radius * max_scale)

	return fallback if radius < 0.0 else radius
