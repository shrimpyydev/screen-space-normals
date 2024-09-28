/// @description Insert description here
// You can write your code in this editor
gpu_set_cullmode(cull_noculling);
gpu_set_ztestenable(1);
gpu_set_zwriteenable(1);
shader_set(Shader1);
shader_set_uniform_f_array(shader_get_uniform(Shader1,"trans_mat"),trans_mat);
vertex_submit(v_buff,pr_trianglelist,tex);

shader_reset();