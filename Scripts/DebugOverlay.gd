extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stats = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_stat(stat_name, object, stat_ref, is_method):
	stats.append([stat_name, object, stat_ref, is_method])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var label_text = ""

	for s in stats:
		var value = null
		if s[1] and weakref(s[1]).get_ref():
			if s[3]:
				value = s[1].call(s[2])
			else:
				value = s[1].get(s[2])
		label_text += str(s[0], ": ", value)
		label_text += "\n"

	$Label.text = label_text