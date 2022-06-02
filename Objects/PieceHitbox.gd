extends CollisionShape2D

const shader = preload("res://Materials/Piece.shader")

var puzzle_pos
var puzzle_size

func init(pos, size, image):
	puzzle_pos = pos
	puzzle_size = size
	var puzzle_ratio = Vector2(1,1) / puzzle_size
	var mat = ShaderMaterial.new()
	mat.set_shader(shader)
	mat.set_shader_param("puzzle_pos", puzzle_pos)
	mat.set_shader_param("puzzle_ratio", puzzle_ratio)

	# left
	var tab_facing = Color(-1,-1,1,1)

	if puzzle_pos.x == 0:
		tab_facing.r = 0
	if puzzle_pos.x == puzzle_size.x-1:
		tab_facing.b = 0
	if puzzle_pos.y == 0:
		tab_facing.g = 0
	if puzzle_pos.y == puzzle_size.y-1:
		tab_facing.a = 0
	mat.set_shader_param("tab_facing", tab_facing)

	$image.set_material(mat)
	$image.texture = image
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
