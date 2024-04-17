shader_type canvas_item;

varying vec2 globalposition;
void vertex(){
    globalposition = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}


const vec4 base_color = vec4(0.1, 0.2, 0.3, 0.8); // Dark bluish color, feel free to adjust

void fragment() {
    vec2 uv = globalposition / 32.0;
    vec4 original = texture(TEXTURE, UV); // Sample the texture to get the original color and alpha
    if (original.a < 0.01) {
        discard;
    }

    float noise = 0.2;
    noise = mix(-0.05, 0.05, noise); // Scale noise impact

    // Sinusoidal wave calculations for calm movements
    float wave = sin(UV.y * 10.0 + TIME); // Adjust frequency with the multiplication factor
    wave *= 0.03; // Reducing amplitude for subtlety

    vec4 color = base_color + 3.0 * vec4(noise + wave, noise + wave, noise + wave, 0.0);
	color.a = 0.65;
    COLOR = color;
}