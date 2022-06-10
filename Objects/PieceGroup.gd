extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# This is what the PieceGroup's initial piece is, so use it as offset
export var puzzle_pos = Vector2(0,0)
export var puzzle_size = Vector2(1,1)
export var mass = 0.2

var edge_top
var edge_bot
var edge_left
var edge_right

const PIECE_SIZE = 100.0

func is_drag():
	return get_node("piece").get_child_count() == 0

var num_pieces = 1

# merges other PieceGroup into this one
func merge(other):
	var other_parent = other.get_node("drag_piece") if other.is_drag() else other.get_node("piece")
	var this_parent = get_node("drag_piece") if is_drag() else get_node("piece")

	var new_edge_left = min(other.edge_left, edge_left)
	var new_edge_right = max(other.edge_right, edge_right)
	var new_edge_top = min(other.edge_top, edge_top)
	var new_edge_bot = max(other.edge_bot, edge_bot)

	var old_position = Vector2((edge_left + edge_right) / 2, (edge_top + edge_bot) / 2) * PIECE_SIZE
	var new_position = Vector2((new_edge_left + new_edge_right) / 2, (new_edge_top + new_edge_bot) / 2) * PIECE_SIZE
	var reposition_offset = new_position - old_position

	# recenter
	var my_children = this_parent.get_children()
	for child in my_children: 
		#this_parent.remove_child(child)
		child.position -= reposition_offset
	# reposition
	this_parent.position += reposition_offset.rotated(this_parent.rotation)
	$drag_piece.click_offset -= reposition_offset.rotated(this_parent.rotation)
	#for child in my_children:
	#	this_parent.add_child(child)
	
	for child in other_parent.get_children():
		other_parent.remove_child(child)
		child.position = (child.puzzle_pos * PIECE_SIZE) - new_position
		this_parent.add_child(child)
	
	edge_left = new_edge_left
	edge_right = new_edge_right
	edge_top = new_edge_top
	edge_bot = new_edge_bot

	# need to recenter parent
	
	num_pieces += other.num_pieces
	$piece.mass = mass * num_pieces

func init(args):
	puzzle_pos = args.pos
	edge_left = puzzle_pos.x
	edge_right = puzzle_pos.x
	edge_top = puzzle_pos.y
	edge_bot = puzzle_pos.y
	puzzle_size = args.size
	$piece/hitbox.init(args)
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("piece").get_node("hitbox").init(puzzle_pos, puzzle_size, image)
	pass
