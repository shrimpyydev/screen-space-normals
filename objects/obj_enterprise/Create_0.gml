/// @description Insert description here
// You can write your code in this editor
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();

vertex_format_add_texcoord();

vertex_format_add_colour();
z=256;
direction=0;
my_format = vertex_format_end();
tex=sprite_get_texture(Sprite2,0);
var buff=buffer_load("ent.vbuff");
model=vertex_create_buffer_from_buffer(buff, my_format);

trans_mat=matrix_build(x,y,z,0,0,0,1,1,1);



for (var i = 0; i < buffer_get_size(buff); i += 36) {
    var xx = buffer_peek(buff, i + 0, buffer_f32);
    var yy = buffer_peek(buff, i + 4, buffer_f32);
    var zz = buffer_peek(buff, i + 8, buffer_f32);
	if(i=0)
	{
	min_x=xx;
	min_y=yy;
	min_z=zz;
	max_x=xx;
	max_y=yy;
	max_z=zz;
		
	}
	else
	{
	min_x=min(min_x,xx);
	max_x=max(max_x,xx);
	min_y=min(min_y,yy);
	max_y=max(max_y,yy);
	min_z=min(zz,min_z);
	max_z=max(zz,max_z);
	}
    
}
scale=512/(max_y-min_y);
v_buff = vertex_create_buffer();
var standardize_matrix=matrix_multiply(matrix_build(-mean(min_x,max_x),-mean(min_y,max_y),-mean(min_z,max_z),0,0,0,1,1,1),matrix_build(0,0,0,0,270,0,scale,scale,scale));
var vert1, vert2, vert3;
vertex_begin(v_buff,my_format);
for (var i = 0; i < buffer_get_size(buff); i += 108) {
vert1 = matrix_transform_vertex(standardize_matrix,buffer_peek(buff, i + 0, buffer_f32),buffer_peek(buff, i + 4, buffer_f32),buffer_peek(buff, i + 8, buffer_f32));
vert2 = matrix_transform_vertex(standardize_matrix,buffer_peek(buff, i + 36, buffer_f32),buffer_peek(buff, i + 40, buffer_f32),buffer_peek(buff, i + 44, buffer_f32));
vert3 = matrix_transform_vertex(standardize_matrix,buffer_peek(buff, i + 72, buffer_f32),buffer_peek(buff, i + 76, buffer_f32),buffer_peek(buff, i + 80, buffer_f32));
vertex_position_3d(v_buff, vert1[0], vert1[1], vert1[2]);
vertex_normal(v_buff,vert2[0],vert2[1],vert2[2]);
vertex_texcoord(v_buff, buffer_peek(buff,i+24, buffer_f32),buffer_peek(buff,i+28, buffer_f32));
vertex_color(v_buff,c_white,1);
	
vertex_position_3d(v_buff, vert2[0], vert2[1], vert2[2]);
vertex_normal(v_buff,vert3[0],vert3[1],vert3[2]);	
vertex_texcoord(v_buff, buffer_peek(buff,i+60, buffer_f32),buffer_peek(buff,i+64, buffer_f32));	
vertex_color(v_buff,c_white,1);	

vertex_position_3d(v_buff, vert3[0], vert3[1], vert3[2]);
vertex_normal(v_buff,vert1[0],vert1[1],vert1[2]);
vertex_texcoord(v_buff, buffer_peek(buff,i+96, buffer_f32),buffer_peek(buff,i+100, buffer_f32));
vertex_color(v_buff,c_white,1);	
	
	}
    

vertex_end(v_buff);
buffer_delete(buff);
x=room_width/2;
y=room_height/2;