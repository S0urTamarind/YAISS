class_name WeaponCtx
extends RefCounted

var parent_node: Node2D
var aim_origin: Vector2 = Vector2.ZERO
var aim_direction: Vector2 = Vector2.ZERO

func _init(root: Node2D) -> void:
	parent_node = root 
