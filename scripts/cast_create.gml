////cast_create(layer)
layer = argument0;

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

if(!ds_map_exists(inst.cast_layer,string(layer)))
{
    nl = ds_list_create();
    ds_map_add(inst.cast_layer, string(layer), nl);
}

var l;
l = ds_map_find_value(inst.cast_layer, string(layer));
ds_list_add(l, self.id);

sprite = sprite_index;
//sprite_index = noone;
static = true;
obscured = true;
