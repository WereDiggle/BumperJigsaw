extends Area2D

const Player = preload("res://Scripts/Player.gd")

onready var piece = get_parent()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_body_entered(node):
	if node is Player:
		print(node)
		piece.attach_to_player(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
