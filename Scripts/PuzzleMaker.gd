extends Node2D

var Wall = load("res://Objects/BoardWall.tscn")
var Piece = load("res://Objects/Piece.tscn")
var Player = load("res://Objects/Player.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Image) var image

export var puzzle_width = 1
export var puzzle_height = 1

export var board_width = 500
export var board_height = 500

func spawn_walls():
	var top = Wall.instance()
	top.set_name("top_wall")
	top.position = Vector2()

func spawn_piece(x, y, is_player = false):
	var piece
	if is_player:
		piece = Player.instance()
	else:
		piece = Piece.instance()

	piece.puzzle_pos = Vector2(x,y)
	piece.puzzle_size = Vector2(puzzle_width, puzzle_height)
	add_child(piece)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn walls for the board
	#spawn_walls()

	# Pick a random coord, spawn that as a player
	for row in range(puzzle_height):
		for col in range(puzzle_width):
			spawn_piece(col, row, row == 0 && col == 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
