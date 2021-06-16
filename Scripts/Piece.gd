extends RigidBody2D

onready var collision_shape = get_node("collision_shape")
onready var image = get_node("image")

const PIECE_SIZE = 100.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var puzzle_pos = Vector2(0,0)

func attach_to_player(player):
	remove_child(collision_shape)
	remove_child(image)

	var offset = puzzle_pos * PIECE_SIZE
	collision_shape.position = offset
	image.position = offset
	player.add_child(collision_shape)
	player.add_child(image)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
