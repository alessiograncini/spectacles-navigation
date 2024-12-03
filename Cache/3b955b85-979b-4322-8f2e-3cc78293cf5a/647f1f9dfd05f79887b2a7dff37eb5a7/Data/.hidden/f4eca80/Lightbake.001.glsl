#version 310 es

//-----------------------------------------------------------------------
// Copyright (c) 2019 Snap Inc.
//-----------------------------------------------------------------------

// NGS_SHADER_FLAGS_BEGIN__
// NGS_SHADER_FLAGS_END__

#pragma paste_to_backend_at_the_top_begin
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_BACKEND_SHADER_FLAGS_END__
#endif 
#pragma paste_to_backend_at_the_top_end


#define NODEFLEX 0 // Hack for now to know if a shader is running in Studio or on a released lens

//-----------------------------------------------------------------------

#define NF_PRECISION highp

//-----------------------------------------------------------------------

// 10-09-2019 - These defines were moved to PBR node but Some old graphs 
//              still have them in their material definition and some compilers
//              don't like them being redefined. Easiest fix for now is to undefine them.

#ifdef ENABLE_LIGHTING
#undef ENABLE_LIGHTING
#endif

#ifdef ENABLE_DIFFUSE_LIGHTING
#undef ENABLE_DIFFUSE_LIGHTING
#endif

#ifdef ENABLE_SPECULAR_LIGHTING
#undef ENABLE_SPECULAR_LIGHTING
#endif

#ifdef ENABLE_TONE_MAPPING
#undef ENABLE_TONE_MAPPING
#endif

//-----------------------------------------------------------------------

#define ENABLE_LIGHTING true
#define ENABLE_DIFFUSE_LIGHTING true
#define ENABLE_SPECULAR_LIGHTING true
#define ENABLE_TONE_MAPPING


//-----------------------------------------------------------------------



//-----------------------------------------------------------------------


//-----------------------------------------------------------------------
// Standard defines
//-----------------------------------------------------------------------


#pragma paste_to_backend_at_the_top_begin



#pragma paste_to_backend_at_the_top_end


//-----------------------------------------------------------------------
// Standard includes
//-----------------------------------------------------------------------

#include <std3.glsl>
#include <std3_vs.glsl>
#include <std3_texture.glsl>
#include <std3_fs.glsl>
#include <std3_ssao.glsl>
#include <std3_taa.glsl>

#if defined(SC_ENABLE_RT_CASTER) && !SC_RT_RECEIVER_MODE
#include <std3_proxy.glsl>
#endif


#if defined(SC_ENABLE_RT_RECEIVER)
#include <std3_receiver.glsl>
#endif




//-------------------
// Global defines
//-------------------

#define SCENARIUM

#ifdef SC_BACKEND_LANGUAGE_MOBILE
#define MOBILE
#endif

#ifdef SC_BACKEND_LANGUAGE_GL
const bool DEVICE_IS_FAST = SC_DEVICE_CLASS >= SC_DEVICE_CLASS_C && bool(SC_GL_FRAGMENT_PRECISION_HIGH);
#else
const bool DEVICE_IS_FAST = SC_DEVICE_CLASS >= SC_DEVICE_CLASS_C;
#endif

const bool SC_ENABLE_SRGB_EMULATION_IN_SHADER = true;


//-----------------------------------------------------------------------
// Varyings
//-----------------------------------------------------------------------

varying vec4 varColor;

//-----------------------------------------------------------------------
// User includes
//-----------------------------------------------------------------------
#include "includes/utils.glsl"		

#if !SC_RT_RECEIVER_MODE
#include "includes/blend_modes.glsl"
#include "includes/oit.glsl" 
#endif
#include "includes/rgbhsl.glsl"
#include "includes/uniforms.glsl"

//-----------------------------------------------------------------------

// The next 60 or so lines of code are for debugging support, live tweaks, node previews, etc and will be included in a 
// shared glsl file.

//-----------------------------------------------------------------------

// Hack for now to know if a shader is running in Studio or on a released lens

#if !defined(MOBILE) && !NODEFLEX
#define STUDIO
#endif

//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
// Basic Macros
//-----------------------------------------------------------------------

// Time Overrides

uniform       int   overrideTimeEnabled;
uniform highp float overrideTimeElapsed;
uniform highp float overrideTimeDelta;

//-----------------------------------------------------------------------

#if defined( STUDIO )
#define ssConstOrUniformPrecision	uniform NF_PRECISION
#define ssConstOrUniform			uniform
#else
#define ssConstOrUniformPrecision   const
#define ssConstOrUniform    		const
#endif

//--------------------------------------------------------

// When compiling the shader for rendering in a node-based editor, we need any unconnected dynamic input port's value to
// be tweakable in real-time so we expose it to the engine as a uniform. If we're compiling the shader for a release build
// we use a literal or const value

#if defined( STUDIO )
#define NF_PORT_CONSTANT( xValue, xUniform )	xUniform
#else
#define NF_PORT_CONSTANT( xValue, xUniform )	xValue
#endif

//--------------------------------------------------------

#define float2   vec2
#define float3   vec3
#define float4   vec4
#define bool2    bvec2
#define bool3    bvec3
#define bool4    bvec4
#define float2x2 mat2
#define float3x3 mat3
#define float4x4 mat4

//--------------------------------------------------------

#define ssConditional( C, A, B ) ( ( C * 1.0 != 0.0 ) ? A : B )
#define ssEqual( A, B )          ( ( A == B ) ? 1.0 : 0.0 )
#define ssNotEqual( A, B )       ( ( A == B ) ? 0.0 : 1.0 )
#define ssLarger( A, B )         ( ( A > B ) ? 1.0 : 0.0 )
#define ssLargerOrEqual( A, B )  ( ( A >= B ) ? 1.0 : 0.0 )
#define ssSmaller( A,  B ) 		 ( ( A < B ) ? 1.0 : 0.0 )
#define ssSmallerOrEqual( A, B ) ( ( A <= B ) ? 1.0 : 0.0 )
#define ssNot( A ) 		         ( ( A * 1.0 != 0.0 ) ? 0.0 : 1.0 )

int ssIntMod( int x, int y ) { return x - y * ( x / y ); }

#define ssPRECISION_LIMITER( Value ) Value = floor( Value * 10000.0 ) * 0.0001;
#define ssPRECISION_LIMITER2( Value ) Value = floor( Value * 2000.0 + 0.5 ) * 0.0005;

#define ssDELTA_TIME_MIN 0.00

//--------------------------------------------------------

float ssSRGB_to_Linear( float value ) { return ( DEVICE_IS_FAST ) ? pow( value, 2.2 ) : value * value; }
vec2  ssSRGB_to_Linear( vec2  value ) { return ( DEVICE_IS_FAST ) ? vec2( pow( value.x, 2.2 ), pow( value.y, 2.2 ) ) : value * value; }
vec3  ssSRGB_to_Linear( vec3  value ) { return ( DEVICE_IS_FAST ) ? vec3( pow( value.x, 2.2 ), pow( value.y, 2.2 ), pow( value.z, 2.2 ) ) : value * value; }
vec4  ssSRGB_to_Linear( vec4  value ) { return ( DEVICE_IS_FAST ) ? vec4( pow( value.x, 2.2 ), pow( value.y, 2.2 ), pow( value.z, 2.2 ), pow( value.w, 2.2 ) ) : value * value; }

float ssLinear_to_SRGB( float value ) { return ( DEVICE_IS_FAST ) ? pow( value, 0.45454545 ) : sqrt( value ); }
vec2  ssLinear_to_SRGB( vec2  value ) { return ( DEVICE_IS_FAST ) ? vec2( pow( value.x, 0.45454545 ), pow( value.y, 0.45454545 ) ) : sqrt( value ); }
vec3  ssLinear_to_SRGB( vec3  value ) { return ( DEVICE_IS_FAST ) ? vec3( pow( value.x, 0.45454545 ), pow( value.y, 0.45454545 ), pow( value.z, 0.45454545 ) ) : sqrt( value ); }
vec4  ssLinear_to_SRGB( vec4  value ) { return ( DEVICE_IS_FAST ) ? vec4( pow( value.x, 0.45454545 ), pow( value.y, 0.45454545 ), pow( value.z, 0.45454545 ), pow( value.w, 0.45454545 ) ) : sqrt( value ); }

