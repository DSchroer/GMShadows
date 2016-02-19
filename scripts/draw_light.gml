////draw_light(light)

surface_set_target(back);
draw_clear_alpha(c_white,0);
with(obj_shadow_caster)
{
    draw_sprite(sprite,0,x - other.x,y - other.y);
}
surface_reset_target();

surface_set_target(sur);
shader_set(sdr_dist);
draw_surface(back,0,0);
shader_reset();
surface_reset_target();

size = shader_get_uniform(sdr_reduce,"size");

surface_set_target(red);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/512.0,1.0/512.0);
draw_surface(sur,0,0);
shader_reset();
surface_reset_target();

surface_set_target(red2);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/256.0,1.0/512.0);
draw_surface_ext(red,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red3);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/128.0,1.0/512.0);
draw_surface_ext(red2,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red4);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/64.0,1.0/512.0);
draw_surface_ext(red3,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red5);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/32.0,1.0/512.0);
draw_surface_ext(red4,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red6);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/16.0,1.0/512.0);
draw_surface_ext(red5,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red7);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/8.0,1.0/512.0);
draw_surface_ext(red6,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red8);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/4.0,1.0/512.0);
draw_surface_ext(red7,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

surface_set_target(red9);
shader_set(sdr_reduce);
shader_set_uniform_f(size,1.0/2.0,1.0/512.0);
draw_surface_ext(red8,0,0,1,1,0,c_white,255);
shader_reset();
surface_reset_target();

stages = shader_get_sampler_index(sdr_shadow,"shadowMapSamplers");
shader_set(sdr_shadow);
texture_set_stage(stages,surface_get_texture(red9));
draw_surface(final,x,y);
shader_reset();
