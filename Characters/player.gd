class_name Player
extends Area2D

@export var bullet_scene: PackedScene
@export var aim_target: Node2D
@export var projectile_spawn_margin: float = 10.0
@export var move_speed: float = 500.0
const Geometry = preload("res://src/yaiss/geometry.gd")
var _last_aim_direction := Vector2.UP

func _physics_process(delta: float) -> void:
	var movement := Input.get_vector(
		"Move Left",
		"Move Right",
		"Move Up",
		"Move Down"
	)
	global_position += movement * move_speed * delta

	var viewport_rect := get_viewport_rect()
	var radius := Geometry.collision_radius(self)
	global_position.x = clampf(
		global_position.x,
		viewport_rect.position.x + radius,
		viewport_rect.end.x - radius
	)
	global_position.y = clampf(
		global_position.y,
		viewport_rect.position.y + radius,
		viewport_rect.end.y - radius
	)

func get_aim() -> Dictionary[String, Vector2]:
	var difference := aim_target.global_position - global_position
	var direction := _last_aim_direction
	if not is_zero_approx(difference.length_squared()):
		direction = difference.normalized()
		_last_aim_direction = direction

	var spawn_distance := (
		Geometry.collision_radius(self) + projectile_spawn_margin
	)

	return {
		"origin": global_position + direction * spawn_distance,
		"direction": direction,
	}
