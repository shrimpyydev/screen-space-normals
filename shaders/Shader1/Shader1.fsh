//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 norm_colour;
uniform float tex_draw;
void main()
{
    
	
	if(1.0 - tex_draw == 1.0)//draws the texture with shading based on how far the normal deviates from the camera vector
	{
	vec3 remap = (norm_colour.rgb - vec3(0.5,0.5,0.5))*2.0;//un-normalize the normal
	float dis = distance(remap, vec3(0.0, 0.0, -1.0));//calulate how far off camera axis, expected range is square root of 2 to 2.
	dis = (dis - sqrt(2.0)) / (2.0 - sqrt(2.0));//normalize the range 
	dis = clamp(dis, 0.0, 1.0);
	
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) * vec4(dis,dis,dis,1.0);
	}
	else
	{
	gl_FragColor = norm_colour;//draw the normal texture	
	}

	
}
