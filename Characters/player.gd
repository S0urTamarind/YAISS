extends Area2D

@export var bullet_scene: PackedScene
@export var aim_target: Node2D
@export var projectile_spawn_margin: float = 10.0
const Log = preload("res://src/yaiss/logging.gd")
const Geometry = preload("res://src/yaiss/geometry.gd")
	
func _physics_process(_delta: float) -> void:
	# TODO: Make this callback
	if Input.is_action_just_pressed("Shoot"):
		shoot()
		
func shoot() -> void:
# TODO: This is AI-generated and needs to be replaced once we declare objects to have colliders first,
# 		then fit a texture to it
	if not is_instance_valid(aim_target):
		return

	Log.record_debug("Player called shoot()!", ["Player"])

	var bullet = bullet_scene.instantiate()
	var fire_dir = (aim_target.global_position - global_position).normalized()
	var spawn_distance = Geometry.collision_radius(self) + projectile_spawn_margin
	
	bullet.direction = fire_dir
	bullet.global_position = global_position + (fire_dir * spawn_distance)
	bullet.rotation = fire_dir.angle()
	get_tree().root.add_child(bullet)
