#define draw_light_new
////draw_light_new(light)
surface_set_target(self.back);
draw_clear_alpha(c_white,0);
with(obj_shadow_caster)
{
    xpos = (x - other.x) * other.iscale;
    ypos = (y - other.y) * other.iscale;
    draw_sprite_ext(sprite,0,xpos,ypos,other.iscale, other.iscale, 0, 0, 1.0);
}
surface_reset_target();

surface_set_target(self.sur);
shader_set(sdr_dist);
draw_surface(self.back,0,0);
shader_reset();
surface_reset_target();

shader_set(sdr_reduce_linear);
baseSize = shader_get_uniform(sdr_reduce_linear,"baseSize");
shader_set_uniform_f(baseSize,l_width);
surface_set_target(reduction);
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();

stages = shader_get_sampler_index(sdr_shadow,"shadowMapSamplers");
shader_set(sdr_shadow);
surface_set_target(self.posts);
draw_clear_alpha(c_white,0);
texture_set_stage(stages,surface_get_texture(reduction));
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();


shader_set(sdr_post);
surface_set_target(self.redraw);
draw_clear_alpha(c_white,0);
draw_surface(self.posts,0,0);
surface_reset_target();
shader_reset();

#define draw_shadow_casters
surface_set_target(self.back);
draw_clear_alpha(c_white,0);
with(obj_shadow_caster)
{
    xpos = (x - other.x) * other.iscale;
    ypos = (y - other.y) * other.iscale;
    draw_sprite_ext(sprite,0,xpos,ypos,other.iscale, other.iscale, 0, 0, 1.0);
}
surface_reset_target();

#define draw_distance_map
surface_set_target(self.sur);
shader_set(sdr_dist);
draw_surface(self.back,0,0);
shader_reset();
surface_reset_target();

#define draw_reduction
shader_set(sdr_reduce_linear);
baseSize = shader_get_uniform(sdr_reduce_linear,"baseSize");
shader_set_uniform_f(baseSize,l_width);
surface_set_target(reduction);
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();

#define draw_shadow_map
stages = shader_get_sampler_index(sdr_shadow,"shadowMapSamplers");
shader_set(sdr_shadow);
surface_set_target(self.posts);
draw_clear_alpha(c_white,0);
texture_set_stage(stages,surface_get_texture(reduction));
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();

#define draw_post_shadow
shader_set(sdr_post);
surface_set_target(self.redraw);
draw_clear_alpha(c_white,0);
draw_surface(self.posts,0,0);
surface_reset_target();
shader_reset();