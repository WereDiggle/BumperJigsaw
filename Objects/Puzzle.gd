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

func rand_vector():
	return Vector2(rand_range(-1, 1), rand_range(-1, 1))

# Called when the node enters the scene tree for the first time.
func _ready():
	for h in puzzle_height:
		for w in puzzle_width:
			var piece_group = PieceGroup.instance().init(Vector2(w, h), Vector2(puzzle_width, puzzle_height), image)
			piece_group.position = Vector2(w, h) * spawn_distance + rand_vector() * spawn_jiggle
			add_child(piece_group)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
