shader_type canvas_item;

uniform float blue = 1.0;
uniform vec2 puzzle_pos = vec2(0.0, 0.0);
uniform vec2 puzzle_ratio = vec2(1.0, 1.0);

uniform vec2 top = vec2(0.5, 0.1);
uniform vec2 left = vec2(0.1, 0.5);
uniform vec2 right = vec2(0.9, 0.5);
uniform vec2 bot = vec2(0.5, 0.9);

uniform vec4 tab_facing = vec4(0.0, 0.0, 0.0, 0.0);

uniform vec4 tab_size = vec4(-0.15, 0.0, 0.0, 0.15);

void fragment() {
	vec2 uv = UV * puzzle_ratio + puzzle_pos * puzzle_ratio;
	vec4 color = texture(TEXTURE, uv);

	if (length(top - UV) < tab_size[0]) {
		color.a = 0.0;
	}
	if (length(left - UV) < tab_size[1]) {
		color.a = 0.0;
	}
	if (length(right - UV) < tab_size[2]) {
		color.a = 0.0;
	}
	if (length(bot - UV) < tab_size[3]) {
		color.a = 0.0;
	}
	// we want to change the alpha of a region
	COLOR = color;
}