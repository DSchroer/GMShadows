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

float ComputeDistances(vec2 TexCoord);
vec4 DistortPS(vec2 TexCoord);

void main()
{
    gl_FragColor = DistortPS(v_vTexcoord);    
}

float ComputeDistances(vec2 TexCoord)
{
    vec4 color = texture2D(gm_BaseTexture, TexCoord);
    
    float distance = color.a > 0.3 ? length(TexCoord - vec2(0.5,0.5)) : 1.0 ;
    distance *= 2.0;
    
    return distance;
}

vec4 DistortPS(vec2 TexCoord)
{
    float u0 = (TexCoord.x * 2.0) - 1.0;
    float v0 = (TexCoord.y * 2.0) - 1.0;

    v0 = v0 * abs(u0);
    v0 = (v0 + 1.0) / 2.0;
    vec2 newCoords = vec2(TexCoord.x, v0);
    float hdistance = ComputeDistances(newCoords);
    
    newCoords = vec2(newCoords.y, newCoords.x);
    float vdistance = ComputeDistances(newCoords);
    
    return vec4(hdistance,vdistance ,0.0,1.0);
}

