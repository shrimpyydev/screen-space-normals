attribute vec3 in_Position;                  // (x,y,z) Current vertex position
attribute vec3 in_Normal;                    // (x,y,z) This stores the next clockwise vertex position in your case
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec3 in_Colour0;
attribute vec4 in_Colour1;      

uniform mat4 trans_mat;  // Object transform matrix
varying vec2 v_vTexcoord;                    // Pass texture coordinates to fragment shader
varying vec4 v_vColour;                      // Output color
varying vec4 norm_colour;

void main()
{
    // Transform the current position into object space
    vec4 object_space_pos = trans_mat * vec4(in_Position, 1.0);
    
    // Transform the next clockwise vertex (stored in the normal attribute) into object space
    vec4 next_object_space_pos = trans_mat * vec4(in_Normal, 1.0);
	
	vec4 final_object_pos = trans_mat * vec4(in_Colour0, 1.0);
    
    // Project both positions into screen space using the world-view-projection matrix
    vec4 screen_pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    vec4 next_screen_pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * next_object_space_pos;
    vec4 final_screen_pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * final_object_pos;
	
    // Convert from homogeneous coordinates to normalized device coordinates (NDC)
    vec3 ndc_pos = screen_pos.xyz / screen_pos.w;
    vec3 next_ndc_pos = next_screen_pos.xyz / next_screen_pos.w;
    vec3 final_ndc_pos = final_screen_pos.xyz / final_screen_pos.w;
	
    // Calculate screen space normal by taking the cross product of the two positions
    //vec3 screen_space_normal = normalize(cross(ndc_pos, next_ndc_pos));
    
	vec3 edge_first = next_ndc_pos - ndc_pos;
	
	vec3 edge_last = final_ndc_pos - ndc_pos;
	
	vec3 screen_space_normal = normalize(cross(edge_first,edge_last));
	
	
	
    // Set the color based on the screen space normal, remapping [-1, 1] to [0, 1]
    norm_colour = vec4((screen_space_normal*0.5+0.5), 1.0);
	v_vColour = in_Colour1;
    
    // Pass texture coordinates to the fragment shader
    v_vTexcoord = in_TextureCoord;

    // Set the final screen space position for the vertex
    gl_Position = screen_pos;
}