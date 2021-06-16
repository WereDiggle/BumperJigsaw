shader_type canvas_item;

uniform float blue = 1.0;
uniform vec2 puzzle_pos = vec2(0.0, 0.0);
uniform vec2 puzzle_ratio = vec2(1.0, 1.0);

void fragment() {
	vec2 uv = UV * puzzle_ratio + puzzle_pos * puzzle_ratio;
	COLOR = texture(TEXTURE, uv);
}