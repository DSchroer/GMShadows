////map_calculate_culling()

var l;
l = ds_map_find_value(obj_light_var.map_layer,string(layer));

for(i = 0; i < ds_list_size(l); i++)
{
    var obj;
    obj = ds_list_find_index(obj_light_var.map_layer, i);
    
    with(obj)
    {
        if(self.layer == other.layer)
        {
            lastCol = self.collision;
            self.collision = collision_circle(self.x + (self.light_size / 2), self.y + (self.light_size / 2), (self.light_size / 2),obj_dynamic_shadow_caster, true, true);
            if(lastCol && !collision)
            {
                self.rendered = false;
            }
        }
    }
}
