class_name WeaponBase
extends RefCounted

var weapon_ctx: WeaponCtx
var weapon_name: String

func _init(name: String, ctx: WeaponCtx) -> void:
	weapon_name = name
	weapon_ctx = ctx

func on_press() -> void:
	pass

func on_release() -> void:
	pass

func on_hold(_dt: float) -> void:
	pass

func on_update(_dt: float) -> void:
	pass

func on_equip() -> void:
	pass

func on_unequip() -> void:
	pass