//--------------------------------------------------------

float3 ssWorldToNDC( float3 posWS, mat4 ViewProjectionMatrix )
{
	float4 ScreenVector = ViewProjectionMatrix * float4( posWS, 1.0 );
	return ScreenVector.xyz / ScreenVector.w;
}

//-------------------

float  Dummy1;
float2 Dummy2;
float3 Dummy3;
float4 Dummy4;


// When calling matrices in NGS, please use the global functions defined in the Matrix node
// This ensures their respective flags are set correctly for VFX, eg. ngsViewMatrix --> ssGetGlobal_Matrix_View()
#define ngsLocalAabbMin						sc_LocalAabbMin
#define ngsWorldAabbMin						sc_WorldAabbMin
#define ngsLocalAabbMax						sc_LocalAabbMax
#define ngsWorldAabbMax						sc_WorldAabbMax
#define ngsCameraAspect 					sc_Camera.aspect;
#define ngsCameraNear                       sc_Camera.clipPlanes.x
#define ngsCameraFar                        sc_Camera.clipPlanes.y
#define ngsCameraPosition                   sc_Camera.position
#define ngsModelMatrix                      sc_ModelMatrix							//ssGetGlobal_Matrix_World()
#define ngsModelMatrixInverse               sc_ModelMatrixInverse					//ssGetGlobal_Matrix_World_Inverse()
#define ngsModelViewMatrix                  sc_ModelViewMatrix						//ssGetGlobal_Matrix_World_View()
#define ngsModelViewMatrixInverse           sc_ModelViewMatrixInverse				//ssGetGlobal_Matrix_World_View_Inverse()
#define ngsProjectionMatrix                 sc_ProjectionMatrix						//ssGetGlobal_Matrix_World_View_Projection()
#define ngsProjectionMatrixInverse          sc_ProjectionMatrixInverse				//ssGetGlobal_Matrix_World_View_Projection_Inverse()
#define ngsModelViewProjectionMatrix        sc_ModelViewProjectionMatrix			//ssGetGlobal_Matrix_Projection()
#define ngsModelViewProjectionMatrixInverse sc_ModelViewProjectionMatrixInverse		//ssGetGlobal_Matrix_Projection_Inverse()
#define ngsViewMatrix                       sc_ViewMatrix							//ssGetGlobal_Matrix_View()
#define ngsViewMatrixInverse                sc_ViewMatrixInverse					//ssGetGlobal_Matrix_View_Inverse()
#define ngsViewProjectionMatrix             sc_ViewProjectionMatrix					//ssGetGlobal_Matrix_View_Projection()
#define ngsViewProjectionMatrixInverse      sc_ViewProjectionMatrixInverse			//ssGetGlobal_Matrix_View_Projection_Inverse()
#define ngsCameraUp 					    sc_ViewMatrixInverse[1].xyz
#define ngsCameraForward                    -sc_ViewMatrixInverse[2].xyz
#define ngsCameraRight                      sc_ViewMatrixInverse[0].xyz
#define ngsFrame 		                    0

//--------------------------------------------------------


#if defined( STUDIO )

struct ssPreviewInfo
{
	float4 Color;
	bool   Saved;
};

ssPreviewInfo PreviewInfo;

uniform NF_PRECISION int PreviewEnabled; // PreviewEnabled is set to 1 by the renderer when Lens Studio is rendering node previews
uniform NF_PRECISION int PreviewNodeID;  // PreviewNodeID is set to the node's ID that a preview is being rendered for

varying float4 PreviewVertexColor;
varying float  PreviewVertexSaved;

#define NF_DISABLE_VERTEX_CHANGES()					( PreviewEnabled == 1 )			
#define NF_SETUP_PREVIEW_VERTEX()					PreviewInfo.Color = PreviewVertexColor = float4( 0.5 ); PreviewInfo.Saved = false; PreviewVertexSaved = 0.0;
#define NF_SETUP_PREVIEW_PIXEL()					PreviewInfo.Color = PreviewVertexColor; PreviewInfo.Saved = ( PreviewVertexSaved * 1.0 != 0.0 ) ? true : false;
#define NF_PREVIEW_SAVE( xCode, xNodeID, xAlpha ) 	if ( PreviewEnabled == 1 && !PreviewInfo.Saved && xNodeID == PreviewNodeID ) { PreviewInfo.Saved = true; { PreviewInfo.Color = xCode; if ( !xAlpha ) PreviewInfo.Color.a = 1.0; } }
#define NF_PREVIEW_FORCE_SAVE( xCode ) 				if ( PreviewEnabled == 0 ) { PreviewInfo.Saved = true; { PreviewInfo.Color = xCode; } }
#define NF_PREVIEW_OUTPUT_VERTEX()					if ( PreviewInfo.Saved ) { PreviewVertexColor = float4( PreviewInfo.Color.rgb, 1.0 ); PreviewVertexSaved = 1.0; }
#define NF_PREVIEW_OUTPUT_PIXEL()					if ( PreviewEnabled == 1 ) { if ( PreviewInfo.Saved ) { FinalColor = float4( PreviewInfo.Color ); } else { FinalColor = vec4( 0.0, 0.0, 0.0, 0.0 ); /*FinalColor.a = 1.0;*/ /* this will be an option later */ }  }

#else

#define NF_DISABLE_VERTEX_CHANGES()					false			
#define NF_SETUP_PREVIEW_VERTEX()
#define NF_SETUP_PREVIEW_PIXEL()
#define NF_PREVIEW_SAVE( xCode, xNodeID, xAlpha )
#define NF_PREVIEW_FORCE_SAVE( xCode )
#define NF_PREVIEW_OUTPUT_VERTEX()
#define NF_PREVIEW_OUTPUT_PIXEL()

#endif


//--------------------------------------------------------



//--------------------------------------------------------

#ifdef VERTEX_SHADER

//--------------------------------------------------------

in vec4 color;

//--------------------------------------------------------

void ngsVertexShaderBegin( out sc_Vertex_t v )
{
	v = sc_LoadVertexAttributes();
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	sc_BlendVertex(v);
	sc_SkinVertex(v);
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( sc_RenderingSpace == SC_RENDERING_SPACE_SCREEN )
	{
		varPos         = vec3( 0.0 );
		varNormal      = v.normal;
		varTangent.xyz = v.tangent;
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_SCREEN_MV )
	{
		varPos         = vec3( 0.0 );
		varNormal      = v.normal;
		varTangent.xyz = v.tangent;
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_WORLD )
	{				
		varPos         = v.position.xyz;
		varNormal      = v.normal;
		varTangent.xyz = v.tangent;
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_OBJECT )
	{
		varPos         = (sc_ModelMatrix * v.position).xyz;
		varNormal      = sc_NormalMatrix * v.normal;
		varTangent.xyz = sc_NormalMatrix * v.tangent;
	}
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if !defined(MOBILE)
	if ( PreviewEnabled == 1 )
	v.texture0.x = 1.0 - v.texture0.x; // fix to flip the preview quad UVs horizontally
	#endif
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	varColor = color;
}

//--------------------------------------------------------

#ifndef SC_PROCESS_AA
#define SC_PROCESS_AA
#endif

//--------------------------------------------------------

