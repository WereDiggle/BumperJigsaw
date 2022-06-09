extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export(String, FILE, "*.tscn") var target_path

func _on_pressed():
	get_tree().change_scene(target_path)
