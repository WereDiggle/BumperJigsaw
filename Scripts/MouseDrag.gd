extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var click_loc = Vector2(0,0);
var direction = Vector2(0,0);

# Called when the node enters the scene tree for the first time.
func _ready():
	var overlay = load("res://Objects/DebugOverlay.tscn").instance()
	overlay.add_stat("Click Loc", self, "click_loc", false)
	overlay.add_stat("Direction", self, "direction", false)
	add_child(overlay)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("select"):
		direction = get_viewport().get_mouse_position() - click_loc
	pass

func _input(event):
	# Interestingly, on down click only fires one event
	if event.is_action_pressed("select"):
		click_loc = get_viewport().get_mouse_position()
	elif event.is_action_released("select"):
		click_loc = Vector2(0,0)
		direction = Vector2(0,0)


