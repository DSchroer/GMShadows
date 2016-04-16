if(!surface_exists(self.posts))
{
self.posts = surface_create(l_width, l_height);
}

var green;
green = shader_get_uniform(sdr_shadow, "lightGreen");
var red;
red = shader_get_uniform(sdr_shadow, "lightRed");
var blue;
blue = shader_get_uniform(sdr_shadow, "lightBlue");
var intensity;
intensity = shader_get_uniform(sdr_shadow, "lightIntensity");

surface_set_target(self.posts);
shader_set(sdr_shadow);

shader_set_uniform_f(red,1.0);
shader_set_uniform_f(green,1.0);
shader_set_uniform_f(blue,1.0);
shader_set_uniform_f(intensity,0.9);

draw_clear_alpha(c_white,0);

draw_surface(self.reduction,0,0);

surface_reset_target();
shader_reset();
