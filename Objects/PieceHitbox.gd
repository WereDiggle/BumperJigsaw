extends CollisionShape2D

const shader = preload("res://Materials/Piece.shader")

var puzzle_pos
var puzzle_size
var tab_facing

func init(args):
	puzzle_pos = args.pos
	puzzle_size = args.size
	var puzzle_ratio = Vector2(1,1) / puzzle_size
	var mat = ShaderMaterial.new()
	mat.set_shader(shader)
	mat.set_shader_param("puzzle_pos", puzzle_pos)
	mat.set_shader_param("puzzle_ratio", puzzle_ratio)

	#var tab_facing = Color(-1,-1,1,1)
	tab_facing = args.tab_facing
	if puzzle_pos.x == 0:
		tab_facing.r = 0
	if puzzle_pos.x == puzzle_size.x-1:
		tab_facing.b = 0
	if puzzle_pos.y == 0:
		tab_facing.g = 0
	if puzzle_pos.y == puzzle_size.y-1:
		tab_facing.a = 0
	mat.set_shader_param("tab_facing", tab_facing)
	mat.set_shader_param("tab_size", args.tab_size)
	$image.set_material(mat)

	var s = args.image.get_size() #image size
	var margin = 0.15;
	var target_width = 100/(1-2*margin)
	var scale = Vector2(target_width/s.x, target_width/s.y)
	$image.set_texture(args.image)
	$image.scale = scale
	return self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
