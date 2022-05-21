extends KinematicBody2D

const shader = preload("res://Materials/Piece.shader")

onready var rigid_double = get_parent().get_node("piece")

const PIECE_SIZE = 100.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var puzzle_pos = Vector2(0,0)
export var puzzle_size = Vector2(1,1)

func attach_to_player(player):
	for child in get_children():
		remove_child(child)
		var offset = puzzle_pos * PIECE_SIZE
		child.position += offset
		player.add_child(child)

	player.top_left_corner.x = min(player.top_left_corner.x, puzzle_pos.x)
	player.top_left_corner.y = min(player.top_left_corner.y, puzzle_pos.y)

	player.bot_right_corner.x = max(player.bot_right_corner.x, puzzle_pos.x)
	player.bot_right_corner.y = max(player.bot_right_corner.y, puzzle_pos.y)

	player.num_pieces += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var click_loc = null

func _input(event):
	# Interestingly, on down click only fires one event
	if event.is_action_pressed("select"):
		click_loc = get_viewport().get_mouse_position()
	elif event.is_action_released("select"):
		click_loc = null

func make_rigid():
	for child in get_children():
		remove_child(child)
		rigid_double.add_child(child)
	rigid_double.transform = transform

var can_drag = false;
var click_offset = Vector2(0, 0)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and not event.pressed:
		print_debug("making rigid")
		make_rigid()
		can_drag = false

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_drag:
		global_position = get_global_mouse_position() - click_offset

export (int, 0, 200) var push = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).clamped(1)
	if click_loc != null:
		direction = (get_viewport().get_mouse_position() - click_loc).clamped(1)

	#move_and_slide(direction)

	# after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * push)