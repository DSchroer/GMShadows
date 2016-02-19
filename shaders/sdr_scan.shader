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

vec4 DistortPS(vec2 TexCoord);

void main()
{
    gl_FragColor = DistortPS(v_vTexcoord);    
}

vec4 DistortPS(vec2 TexCoord)
{
    //translate u and v into [-1 , 1] domain
    float u0 = (TexCoord.x * 2.0) - 1.0;
    float v0 = (TexCoord.y * 2.0) - 1.0;
     
    //then, as u0 approaches 0 (the center), v should also approach 0
    v0 = v0 * abs(u0);
    //convert back from [-1,1] domain to [0,1] domain
    v0 = (v0 + 1.0) / 2.0;
    //we now have the coordinates for reading from the initial image
    vec2 newCoords = vec2(TexCoord.x, v0);
     
    //read for both horizontal and vertical direction and store them in separate channels
    float horizontal = texture2D(gm_BaseTexture, newCoords).r;
    float vertical = texture2D(gm_BaseTexture, vec2(newCoords.y, newCoords.x)).r;
    return vec4(horizontal,vertical ,0.0,1.0);
    //return vec4(horizontal,0.0 ,0.0,1.0);
}

