shader_type canvas_item;

uniform float glow_intensity = 1; // قوة اللمعان
uniform float glow_speed = 2.5; // سرعة اللمعان

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    // حساب قيمة اللمعان باستخدام الوقت
    float glow_value = (sin(TIME * glow_speed) + 1.0) / 2.0;

    // مزج لون اللمعان مع لون الصورة الأصلي
    vec4 glow_color = texture_color * (1.0 + glow_value * glow_intensity);

    // تطبيق اللون النهائي
    COLOR = glow_color;
}