extends RigidBody2D

onready var collision_shape = get_node("collision_shape")
onready var image = get_node("image")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func attach_to_player(player):
	remove_child(collision_shape)
	remove_child(image)

	player.add_child(collision_shape)
	player.add_child(image)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
