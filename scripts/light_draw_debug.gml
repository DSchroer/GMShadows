////light_draw_debug()
draw_set_color(c_white)

var s;
s = map_size / 4;
var alpha;
alpha = 0.5;

if(surface_exists(self.back))
{
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
}

draw_set_font(fnt_default);
draw_set_color(c_white);
draw_text(x,y + s,"Red: " + string(color_get_red(self.shadow_color)));
draw_text(x,y + s + 15,"Green: " + string(color_get_green(self.shadow_color)));
draw_text(x,y + s + 30,"Blue: " + string(color_get_blue(self.shadow_color)));

draw_set_alpha(1.0);
if(collision)
{
    draw_set_color(c_red);
}else{
    draw_set_color(c_green);
}

var xp, yp, sp;
xp = self.x + (self.light_size / 2);
yp = self.y + (self.light_size / 2);
sp = (self.light_size / 2);
draw_circle(xp, yp, sp, true);

draw_set_color(c_black);

if(in_view)
{
    draw_set_color(c_red);
}else{
    draw_set_color(c_green);
}
draw_rectangle(xp - sp,yp - sp, xp + sp, yp + sp, true);

