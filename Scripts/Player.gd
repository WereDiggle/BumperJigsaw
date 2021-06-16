extends "res://Scripts/Piece.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move()
	spin()

var move_force = 10.0
var max_velocity = 500.0

var spin_force = 5000.0
var max_spin = 6.0

func spin():
	var direction = Input.get_action_strength("rotate_right") - Input.get_action_strength("rotate_left")
	#print(angular_velocity)
	applied_torque = (direction * max_spin - angular_velocity * abs(direction)) * spin_force

func move():
	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).clamped(1)
	var temp_force = direction * max_velocity
	var force_dot = direction.dot(linear_velocity) * linear_velocity.normalized()
	applied_force = (temp_force - force_dot) * move_force
	#print(linear_velocity)
