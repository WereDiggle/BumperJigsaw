extends Area2D

const DragPiece = preload("res://Scripts/DragPiece.gd")
var PieceFeeler = get_script()

export var feeler_direction = Vector2(0,0) 

onready var piece = get_parent()
onready var puzzle_pos = get_parent().get_parent().puzzle_pos

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func is_twin(other):
	return puzzle_pos + feeler_direction == other.puzzle_pos && other.puzzle_pos + other.feeler_direction == puzzle_pos

func _on_area_entered(area):
	if  area is PieceFeeler and area.get_parent() is DragPiece and area.is_twin(self):
		print(area)
		piece.attach(area.get_parent())
		area.queue_free()
		queue_free()

func _on_body_entered(node):
	pass
	#if node is Player:
	#	print(node)
	#	piece.attach_to_player(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
