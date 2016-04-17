////light_set_intensity(value)

if(argument0 < 0)
{
    self.intensity = 0.0;
}else if(argument0 > 1.0)
{
    self.intensity = 1.0;
}else{
    self.intensity = argument0;
}
