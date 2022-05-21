extends RigidBody2D

const shader = preload("res://Materials/Piece.shader")

onready var collision_shape = get_node("collision_shape")
onready var drag_double = get_parent().get_node("drag_piece")

const PIECE_SIZE = 100.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var puzzle_pos = get_parent().puzzle_pos
onready var puzzle_size = get_parent().puzzle_size

func attach(player):
	for child in get_children():
		remove_child(child)
		var offset = puzzle_pos * PIECE_SIZE
		child.position += offset
		player.add_child(child)

	#player.top_left_corner.x = min(player.top_left_corner.x, puzzle_pos.x)
	#player.top_left_corner.y = min(player.top_left_corner.y, puzzle_pos.y)

	#player.bot_right_corner.x = max(player.bot_right_corner.x, puzzle_pos.x)
	#player.bot_right_corner.y = max(player.bot_right_corner.y, puzzle_pos.y)

	#player.num_pieces += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var puzzle_ratio = Vector2(1,1) / puzzle_size
	var mat = ShaderMaterial.new()
	mat.set_shader(shader)
	mat.set_shader_param("puzzle_pos", puzzle_pos)
	mat.set_shader_param("puzzle_ratio", puzzle_ratio)
	get_node("image").set_material(mat)
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Make the piece able to drag
		for child in get_children():
			remove_child(child)
			drag_double.add_child(child)
		drag_double.transform = transform
		drag_double.can_drag = true
		drag_double.click_offset = get_global_mouse_position() - global_position
		linear_velocity = Vector2(0,0)
		angular_velocity = 0
		applied_force = Vector2(0,0)
		applied_torque = 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
