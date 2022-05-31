extends RigidBody2D

onready var collision_shape = get_node("collision_shape")
onready var drag_double = get_parent().get_node("drag_piece")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		# Make the piece able to drag
		for child in get_children():
			remove_child(child)
			drag_double.add_child(child)
		drag_double.transform = transform
		drag_double.can_drag = true
		drag_double.click_offset = get_global_mouse_position() - global_position
		drag_double.rotate_offset = rotation
		linear_velocity = Vector2(0,0)
		angular_velocity = 0
		applied_force = Vector2(0,0)
		applied_torque = 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
