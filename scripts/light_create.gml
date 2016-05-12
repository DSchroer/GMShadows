////light_create(light_size, shadow_size, layer)

light_size = argument0;
map_size = argument1;
layer = argument2;

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

if(!ds_map_exists(inst.map_layer,string(layer)))
{
    nl = ds_list_create();
    ds_map_add(inst.map_layer, string(layer), nl);
}

var l;
l = ds_map_find_value(inst.map_layer, string(layer));
ds_list_add(l, self.id);

sprite_index = noone;

collision = false;
rendered = false;
dynamic = false;
in_view = true;

castsShadows = true;

shadow_color = c_white;
intensity = 1.0;

gradient = 1.0;

scale = light_size / map_size;
iscale = map_size / light_size;

x = x - (light_size / 2);
y = y - (light_size / 2);

l_width = map_size;
l_height = map_size;

back=surface_create(l_width, l_height);
sur=surface_create(l_width, l_height);
final=surface_create(l_width, l_height);
posts=surface_create(l_width, l_height);
reduction=surface_create(l_width, l_height);
redraw=surface_create(l_width, l_height);