void ngsVertexShaderEnd( inout sc_Vertex_t v, vec3 WorldPosition, vec3 WorldNormal, vec3 WorldTangent, vec4 ScreenPosition )
{
	varPos          = WorldPosition; 
	varNormal       = normalize( WorldNormal );
	varTangent.xyz  = normalize( WorldTangent );
	varTangent.w    = tangent.w;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( bool( UseViewSpaceDepthVariant ) && ( bool( sc_OITDepthGatherPass ) || bool( sc_OITCompositingPass ) || bool( sc_OITDepthBoundsPass ) ) )
	{
		varViewSpaceDepth = -sc_ObjectToView( v.position ).z;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 screenPosition = float4( 0.0 );
	
	if ( sc_RenderingSpace == SC_RENDERING_SPACE_SCREEN )
	{
		screenPosition = ScreenPosition; 
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_SCREEN_MV )
	{
		screenPosition = ( ngsModelViewMatrix * v.position ) * vec4( 1.0 / sc_Camera.aspect, 1.0, 1.0, 1.0 );
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_WORLD )
	{
		screenPosition = ngsViewProjectionMatrix * float4( varPos.xyz, 1.0 );
	}
	else if ( sc_RenderingSpace == SC_RENDERING_SPACE_OBJECT )
	{
		screenPosition = ngsViewProjectionMatrix * float4( varPos.xyz, 1.0 );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	varTex01 = vec4( v.texture0, v.texture1 );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( bool( sc_ProjectiveShadowsReceiver ) )
	{
		varShadowTex = getProjectedTexCoords(v.position);
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	screenPosition = applyDepthAlgorithm(screenPosition); 
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	vec4 finalPosition = SC_PROCESS_AA( screenPosition );
	sc_SetClipPosition( finalPosition );
}

//--------------------------------------------------------

#endif //VERTEX_SHADER

//--------------------------------------------------------

float3 ssGetScreenPositionNDC( float4 vertexPosition, float3 positionWS, mat4 viewProjectionMatrix )
{
	float3 screenPosition = vec3( 0.0 );
	
	#ifdef VERTEX_SHADER
	
	if ( sc_RenderingSpace == SC_RENDERING_SPACE_SCREEN )
	{
		screenPosition = vertexPosition.xyz;
	}
	else
	{
		screenPosition = ssWorldToNDC( positionWS, viewProjectionMatrix );
	}
	
	#endif
	
	return screenPosition;
}

//--------------------------------------------------------

uniform NF_PRECISION float alphaTestThreshold;

#ifdef FRAGMENT_SHADER

void ngsAlphaTest( float opacity )
{
	if ( sc_BlendMode_AlphaTest )
	{
		if ( opacity < alphaTestThreshold )
		{
			discard;
		}
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( ENABLE_STIPPLE_PATTERN_TEST )
	{
		vec2  localCoord = floor(mod(sc_GetGlFragCoord().xy, vec2(4.0)));
		float threshold  = (mod(dot(localCoord, vec2(4.0, 1.0)) * 9.0, 16.0) + 1.0) / 17.0;
		
		if ( opacity < threshold )
		{
			discard;
		}
	}
}

#endif // #ifdef FRAGMENT_SHADER

#ifdef FRAGMENT_SHADER
#if !SC_RT_RECEIVER_MODE
vec4 ngsPixelShader( vec4 result ) 
{	
	if ( sc_ProjectiveShadowsCaster )
	{
		result = evaluateShadowCasterColor( result );
	}
	else if ( sc_RenderAlphaToColor )
	{
		result = vec4(result.a);
	}
	else if ( sc_BlendMode_Custom )
	{
		result = applyCustomBlend(result);
	}
	else
	{
		result = sc_ApplyBlendModeModifications(result);
	}
	
	return result;
}
#endif
#endif


//-----------------------------------------------------------------------


// Spec Consts

SPEC_CONST(int) NODE_38_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_BASE_TEX = false;
SPEC_CONST(int) NODE_27_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_RECOLOR = false;
SPEC_CONST(bool) ENABLE_OPACITY_TEX = false;
SPEC_CONST(int) NODE_69_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_NORMALMAP = false;
SPEC_CONST(int) NODE_181_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_DETAIL_NORMAL = false;
SPEC_CONST(int) NODE_184_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_EMISSIVE = false;
SPEC_CONST(int) NODE_76_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_SIMPLE_REFLECTION = false;
SPEC_CONST(bool) Tweak_N177 = false;
SPEC_CONST(int) NODE_228_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_RIM_HIGHLIGHT = false;
SPEC_CONST(bool) Tweak_N216 = false;
SPEC_CONST(bool) ENABLE_RIM_INVERT = false;
SPEC_CONST(int) NODE_315_DROPLIST_ITEM = 0;
SPEC_CONST(int) NODE_221_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_SPECULAR_AO = false;
SPEC_CONST(bool) ENABLE_UV2 = false;
SPEC_CONST(int) NODE_13_DROPLIST_ITEM = 0;
SPEC_CONST(bool) uv2EnableAnimation = false;
SPEC_CONST(bool) ENABLE_UV3 = false;
SPEC_CONST(int) NODE_49_DROPLIST_ITEM = 0;
SPEC_CONST(bool) uv3EnableAnimation = false;


// Material Parameters ( Tweaks )

uniform NF_PRECISION                            float4 baseColor; // Title: Base Color
SC_DECLARE_TEXTURE(baseTex); //                 Title: Texture
uniform NF_PRECISION                            float3 recolorRed; // Title: Recolor Red
uniform NF_PRECISION                            float3 recolorGreen; // Title: Recolor Green
uniform NF_PRECISION                            float3 recolorBlue; // Title: Recolor Blue
SC_DECLARE_TEXTURE(opacityTex); //              Title: Texture
SC_DECLARE_TEXTURE(normalTex); //               Title: Texture
SC_DECLARE_TEXTURE(detailNormalTex); //         Title: Texture
SC_DECLARE_TEXTURE(emissiveTex); //             Title: Texture
uniform NF_PRECISION                            float3 emissiveColor; // Title: Color
uniform NF_PRECISION                            float  emissiveIntensity; // Title: Intensity
SC_DECLARE_TEXTURE(reflectionTex); //           Title: Texture
uniform NF_PRECISION                            float  reflectionIntensity; // Title: Intensity
SC_DECLARE_TEXTURE(reflectionModulationTex); // Title: Texture
uniform NF_PRECISION                            float3 rimColor; // Title: Color
uniform NF_PRECISION                            float  rimIntensity; // Title: Intensity
uniform NF_PRECISION                            float  rimExponent; // Title: Exponent
SC_DECLARE_TEXTURE(rimColorTex); //             Title: Texture
uniform NF_PRECISION                            float  metallic; // Title: Metallic
uniform NF_PRECISION                            float  roughness; // Title: Roughness
SC_DECLARE_TEXTURE(materialParamsTex); //       Title: Texture
uniform NF_PRECISION                            float  specularAoIntensity; // Title: Intensity
uniform NF_PRECISION                            float  specularAoDarkening; // Title: Darkening
uniform NF_PRECISION                            float2 uv2Scale; // Title: Scale
uniform NF_PRECISION                            float2 uv2Offset; // Title: Offset
uniform NF_PRECISION                            float2 uv3Scale; // Title: Scale
uniform NF_PRECISION                            float2 uv3Offset; // Title: Offset	


//-----------------------------------------------------------------------


#if defined(SC_ENABLE_RT_CASTER)
uniform highp float depthRef;
#endif


//-----------------------------------------------------------------------

#ifdef VERTEX_SHADER

//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	vec2 N7_TransformedUV2;
	vec2 N7_TransformedUV3;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform

//-----------------------------------------------------------------------

void main() 
{
	
	#if defined(SC_ENABLE_RT_CASTER) && !SC_RT_RECEIVER_MODE
	if (bool(sc_ProxyMode)) {
		sc_SetClipPosition(vec4(position.xy, depthRef + 1e-10 * position.z, 1.0 + 1e-10 * position.w)); // GPU_BUG_028
		return;
	}
	#endif
	
	
	NF_SETUP_PREVIEW_VERTEX()
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	sc_Vertex_t v;
	ngsVertexShaderBegin( v );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssGlobals Globals;	
	Globals.gTimeElapsed = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	Globals.gTimeDelta   = ( overrideTimeEnabled == 1 ) ? overrideTimeDelta : sc_TimeDelta;
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 ScreenPosition = vec4( 0.0 );
	float3 WorldPosition  = varPos;
	float3 WorldNormal    = varNormal;
	float3 WorldTangent   = varTangent.xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	// no vertex transformation needed
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( NF_DISABLE_VERTEX_CHANGES() )
	{
		WorldPosition  = varPos;
		WorldNormal    = varNormal;
		WorldTangent   = varTangent.xyz;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ngsVertexShaderEnd( v, WorldPosition, WorldNormal, WorldTangent, v.position );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	NF_PREVIEW_OUTPUT_VERTEX()
}

//-----------------------------------------------------------------------

#endif // #ifdef VERTEX_SHADER

//-----------------------------------------------------------------------

#ifdef FRAGMENT_SHADER

//-----------------------------------------------------------------------------

//----------

// Includes


#include "includes/uber_lighting.glsl"
#include "includes/pbr.glsl"

#if !SC_RT_RECEIVER_MODE
//-----------------------------------------------------------------------

vec4 ngsCalculateLighting( vec3 albedo, float opacity, vec3 normal, vec3 position, vec3 viewDir, vec3 emissive, float metallic, float roughness, vec3 ao, vec3 specularAO )
{
	SurfaceProperties surfaceProperties = defaultSurfaceProperties();
	surfaceProperties.opacity = opacity;
	surfaceProperties.albedo = ssSRGB_to_Linear( albedo );
	surfaceProperties.normal = normalize( normal );
	surfaceProperties.positionWS = position;
	surfaceProperties.viewDirWS = viewDir;
	surfaceProperties.emissive = ssSRGB_to_Linear( emissive );
	surfaceProperties.metallic = metallic;
	surfaceProperties.roughness = roughness;
	surfaceProperties.ao = ao;
	surfaceProperties.specularAo = specularAO;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#ifdef ENABLE_LIGHTING
	
	if (sc_SSAOEnabled) {
		surfaceProperties.ao = evaluateSSAO(surfaceProperties.positionWS.xyz);
	}
	
	surfaceProperties = calculateDerivedSurfaceProperties(surfaceProperties);
	LightingComponents lighting = evaluateLighting(surfaceProperties);
	
	#else
	
	LightingComponents lighting = defaultLightingComponents();
	
	#endif
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( sc_BlendMode_ColoredGlass )
	{		
		// Colored glass implies that the surface does not diffusely reflect light, instead it transmits light.
		// The transmitted light is the background multiplied by the color of the glass, taking opacity as strength.
		lighting.directDiffuse = vec3(0.0);
		lighting.indirectDiffuse = vec3(0.0);
		vec3 framebuffer = ssSRGB_to_Linear( getFramebufferColor().rgb );
		lighting.transmitted = framebuffer * mix(vec3(1.0), surfaceProperties.albedo, surfaceProperties.opacity);
		surfaceProperties.opacity = 1.0; // Since colored glass does its own multiplicative blending (above), forbid any other blending.
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	bool enablePremultipliedAlpha = false;
	
	if ( sc_BlendMode_PremultipliedAlpha )
	{
		enablePremultipliedAlpha = true;
	}						
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	// This is where the lighting and the surface finally come together.
	
	vec4 Output = vec4(combineSurfacePropertiesWithLighting(surfaceProperties, lighting, enablePremultipliedAlpha), surfaceProperties.opacity);
	
	if (sc_IsEditor) {
		// [STUDIO-47088] [HACK 1/8/2024] The wrong lighting environment is in effect, ie: no lighting, when syncShaderProperties() is called.
		// Because the envmap is not enabled at that point, the ao uniforms get dead code removed, and thus they don"t get their values set during real rendering either, so they"re stuck at 0 and envmaps look black. 
		// We force potential uniforms to be active here, so their values can be set correctly during real rendering. 
		Output.r += surfaceProperties.ao.r * surfaceProperties.specularAo.r * 0.00001;
	}
	
	
	#if defined(SC_ENABLE_RT_CASTER) && !SC_RT_RECEIVER_MODE
	if (bool(sc_ProxyMode)) {
		return Output;
	}
	#endif
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	// Tone mapping
	
	if ( !sc_BlendMode_Multiply )
	{
		#if defined(ENABLE_TONE_MAPPING)
		
		Output.rgb = linearToneMapping( Output.rgb );
		
		#endif
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	// sRGB output
	
	Output.rgb = linearToSrgb( Output.rgb );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	return Output;
}	
#endif



//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	vec2   N7_TransformedUV2;
	vec2   N7_TransformedUV3;
	float3 BumpedNormal;
	float3 ViewDirWS;
	float3 PositionWS;
	float3 VertexNormal_WorldSpace;
	float3 VertexTangent_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float2 Surface_UVCoord0;
	float2 Surface_UVCoord1;
	float4 VertexColor;
	float2 gScreenCoord;
	float3 SurfacePosition_WorldSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

float ssPow( float A, float B ) { return ( A <= 0.0 ) ? 0.0 : pow( A, B ); }
vec2  ssPow( vec2  A, vec2  B ) { return vec2( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ) ); }
vec3  ssPow( vec3  A, vec3  B ) { return vec3( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ), ( A.z <= 0.0 ) ? 0.0 : pow( A.z, B.z ) ); }
vec4  ssPow( vec4  A, vec4  B ) { return vec4( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ), ( A.z <= 0.0 ) ? 0.0 : pow( A.z, B.z ), ( A.w <= 0.0 ) ? 0.0 : pow( A.w, B.w ) ); }
float ssSqrt( float A ) { return ( A <= 0.0 ) ? 0.0 : sqrt( A ); }
vec2  ssSqrt( vec2  A ) { return vec2( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ) ); }
vec3  ssSqrt( vec3  A ) { return vec3( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ), ( A.z <= 0.0 ) ? 0.0 : sqrt( A.z ) ); }
vec4  ssSqrt( vec4  A ) { return vec4( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ), ( A.z <= 0.0 ) ? 0.0 : sqrt( A.z ), ( A.w <= 0.0 ) ? 0.0 : sqrt( A.w ) ); }
int N7_VertexColorSwitch_evaluate() { return int( NODE_38_DROPLIST_ITEM ); }
bool N7_EnableBaseTexture_evaluate() { return bool( ENABLE_BASE_TEX ); }
vec4 N7_BaseTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(baseTex, coords, 0.0); return _result_memfunc; }
int N7_BaseTextureUVSwitch_evaluate() { return int( NODE_27_DROPLIST_ITEM ); }
bool N7_EnableRecolor_evaluate() { return bool( ENABLE_RECOLOR ); }
bool N7_EnableOpacityTexture_evaluate() { return bool( ENABLE_OPACITY_TEX ); }
vec4 N7_OpacityTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(opacityTex, coords, 0.0); return _result_memfunc; }
int N7_OpacityUVSwitch_evaluate() { return int( NODE_69_DROPLIST_ITEM ); }
bool N7_EnableNormalTexture_evaluate() { return bool( ENABLE_NORMALMAP ); }
vec4 N7_NormalTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(normalTex, coords, 0.0); return _result_memfunc; }
int N7_NormalUVSwitch_evaluate() { return int( NODE_181_DROPLIST_ITEM ); }
bool N7_EnableDetailNormal_evaluate() { return bool( ENABLE_DETAIL_NORMAL ); }
vec4 N7_DetailNormalTex_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(detailNormalTex, coords, 0.0); return _result_memfunc; }
int N7_Detail_NormalUVSwitch_evaluate() { return int( NODE_184_DROPLIST_ITEM ); }
bool N7_EnableEmissiveTexture_evaluate() { return bool( ENABLE_EMISSIVE ); }
vec4 N7_EmissiveTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(emissiveTex, coords, 0.0); return _result_memfunc; }
int N7_EmissiveUVSwitch_evaluate() { return int( NODE_76_DROPLIST_ITEM ); }
bool N7_EnableSimpleReflection_evaluate() { return bool( ENABLE_SIMPLE_REFLECTION ); }
vec4 N7_ReflectionTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(reflectionTex, coords, 0.0); return _result_memfunc; }
bool N7_EnableModulationTexture_evaluate() { return bool( Tweak_N177 ); }
int N7_ModuationUVSwitch_evaluate() { return int( NODE_228_DROPLIST_ITEM ); }
vec4 N7_ModuationTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(reflectionModulationTex, coords, 0.0); return _result_memfunc; }
bool N7_EnableRimHighlight_evaluate() { return bool( ENABLE_RIM_HIGHLIGHT ); }
bool N7_EnableRimColorTexture_evaluate() { return bool( Tweak_N216 ); }
bool N7_EnableRimInvert_evaluate() { return bool( ENABLE_RIM_INVERT ); }
vec4 N7_RimColorTex_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(rimColorTex, coords, 0.0); return _result_memfunc; }
int N7_RimUVSwitch_evaluate() { return int( NODE_315_DROPLIST_ITEM ); }
vec4 N7_MaterialParamsTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(materialParamsTex, coords, 0.0); return _result_memfunc; }
int N7_MaterialParamsUVSwitch_evaluate() { return int( NODE_221_DROPLIST_ITEM ); }
bool N7_EnableSpecularAO_evaluate() { return bool( ENABLE_SPECULAR_AO ); }
bool N7_EnableUV2_evaluate() { return bool( ENABLE_UV2 ); }
int N7_UV2Switch_evaluate() { return int( NODE_13_DROPLIST_ITEM ); }
bool N7_UV2Animation_evaluate() { return bool( uv2EnableAnimation ); }
bool N7_EnableUV3_evaluate() { return bool( ENABLE_UV3 ); }
int N7_UV3Switch_evaluate() { return int( NODE_49_DROPLIST_ITEM ); }
bool N7_UV3Animation_evaluate() { return bool( uv3EnableAnimation ); }
vec3 N7_system_getSurfaceNormalWorldSpace() { return tempGlobals.VertexNormal_WorldSpace; }
vec3 N7_system_getSurfaceTangentWorldSpace() { return tempGlobals.VertexTangent_WorldSpace; }
vec3 N7_system_getSurfaceBitangentWorldSpace() { return tempGlobals.VertexBinormal_WorldSpace; }
vec2 N7_system_getSurfaceUVCoord0() { return tempGlobals.Surface_UVCoord0; }
vec2 N7_system_getSurfaceUVCoord1() { return tempGlobals.Surface_UVCoord1; }
vec4 N7_system_getSurfaceColor() { return tempGlobals.VertexColor; }
float N7_system_getTimeElapsed() { return tempGlobals.gTimeElapsed; }
vec2 N7_system_getScreenUVCoord() { return tempGlobals.gScreenCoord; }
vec3 N7_system_getViewVector() { return tempGlobals.ViewDirWS; }
int N7_VertexColorSwitch;
vec4 N7_BaseColorValue;
bool N7_EnableBaseTexture;

