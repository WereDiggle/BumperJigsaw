extends Area2D

const DragPiece = preload("res://Scripts/DragPiece.gd")
const PieceHitbox = preload("res://Objects/PieceHitbox.gd")
var PieceFeeler = get_script()

export var feeler_direction = Vector2(0,0) 

onready var piece = get_parent()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func is_twin(other):
	return piece.puzzle_pos + feeler_direction == other.piece.puzzle_pos \
		&& other.piece.puzzle_pos + other.feeler_direction == piece.puzzle_pos

func on_area_entered(area):
	if area is PieceFeeler and area.get_parent() is PieceHitbox and area.is_twin(self):
		var other_group = area.get_parent().get_parent().get_parent()
		var this_group = get_parent().get_parent().get_parent()
		if other_group != this_group:
			if other_group.is_drag():
				other_group.merge(this_group)
			else:
				this_group.merge(other_group)

		# Remove feelers now they are joined together
		area.queue_free()
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
