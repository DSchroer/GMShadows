////light_set_intensity(value)

if(argument0 < 0)
{
    self.intensity = 0.0;
}else if(argument0 > 2.0)
{
    self.intensity = 2.0;
}else{
    self.intensity = argument0;
}
