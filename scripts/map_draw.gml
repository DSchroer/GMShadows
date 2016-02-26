////map_draw()
if(!surface_exists(lightSurface))
{
    lightSurface = surface_create(window_get_width(), window_get_height());
}

surface_set_target(lightSurface);
draw_clear_alpha(c_black,1.0);

var l;
l = ds_map_find_value(instance_find(obj_light_var,0).map_layer,string(layer));

for(i = 0; i < ds_list_size(l); i++)
{
    var obj;
    obj = ds_list_find_value(l, i);
    
    with(obj)
    {
        if(self.layer == other.layer)
        {
            if(!surface_exists(self.redraw))
            {
                self.redraw = surface_create(l_width, l_height);
                self.rendered = false;
            }
            
            if(!self.rendered || collision)
            {
                caster();
                distance();
                reductions();
                shadow();
                postprocess();
                self.rendered = true;
            }
            
            draw_surface_ext(self.redraw,self.x,self.y,self.scale,self.scale,0,c_white,1.0);
        }
    }
}
surface_reset_target();


shader_set(sdr_blend_shadow);

shdCol = shader_get_uniform(sdr_blend_shadow, "colorIn");

r = color_get_red(color);
g = color_get_green(color);
b = color_get_blue(color);
shader_set_uniform_f(shdCol,r,g,b,alpha);

draw_surface(lightSurface,0,0);
shader_reset();
