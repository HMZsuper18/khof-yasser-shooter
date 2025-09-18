shader_type canvas_item;

uniform vec4 shine_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // لون اللمعان
uniform float shine_speed = 1; // سرعة تحرك اللمعان (حركة واحدة)
uniform float shine_frequency = 1.0; // سرعة تكرار اللمعان
uniform float shine_width = 0.1; // سُمك اللمعان (كل ما الرقم يزيد، اللمعان يبقى رفيع)
uniform float shine_intensity = 0.5; // شدة لمعان
uniform float shine_angle = -0.785; // زاوية اللمعان (من زاوية تحت يمين)

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    
    // حساب قيمة اللمعان باستخدام الوقت وسرعة التكرار
    float glow_value = sin(UV.x * cos(shine_angle) - UV.y * sin(shine_angle) + TIME * shine_speed);
    
    // تحويل قيمة اللمعان إلى تأثير مرئي
    float shine = pow(max(0.0, glow_value), 10.0) * shine_intensity;
    
    // مزج تأثير اللمعان مع لون الصورة الأصلي
    COLOR = vec4(texture_color.rgb + shine_color.rgb * shine, texture_color.a);
}