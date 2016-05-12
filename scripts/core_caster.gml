if(!surface_exists(self.back))
{
self.back = surface_create(l_width, l_height);
}

surface_set_target(self.back);
draw_clear_alpha(c_white,0);

var l;
l = ds_map_find_value(instance_find(obj_light_var,0).cast_layer,string(layer));

for(i = 0; i < ds_list_size(l); i++)
{
    var obj;
    obj = ds_list_find_value(l, i);
    
    with(obj)
    {
        xpos = (x - other.x) * other.iscale;
        ypos = (y - other.y) * other.iscale;
        
        if(other.castsShadows)
        {
            draw_sprite_ext(sprite,0,xpos,ypos,other.iscale, other.iscale, 0, 0, 1.0);
        }
        draw_set_blend_mode(bm_normal);
    }
}

surface_reset_target();
