extends KinematicBody2D

const shader = preload("res://Materials/Piece.shader")

onready var rigid_double = get_parent().get_node("piece")

const PIECE_SIZE = 100.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var puzzle_pos = get_parent().puzzle_pos
onready var puzzle_size = get_parent().puzzle_size

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

var can_drag = "";
var click_offset = Vector2(0, 0)

#func _input_event(viewport, event, shape_idx):
#	pass

export var max_speed = 5000
export var speed_factor = 20
export var deadzone = 10
var velocity = Vector2(0, 0)

var rotate_deadzone = deg2rad(10) # 10 deg
var rotate_max_speed = 100
var rotate_offset = 0
var rotate_speed_factor = 4*PI
var rotate_velocity = 0

export (int, 0, 200) var push = 100

const double_click_dur = 1000
var last_click_time = 0

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var cur_time = OS.get_ticks_msec()
			if cur_time - rigid_double.last_click_time < rigid_double.double_click_dur:
				can_drag = "rotate"
			rigid_double.last_click_time = cur_time 
		elif event.button_index == BUTTON_RIGHT:
			can_drag = "rotate"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if Input.is_mouse_button_pressed(BUTTON_LEFT) or Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if can_drag == "translate":
			global_position = get_global_mouse_position() - click_offset
		elif can_drag == "rotate":
			var vector_from_center = get_global_mouse_position() - global_position
			var cur_rotation = click_offset.rotated(rotation - rotate_offset)
			var angle_diff = cur_rotation.angle_to(vector_from_center)
			rotation += min(angle_diff, rotate_max_speed) * rotate_speed_factor * delta
	else:
		make_rigid()
		can_drag = ""

	# after calling move_and_slide()
	#for index in get_slide_count():
	#	var collision = get_slide_collision(index)
	#	if collision.collider.is_in_group("bodies"):
	#		print(-collision.normal * push)
	#		collision.collider.apply_central_impulse(-collision.normal * push)
