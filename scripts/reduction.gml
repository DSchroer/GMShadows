shader_set(sdr_reduce_linear);
baseSize = shader_get_uniform(sdr_reduce_linear,"baseSize");
shader_set_uniform_f(baseSize,l_width);
surface_set_target(self.reduction);
draw_surface(self.sur,0,0);
surface_reset_target();
shader_reset();
