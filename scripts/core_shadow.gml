if(!surface_exists(self.posts))
{
self.posts = surface_create(l_width, l_height);
}


surface_set_target(self.posts);
shader_set(sdr_shadow);

draw_clear_alpha(c_white,0);

draw_surface(self.reduction,0,0);

surface_reset_target();
shader_reset();