int N7_BaseTextureUVSwitch;

bool N7_EnableRecolor; 
vec3 N7_RecolorR;
vec3 N7_RecolorG;
vec3 N7_RecolorB;

bool N7_EnableOpacityTexture;

int N7_OpacityUVSwitch;

bool N7_EnableNormalTexture;

int N7_NormalUVSwitch;

bool N7_EnableDetailNormal;

int N7_Detail_NormalUVSwitch;

bool N7_EnableEmissiveTexture;

int N7_EmissiveUVSwitch;

vec3 N7_EmissiveColor;
float N7_EmissiveIntensity;

bool N7_EnableSimpleReflection;

float N7_ReflectionIntensity;

bool N7_EnableModulationTexture;
int N7_ModuationUVSwitch;

bool N7_EnableRimHighlight;
vec3 N7_RimColor;
float N7_RimIntensity;
float N7_RimExponent;
bool N7_EnableRimColorTexture;
bool N7_EnableRimInvert;

int N7_RimUVSwitch;

float N7_MetallicValue;
float N7_RoughnessValue;

int N7_MaterialParamsUVSwitch;
bool N7_EnableSpecularAO;
float N7_Intensity;
float N7_Darkening;

bool N7_EnableUV2;
int N7_UV2Switch;
vec2 N7_UV2Scale;
vec2 N7_UV2Offset;
bool N7_UV2Animation;

