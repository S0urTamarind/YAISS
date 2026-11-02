extends Sprite2D

const Geometry = preload("res://src/yaiss/geometry.gd")

@export var speed: float = 600
@export var player: Area2D # TODO: Review separating the player from the sight
@export var extra_margin: float = 10.0

var padding: float = 120
var vel := Vector2.ZERO

# TODO: This is AI-generated and needs to be replaced once we declare objects to have colliders first,
# 		then fit a texture to it
func _ready() -> void:
	var sight_radius := 0.0
	if texture:
		sight_radius = texture.get_size().length() * 0.5 * maxf(absf(global_scale.x), absf(global_scale.y))
	padding = Geometry.collision_radius(player) + sight_radius + extra_margin

func _physics_process(delta: float) -> void:
	
	# TODO: Handle input via a callback instead of polling every tick
	var dirVec := Input.get_vector(
		"Shift Aim Left", "Shift Aim Right", 
		"Shift Aim Up", "Shift Aim Down"
	)
		
	vel = dirVec.normalized() * speed
	global_position += vel * delta
	
	if player:
		var difference:= global_position - player.global_position
		var radius:= difference.length()
		if radius < padding:
			if is_zero_approx(radius):
				global_position = player.global_position + Vector2.UP * padding
			else:
				global_position = player.global_position + difference.normalized() * padding
