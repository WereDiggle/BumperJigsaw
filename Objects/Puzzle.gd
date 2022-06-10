extends Node2D

const PieceGroup = preload("res://Objects/PieceGroup.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var image
export var puzzle_width = 1 
export var puzzle_height = 1 

export var spawn_distance = 200
export var spawn_jiggle = 50
export var spawn_shuffle = true
export var spawn_rand_rotate = true

func rand_vector():
	return Vector2(rand_range(-1, 1), rand_range(-1, 1))

func rand_facing():
	return (randi() % 2) * 2 - 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawn_positions = range(puzzle_width*puzzle_height)
	var piece_facings = []
	if spawn_shuffle:
		spawn_positions.shuffle()

	for i in puzzle_height * puzzle_width:
		var h = i / puzzle_width 
		var w = i % puzzle_width
		var facing = Color(rand_facing(), rand_facing(), rand_facing(), rand_facing())
		if w > 0:
			facing.r = -piece_facings[i-1].b
		if h > 0:
			facing.g = -piece_facings[i-puzzle_width].a
		piece_facings.append(facing)
		var piece_group = PieceGroup.instance().init(Vector2(w, h), Vector2(puzzle_width, puzzle_height), image, facing)
		var spawn_pos = spawn_positions[i]
		var spawn_h = spawn_pos / puzzle_width 
		var spawn_w = spawn_pos % puzzle_width
		piece_group.position = Vector2(spawn_w, spawn_h) * spawn_distance + rand_vector() * spawn_jiggle
		if spawn_rand_rotate:
			piece_group.rotation = rand_range(0, 360)
		add_child(piece_group)
	
	for node in get_tree().get_nodes_in_group("PieceFeelers"):
		node.connect("piece_snap", self, "play_snap")

	pass # Replace with function body.

func play_snap():
	$SnapSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
