if(!surface_exists(self.sur))
{
self.sur = surface_create(l_width, l_height);
}


surface_set_target(self.sur);
shader_set(sdr_dist);
draw_surface(self.back,0,0);
shader_reset();
surface_reset_target();
