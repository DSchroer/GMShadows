////map_calculate_culling()
with(obj_light)
{
    lastCol = self.collision;
    self.collision = collision_circle(self.x + (self.light_size / 2), self.y + (self.light_size / 2), (self.light_size / 2),obj_dynamic_shadow_caster, true, true);
    if(lastCol && !collision)
    {
        self.rendered = false;
    }
}
