shader_type canvas_item;

uniform float blue = 1.0;
uniform vec2 puzzle_pos = vec2(0.0, 0.0);
uniform vec2 puzzle_ratio = vec2(1.0, 1.0);

uniform vec4 tab_facing = vec4(-1.0, -1.0, 1.0, 1.0);
uniform vec4 tab_size = vec4(0.1, 0.1, 0.1, 0.1);

uniform float margin_size = 0.25;
uniform float margin_offset = 0.6;

void fragment() {
	// somehow use margin var here 
	vec2 adjusted_ratio = puzzle_ratio * (1.0/(1.0-2.0*margin_size));
	vec2 adjusted_offset = puzzle_ratio * puzzle_pos - adjusted_ratio * margin_size;
	vec2 uv = UV * adjusted_ratio + adjusted_offset; // UV without margins
	vec4 color = texture(TEXTURE, uv);

	if (UV[0] < margin_size) {
		color.a = 0.0;
	}
	if (UV[0] > 1.0 - margin_size) {
		color.a = 0.0;
	}
	if (UV[1] < margin_size) {
		color.a = 0.0;
	}
	if (UV[1] > 1.0 - margin_size) {
		color.a = 0.0;
	}

	vec2 left = vec2(margin_size, 0.5);
	vec2 left_size = vec2(tab_size[0]*margin_offset, 0.0);
	if (tab_facing[0] >= 1.0) {
		if (length(left - left_size - UV) < tab_size[0]) {
			color.a = 1.0;
		}
	} 
	if (tab_facing[0] <= -1.0) {
		if (length(left + left_size - UV) < tab_size[0]) {
			color.a = 0.0;
		}
	}

	vec2 top = vec2(0.5, margin_size);
	vec2 top_size = vec2(0.0, tab_size[1]*margin_offset);
	if (tab_facing[1] >= 1.0) {
		if (length(top - top_size - UV) < tab_size[1]) {
			color.a = 1.0;
		}
	} 
	if (tab_facing[1] <= -1.0) {
		if (length(top + top_size - UV) < tab_size[1]) {
			color.a = 0.0;
		}
	}

	vec2 right = vec2(1.0 - margin_size, 0.5);
	vec2 right_size = vec2(tab_size[2]*margin_offset, 0.0);
	if (tab_facing[2] >= 1.0) {
		if (length(right + right_size - UV) < tab_size[2]) {
			color.a = 1.0;
		}
	}
	if (tab_facing[2] <= -1.0) {
		if (length(right - right_size - UV) < tab_size[2]) {
			color.a = 0.0;
		}
	}

	vec2 bot = vec2(0.5, 1.0 - margin_size);
	vec2 bot_size = vec2(0.0, tab_size[3]*margin_offset);
	if (tab_facing[3] >= 1.0) {
		if (length(bot + bot_size - UV) < tab_size[3]) {
			color.a = 1.0;
		}
	}
	if (tab_facing[3] <= -1.0) {
		if (length(bot - bot_size - UV) < tab_size[3]) {
			color.a = 0.0;
		}
	}

	// we want to change the alpha of a region
	COLOR = color;
}