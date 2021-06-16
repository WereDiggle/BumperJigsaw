extends RigidBody2D

const shader = preload("res://Materials/Piece.shader")

onready var collision_shape = get_node("collision_shape")

const PIECE_SIZE = 100.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var puzzle_pos = Vector2(0,0)

func attach_to_player(player):
	for child in get_children():
		remove_child(child)
		var offset = puzzle_pos * PIECE_SIZE
		child.position += offset
		player.add_child(child)

# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = ShaderMaterial.new()
	mat.set_shader(shader)
	mat.set_shader_param("puzzle_pos", puzzle_pos)
	mat.set_shader_param("puzzle_ratio", Vector2(0.5, 0.5))
	get_node("image").set_material(mat)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