bool N7_EnableUV3;
int N7_UV3Switch;
vec2 N7_UV3Scale;
vec2 N7_UV3Offset;
bool N7_UV3Animation;

vec4 N7_Albedo;
float N7_Opacity;
vec3 N7_Normal;
vec3 N7_Emissive;
float N7_Metallic;
float N7_Roughness;
vec3 N7_AO;
vec3 N7_SpecularAO;

vec2 N7_gettransformUV(int pickUV, vec2 scale, vec2 offset, bool animated, bool enabled)
{   
	vec2 uv = N7_system_getSurfaceUVCoord0();
	if(enabled == N7_EnableUV2) {
		if (pickUV == 0) uv = N7_system_getSurfaceUVCoord0();
		if (pickUV == 1) uv = N7_system_getSurfaceUVCoord1();
		if (pickUV == 2) uv = N7_system_getScreenUVCoord();
	}
	else{
		if (pickUV == 0) uv = N7_system_getSurfaceUVCoord0();
		if (pickUV == 1) uv = N7_system_getSurfaceUVCoord1();
		if (pickUV == 2) uv = N7_system_getScreenUVCoord();
		if (pickUV == 3) uv = tempGlobals.N7_TransformedUV2;
	}
	uv = uv * scale + offset;
	if(animated){
		uv =  uv + offset * N7_system_getTimeElapsed();
	}
	return uv;
}

vec2 N7_getUV(int pickUV)
{
	vec2 uv = N7_system_getSurfaceUVCoord0();
	if (pickUV == 0) uv = N7_system_getSurfaceUVCoord0();
	if (pickUV == 1) uv = N7_system_getSurfaceUVCoord1();
	if (pickUV == 2) uv = tempGlobals.N7_TransformedUV2;
	if (pickUV == 3) uv = tempGlobals.N7_TransformedUV3;
	return uv;
}

vec3 N7_combineNormals(vec3 Normal1, vec3 Normal2){
	vec3 t = Normal1 + vec3(0.0, 0.0, 1.0);
	vec3 u = Normal2 * vec3(-1.0, -1.0, 1.0);
	return normalize(t * dot(t, u)- u * t.z);
}

vec2 N7_sphericalcoordsfromDir(vec3 reflDir){
	float m = 2.0 * ssSqrt(reflDir.x * reflDir.x + reflDir.y * reflDir.y + (reflDir.z + 1.0) * (reflDir.z + 1.0));
	vec2 reflTexCoord = reflDir.xy / m + 0.5;
	return reflTexCoord;
}

vec3 N7_vec3srgbToLinear(vec3 color){
	return vec3(ssPow(color.r, 2.2), ssPow(color.g, 2.2), ssPow(color.b, 2.2));
}

