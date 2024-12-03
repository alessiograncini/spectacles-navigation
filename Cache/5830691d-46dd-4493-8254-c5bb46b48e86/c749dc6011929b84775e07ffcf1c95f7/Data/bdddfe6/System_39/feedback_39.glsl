#version 310 es

#pragma paste_to_backend_at_the_top_begin
#define SC_USE_USER_DEFINED_VS_MAIN
#define SC_DISABLE_FRUSTUM_CULLING
#define SC_ALLOW_16_TEXTURES
#pragma paste_to_backend_at_the_top_end

#include <std3.glsl>
#include <std3_vs.glsl>
#include <std3_fs.glsl>
#include <std3_texture.glsl>
#include <std3_ssao.glsl>

SC_DECLARE_TEXTURE(renderTarget0);
SC_DECLARE_TEXTURE(renderTarget1);
SC_DECLARE_TEXTURE(renderTarget2);
SC_DECLARE_TEXTURE(renderTarget3);

uniform vec2 rtScaleFactor;			

#ifdef VERTEX_SHADER

void main() 
{
	sc_Vertex_t v = sc_LoadVertexAttributes();
	
	sc_SetClipPosition( vec4( v.texture0.xy * 2.0 - 1.0, 1.0, 1.0 ) );
	varTex0 = v.texture0.xy;
}

#endif // #ifdef VERTEX_SHADER


#ifdef FRAGMENT_SHADER

void main()
{
	sc_DiscardStereoFragment();
	
	#if __VERSION__ == 100
	gl_FragColor = result;
	#else
	vec2 uv = varTex0;
	uv *= rtScaleFactor;
	
	vec4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, uv, 0.0);
	vec4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, uv, 0.0);
	vec4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, uv, 0.0);
	vec4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, uv, 0.0);
	
	if ( dot( renderTarget0Sample + renderTarget1Sample + renderTarget2Sample + renderTarget3Sample, vec4( 0.2542325 ) ) == 0.3423183476 )
	{
		discard; // hack so the texture filter modes don't get wiped out
	}
	
	sc_writeFragData0( renderTarget0Sample );
	sc_writeFragData1( renderTarget1Sample );
	sc_writeFragData2( renderTarget2Sample );
	sc_writeFragData3( renderTarget3Sample );
	#endif
}

#endif //FRAGMENT SHADER
