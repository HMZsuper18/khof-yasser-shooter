shader_type canvas_item;

uniform float speed = 1.0;
uniform float glow_width = 0.5;
uniform vec4 neon_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);

void fragment() {
    vec2 uv = UV;
    float time = TIME * speed;

    float glow = sin(time + uv.x * 10.0) * cos(time * 0.5 + uv.y * 10.0);
    glow = pow(abs(glow), 1.5) * glow_width;

    // ناخد اللون من التكستشر
    vec4 texture_color = texture(TEXTURE, uv);

    // اللون النهائي = لون التكستشر × لون العقدة (modulate) + النيون
    vec3 final_rgb = (texture_color.rgb * COLOR.rgb) + neon_color.rgb * glow * texture_color.a;

    // نخلي الألفا ياخد تأثير التكستشر × الـ modulate
    float final_alpha = clamp(texture_color.a * COLOR.a + glow * 0.5, 0.0, 1.0);

    COLOR = vec4(final_rgb, final_alpha);
}
