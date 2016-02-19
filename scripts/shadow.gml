if(!surface_exists(self.posts))
{
self.posts = surface_create(l_width, l_height);
}

stages = shader_get_sampler_index(sdr_shadow,"shadowMapSamplers");
shader_set(sdr_shadow);
surface_set_target(self.posts);
draw_clear_alpha(c_white,0);
texture_set_stage(stages,surface_get_texture(reduction));
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();
