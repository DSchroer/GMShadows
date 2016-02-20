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

const vec2 light = vec2(0.0, 0.0);
const float size = (1.0 / 32.0) * 2.0;

void main()
{
    gl_FragColor = vec4(0,0,0,0);
    
    vec2 ldir = normalize(light) * size;
    vec4 ncol = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    if(ncol.a > 0.3)
    {
        vec2 npos = v_vTexcoord + ldir;
        vec4 ccol = v_vColour * texture2D( gm_BaseTexture, npos);
        
        if(npos.x < 0.0|| npos.y < 0.0 || npos.x > 1.0|| npos.y > 1.0 || ccol.a < 0.3)
        {
            gl_FragColor = vec4(0,0,0,1);
            return;
        }
    }
}

