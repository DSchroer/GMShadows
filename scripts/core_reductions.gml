if(!surface_exists(self.reduction))
{
self.reduction = surface_create(self.l_width, self.l_height);
}

surface_set_target(self.reduction);

var baseSize;
baseSize = shader_get_uniform(sdr_reduce_linear,"linearBaseSize");

shader_set(sdr_reduce_linear);

shader_set_uniform_f(baseSize,self.l_width, self.map_size);

draw_surface(self.sur,0,0);

surface_reset_target();
shader_reset();
