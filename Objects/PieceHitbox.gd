extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var puzzle_pos
var puzzle_size

func init(pos, size, shader):
	puzzle_pos = pos	
	puzzle_size = size
	var puzzle_ratio = Vector2(1,1) / puzzle_size
	var mat = ShaderMaterial.new()
	mat.set_shader(shader)
	mat.set_shader_param("puzzle_pos", puzzle_pos)
	mat.set_shader_param("puzzle_ratio", puzzle_ratio)
	get_node("image").set_material(mat)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
