////map_create(layer)
layer = argument0;

if (!instance_exists(obj_light_var))
{
    instance_create(0,0,obj_light_var);
    obj_light_var.map_layer = ds_map_create();
    obj_light_var.cast_layer = ds_map_create();
    obj_light_var.cul_layer = ds_map_create();
}

if(!ds_map_exists(obj_light_var.map_layer,string(layer)))
{
    ds_map_add(obj_light_var.map_layer, string(layer), ds_list_create());
}

if(!ds_map_exists(obj_light_var.cul_layer,string(layer)))
{
    ds_map_add(obj_light_var.cul_layer, string(layer), ds_list_create());
}

if(!ds_map_exists(obj_light_var.cast_layer,string(layer)))
{
    ds_map_add(obj_light_var.cast_layer, string(layer), ds_list_create());
}

lightSurface = surface_create(window_get_width(), window_get_height());
color = c_black;
