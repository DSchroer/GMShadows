////cast_set_dynamic(dynamic)
dyn = argument0;

var inst;
if (!instance_exists(obj_light_var))
{
    inst = instance_create(0,0,obj_light_var);
    obj_light_var.map_layer = ds_map_create();
    obj_light_var.cast_layer = ds_map_create();
    obj_light_var.cul_layer = ds_map_create();
}else{
    inst = instance_find(obj_light_var,0);
}

if(!ds_map_exists(inst.cul_layer,string(layer)))
{
    nl = ds_list_create();
    ds_map_add(inst.cul_layer, string(layer), nl);
}

var l;
l = ds_map_find_value(inst.cul_layer, string(layer));

var index;
index = ds_list_find_index(l, self.id);

if(index == -1 && dyn == true)
{
    ds_list_add(l, self.id);
}else if(index != -1 && dyn == false)
{
    ds_list_delete(l, index)
}


