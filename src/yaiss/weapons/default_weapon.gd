extends WeaponBase

const Log = preload("res://src/yaiss/logging.gd")
const Bullet = preload("res://Characters/Bullet.tscn")

# TODO: Make these properties editable 
const max_ammo = 10
const reload_time = 1.4
const max_shoot_freq = 5.66

var curr_ammo = max_ammo
var curr_reload_timer = 0.0
var curr_shoot_timer = 0.0

# TODO: Implement reloading, if needed
var can_shoot = true
var can_reload = true

func _fire(origin: Vector2, direction: Vector2) -> void:
	var bullet = Bullet.instantiate()
	bullet.direction = direction
	weapon_ctx.parent_node.add_child(bullet)
	bullet.global_position = origin
	bullet.global_rotation = direction.angle()

func _shoot() -> void:
	if can_shoot:
		# TODO: Add signals for actual shoot
		Log.record_debug("can_shoot=true", ["default_weapon"])
		_fire(weapon_ctx.aim_origin, weapon_ctx.aim_direction)
		can_shoot = false

func on_press() -> void:
	pass
	
func on_release() -> void:
	_shoot()
	
func on_hold(_dt: float) -> void:
	_shoot()

func on_update(dt: float) -> void:
	if not can_shoot:
		curr_shoot_timer += dt
		if curr_shoot_timer >= 1.0/max_shoot_freq:
			# TODO: While timer overshoot is not a concern here, it will be for other weapons
			curr_shoot_timer = 0.0
			can_shoot = true
			
	curr_reload_timer += dt
	
