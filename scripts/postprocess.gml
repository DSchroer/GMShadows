if(!surface_exists(self.redraw))
{
self.redraw = surface_create(l_width, l_height);
}

shader_set(sdr_post);

msize = shader_get_uniform(sdr_post,"mapSize");
shader_set_uniform_f(msize,(1.0 / self.map_size));

grad = shader_get_uniform(sdr_post,"gradient");
shader_set_uniform_f(grad,self.gradient);

surface_set_target(self.redraw);
draw_clear_alpha(c_white,0);
draw_surface(self.posts,0,0);
surface_reset_target();
shader_reset();
