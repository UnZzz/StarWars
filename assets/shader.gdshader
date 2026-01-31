shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, unshaded;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;

uniform float roughness : hint_range(0.0, 1.0);
uniform float metallic : hint_range(0.0, 1.0);
uniform float specular : hint_range(0.0, 1.0);

uniform vec3 uv1_scale = vec3(1.0);
uniform vec3 uv1_offset = vec3(0.0);

/* 🔄 Rotation (radians) */
uniform float rotation_angle : hint_range(-6.283, 6.283) = 0.0;

/* ---------------- ROTATION FUNCTION ---------------- */

mat3 rotate_y(float angle) {
	float s = sin(angle);
	float c = cos(angle);

	return mat3(
		vec3(c, -s, 0.0),
		vec3(s, c, 0.0),
		vec3(0.0, 0.0, 1)
	);
}

/* ---------------- VERTEX ---------------- */

void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;

	/* Rotate mesh in local space */
	VERTEX = rotate_y(rotation_angle) * VERTEX;

	/* Y-Billboard */
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
		vec4(normalize(cross(vec3(0.0, 1.0, 0.0), MAIN_CAM_INV_VIEW_MATRIX[2].xyz)), 0.0),
		vec4(0.0, 1.0, 0.0, 0.0),
		vec4(normalize(cross(MAIN_CAM_INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
		MODEL_MATRIX[3]
	);

	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

/* ---------------- FRAGMENT ---------------- */

void fragment() {
	vec4 tex = texture(texture_albedo, UV);
	ALBEDO = albedo.rgb * tex.rgb;
	
	ALPHA = albedo.a * tex.a;
}
