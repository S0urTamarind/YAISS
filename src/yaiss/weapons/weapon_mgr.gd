class_name WeaponMgr
extends Node

const DefaultWeapon = preload("res://src/yaiss/weapons/default_weapon.gd")
const Log = preload("res://src/yaiss/logging.gd")

# TODO: Should WeaponMgr accept projectile_parent as a ctor param or should we choose it here itself?
@export var projectile_parent: Node2D
@export var player: Player

var curr_weapon: WeaponBase
var curr_weapon_ctx: WeaponCtx
var _shoot_events: Array[bool] = []  # true = press, false = release
var _trigger_down: bool = false

func _ready() -> void:
	curr_weapon_ctx = WeaponCtx.new(projectile_parent)
	switch(DefaultWeapon.new("DefaultWeapon", curr_weapon_ctx))

func _unhandled_input(event: InputEvent) -> void:
	if not curr_weapon:
		return

	if event.is_action_pressed("Shoot"):
		_shoot_events.append(true)
	elif event.is_action_released("Shoot"):
		_shoot_events.append(false)
	else:
		return

	get_viewport().set_input_as_handled()

func _dispatch_trigger(dt: float) -> void:
	for pressed in _shoot_events:
		if pressed == _trigger_down:
			continue

		_trigger_down = pressed
		if pressed:
			Log.record_debug("trigger pressed", ["WeaponMgr"])
			curr_weapon.on_press()
		else:
			Log.record_debug("trigger released", ["WeaponMgr"])
			curr_weapon.on_release()

	_shoot_events.clear()

	if _trigger_down:
		curr_weapon.on_hold(dt)

func _physics_process(dt: float) -> void:
	if curr_weapon:
		var aim := player.get_aim()
		curr_weapon_ctx.aim_origin = aim["origin"]
		curr_weapon_ctx.aim_direction = aim["direction"]
		curr_weapon.on_update(dt)
		_dispatch_trigger(dt)
	else:
		_shoot_events.clear()
		_trigger_down = false

func switch(new_weapon: WeaponBase) -> void:

	if curr_weapon == new_weapon:
		return
	if curr_weapon:
		curr_weapon.on_unequip()
	_shoot_events.clear()
	_trigger_down = false
	Log.record_info(
		"switched weapon from {old_w} to {new_w}".format({
			"old_w": curr_weapon.weapon_name if curr_weapon else "<none>",
			"new_w": new_weapon.weapon_name if new_weapon else "<none>",
		}),
		["WeaponMgr"]
	)
	curr_weapon = new_weapon
	if curr_weapon:
		curr_weapon.on_equip()
