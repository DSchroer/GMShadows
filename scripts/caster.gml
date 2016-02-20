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
    
    if(!obscured)
    {
        xvec = (other.map_size/2.0) - xpos;
        yvec = (other.map_size/2.0) - ypos;
        
        mag = sqrt((xvec * xvec) + (yvec * yvec));
        sc = 6.0;
        xunit = ((xvec / mag) * other.iscale) * sc;
        yunit = ((yvec / mag) * other.iscale) * sc;
        draw_sprite_ext(sprite,0,xpos - xunit,ypos - yunit,other.iscale, other.iscale, 0, 0, 1.0);
        
        draw_set_blend_mode(bm_subtract);
    }
    
    draw_sprite_ext(sprite,0,xpos,ypos,other.iscale, other.iscale, 0, 0, 1.0);
    draw_set_blend_mode(bm_normal);
}
surface_reset_target();
