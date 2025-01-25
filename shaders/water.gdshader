shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
//a noise texture will be added to apply the distortion effect
uniform sampler2D noise_texture: filter_nearest, repeat_enable;

//strength of the distortion effect
uniform float distortion = 0.00;

//strength of the wavwe effect
uniform float wave_strength = 0.0; 

//speed of water waves
uniform vec2 speed = vec2(0.2,0.08);

// Called for every vertex the material is visible on.
void vertex() {
	//move the water up and down
	VERTEX.y += sin(TIME*2.0); 
	
}

// Called for every pixel the material is visible on.
void fragment() {
	 vec2 noise = 0.9 * texture(noise_texture, UV + speed*TIME).rg - vec2(1.0);
    vec4 water_color = texture(TEXTURE, UV + noise * wave_strength);
    
    // Much lighter blue color
    vec4 light_blue = vec4(0.35, 0.9, 1.0, water_color.a); // Very light blue values
    water_color = mix(water_color, light_blue, 0.8); // Higher mix factor for more prominence
    
    COLOR = water_color;
    COLOR *= texture(screen_texture, SCREEN_UV + noise * distortion);
	
}


