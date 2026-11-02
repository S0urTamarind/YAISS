class_name WeaponMgr
extends Node

const DefaultWeapon = preload("res://src/yaiss/weapons/default_weapon.gd")


# TODO: Should WeaponMgr accept projectile_parent as a ctor param or should we choose it here itself?
@export var projectile_parent: Node2D
@export var player: Player

var curr_weapon: WeaponBase
var curr_weapon_ctx: WeaponCtx
var _shoot_events: Array[bool] = []  # true = press, false = release
var _trigger_down: bool = false

func _ready() -> void:
	curr_weapon_ctx = WeaponCtx.new(projectile_parent)
	switch(DefaultWeapon.new(curr_weapon_ctx))

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
			curr_weapon.on_press()
		else:
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
	curr_weapon = new_weapon
	if curr_weapon:
		curr_weapon.on_equip()
