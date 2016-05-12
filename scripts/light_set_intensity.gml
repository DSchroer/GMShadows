////light_set_intensity(value)

var intens;
intens = argument0;

if(intens < 0)
{
    self.intensity = 0.0;
}else if(intens > 1.0)
{
    self.intensity = 1.0;
}else{
    self.intensity = intens;
}
self.rendered = false;
