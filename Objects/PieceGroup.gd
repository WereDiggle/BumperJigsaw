extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# This is what the PieceGroup's initial piece is, so use it as offset
export var puzzle_pos = Vector2(0,0)
export var puzzle_size = Vector2(1,1)

const PIECE_SIZE = 100.0

func is_drag():
	return get_node("piece").get_child_count() == 0

# merges other PieceGroup into this one
func merge(other):
	var other_parent = other.get_node("drag_piece") if other.is_drag() else other.get_node("piece")
	var this_parent = get_node("drag_piece") if is_drag() else get_node("piece")
	
	for child in other_parent.get_children():
		other_parent.remove_child(child)
		child.position = (child.puzzle_pos - puzzle_pos) * PIECE_SIZE
		this_parent.add_child(child)

func init(pos, size, image, facing):
	puzzle_pos = pos
	puzzle_size = size
	$piece/hitbox.init(pos, size, image, facing)
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("piece").get_node("hitbox").init(puzzle_pos, puzzle_size, image)
	pass