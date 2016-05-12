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

uniform float gradient;
uniform float mapSize;

const float size = 1024.0;

vec4 blur(float dist);

void main()
{
    float d = distance(v_vTexcoord, vec2(0.5,0.5)) * 2.0;
    float dist = mapSize * d;
    
    vec4 avg = blur(d);
    
    vec4 orig = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
    
    if(gradient == 0.0)
    {
        avg = vec4(avg.rgb, avg.a);
    }else{
        avg = vec4(avg.rgb, avg.a * (1.0 - pow(d,gradient)));
    }
    
    gl_FragColor = avg;
}

const float base = 1.0;
const float top = 5.0;
const float quality = 1.0;

vec2 coord(float x, float y);
int index(int x, int y);
vec4 gchunck(float x, float y,float sc, float[25] gau, float quality);

vec4 blur(float dist)
{
    float gau[25];
    gau[0] = 0.003765;
    gau[1] = 0.015019;
    gau[2] = 0.023792;
    gau[3] = 0.015019;
    gau[4] = 0.003765;
    gau[5] = 0.015019;
    gau[6] = 0.059912;
    gau[7] = 0.094907;
    gau[8] = 0.059912;
    gau[9] = 0.015019;
    gau[10] = 0.023792;
    gau[11] = 0.094907;
    gau[12] = 0.150342;
    gau[13] = 0.094907;
    gau[14] = 0.023792;
    gau[15] = 0.015019;
    gau[16] = 0.059912;
    gau[17] = 0.094907;
    gau[18] = 0.059912;
    gau[19] = 0.015019;
    gau[20] = 0.003765;
    gau[21] = 0.015019;
    gau[22] = 0.023792;
    gau[23] = 0.015019;
    gau[24] = 0.003765;
    
    vec4 tex = vec4(0,0,0,0);
    
    vec4 orig = v_vColour * texture2D( gm_BaseTexture,v_vTexcoord );
    if(orig.a == 0.0)
    {
        return orig;
    }
    
    float d = pow(dist,gradient);
    if(gradient == 0.0)
    {
        d = 0.0;
    }
    
    for(float i = -2.0; i < 3.0; i+=(1.0/quality))
    {
        for(float j = -2.0; j < 3.0; j+=(1.0/quality))
        {
            tex += gchunck(i,j,(d * (top - base) + base), gau, quality);
        }
    }
    
    return tex;
}

vec4 gchunck(float x, float y, float sc, float[25] gau, float quality)
{
    return v_vColour * texture2D( gm_BaseTexture, coord(float(x) * sc, float(y) * sc) ) * (gau[index(int(x),int(y))] / (quality * quality));
}

vec2 coord(float x, float y)
{
    return v_vTexcoord + vec2((1.0/512.0) * x, (1.0/512.0) * y);
}

int index(int x, int y)
{
    return ((2 + x) * 5) + (2 + y);
}

