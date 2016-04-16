////light_draw_debug()
draw_set_color(c_white)

var s;
s = map_size / 4;
var alpha;
alpha = 0.5;

draw_set_alpha(alpha);
draw_rectangle(x,y,x + s, y + s,false);
draw_surface_ext(back,x,y,0.25,0.25,0,c_white,alpha);

draw_surface_ext(sur,x + s,y,0.25,0.25,0,c_white,alpha);

draw_set_color(c_black)
draw_set_alpha(alpha);
draw_rectangle(x + (s * 2),y,x + (s * 4), y + s,false);
draw_set_color(c_white)
draw_surface_ext(posts,x + (s * 2),y,0.25,0.25,0,c_white,alpha);

draw_surface_ext(redraw,x + (s * 3),y ,0.25,0.25,0,c_white,alpha);

draw_set_alpha(1.0);
