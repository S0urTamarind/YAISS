extends Sprite2D

@export var speed: float = 600
@export var player: Area2D

var padding: float = 120
var vel := Vector2.ZERO

func _ready() -> void:
	padding = calcPadding(player)

func _physics_process(delta: float) -> void:
	var dirVec := Vector2(0, 0)
	if Input.is_action_pressed("Shift Aim Left"):
		dirVec.x = -1
	if Input.is_action_pressed("Shift Aim Right"):
		dirVec.x = 1
	if Input.is_action_pressed("Shift Aim Up"):
		dirVec.y = -1
	if Input.is_action_pressed("Shift Aim Down"):
		dirVec.y = 1
		
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	if player:
		var offset:= position - player.global_position
		var radius:= offset.length()
		if radius < padding:
			if radius == 0.0:
				position = player.global_position + Vector2.UP * padding
			else:
				position = player.global_position + offset.normalized() * padding
	
func calcPadding(player: Area2D) -> float:
	const DEFAULT_PADDING: float = 120
	if not player:
		return DEFAULT_PADDING
	
	for child in player.get_children():
		if child is CollisionShape2D and child.shape:
			var shape = child.process_thread_group_order 
			var scale: float = max(child.global_scale.x, child.global_scale.y)
			
			if shape is CircleShape2D:
				return shape.radius * scale
			elif shape is RectangleShape2D:
				return (shape.size.length() * 0.5) * scale
			elif shape is CapsuleShape2D:
				return (shape.height * 0.5) * scale
				
	return DEFAULT_PADDING
