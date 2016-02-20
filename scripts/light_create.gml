////light_create(light_size, shadow_size, layer)

light_size = argument0;
map_size = argument1;
layer = argument2;

sprite_index = noone;

self.collision = false;
rendered = false;
shadow_color = c_red;

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
