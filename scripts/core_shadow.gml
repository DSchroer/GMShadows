if(!surface_exists(self.posts))
{
    self.posts = surface_create(l_width, l_height);
}

surface_set_target(self.posts);
shader_set(sdr_shadow);

fcol = shader_get_uniform(sdr_shadow, "f_color");
shader_set_uniform_f(fcol,color_get_red(self.shadow_color)/255,color_get_green(self.shadow_color)/255,color_get_blue(self.shadow_color)/255.0);

var intensity;
intensity = shader_get_uniform(sdr_shadow, "lightIntensity");
shader_set_uniform_f(intensity,self.intensity);

draw_clear_alpha(c_white,0);

draw_surface(self.reduction,0,0);

surface_reset_target();
shader_reset();
