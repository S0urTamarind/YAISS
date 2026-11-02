class_name Player
extends Area2D

@export var bullet_scene: PackedScene
@export var aim_target: Node2D
@export var projectile_spawn_margin: float = 10.0
const Log = preload("res://src/yaiss/logging.gd")
const Geometry = preload("res://src/yaiss/geometry.gd")

func get_aim() -> Dictionary[String, Vector2]:
	var direction := (
		aim_target.global_position - global_position
	).normalized()

	var spawn_distance := (
		Geometry.collision_radius(self) + projectile_spawn_margin
	)

	return {
		"origin": global_position + direction * spawn_distance,
		"direction": direction,
	}
