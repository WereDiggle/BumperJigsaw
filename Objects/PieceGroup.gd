extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# This is what the PieceGroup's initial piece is, so use it as offset
export var puzzle_pos = Vector2(0,0)
export var puzzle_size = Vector2(1,1)
export var mass = 0.2

const PIECE_SIZE = 100.0

func is_drag():
	return get_node("piece").get_child_count() == 0

var num_pieces = 1

# merges other PieceGroup into this one
func merge(other):
	var other_parent = other.get_node("drag_piece") if other.is_drag() else other.get_node("piece")
	var this_parent = get_node("drag_piece") if is_drag() else get_node("piece")
	
	for child in other_parent.get_children():
		other_parent.remove_child(child)
		child.position = (child.puzzle_pos - puzzle_pos) * PIECE_SIZE
		this_parent.add_child(child)
	
	num_pieces += other.num_pieces
	$piece.mass = mass * num_pieces

func init(args):
	puzzle_pos = args.pos
	puzzle_size = args.size
	$piece/hitbox.init(args)
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("piece").get_node("hitbox").init(puzzle_pos, puzzle_size, image)
	pass