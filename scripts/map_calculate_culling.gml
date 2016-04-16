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
        if(self.layer == other.layer)
        {
            hl = (self.light_size / 2);
            
            self.in_view = false;
            if(self.x - hl < view_xview + view_wview && self.x + hl > view_xview)
            {
                if(self.y - hl < view_yview + view_hview && self.y + hl > view_yview)
                {
                    if(!self.in_view)
                    {
                        rendered = false;
                    }
                    self.in_view = true;
                }
            }
            
            if(self.in_view)
            {
                lastCol = self.collision;
                            
                var xp, yp, sp;
                xp = self.x + (self.light_size / 2);
                yp = self.y + (self.light_size / 2);
                sp = (self.light_size / 2);
                
                collision = false;
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
    
                if(lastCol && !collision)
                {
                    self.rendered = false;
                }
            }
        }
    }
}