#pragma inline 
void N7_main()
{
	
	// UV Transform UVs
	tempGlobals.N7_TransformedUV2 = N7_gettransformUV(N7_UV2Switch, N7_UV2Scale, N7_UV2Offset, N7_UV2Animation, N7_EnableUV2);
	tempGlobals.N7_TransformedUV3 = N7_gettransformUV(N7_UV3Switch, N7_UV3Scale, N7_UV3Offset, N7_UV3Animation, N7_EnableUV3);
	//We keep Projected UV removed from transform UVs there"s no way to hide the matrix parameter UI.
	
	
	//Base Texture
	vec2 base_UV = N7_system_getSurfaceUVCoord0();
	vec2 opacity_UV = N7_system_getSurfaceUVCoord0();
	
	N7_Opacity = 1.0;
	N7_Albedo = N7_BaseColorValue;
	
	if(N7_EnableBaseTexture){
		base_UV = N7_getUV(N7_BaseTextureUVSwitch);
		N7_Albedo *= N7_BaseTexture_sample(base_UV);
	}
	
	if(N7_EnableRecolor){
		N7_Albedo.rgb = N7_Albedo.r * N7_RecolorR + N7_Albedo.g * N7_RecolorG + N7_Albedo.b * N7_RecolorB;
	}
	
	// N7_Opacity
	if(N7_EnableOpacityTexture){
		opacity_UV = N7_getUV(N7_OpacityUVSwitch);
		N7_Opacity = N7_OpacityTexture_sample(opacity_UV).r;
	}
	
	N7_Opacity *= N7_Albedo.a;
	
	if(N7_VertexColorSwitch == 1){
		N7_Albedo *= N7_system_getSurfaceColor();
		N7_Opacity *= N7_system_getSurfaceColor().a;
	}
	
	// N7_Normal
	if(N7_EnableNormalTexture){
		vec3 detailNor = vec3(0.0, 0.0, 1.0);
		vec2 normal_UV = N7_getUV(N7_NormalUVSwitch);
		N7_Normal = N7_NormalTexture_sample(normal_UV).rgb * (255.0 / 128.0) - 1.0; // maps RGB 128 to 0.
		
		if(N7_EnableDetailNormal){
			
			vec2 detail_normal_UV = N7_getUV(N7_Detail_NormalUVSwitch);
			detailNor = N7_DetailNormalTex_sample(detail_normal_UV).rgb *(255.0 / 128.0) - 1.0;  // maps RGB 128 to 0.
		}
		
		N7_Normal = N7_combineNormals(N7_Normal, detailNor);
		vec3 N = N7_system_getSurfaceNormalWorldSpace();
		vec3 T = N7_system_getSurfaceTangentWorldSpace();
		vec3 B = N7_system_getSurfaceBitangentWorldSpace();
		mat3 TBN = mat3(T, B, N);
		N7_Normal = normalize(TBN * N7_Normal);
	}
	else{
		N7_Normal = normalize(N7_system_getSurfaceNormalWorldSpace());
	}
	
	// N7_Emissive
	vec2 UV = N7_system_getSurfaceUVCoord0();
	vec3 simplereflectionColor = vec3(0.0, 0.0, 0.0);
	vec3 rimHighlight = vec3(0.0, 0.0, 0.0);
	// We need this line to guard the value so it will render correctly when Advanced Graphics is enabled.
	N7_Emissive = vec3(0.0, 0.0, 0.0);
	
	if(N7_EnableEmissiveTexture){
		
		UV = N7_getUV(N7_EmissiveUVSwitch);
		N7_Emissive = N7_EmissiveTexture_sample(UV).rgb;
	}
	
	if(N7_VertexColorSwitch == 2){
		N7_Emissive += N7_system_getSurfaceColor().rgb;
	}
	
	if(N7_VertexColorSwitch == 2 || N7_EnableEmissiveTexture){
		N7_Emissive = ssPow(N7_Emissive * N7_EmissiveColor * vec3(N7_EmissiveIntensity), vec3(2.2));
	}
	
	if(N7_EnableSimpleReflection){
		vec3 V = N7_system_getViewVector();
		vec3 R = reflect(V, N7_Normal);
		R.z = -R.z;
		vec2 UV = vec2(1.0)- N7_sphericalcoordsfromDir(R);
		
		simplereflectionColor = N7_ReflectionTexture_sample(UV).rgb;
		
		if(N7_EnableModulationTexture){
			
			vec2 modulation_UV = N7_getUV(N7_ModuationUVSwitch);
			vec3 Moduation = N7_ModuationTexture_sample(modulation_UV).rgb;
			simplereflectionColor *= Moduation;
		}
		simplereflectionColor = N7_vec3srgbToLinear(simplereflectionColor);
		simplereflectionColor *= N7_ReflectionIntensity;
	}
	
	if(N7_EnableRimHighlight){
		vec3 rimCol = N7_RimColor * N7_RimIntensity;
		
		if(N7_EnableRimColorTexture){
			vec2 rim_UV = N7_getUV(N7_RimUVSwitch);
			rimCol *= N7_RimColorTex_sample(rim_UV).rgb;
		}
		
		vec3 V = N7_system_getViewVector();
		float rimFactor = abs(dot(N7_Normal, V));
		if(!N7_EnableRimInvert){
			rimFactor = 1.0 - rimFactor;
		}
		
		rimHighlight += ssPow(rimFactor, N7_RimExponent) * N7_vec3srgbToLinear(rimCol);
		
	}
	
	N7_Emissive = ssPow(N7_Emissive + simplereflectionColor + rimHighlight, vec3(1.0 / 2.2));
	
	// Material Parameter
	vec3 MaterialParams;
	vec2 Material_Params_UV = N7_getUV(N7_MaterialParamsUVSwitch);
	MaterialParams = N7_MaterialParamsTexture_sample(Material_Params_UV).rgb;
	N7_Metallic = MaterialParams.r * N7_MetallicValue;
	N7_Roughness = MaterialParams.g * N7_RoughnessValue;
	
	if(N7_VertexColorSwitch == 3){
		N7_AO = vec3(MaterialParams.b)* N7_system_getSurfaceColor().rgb;
	}
	else{
		N7_AO = vec3(MaterialParams.b);
	}
	
	if(N7_EnableSpecularAO){
		N7_SpecularAO = mix(vec3(0.04), N7_Albedo.rgb * N7_Metallic, N7_Metallic);
		N7_SpecularAO = mix((1.0 - N7_Darkening) * N7_SpecularAO * N7_SpecularAO , vec3(1.0), N7_AO.r);
		N7_SpecularAO = mix(vec3(1.0), N7_SpecularAO, N7_Intensity);
	}
	else{
		N7_SpecularAO = vec3(1.0);
	}
	if(N7_EnableSimpleReflection){
		N7_SpecularAO = vec3(0.0);
	}
	
}
#define Node38_DropList_Parameter( Output, Globals ) Output = float( NODE_38_DROPLIST_ITEM )
void Node5_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = baseColor; }
void Node121_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_BASE_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node28_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node27_DropList_Parameter( Output, Globals ) Output = float( NODE_27_DROPLIST_ITEM )
void Node37_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_RECOLOR )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node85_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorRed; }
void Node86_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorGreen; }
void Node87_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorBlue; }
void Node308_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_OPACITY_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node68_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node69_DropList_Parameter( Output, Globals ) Output = float( NODE_69_DROPLIST_ITEM )
void Node354_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_NORMALMAP )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node180_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node181_DropList_Parameter( Output, Globals ) Output = float( NODE_181_DROPLIST_ITEM )
void Node218_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_DETAIL_NORMAL )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node183_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node184_DropList_Parameter( Output, Globals ) Output = float( NODE_184_DROPLIST_ITEM )
void Node223_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_EMISSIVE )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node75_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node76_DropList_Parameter( Output, Globals ) Output = float( NODE_76_DROPLIST_ITEM )
void Node236_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = emissiveColor; }
void Node233_Float_Parameter( out float Output, ssGlobals Globals ) { Output = emissiveIntensity; }
void Node179_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SIMPLE_REFLECTION )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node226_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node225_Float_Parameter( out float Output, ssGlobals Globals ) { Output = reflectionIntensity; }
void Node177_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( Tweak_N177 )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node228_DropList_Parameter( Output, Globals ) Output = float( NODE_228_DROPLIST_ITEM )
#define Node227_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node74_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_RIM_HIGHLIGHT )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node309_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = rimColor; }
void Node310_Float_Parameter( out float Output, ssGlobals Globals ) { Output = rimIntensity; }
void Node311_Float_Parameter( out float Output, ssGlobals Globals ) { Output = rimExponent; }
void Node216_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( Tweak_N216 )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node312_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_RIM_INVERT )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node314_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node315_DropList_Parameter( Output, Globals ) Output = float( NODE_315_DROPLIST_ITEM )
void Node242_Float_Parameter( out float Output, ssGlobals Globals ) { Output = metallic; }
void Node243_Float_Parameter( out float Output, ssGlobals Globals ) { Output = roughness; }
#define Node220_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node221_DropList_Parameter( Output, Globals ) Output = float( NODE_221_DROPLIST_ITEM )
void Node219_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SPECULAR_AO )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node244_Float_Parameter( out float Output, ssGlobals Globals ) { Output = specularAoIntensity; }
void Node245_Float_Parameter( out float Output, ssGlobals Globals ) { Output = specularAoDarkening; }
void Node67_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_UV2 )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node13_DropList_Parameter( Output, Globals ) Output = float( NODE_13_DROPLIST_ITEM )
void Node14_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv2Scale; }
void Node15_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv2Offset; }
void Node16_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( uv2EnableAnimation )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node11_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_UV3 )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node49_DropList_Parameter( Output, Globals ) Output = float( NODE_49_DROPLIST_ITEM )
void Node50_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv3Scale; }
void Node51_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv3Offset; }
void Node52_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( uv3EnableAnimation )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node7_Code_Node_Uber_PBR( in float VertexColorSwitch, in float4 BaseColorValue, in float EnableBaseTexture, in float BaseTextureUVSwitch, in float EnableRecolor, in float3 RecolorR, in float3 RecolorG, in float3 RecolorB, in float EnableOpacityTexture, in float OpacityUVSwitch, in float EnableNormalTexture, in float NormalUVSwitch, in float EnableDetailNormal, in float Detail_NormalUVSwitch, in float EnableEmissiveTexture, in float EmissiveUVSwitch, in float3 EmissiveColor, in float EmissiveIntensity, in float EnableSimpleReflection, in float ReflectionIntensity, in float EnableModulationTexture, in float ModuationUVSwitch, in float EnableRimHighlight, in float3 RimColor, in float RimIntensity, in float RimExponent, in float EnableRimColorTexture, in float EnableRimInvert, in float RimUVSwitch, in float MetallicValue, in float RoughnessValue, in float MaterialParamsUVSwitch, in float EnableSpecularAO, in float Intensity, in float Darkening, in float EnableUV2, in float UV2Switch, in float2 UV2Scale, in float2 UV2Offset, in float UV2Animation, in float EnableUV3, in float UV3Switch, in float2 UV3Scale, in float2 UV3Offset, in float UV3Animation, out float4 Albedo, out float Opacity, out float3 Normal, out float3 Emissive, out float Metallic, out float Roughness, out float3 AO, out float3 SpecularAO, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	Albedo = vec4( 0.0 );
	Opacity = float( 0.0 );
	Normal = vec3( 0.0 );
	Emissive = vec3( 0.0 );
	Metallic = float( 0.0 );
	Roughness = float( 0.0 );
	AO = vec3( 0.0 );
	SpecularAO = vec3( 0.0 );
	
	
	N7_VertexColorSwitch = int( NODE_38_DROPLIST_ITEM );
	N7_BaseColorValue = BaseColorValue;
	N7_EnableBaseTexture = bool( ENABLE_BASE_TEX );
	N7_BaseTextureUVSwitch = int( NODE_27_DROPLIST_ITEM );
	N7_EnableRecolor = bool( ENABLE_RECOLOR );
	N7_RecolorR = RecolorR;
	N7_RecolorG = RecolorG;
	N7_RecolorB = RecolorB;
	N7_EnableOpacityTexture = bool( ENABLE_OPACITY_TEX );
	N7_OpacityUVSwitch = int( NODE_69_DROPLIST_ITEM );
	N7_EnableNormalTexture = bool( ENABLE_NORMALMAP );
	N7_NormalUVSwitch = int( NODE_181_DROPLIST_ITEM );
	N7_EnableDetailNormal = bool( ENABLE_DETAIL_NORMAL );
	N7_Detail_NormalUVSwitch = int( NODE_184_DROPLIST_ITEM );
	N7_EnableEmissiveTexture = bool( ENABLE_EMISSIVE );
	N7_EmissiveUVSwitch = int( NODE_76_DROPLIST_ITEM );
	N7_EmissiveColor = EmissiveColor;
	N7_EmissiveIntensity = EmissiveIntensity;
	N7_EnableSimpleReflection = bool( ENABLE_SIMPLE_REFLECTION );
	N7_ReflectionIntensity = ReflectionIntensity;
	N7_EnableModulationTexture = bool( Tweak_N177 );
	N7_ModuationUVSwitch = int( NODE_228_DROPLIST_ITEM );
	N7_EnableRimHighlight = bool( ENABLE_RIM_HIGHLIGHT );
	N7_RimColor = RimColor;
	N7_RimIntensity = RimIntensity;
	N7_RimExponent = RimExponent;
	N7_EnableRimColorTexture = bool( Tweak_N216 );
	N7_EnableRimInvert = bool( ENABLE_RIM_INVERT );
	N7_RimUVSwitch = int( NODE_315_DROPLIST_ITEM );
	N7_MetallicValue = MetallicValue;
	N7_RoughnessValue = RoughnessValue;
	N7_MaterialParamsUVSwitch = int( NODE_221_DROPLIST_ITEM );
	N7_EnableSpecularAO = bool( ENABLE_SPECULAR_AO );
	N7_Intensity = Intensity;
	N7_Darkening = Darkening;
	N7_EnableUV2 = bool( ENABLE_UV2 );
	N7_UV2Switch = int( NODE_13_DROPLIST_ITEM );
	N7_UV2Scale = UV2Scale;
	N7_UV2Offset = UV2Offset;
	N7_UV2Animation = bool( uv2EnableAnimation );
	N7_EnableUV3 = bool( ENABLE_UV3 );
	N7_UV3Switch = int( NODE_49_DROPLIST_ITEM );
	N7_UV3Scale = UV3Scale;
	N7_UV3Offset = UV3Offset;
	N7_UV3Animation = bool( uv3EnableAnimation );
	
	N7_main();
	
	Albedo = N7_Albedo;
	Opacity = N7_Opacity;
	Normal = N7_Normal;
	Emissive = N7_Emissive;
	Metallic = N7_Metallic;
	Roughness = N7_Roughness;
	AO = N7_AO;
	SpecularAO = N7_SpecularAO;
}
void Node36_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Normal;
	}
	
	
	Opacity = clamp( Opacity, 0.0, 1.0 ); 		
	
	ngsAlphaTest( Opacity );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if SC_RT_RECEIVER_MODE
	sc_WriteReceiverData( Globals.PositionWS, Globals.BumpedNormal, Roughness );
	#else 
	
	
	Albedo = max( Albedo, 0.0 );	
	
	if ( sc_ProjectiveShadowsCaster )
	{
		Output = float4( Albedo, Opacity );
	}
	else
	{
		Emissive = max( Emissive, 0.0 );	
		
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );	
		
		AO = clamp( AO, vec3( 0.0 ), vec3( 1.0 ) );		
		
		SpecularAO = clamp( SpecularAO, vec3( 0.0 ), vec3( 1.0 ) );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
