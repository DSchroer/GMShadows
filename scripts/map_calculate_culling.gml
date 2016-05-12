////map_calculate_culling()
var l;
var c;
l = ds_map_find_value(instance_find(obj_light_var,0).map_layer,string(layer));
c = ds_map_find_value(instance_find(obj_light_var,0).cul_layer,string(layer));

for(i = 0; i < ds_list_size(l); i++)
{
    var obj;
    obj = ds_list_find_value(l, i);
    
    with(obj)
    {
        var xp, yp, sp;
        xp = self.x + (self.light_size / 2);
        yp = self.y + (self.light_size / 2);
        sp = (self.light_size / 2);
    
        if(self.layer == other.layer)
        {
            var viewx, viewy, viewh, vieww;
            if(view_enabled)
            {
                viewx = view_xview;
                viewy = view_yview;
                viewh = view_hview;
                vieww = view_wview;
            }else{
                viewx = 0;
                viewy = 0;
                viewh = window_get_height();
                vieww = window_get_width();
            }
            
            self.in_view = false;
            if(xp - sp < viewx + vieww && xp + sp > viewx)
            {
                if(yp - sp < viewy + viewh && yp + sp > viewy)
                {
                    self.in_view = true;
                }
            }
            
            self.lastCol = self.collision;
            if(!self.castsShadows)
            {
               // self.collision = false;
            }
            
            if(self.in_view && self.castsShadows)
            {    
                self.collision = false;
                for(j = 0; j < ds_list_size(c); j++)
                {
                    var ob;
                    ob = ds_list_find_value(c, j);
                    
                    if(collision_circle( xp, yp, sp ,ob, true, true))
                    {
                        collision = true;
                        break;
                    }
                }
                
                if(lastCol && !self.collision)
                {
                    self.rendered = false;
                }
            }
        }
    }
}
