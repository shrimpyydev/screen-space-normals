//
// Simple passthrough fragment shader
//
#extension GL_OES_standard_derivatives : enable
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 norm_colour;
uniform float tex_draw;


void main()
{
    if(1.0 - tex_draw == 1.0) // draws the texture with shading based on how far the normal deviates from the camera vector
    {
        float dotProd = dot(normalize(norm_colour.rgb), vec3(0.0, 0.0, 1.0));
       float dis = (dotProd + 1.0) * 0.5; // Normalize from [-1, 1] to [0, 1]
        //gl_FragColor = vec4(dis, dis, dis, 1.0);
        gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord) * vec4(dis,dis,dis, 1.0);
    }
    else
    {
       
		
		
        gl_FragColor = norm_colour; // draw the normal texture
    }
}
