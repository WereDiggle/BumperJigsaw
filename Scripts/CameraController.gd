extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var speed = 500
export var zoom_speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).clamped(1)
	position += direction * speed * delta * zoom

	var zoom_direction = Input.get_action_strength("rotate_left") - Input.get_action_strength("rotate_right")
	zoom *= Vector2(1,1) + Vector2(1,1) * (zoom_direction * zoom_speed * delta)
	pass
