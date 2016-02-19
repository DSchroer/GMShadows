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

uniform vec2 size;

vec4 HorizontalReductionPS(vec2 TexCoord);

void main()
{
    gl_FragColor = HorizontalReductionPS(v_vTexcoord);
}

vec4 HorizontalReductionPS(vec2 TexCoord)
{
    vec2 color = (v_vColour * texture2D(gm_BaseTexture, TexCoord)).rg;
    
    vec2 colorR;
    if(TexCoord.x < 0.5)
    {
        colorR = (v_vColour * texture2D(gm_BaseTexture, TexCoord + vec2(size.x,0))).rg;
    }else{
        colorR = (v_vColour * texture2D(gm_BaseTexture, TexCoord - vec2(size.x,0))).rg;
    }
    
    
    vec2 result = min(color,colorR);
    return vec4(result.rg,0,1);
}