//-----------------------------------------------------------------------------

void main() 
{
	if (bool(sc_DepthOnly)) {
		return;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if !SC_RT_RECEIVER_MODE
	sc_DiscardStereoFragment();
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	NF_SETUP_PREVIEW_PIXEL()
	#endif
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 FinalColor = float4( 0.0, 0.99144, 1.0, 1.0 );
	
	
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssGlobals Globals;	
	Globals.gTimeElapsed = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	Globals.gTimeDelta   = ( overrideTimeEnabled == 1 ) ? overrideTimeDelta : sc_TimeDelta;
	
	
	#if defined(SC_ENABLE_RT_CASTER) && !SC_RT_RECEIVER_MODE
	if (bool(sc_ProxyMode)) {
		RayHitPayload rhp = GetRayTracingHitData();
		
		if (bool(sc_NoEarlyZ)) {
			if (rhp.id.x != uint(instance_id)) {
				return;
			}
		}
		
		Globals.BumpedNormal               = float3( 0.0 );
		Globals.ViewDirWS                  = rhp.viewDirWS;
		Globals.PositionWS                 = rhp.positionWS;
		Globals.VertexNormal_WorldSpace    = rhp.normalWS;
		Globals.VertexTangent_WorldSpace   = rhp.tangentWS.xyz;
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
		Globals.Surface_UVCoord0           = rhp.uv0;
		Globals.Surface_UVCoord1           = rhp.uv1;
		Globals.VertexColor                = rhp.color;
		
		float4                             emitterPositionCS = ngsViewProjectionMatrix * float4( rhp.positionWS , 1.0 );
		Globals.gScreenCoord               = (emitterPositionCS.xy / emitterPositionCS.w) * 0.5 + 0.5;
		
		Globals.SurfacePosition_WorldSpace = rhp.positionWS;
	} else
	#endif
	
	{
		Globals.BumpedNormal               = float3( 0.0 );
		Globals.ViewDirWS                  = normalize(sc_Camera.position - varPos);
		Globals.PositionWS                 = varPos;
		Globals.VertexNormal_WorldSpace    = normalize( varNormal );
		Globals.VertexTangent_WorldSpace   = normalize( varTangent.xyz );
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.Surface_UVCoord0           = varTex01.xy;
		Globals.Surface_UVCoord1           = varTex01.zw;
		Globals.VertexColor                = varColor;
		
		#ifdef                             VERTEX_SHADER
		
		float4                             Result = ngsViewProjectionMatrix * float4( varPos, 1.0 );
		Result.xyz                         /= Result.w; /* map from clip space to NDC space. keep w around so we can re-project back to world*/
		Globals.gScreenCoord               = Result.xy * 0.5 + 0.5;
		
		#else
		
		Globals.gScreenCoord               = getScreenUV().xy;
		
		#endif
		
		Globals.SurfacePosition_WorldSpace = varPos;
		Globals.ViewDirWS                  = normalize( ngsCameraPosition - Globals.SurfacePosition_WorldSpace );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float Output_N38 = 0.0; Node38_DropList_Parameter( Output_N38, Globals );
		float4 Output_N5 = float4(0.0); Node5_Color_Parameter( Output_N5, Globals );
		float Output_N121 = 0.0; Node121_Bool_Parameter( Output_N121, Globals );
		Node28_Texture_2D_Object_Parameter( Globals );
		float Output_N27 = 0.0; Node27_DropList_Parameter( Output_N27, Globals );
		float Output_N37 = 0.0; Node37_Bool_Parameter( Output_N37, Globals );
		float3 Output_N85 = float3(0.0); Node85_Color_Parameter( Output_N85, Globals );
		float3 Output_N86 = float3(0.0); Node86_Color_Parameter( Output_N86, Globals );
		float3 Output_N87 = float3(0.0); Node87_Color_Parameter( Output_N87, Globals );
		float Output_N308 = 0.0; Node308_Bool_Parameter( Output_N308, Globals );
		Node68_Texture_2D_Object_Parameter( Globals );
		float Output_N69 = 0.0; Node69_DropList_Parameter( Output_N69, Globals );
		float Output_N354 = 0.0; Node354_Bool_Parameter( Output_N354, Globals );
		Node180_Texture_2D_Object_Parameter( Globals );
		float Output_N181 = 0.0; Node181_DropList_Parameter( Output_N181, Globals );
		float Output_N218 = 0.0; Node218_Bool_Parameter( Output_N218, Globals );
		Node183_Texture_2D_Object_Parameter( Globals );
		float Output_N184 = 0.0; Node184_DropList_Parameter( Output_N184, Globals );
		float Output_N223 = 0.0; Node223_Bool_Parameter( Output_N223, Globals );
		Node75_Texture_2D_Object_Parameter( Globals );
		float Output_N76 = 0.0; Node76_DropList_Parameter( Output_N76, Globals );
		float3 Output_N236 = float3(0.0); Node236_Color_Parameter( Output_N236, Globals );
		float Output_N233 = 0.0; Node233_Float_Parameter( Output_N233, Globals );
		float Output_N179 = 0.0; Node179_Bool_Parameter( Output_N179, Globals );
		Node226_Texture_2D_Object_Parameter( Globals );
		float Output_N225 = 0.0; Node225_Float_Parameter( Output_N225, Globals );
		float Output_N177 = 0.0; Node177_Bool_Parameter( Output_N177, Globals );
		float Output_N228 = 0.0; Node228_DropList_Parameter( Output_N228, Globals );
		Node227_Texture_2D_Object_Parameter( Globals );
		float Output_N74 = 0.0; Node74_Bool_Parameter( Output_N74, Globals );
		float3 Output_N309 = float3(0.0); Node309_Color_Parameter( Output_N309, Globals );
		float Output_N310 = 0.0; Node310_Float_Parameter( Output_N310, Globals );
		float Output_N311 = 0.0; Node311_Float_Parameter( Output_N311, Globals );
		float Output_N216 = 0.0; Node216_Bool_Parameter( Output_N216, Globals );
		float Output_N312 = 0.0; Node312_Bool_Parameter( Output_N312, Globals );
		Node314_Texture_2D_Object_Parameter( Globals );
		float Output_N315 = 0.0; Node315_DropList_Parameter( Output_N315, Globals );
		float Output_N242 = 0.0; Node242_Float_Parameter( Output_N242, Globals );
		float Output_N243 = 0.0; Node243_Float_Parameter( Output_N243, Globals );
		Node220_Texture_2D_Object_Parameter( Globals );
		float Output_N221 = 0.0; Node221_DropList_Parameter( Output_N221, Globals );
		float Output_N219 = 0.0; Node219_Bool_Parameter( Output_N219, Globals );
		float Output_N244 = 0.0; Node244_Float_Parameter( Output_N244, Globals );
		float Output_N245 = 0.0; Node245_Float_Parameter( Output_N245, Globals );
		float Output_N67 = 0.0; Node67_Bool_Parameter( Output_N67, Globals );
		float Output_N13 = 0.0; Node13_DropList_Parameter( Output_N13, Globals );
		float2 Output_N14 = float2(0.0); Node14_Float_Parameter( Output_N14, Globals );
		float2 Output_N15 = float2(0.0); Node15_Float_Parameter( Output_N15, Globals );
		float Output_N16 = 0.0; Node16_Bool_Parameter( Output_N16, Globals );
		float Output_N11 = 0.0; Node11_Bool_Parameter( Output_N11, Globals );
		float Output_N49 = 0.0; Node49_DropList_Parameter( Output_N49, Globals );
		float2 Output_N50 = float2(0.0); Node50_Float_Parameter( Output_N50, Globals );
		float2 Output_N51 = float2(0.0); Node51_Float_Parameter( Output_N51, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float4 Albedo_N7 = float4(0.0); float Opacity_N7 = 0.0; float3 Normal_N7 = float3(0.0); float3 Emissive_N7 = float3(0.0); float Metallic_N7 = 0.0; float Roughness_N7 = 0.0; float3 AO_N7 = float3(0.0); float3 SpecularAO_N7 = float3(0.0); Node7_Code_Node_Uber_PBR( Output_N38, Output_N5, Output_N121, Output_N27, Output_N37, Output_N85, Output_N86, Output_N87, Output_N308, Output_N69, Output_N354, Output_N181, Output_N218, Output_N184, Output_N223, Output_N76, Output_N236, Output_N233, Output_N179, Output_N225, Output_N177, Output_N228, Output_N74, Output_N309, Output_N310, Output_N311, Output_N216, Output_N312, Output_N315, Output_N242, Output_N243, Output_N221, Output_N219, Output_N244, Output_N245, Output_N67, Output_N13, Output_N14, Output_N15, Output_N16, Output_N11, Output_N49, Output_N50, Output_N51, Output_N52, Albedo_N7, Opacity_N7, Normal_N7, Emissive_N7, Metallic_N7, Roughness_N7, AO_N7, SpecularAO_N7, Globals );
		float4 Output_N36 = float4(0.0); Node36_PBR_Lighting( Albedo_N7.xyz, Opacity_N7, Normal_N7, Emissive_N7, Metallic_N7, Roughness_N7, AO_N7, SpecularAO_N7, Output_N36, Globals );
		
		FinalColor = Output_N36;
	}
	
	#if SC_RT_RECEIVER_MODE
	
	#else
	
	
	
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	#if defined(SC_ENABLE_RT_CASTER) && !SC_RT_RECEIVER_MODE
	if (bool(sc_ProxyMode)) {
		sc_writeFragData0( encodeReflection( FinalColor ) );
		return;
	}
	#endif
	
	FinalColor = ngsPixelShader( FinalColor );
	
	NF_PREVIEW_OUTPUT_PIXEL()
	
	#ifdef STUDIO
	vec4 Cost = getPixelRenderingCost();
	if ( Cost.w > 0.0 )
	FinalColor = Cost;
	#endif
	
	FinalColor = max( FinalColor, 0.0 );
	FinalColor = outputMotionVectorsIfNeeded(varPos, FinalColor);
	processOIT( FinalColor );
	
	#endif
}

#endif // #ifdef FRAGMENT_SHADER
