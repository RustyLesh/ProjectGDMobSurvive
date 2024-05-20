shader_type canvas_item;

//Outline
uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;

//Flash
uniform float flash_opacity: hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0);

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() { //Code to have outline not flash with sprite
	vec4 tex_color = texture(TEXTURE, UV);
    vec3 blended_color = mix(tex_color.rgb, flash_color.rgb, flash_opacity); // Use only the RGB components for blending

	COLOR.rgb = blended_color;
	COLOR.a = tex_color.a;
	
	//Outline
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	
	for (int i = 0; i < OFFSETS.length(); i++) {
		outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
	}
	outline = min(outline, 1.0);
	
	vec4 mixed = mix(COLOR, line_color, outline - COLOR.a);
	COLOR = mix(COLOR, line_color, outline - tex_color.a);
	
		////Outline Code to have outline flash with sprite.
	//vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	//float outline = 0.0;
	//
	//for (int i = 0; i < OFFSETS.length(); i++) {
		//outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
	//}
	//outline = min(outline, 1.0);
	//
	//vec4 color = texture(TEXTURE, UV);
	//vec4 mixed = mix(color, line_color, outline - color.a);
	//COLOR = mix(color, line_color, outline - color.a);
	//
	////Flash
	//vec3 blended_color = mix(mixed.rgb, flash_color.rgb, flash_opacity); // Use only the RGB components for blending
	//COLOR.rgb = blended_color;
}