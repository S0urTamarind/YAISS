class_name WeaponBase
extends RefCounted

var weapon_ctx: WeaponCtx

func _init(ctx: WeaponCtx) -> void:
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
