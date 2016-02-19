if(!surface_exists(self.back))
{
self.back = surface_create(l_width, l_height);
}

surface_set_target(self.back);
draw_clear_alpha(c_white,0);
with(obj_shadow_caster)
{
    xpos = (x - other.x) * other.iscale;
    ypos = (y - other.y) * other.iscale;
    draw_sprite_ext(sprite,0,xpos,ypos,other.iscale, other.iscale, 0, 0, 1.0);
}
surface_reset_target();
