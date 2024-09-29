/// @description Insert description here
// You can write your code in this editor
draw_text_color(32,32,"Hold space to draw normal",c_white,c_white,c_white,c_white,1);
gpu_set_cullmode(cull_noculling);
gpu_set_ztestenable(1);
gpu_set_zwriteenable(1);
shader_set(Shader1);
shader_set_uniform_f(shader_get_uniform(Shader1,"tex_draw"),keyboard_check(vk_space));
shader_set_uniform_f_array(shader_get_uniform(Shader1,"trans_mat"),trans_mat);
vertex_submit(v_buff,pr_trianglelist,tex);

shader_reset();