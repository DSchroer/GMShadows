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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 linearBaseSize;

vec4 HorizontalReductionPS(vec2 TexCoord);

//!IMPORTANT set this to the largest light map size that you will use!
const int big_ass_const = 256;

void main()
{
    gl_FragColor = HorizontalReductionPS(v_vTexcoord);
}

vec4 HorizontalReductionPS(vec2 TexCoord)
{
    float sizec = 1.0 / linearBaseSize.x;
    if(TexCoord.x > sizec && TexCoord.x < 1.0 - sizec)
    {
        return vec4(0,0,1,1);
    }
    
    vec2 color = vec2(1,1);
    
    float ac = sizec;
    if(TexCoord.x > 0.5)
    {
        ac = - ac;
    }
    float f = ac;
    
    int val = int(linearBaseSize.y);
    for (int i = 0; i < big_ass_const; i++)
    {
        if(i >= val)
        {
            break;
        }
        
        if(abs(f) >= 0.5)
        {
            break;
        }
        vec2 nColor = (v_vColour * texture2D(gm_BaseTexture, TexCoord + vec2(f,0))).rg;
        
        color = min(color, nColor);
        f = f + ac;
    }
    
    return vec4(color,0,1);
}

