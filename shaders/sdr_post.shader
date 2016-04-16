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

const int quality = 4;
const float base = 2.0;
const float top = 15.0;
const float size = 512.0;

const vec4 col = vec4(1,1,1,1);

void main()
{
    float d = distance(v_vTexcoord, vec2(0.5,0.5)) * 2.0;
    float dist = mapSize * d;
    
    vec4 total = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
    for(int i = 1; i < quality + 1; i++)
    {
        float pos = dist * (float(quality) / float(i)); 
        pos = max(pos, base * mapSize);
        
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(pos,0.0) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(-pos,0.0) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0,pos) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0,-pos) );
        
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(pos,pos) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(-pos,pos) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(-pos,-pos) );
        total +=  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(pos,-pos) );
    }
    
    vec4 avg = (total) / (8.0 * float(quality));
    
    if(gradient > 0.5)
    {
        avg = avg * vec4(1,1,1, 1.0-d);
    }
    
    gl_FragColor = avg;
}

