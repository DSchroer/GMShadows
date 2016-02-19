//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D shadowMapSamplers;

vec4 DrawShadowsPS(vec2 TexCoord);
float GetShadowDistanceH(vec2 TexCoord);
float GetShadowDistanceV(vec2 TexCoord);

void main()
{
    gl_FragColor = DrawShadowsPS(v_vTexcoord);
}

vec4 DrawShadowsPS(vec2 TexCoord)
{
    float dist = length(TexCoord - vec2(0.5,0.5));
    dist *= 512.0; 

    float shadowMapDistance;
    float nY = 2.0*( TexCoord.y - 0.5);
    float nX = 2.0*( TexCoord.x - 0.5);

    if(abs(nY) < abs(nX))
    {
        shadowMapDistance = GetShadowDistanceH(TexCoord);
    }
    else
    {
        shadowMapDistance = GetShadowDistanceV(TexCoord);
    }
     
    float light = dist < (shadowMapDistance * 255.0) ? 1.0:0.0;
    return vec4(light, light, light, light);
}

float GetShadowDistanceH(vec2 TexCoord)
{
    float u = TexCoord.x;
    float v = TexCoord.y;

    u = abs(u - 0.5) * 2.0;
    v = v * 2.0 - 1.0;
    float v0 = v/u;
    v0 = (v0 + 1.0) / 2.0;

    vec2 newCoords = vec2(TexCoord.x, v0);
    
    if(newCoords.x > 0.5)
    {
        newCoords = vec2(1.0 ,newCoords.y);
    }else{
        newCoords = vec2(0.0 ,newCoords.y);
    }

    return texture2D(shadowMapSamplers, newCoords).r;
}

float GetShadowDistanceV(vec2 TexCoord)
{
    float u = TexCoord.y;
    float v = TexCoord.x;
    
    u = abs(u - 0.5) * 2.0;
    v = v * 2.0 - 1.0;
    float v0 = v/u;
    v0 = (v0 + 1.0) / 2.0;
    
    vec2 newCoords = vec2(TexCoord.y, v0);
    
    if(newCoords.x > 0.5)
    {
        newCoords = vec2(1.0 ,newCoords.y);
    }else{
        newCoords = vec2(0.0 ,newCoords.y);
    }
    
    return texture2D(shadowMapSamplers, newCoords).g;
}

