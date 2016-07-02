////light_destroy()
inst = instance_find(obj_light_var,0);
l = ds_map_find_value(inst.map_layer, string(layer));
ds_list_delete(l,ds_list_find_index(l,self.id));
