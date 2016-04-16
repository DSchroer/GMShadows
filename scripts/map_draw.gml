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
    
    if(!obj.in_view)
    {
        continue;
    }
    
    with(obj)
    {
        if(self.layer == other.layer)
        {
            if(!surface_exists(self.redraw))
            {
                self.redraw = surface_create(l_width, l_height);
                self.rendered = false;
            }
            
            if(!self.rendered || collision || dynamic)
            {
                core_caster();
                core_distance();
                core_reductions();
                core_shadow();
                core_postprocess();
                self.rendered = true;
            }
            
            draw_set_blend_mode( bm_add );
            draw_surface_ext(self.redraw,self.x-view_xview,self.y-view_yview,self.scale,self.scale,0,c_white,1.0);
        }
    }
}
surface_reset_target();

draw_clear_alpha(c_black,1.0);
shader_set(sdr_blend_shadow);
draw_surface(lightSurface,view_xview,view_yview);
shader_reset();
