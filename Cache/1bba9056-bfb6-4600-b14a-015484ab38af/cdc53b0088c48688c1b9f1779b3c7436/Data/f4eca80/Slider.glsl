#version 310 es

//-----------------------------------------------------------------------
// Copyright (c) 2019 Snap Inc.
//-----------------------------------------------------------------------

// NGS_SHADER_FLAGS_BEGIN__
// NGS_SHADER_FLAGS_END__

#pragma paste_to_backend_at_the_top_begin
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_FLAG_IS_NORMAL_MAP normalTex
NGS_FLAG_IS_NORMAL_MAP detailNormalTex
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
#define ENABLE_SPECULAR_LIGHTING false
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
SPEC_CONST(bool) ENABLE_RECOLOR = false;
SPEC_CONST(bool) ENABLE_BASE_TEX = false;
SPEC_CONST(int) NODE_27_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_UV2 = false;
SPEC_CONST(bool) ENABLE_UV2_ANIMATION = false;
SPEC_CONST(int) NODE_13_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_UV3 = false;
SPEC_CONST(bool) ENABLE_UV3_ANIMATION = false;
SPEC_CONST(int) NODE_49_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_OPACITY_TEX = false;
SPEC_CONST(int) NODE_69_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_NORMALMAP = false;
SPEC_CONST(int) NODE_181_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_DETAIL_NORMAL = false;
SPEC_CONST(int) NODE_184_DROPLIST_ITEM = 0;


// Material Parameters ( Tweaks )

uniform NF_PRECISION                    float3 recolorRed; // Title: Recolor Red
uniform NF_PRECISION                    float  Level; // Title: Level
uniform NF_PRECISION                    float4 innerColor1; // Title: Inner Color 1
uniform NF_PRECISION                    float4 innerColor2; // Title: Inner Color 2
uniform NF_PRECISION                    float4 outerColor1; // Title: Outer Color 1
uniform NF_PRECISION                    float4 outerColor2; // Title: Outer Color 2
SC_DECLARE_TEXTURE(baseTex); //         Title: Texture
uniform NF_PRECISION                    float2 uv2Scale; // Title: Scale
uniform NF_PRECISION                    float2 uv2Offset; // Title: Offset
uniform NF_PRECISION                    float2 uv3Scale; // Title: Scale
uniform NF_PRECISION                    float2 uv3Offset; // Title: Offset
uniform NF_PRECISION                    float3 recolorGreen; // Title: Recolor Green
uniform NF_PRECISION                    float3 recolorBlue; // Title: Recolor Blue
SC_DECLARE_TEXTURE(opacityTex); //      Title: Texture
SC_DECLARE_TEXTURE(normalTex); //       Title: Texture
SC_DECLARE_TEXTURE(detailNormalTex); // Title: Texture
uniform NF_PRECISION                    float  innerColorMultiplier; // Title: Inner Color Multiplier
uniform NF_PRECISION                    float  outerColorMultiplier; // Title: Outer Color Multiplier	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float4 Port_Import_N042;
uniform NF_PRECISION float Port_Input1_N044;
uniform NF_PRECISION float Port_Import_N088;
uniform NF_PRECISION float3 Port_Import_N089;
uniform NF_PRECISION float4 Port_Import_N384;
uniform NF_PRECISION float Port_Import_N307;
uniform NF_PRECISION float Port_Import_N201;
uniform NF_PRECISION float Port_Import_N012;
uniform NF_PRECISION float Port_Import_N010;
uniform NF_PRECISION float Port_Import_N007;
uniform NF_PRECISION float2 Port_Import_N008;
uniform NF_PRECISION float2 Port_Import_N009;
uniform NF_PRECISION float Port_Speed_N022;
uniform NF_PRECISION float2 Port_Import_N254;
uniform NF_PRECISION float Port_Import_N065;
uniform NF_PRECISION float Port_Import_N055;
uniform NF_PRECISION float Port_Import_N056;
uniform NF_PRECISION float2 Port_Import_N000;
uniform NF_PRECISION float2 Port_Import_N060;
uniform NF_PRECISION float2 Port_Import_N061;
uniform NF_PRECISION float Port_Speed_N063;
uniform NF_PRECISION float2 Port_Import_N255;
uniform NF_PRECISION float4 Port_Default_N369;
uniform NF_PRECISION float4 Port_Import_N092;
uniform NF_PRECISION float3 Port_Import_N090;
uniform NF_PRECISION float3 Port_Import_N091;
uniform NF_PRECISION float3 Port_Import_N144;
uniform NF_PRECISION float Port_Value2_N073;
uniform NF_PRECISION float4 Port_Import_N166;
uniform NF_PRECISION float Port_Import_N206;
uniform NF_PRECISION float Port_Import_N043;
uniform NF_PRECISION float2 Port_Import_N151;
uniform NF_PRECISION float2 Port_Import_N155;
uniform NF_PRECISION float Port_Default_N204;
uniform NF_PRECISION float Port_Import_N047;
uniform NF_PRECISION float Port_Input1_N002;
uniform NF_PRECISION float Port_Input2_N072;
uniform NF_PRECISION float Port_Import_N336;
uniform NF_PRECISION float Port_Import_N160;
uniform NF_PRECISION float2 Port_Import_N167;
uniform NF_PRECISION float2 Port_Import_N207;
uniform NF_PRECISION float Port_Strength1_N200;
uniform NF_PRECISION float Port_Import_N095;
uniform NF_PRECISION float Port_Import_N108;
uniform NF_PRECISION float3 Port_Default_N113;
uniform NF_PRECISION float Port_Strength2_N200;
uniform NF_PRECISION float3 Port_Emissive_N036;
uniform NF_PRECISION float3 Port_AO_N036;
#endif	



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
	
	float3 BumpedNormal;
	float3 ViewDirWS;
	float3 PositionWS;
	float4 VertexColor;
	float2 Surface_UVCoord0;
	float2 Surface_UVCoord1;
	float2 gScreenCoord;
	float3 VertexTangent_WorldSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexBinormal_WorldSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node38_DropList_Parameter( Output, Globals ) Output = float( NODE_38_DROPLIST_ITEM )
#define Node42_Float_Import( Import, Value, Globals ) Value = Import
#define Node44_Is_Equal( Input0, Input1, Output, Globals ) Output = ssEqual( Input0, Input1 )
#define Node45_Surface_Color( Color, Globals ) Color = Globals.VertexColor
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
#define Node88_Float_Import( Import, Value, Globals ) Value = Import
void Node85_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorRed; }
#define Node89_Float_Import( Import, Value, Globals ) Value = Import
#define Node66_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node76_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
void Node74_Float_Parameter( out float Output, ssGlobals Globals ) { Output = Level; }
#define Node75_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
void Node5_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = innerColor1; }
void Node79_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = innerColor2; }
#define Node81_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node57_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = outerColor1; }
void Node77_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = outerColor2; }
#define Node78_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node70_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	/* Input port: "Input0"  */
	
	{
		float2 UVCoord_N66 = float2(0.0); Node66_Surface_UV_Coord( UVCoord_N66, Globals );
		float Value1_N76 = 0.0; float Value2_N76 = 0.0; Node76_Split_Vector( UVCoord_N66, Value1_N76, Value2_N76, Globals );
		float Output_N74 = 0.0; Node74_Float_Parameter( Output_N74, Globals );
		float Output_N75 = 0.0; Node75_Is_Less( Value1_N76, Output_N74, Output_N75, Globals );
		
		Input0 = Output_N75;
	}
	
	if ( bool( Input0 * 1.0 != 0.0 ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Output_N5 = float4(0.0); Node5_Color_Parameter( Output_N5, Globals );
			float4 Output_N79 = float4(0.0); Node79_Color_Parameter( Output_N79, Globals );
			float2 UVCoord_N66 = float2(0.0); Node66_Surface_UV_Coord( UVCoord_N66, Globals );
			float Value1_N76 = 0.0; float Value2_N76 = 0.0; Node76_Split_Vector( UVCoord_N66, Value1_N76, Value2_N76, Globals );
			float4 Output_N81 = float4(0.0); Node81_Mix( Output_N5, Output_N79, Value2_N76, Output_N81, Globals );
			
			Input1 = Output_N81;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float4 Output_N57 = float4(0.0); Node57_Color_Parameter( Output_N57, Globals );
			float4 Output_N77 = float4(0.0); Node77_Color_Parameter( Output_N77, Globals );
			float2 UVCoord_N66 = float2(0.0); Node66_Surface_UV_Coord( UVCoord_N66, Globals );
			float Value1_N76 = 0.0; float Value2_N76 = 0.0; Node76_Split_Vector( UVCoord_N66, Value1_N76, Value2_N76, Globals );
			float4 Output_N78 = float4(0.0); Node78_Mix( Output_N57, Output_N77, Value2_N76, Output_N78, Globals );
			
			Input2 = Output_N78;
		}
		Output = Input2; 
	}
}
#define Node384_Float_Import( Import, Value, Globals ) Value = Import
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
#define Node307_Float_Import( Import, Value, Globals ) Value = Import
#define Node28_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node199_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node27_DropList_Parameter( Output, Globals ) Output = float( NODE_27_DROPLIST_ITEM )
#define Node201_Float_Import( Import, Value, Globals ) Value = Import
#define Node386_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node32_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
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
#define Node12_Float_Import( Import, Value, Globals ) Value = Import
void Node16_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_UV2_ANIMATION )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node10_Float_Import( Import, Value, Globals ) Value = Import
#define Node13_DropList_Parameter( Output, Globals ) Output = float( NODE_13_DROPLIST_ITEM )
#define Node7_Float_Import( Import, Value, Globals ) Value = Import
#define Node18_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node31_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
#define Node20_Screen_UV_Coord( ScreenCoord, Globals ) ScreenCoord = Globals.gScreenCoord
void Node17_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_13_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N18 = float2(0.0); Node18_Surface_UV_Coord( UVCoord_N18, Globals );
			
			Value0 = UVCoord_N18;
		}
		Result = Value0;
	}
	else if ( int( NODE_13_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N31 = float2(0.0); Node31_Surface_UV_Coord( UVCoord_N31, Globals );
			
			Value1 = UVCoord_N31;
		}
		Result = Value1;
	}
	else if ( int( NODE_13_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 ScreenCoord_N20 = float2(0.0); Node20_Screen_UV_Coord( ScreenCoord_N20, Globals );
			
			Value2 = ScreenCoord_N20;
		}
		Result = Value2;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N18 = float2(0.0); Node18_Surface_UV_Coord( UVCoord_N18, Globals );
			
			Default = UVCoord_N18;
		}
		Result = Default;
	}
}
void Node14_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv2Scale; }
#define Node8_Float_Import( Import, Value, Globals ) Value = Import
void Node15_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv2Offset; }
#define Node9_Float_Import( Import, Value, Globals ) Value = Import
#define Node21_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node22_Scroll_Coords( CoordsIn, Direction, Speed, CoordsOut, Globals ) CoordsOut = CoordsIn + ( Globals.gTimeElapsed * Speed * Direction )
void Node122_If_else( in float Bool1, in float2 Value1, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_UV2_ANIMATION ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 Result_N17 = float2(0.0); Node17_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N17, Globals );
			float2 Output_N14 = float2(0.0); Node14_Float_Parameter( Output_N14, Globals );
			float2 Value_N8 = float2(0.0); Node8_Float_Import( Output_N14, Value_N8, Globals );
			float2 Output_N15 = float2(0.0); Node15_Float_Parameter( Output_N15, Globals );
			float2 Value_N9 = float2(0.0); Node9_Float_Import( Output_N15, Value_N9, Globals );
			float2 Output_N21 = float2(0.0); Node21_Scale_and_Offset( Result_N17, Value_N8, Value_N9, Output_N21, Globals );
			float2 CoordsOut_N22 = float2(0.0); Node22_Scroll_Coords( Output_N21, Value_N9, NF_PORT_CONSTANT( float( 1.0 ), Port_Speed_N022 ), CoordsOut_N22, Globals );
			
			Value1 = CoordsOut_N22;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 Result_N17 = float2(0.0); Node17_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N17, Globals );
			float2 Output_N14 = float2(0.0); Node14_Float_Parameter( Output_N14, Globals );
			float2 Value_N8 = float2(0.0); Node8_Float_Import( Output_N14, Value_N8, Globals );
			float2 Output_N15 = float2(0.0); Node15_Float_Parameter( Output_N15, Globals );
			float2 Value_N9 = float2(0.0); Node9_Float_Import( Output_N15, Value_N9, Globals );
			float2 Output_N21 = float2(0.0); Node21_Scale_and_Offset( Result_N17, Value_N8, Value_N9, Output_N21, Globals );
			
			Default = Output_N21;
		}
		Result = Default;
	}
}
void Node1_If_else( in float Bool1, in float2 Value1, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_UV2 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 Result_N122 = float2(0.0); Node122_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N122, Globals );
			
			Value1 = Result_N122;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N18 = float2(0.0); Node18_Surface_UV_Coord( UVCoord_N18, Globals );
			
			Default = UVCoord_N18;
		}
		Result = Default;
	}
}
#define Node23_Float_Export( Value, Export, Globals ) Export = Value
#define Node254_Float_Import( Import, Value, Globals ) Value = Import
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
#define Node65_Float_Import( Import, Value, Globals ) Value = Import
void Node52_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_UV3_ANIMATION )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node55_Float_Import( Import, Value, Globals ) Value = Import
#define Node49_DropList_Parameter( Output, Globals ) Output = float( NODE_49_DROPLIST_ITEM )
#define Node56_Float_Import( Import, Value, Globals ) Value = Import
#define Node54_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node19_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
#define Node58_Screen_UV_Coord( ScreenCoord, Globals ) ScreenCoord = Globals.gScreenCoord
#define Node0_Float_Import( Import, Value, Globals ) Value = Import
void Node59_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Value3, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_49_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N54 = float2(0.0); Node54_Surface_UV_Coord( UVCoord_N54, Globals );
			
			Value0 = UVCoord_N54;
		}
		Result = Value0;
	}
	else if ( int( NODE_49_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N19 = float2(0.0); Node19_Surface_UV_Coord( UVCoord_N19, Globals );
			
			Value1 = UVCoord_N19;
		}
		Result = Value1;
	}
	else if ( int( NODE_49_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 ScreenCoord_N58 = float2(0.0); Node58_Screen_UV_Coord( ScreenCoord_N58, Globals );
			
			Value2 = ScreenCoord_N58;
		}
		Result = Value2;
	}
	else if ( int( NODE_49_DROPLIST_ITEM ) == 3 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 Result_N1 = float2(0.0); Node1_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N1, Globals );
			float2 Export_N23 = float2(0.0); Node23_Float_Export( Result_N1, Export_N23, Globals );
			float2 Value_N0 = float2(0.0); Node0_Float_Import( Export_N23, Value_N0, Globals );
			
			Value3 = Value_N0;
		}
		Result = Value3;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N54 = float2(0.0); Node54_Surface_UV_Coord( UVCoord_N54, Globals );
			
			Default = UVCoord_N54;
		}
		Result = Default;
	}
}
void Node50_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv3Scale; }
#define Node60_Float_Import( Import, Value, Globals ) Value = Import
void Node51_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = uv3Offset; }
#define Node61_Float_Import( Import, Value, Globals ) Value = Import
#define Node62_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node63_Scroll_Coords( CoordsIn, Direction, Speed, CoordsOut, Globals ) CoordsOut = CoordsIn + ( Globals.gTimeElapsed * Speed * Direction )
void Node64_If_else( in float Bool1, in float2 Value1, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_UV3_ANIMATION ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 Result_N59 = float2(0.0); Node59_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N59, Globals );
			float2 Output_N50 = float2(0.0); Node50_Float_Parameter( Output_N50, Globals );
			float2 Value_N60 = float2(0.0); Node60_Float_Import( Output_N50, Value_N60, Globals );
			float2 Output_N51 = float2(0.0); Node51_Float_Parameter( Output_N51, Globals );
			float2 Value_N61 = float2(0.0); Node61_Float_Import( Output_N51, Value_N61, Globals );
			float2 Output_N62 = float2(0.0); Node62_Scale_and_Offset( Result_N59, Value_N60, Value_N61, Output_N62, Globals );
			float2 CoordsOut_N63 = float2(0.0); Node63_Scroll_Coords( Output_N62, Value_N61, NF_PORT_CONSTANT( float( 1.0 ), Port_Speed_N063 ), CoordsOut_N63, Globals );
			
			Value1 = CoordsOut_N63;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 Result_N59 = float2(0.0); Node59_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N59, Globals );
			float2 Output_N50 = float2(0.0); Node50_Float_Parameter( Output_N50, Globals );
			float2 Value_N60 = float2(0.0); Node60_Float_Import( Output_N50, Value_N60, Globals );
			float2 Output_N51 = float2(0.0); Node51_Float_Parameter( Output_N51, Globals );
			float2 Value_N61 = float2(0.0); Node61_Float_Import( Output_N51, Value_N61, Globals );
			float2 Output_N62 = float2(0.0); Node62_Scale_and_Offset( Result_N59, Value_N60, Value_N61, Output_N62, Globals );
			
			Default = Output_N62;
		}
		Result = Default;
	}
}
void Node24_If_else( in float Bool1, in float2 Value1, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_UV3 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 Result_N64 = float2(0.0); Node64_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N64, Globals );
			
			Value1 = Result_N64;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N54 = float2(0.0); Node54_Surface_UV_Coord( UVCoord_N54, Globals );
			
			Default = UVCoord_N54;
		}
		Result = Default;
	}
}
#define Node125_Float_Export( Value, Export, Globals ) Export = Value
#define Node255_Float_Import( Import, Value, Globals ) Value = Import
void Node388_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Value3, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_27_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N386 = float2(0.0); Node386_Surface_UV_Coord( UVCoord_N386, Globals );
			
			Value0 = UVCoord_N386;
		}
		Result = Value0;
	}
	else if ( int( NODE_27_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N32 = float2(0.0); Node32_Surface_UV_Coord( UVCoord_N32, Globals );
			
			Value1 = UVCoord_N32;
		}
		Result = Value1;
	}
	else if ( int( NODE_27_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 Result_N1 = float2(0.0); Node1_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N1, Globals );
			float2 Export_N23 = float2(0.0); Node23_Float_Export( Result_N1, Export_N23, Globals );
			float2 Value_N254 = float2(0.0); Node254_Float_Import( Export_N23, Value_N254, Globals );
			
			Value2 = Value_N254;
		}
		Result = Value2;
	}
	else if ( int( NODE_27_DROPLIST_ITEM ) == 3 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 Result_N24 = float2(0.0); Node24_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N24, Globals );
			float2 Export_N125 = float2(0.0); Node125_Float_Export( Result_N24, Export_N125, Globals );
			float2 Value_N255 = float2(0.0); Node255_Float_Import( Export_N125, Value_N255, Globals );
			
			Value3 = Value_N255;
		}
		Result = Value3;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N386 = float2(0.0); Node386_Surface_UV_Coord( UVCoord_N386, Globals );
			
			Default = UVCoord_N386;
		}
		Result = Default;
	}
}
#define Node25_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(baseTex, UVCoord, 0.0)
void Node369_If_else( in float Bool1, in float4 Value1, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_BASE_TEX ) )
	{
		/* Input port: "Value1"  */
		
		{
			Node28_Texture_2D_Object_Parameter( Globals );
			Node199_Texture_Object_2D_Import( Globals );
			float2 Result_N388 = float2(0.0); Node388_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N388, Globals );
			float4 Color_N25 = float4(0.0); Node25_Texture_2D_Sample( Result_N388, Color_N25, Globals );
			
			Value1 = Color_N25;
		}
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node148_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node385_Float_Export( Value, Export, Globals ) Export = Value
#define Node92_Float_Import( Import, Value, Globals ) Value = Import
void Node94_Split_Vector( in float3 Value, out float Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.r;
	Value2 = Value.g;
	Value3 = Value.b;
}
#define Node98_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
void Node86_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorGreen; }
#define Node90_Float_Import( Import, Value, Globals ) Value = Import
#define Node99_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
void Node87_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = recolorBlue; }
#define Node91_Float_Import( Import, Value, Globals ) Value = Import
#define Node100_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node101_Add( Input0, Input1, Input2, Output, Globals ) Output = Input0 + Input1 + Input2
void Node80_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_RECOLOR ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Output_N85 = float3(0.0); Node85_Color_Parameter( Output_N85, Globals );
			float3 Value_N89 = float3(0.0); Node89_Float_Import( Output_N85, Value_N89, Globals );
			float4 Output_N70 = float4(0.0); Node70_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Output_N70, Globals );
			float4 Value_N384 = float4(0.0); Node384_Float_Import( Output_N70, Value_N384, Globals );
			float4 Result_N369 = float4(0.0); Node369_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Default_N369 ), Result_N369, Globals );
			float4 Output_N148 = float4(0.0); Node148_Multiply( Value_N384, Result_N369, Output_N148, Globals );
			float4 Export_N385 = float4(0.0); Node385_Float_Export( Output_N148, Export_N385, Globals );
			float4 Value_N92 = float4(0.0); Node92_Float_Import( Export_N385, Value_N92, Globals );
			float Value1_N94 = 0.0; float Value2_N94 = 0.0; float Value3_N94 = 0.0; Node94_Split_Vector( Value_N92.xyz, Value1_N94, Value2_N94, Value3_N94, Globals );
			float3 Output_N98 = float3(0.0); Node98_Multiply( Value_N89, Value1_N94, Output_N98, Globals );
			float3 Output_N86 = float3(0.0); Node86_Color_Parameter( Output_N86, Globals );
			float3 Value_N90 = float3(0.0); Node90_Float_Import( Output_N86, Value_N90, Globals );
			float3 Output_N99 = float3(0.0); Node99_Multiply( Value_N90, Value2_N94, Output_N99, Globals );
			float3 Output_N87 = float3(0.0); Node87_Color_Parameter( Output_N87, Globals );
			float3 Value_N91 = float3(0.0); Node91_Float_Import( Output_N87, Value_N91, Globals );
			float3 Output_N100 = float3(0.0); Node100_Multiply( Value_N91, Value3_N94, Output_N100, Globals );
			float3 Output_N101 = float3(0.0); Node101_Add( Output_N98, Output_N99, Output_N100, Output_N101, Globals );
			
			Value1 = Output_N101;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float4 Output_N70 = float4(0.0); Node70_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Output_N70, Globals );
			float4 Value_N384 = float4(0.0); Node384_Float_Import( Output_N70, Value_N384, Globals );
			float4 Result_N369 = float4(0.0); Node369_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Default_N369 ), Result_N369, Globals );
			float4 Output_N148 = float4(0.0); Node148_Multiply( Value_N384, Result_N369, Output_N148, Globals );
			float4 Export_N385 = float4(0.0); Node385_Float_Export( Output_N148, Export_N385, Globals );
			float4 Value_N92 = float4(0.0); Node92_Float_Import( Export_N385, Value_N92, Globals );
			
			Default = Value_N92.xyz;
		}
		Result = Default;
	}
}
#define Node93_Float_Export( Value, Export, Globals ) Export = Value
#define Node144_Float_Import( Import, Value, Globals ) Value = Import
#define Node73_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node362_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node363_If_else( in float Bool1, in float4 Value1, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( bool( ( int( NODE_38_DROPLIST_ITEM ) == int( 1 ) ) ) )
	{
		/* Input port: "Value1"  */
		
		{
			float4 Color_N45 = float4(0.0); Node45_Surface_Color( Color_N45, Globals );
			float3 Result_N80 = float3(0.0); Node80_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), Result_N80, Globals );
			float3 Export_N93 = float3(0.0); Node93_Float_Export( Result_N80, Export_N93, Globals );
			float3 Value_N144 = float3(0.0); Node144_Float_Import( Export_N93, Value_N144, Globals );
			float4 Value_N73 = float4(0.0); Node73_Construct_Vector( Value_N144, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N073 ), Value_N73, Globals );
			float4 Output_N362 = float4(0.0); Node362_Multiply( Color_N45, Value_N73, Output_N362, Globals );
			
			Value1 = Output_N362;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Result_N80 = float3(0.0); Node80_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), Result_N80, Globals );
			float3 Export_N93 = float3(0.0); Node93_Float_Export( Result_N80, Export_N93, Globals );
			float3 Value_N144 = float3(0.0); Node144_Float_Import( Export_N93, Value_N144, Globals );
			float4 Value_N73 = float4(0.0); Node73_Construct_Vector( Value_N144, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N073 ), Value_N73, Globals );
			
			Default = Value_N73;
		}
		Result = Default;
	}
}
#define Node364_Float_Export( Value, Export, Globals ) Export = Value
#define Node166_Float_Import( Import, Value, Globals ) Value = Import
#define Node168_Swizzle( Input, Output, Globals ) Output = Input.a
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
#define Node206_Float_Import( Import, Value, Globals ) Value = Import
#define Node68_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node40_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node69_DropList_Parameter( Output, Globals ) Output = float( NODE_69_DROPLIST_ITEM )
#define Node43_Float_Import( Import, Value, Globals ) Value = Import
#define Node48_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node33_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
#define Node151_Float_Import( Import, Value, Globals ) Value = Import
#define Node155_Float_Import( Import, Value, Globals ) Value = Import
void Node156_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Value3, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_69_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N48 = float2(0.0); Node48_Surface_UV_Coord( UVCoord_N48, Globals );
			
			Value0 = UVCoord_N48;
		}
		Result = Value0;
	}
	else if ( int( NODE_69_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N33 = float2(0.0); Node33_Surface_UV_Coord( UVCoord_N33, Globals );
			
			Value1 = UVCoord_N33;
		}
		Result = Value1;
	}
	else if ( int( NODE_69_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 Result_N1 = float2(0.0); Node1_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N1, Globals );
			float2 Export_N23 = float2(0.0); Node23_Float_Export( Result_N1, Export_N23, Globals );
			float2 Value_N151 = float2(0.0); Node151_Float_Import( Export_N23, Value_N151, Globals );
			
			Value2 = Value_N151;
		}
		Result = Value2;
	}
	else if ( int( NODE_69_DROPLIST_ITEM ) == 3 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 Result_N24 = float2(0.0); Node24_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N24, Globals );
			float2 Export_N125 = float2(0.0); Node125_Float_Export( Result_N24, Export_N125, Globals );
			float2 Value_N155 = float2(0.0); Node155_Float_Import( Export_N125, Value_N155, Globals );
			
			Value3 = Value_N155;
		}
		Result = Value3;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N48 = float2(0.0); Node48_Surface_UV_Coord( UVCoord_N48, Globals );
			
			Default = UVCoord_N48;
		}
		Result = Default;
	}
}
#define Node26_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(opacityTex, UVCoord, 0.0)
#define Node203_Swizzle( Input, Output, Globals ) Output = Input
void Node204_If_else( in float Bool1, in float Value1, in float Default, out float Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_OPACITY_TEX ) )
	{
		/* Input port: "Value1"  */
		
		{
			Node68_Texture_2D_Object_Parameter( Globals );
			Node40_Texture_Object_2D_Import( Globals );
			float2 Result_N156 = float2(0.0); Node156_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N156, Globals );
			float4 Color_N26 = float4(0.0); Node26_Texture_2D_Sample( Result_N156, Color_N26, Globals );
			float Output_N203 = 0.0; Node203_Swizzle( Color_N26.x, Output_N203, Globals );
			
			Value1 = Output_N203;
		}
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node47_Float_Import( Import, Value, Globals ) Value = Import
#define Node2_Is_Equal( Input0, Input1, Output, Globals ) Output = ssEqual( Input0, Input1 )
#define Node84_Surface_Color( Color, Globals ) Color = Globals.VertexColor
#define Node96_Swizzle( Input, Output, Globals ) Output = Input.a
void Node72_Conditional( in float Input0, in float Input1, in float Input2, out float Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N38 = 0.0; Node38_DropList_Parameter( Output_N38, Globals );
		float Value_N47 = 0.0; Node47_Float_Import( Output_N38, Value_N47, Globals );
		float Output_N2 = 0.0; Node2_Is_Equal( Value_N47, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N002 ), Output_N2, Globals );
		
		Input0 = Output_N2;
	}
	#endif
	
	if ( bool( ( int( NODE_38_DROPLIST_ITEM ) == int( 1 ) ) ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Color_N84 = float4(0.0); Node84_Surface_Color( Color_N84, Globals );
			float Output_N96 = 0.0; Node96_Swizzle( Color_N84, Output_N96, Globals );
			
			Input1 = Output_N96;
		}
		Output = Input1; 
	} 
	else 
	{ 
		
		Output = Input2; 
	}
}
#define Node205_Multiply( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 * Input2
#define Node158_Float_Export( Value, Export, Globals ) Export = Value
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
#define Node336_Float_Import( Import, Value, Globals ) Value = Import
#define Node194_Surface_Tangent( Tangent, Globals ) Tangent = Globals.VertexTangent_WorldSpace
#define Node193_Surface_Bitangent( Binormal, Globals ) Binormal = Globals.VertexBinormal_WorldSpace
#define Node330_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_WorldSpace
#define Node333_Construct_Matrix( Column0, Column1, Column2, Matrix, Globals ) Matrix = mat3( Column0, Column1, Column2 )
float3 ngs_CombineNormals( float3 Normal1, float Strength1, float3 Normal2, float Strength2 )
{
	float3 t = mix( vec3( 0.0, 0.0, 1.0 ), Normal1, Strength1 ) + float3( 0.0, 0.0, 1.0 );
	float3 u = mix( vec3( 0.0, 0.0, 1.0 ), Normal2, Strength2 ) * float3( -1.0, -1.0, 1.0 );
	return normalize( t * dot( t, u ) - u * t.z );
}
#define Node180_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node159_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node181_DropList_Parameter( Output, Globals ) Output = float( NODE_181_DROPLIST_ITEM )
#define Node160_Float_Import( Import, Value, Globals ) Value = Import
#define Node162_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node35_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
#define Node167_Float_Import( Import, Value, Globals ) Value = Import
#define Node207_Float_Import( Import, Value, Globals ) Value = Import
void Node208_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Value3, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_181_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N162 = float2(0.0); Node162_Surface_UV_Coord( UVCoord_N162, Globals );
			
			Value0 = UVCoord_N162;
		}
		Result = Value0;
	}
	else if ( int( NODE_181_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N35 = float2(0.0); Node35_Surface_UV_Coord( UVCoord_N35, Globals );
			
			Value1 = UVCoord_N35;
		}
		Result = Value1;
	}
	else if ( int( NODE_181_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 Result_N1 = float2(0.0); Node1_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N1, Globals );
			float2 Export_N23 = float2(0.0); Node23_Float_Export( Result_N1, Export_N23, Globals );
			float2 Value_N167 = float2(0.0); Node167_Float_Import( Export_N23, Value_N167, Globals );
			
			Value2 = Value_N167;
		}
		Result = Value2;
	}
	else if ( int( NODE_181_DROPLIST_ITEM ) == 3 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 Result_N24 = float2(0.0); Node24_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N24, Globals );
			float2 Export_N125 = float2(0.0); Node125_Float_Export( Result_N24, Export_N125, Globals );
			float2 Value_N207 = float2(0.0); Node207_Float_Import( Export_N125, Value_N207, Globals );
			
			Value3 = Value_N207;
		}
		Result = Value3;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N162 = float2(0.0); Node162_Surface_UV_Coord( UVCoord_N162, Globals );
			
			Default = UVCoord_N162;
		}
		Result = Default;
	}
}
void Node30_Texture_2D_Sample( in float2 UVCoord, out float4 Color, ssGlobals Globals )
{ 
	Color = SC_SAMPLE_TEX_R(normalTex, UVCoord, 0.0);
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	Color.xyz = Color.xyz * ( 255.0 / 128.0 ) - 1.0;
}
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
#define Node95_Float_Import( Import, Value, Globals ) Value = Import
#define Node183_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node107_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node184_DropList_Parameter( Output, Globals ) Output = float( NODE_184_DROPLIST_ITEM )
#define Node108_Float_Import( Import, Value, Globals ) Value = Import
#define Node109_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node110_Surface_UV_Coord_1( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
void Node111_Switch( in float Switch, in float2 Value0, in float2 Value1, in float2 Value2, in float2 Value3, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	if ( int( NODE_184_DROPLIST_ITEM ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N109 = float2(0.0); Node109_Surface_UV_Coord( UVCoord_N109, Globals );
			
			Value0 = UVCoord_N109;
		}
		Result = Value0;
	}
	else if ( int( NODE_184_DROPLIST_ITEM ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N110 = float2(0.0); Node110_Surface_UV_Coord_1( UVCoord_N110, Globals );
			
			Value1 = UVCoord_N110;
		}
		Result = Value1;
	}
	else if ( int( NODE_184_DROPLIST_ITEM ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 Result_N1 = float2(0.0); Node1_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N1, Globals );
			float2 Export_N23 = float2(0.0); Node23_Float_Export( Result_N1, Export_N23, Globals );
			float2 Value_N167 = float2(0.0); Node167_Float_Import( Export_N23, Value_N167, Globals );
			
			Value2 = Value_N167;
		}
		Result = Value2;
	}
	else if ( int( NODE_184_DROPLIST_ITEM ) == 3 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 Result_N24 = float2(0.0); Node24_If_else( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N24, Globals );
			float2 Export_N125 = float2(0.0); Node125_Float_Export( Result_N24, Export_N125, Globals );
			float2 Value_N207 = float2(0.0); Node207_Float_Import( Export_N125, Value_N207, Globals );
			
			Value3 = Value_N207;
		}
		Result = Value3;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N109 = float2(0.0); Node109_Surface_UV_Coord( UVCoord_N109, Globals );
			
			Default = UVCoord_N109;
		}
		Result = Default;
	}
}
void Node29_Texture_2D_Sample( in float2 UVCoord, out float4 Color, ssGlobals Globals )
{ 
	Color = SC_SAMPLE_TEX_R(detailNormalTex, UVCoord, 0.0);
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	Color.xyz = Color.xyz * ( 255.0 / 128.0 ) - 1.0;
}
void Node113_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_DETAIL_NORMAL ) )
	{
		/* Input port: "Value1"  */
		
		{
			Node183_Texture_2D_Object_Parameter( Globals );
			Node107_Texture_Object_2D_Import( Globals );
			float2 Result_N111 = float2(0.0); Node111_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N111, Globals );
			float4 Color_N29 = float4(0.0); Node29_Texture_2D_Sample( Result_N111, Color_N29, Globals );
			
			Value1 = Color_N29.xyz;
		}
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
void Node200_Combine_Normals( in float3 Normal1, in float Strength1, in float3 Normal2, in float Strength2, out float3 Normal, ssGlobals Globals )
{ 
	Normal2 = ngs_CombineNormals( Normal1, Strength1, Normal2, Strength2 );
	Normal = Normal2;
}
#define Node335_Transform_by_Matrix( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node345_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
void Node346_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
void Node337_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	if ( bool( ENABLE_NORMALMAP ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Tangent_N194 = float3(0.0); Node194_Surface_Tangent( Tangent_N194, Globals );
			float3 Binormal_N193 = float3(0.0); Node193_Surface_Bitangent( Binormal_N193, Globals );
			float3 Normal_N330 = float3(0.0); Node330_Surface_Normal( Normal_N330, Globals );
			mat3 Matrix_N333 = mat3(0.0); Node333_Construct_Matrix( Tangent_N194, Binormal_N193, Normal_N330, Matrix_N333, Globals );
			Node180_Texture_2D_Object_Parameter( Globals );
			Node159_Texture_Object_2D_Import( Globals );
			float2 Result_N208 = float2(0.0); Node208_Switch( float( 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), float2( 0.0, 0.0 ), Result_N208, Globals );
			float4 Color_N30 = float4(0.0); Node30_Texture_2D_Sample( Result_N208, Color_N30, Globals );
			float3 Result_N113 = float3(0.0); Node113_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Default_N113 ), Result_N113, Globals );
			float3 Normal_N200 = float3(0.0); Node200_Combine_Normals( Color_N30.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Strength1_N200 ), Result_N113, NF_PORT_CONSTANT( float( 1.0 ), Port_Strength2_N200 ), Normal_N200, Globals );
			float3 Output_N335 = float3(0.0); Node335_Transform_by_Matrix( Matrix_N333, Normal_N200, Output_N335, Globals );
			float3 Output_N345 = float3(0.0); Node345_Normalize( Output_N335, Output_N345, Globals );
			
			Value1 = Output_N345;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Normal_N330 = float3(0.0); Node330_Surface_Normal( Normal_N330, Globals );
			float3 Output_N346 = float3(0.0); Node346_Normalize( Normal_N330, Output_N346, Globals );
			
			Default = Output_N346;
		}
		Result = Default;
	}
}
#define Node334_Float_Export( Value, Export, Globals ) Export = Value
void Node36_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float3 AO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Normal;
	}
	
	
	Opacity = clamp( Opacity, 0.0, 1.0 ); 		
	
	ngsAlphaTest( Opacity );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if SC_RT_RECEIVER_MODE
	
	#else 
	
	
	Albedo = max( Albedo, 0.0 );	
	
	if ( sc_ProjectiveShadowsCaster )
	{
		Output = float4( Albedo, Opacity );
	}
	else
	{
		float Metallic = 0.0;
		float Roughness = 1.0;	
		
		vec3 SpecularAO = vec3( 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node82_Float_Parameter( out float Output, ssGlobals Globals ) { Output = innerColorMultiplier; }
void Node105_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outerColorMultiplier; }
void Node106_Conditional( in float Input0, in float Input1, in float Input2, out float Output, ssGlobals Globals )
{ 
	/* Input port: "Input0"  */
	
	{
		float2 UVCoord_N66 = float2(0.0); Node66_Surface_UV_Coord( UVCoord_N66, Globals );
		float Value1_N76 = 0.0; float Value2_N76 = 0.0; Node76_Split_Vector( UVCoord_N66, Value1_N76, Value2_N76, Globals );
		float Output_N74 = 0.0; Node74_Float_Parameter( Output_N74, Globals );
		float Output_N75 = 0.0; Node75_Is_Less( Value1_N76, Output_N74, Output_N75, Globals );
		
		Input0 = Output_N75;
	}
	
	if ( bool( Input0 * 1.0 != 0.0 ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float Output_N82 = 0.0; Node82_Float_Parameter( Output_N82, Globals );
			
			Input1 = Output_N82;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float Output_N105 = 0.0; Node105_Float_Parameter( Output_N105, Globals );
			
			Input2 = Output_N105;
		}
		Output = Input2; 
	}
}
#define Node97_Add_One( Input0, Output, Globals ) Output = Input0 + 1.0
#define Node102_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
void Node103_Split_Vector( in float4 Value, out float Value1, out float Value2, out float Value3, out float Value4, ssGlobals Globals )
{ 
	Value1 = Value.r;
	Value2 = Value.g;
	Value3 = Value.b;
	Value4 = Value.a;
}
#define Node104_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
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
	
	float4 FinalColor = float4( 1.0, 1.0, 1.0, 1.0 );
	
	
	
	
	
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
		
		Globals.BumpedNormal              = float3( 0.0 );
		Globals.ViewDirWS                 = rhp.viewDirWS;
		Globals.PositionWS                = rhp.positionWS;
		Globals.VertexColor               = rhp.color;
		Globals.Surface_UVCoord0          = rhp.uv0;
		Globals.Surface_UVCoord1          = rhp.uv1;
		
		float4                            emitterPositionCS = ngsViewProjectionMatrix * float4( rhp.positionWS , 1.0 );
		Globals.gScreenCoord              = (emitterPositionCS.xy / emitterPositionCS.w) * 0.5 + 0.5;
		
		Globals.VertexTangent_WorldSpace  = rhp.tangentWS.xyz;
		Globals.VertexNormal_WorldSpace   = rhp.normalWS;
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
	} else
	#endif
	
	{
		Globals.BumpedNormal              = float3( 0.0 );
		Globals.ViewDirWS                 = normalize(sc_Camera.position - varPos);
		Globals.PositionWS                = varPos;
		Globals.VertexColor               = varColor;
		Globals.Surface_UVCoord0          = varTex01.xy;
		Globals.Surface_UVCoord1          = varTex01.zw;
		
		#ifdef                            VERTEX_SHADER
		
		float4                            Result = ngsViewProjectionMatrix * float4( varPos, 1.0 );
		Result.xyz                        /= Result.w; /* map from clip space to NDC space. keep w around so we can re-project back to world*/
		Globals.gScreenCoord              = Result.xy * 0.5 + 0.5;
		
		#else
		
		Globals.gScreenCoord              = getScreenUV().xy;
		
		#endif
		
		Globals.VertexTangent_WorldSpace  = normalize( varTangent.xyz );
		Globals.VertexNormal_WorldSpace   = normalize( varNormal );
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Result_N363 = float4(0.0); Node363_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Result_N363, Globals );
		float4 Export_N364 = float4(0.0); Node364_Float_Export( Result_N363, Export_N364, Globals );
		float4 Output_N70 = float4(0.0); Node70_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Output_N70, Globals );
		float4 Value_N384 = float4(0.0); Node384_Float_Import( Output_N70, Value_N384, Globals );
		float4 Result_N369 = float4(0.0); Node369_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Default_N369 ), Result_N369, Globals );
		float4 Output_N148 = float4(0.0); Node148_Multiply( Value_N384, Result_N369, Output_N148, Globals );
		float4 Export_N385 = float4(0.0); Node385_Float_Export( Output_N148, Export_N385, Globals );
		float4 Value_N166 = float4(0.0); Node166_Float_Import( Export_N385, Value_N166, Globals );
		float Output_N168 = 0.0; Node168_Swizzle( Value_N166, Output_N168, Globals );
		float Result_N204 = 0.0; Node204_If_else( float( 0.0 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Default_N204 ), Result_N204, Globals );
		float Output_N72 = 0.0; Node72_Conditional( float( 1.0 ), float( 1.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N072 ), Output_N72, Globals );
		float Output_N205 = 0.0; Node205_Multiply( Output_N168, Result_N204, Output_N72, Output_N205, Globals );
		float Export_N158 = 0.0; Node158_Float_Export( Output_N205, Export_N158, Globals );
		float3 Result_N337 = float3(0.0); Node337_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), Result_N337, Globals );
		float3 Export_N334 = float3(0.0); Node334_Float_Export( Result_N337, Export_N334, Globals );
		float4 Output_N36 = float4(0.0); Node36_PBR_Lighting( Export_N364.xyz, Export_N158, Export_N334, NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N036 ), NF_PORT_CONSTANT( float3( 1.0, 0.999969, 0.999985 ), Port_AO_N036 ), Output_N36, Globals );
		float Output_N106 = 0.0; Node106_Conditional( float( 1.0 ), float( 1.0 ), float( 0.0 ), Output_N106, Globals );
		float Output_N97 = 0.0; Node97_Add_One( Output_N106, Output_N97, Globals );
		float4 Output_N102 = float4(0.0); Node102_Multiply( Output_N36, Output_N97, Output_N102, Globals );
		float Value1_N103 = 0.0; float Value2_N103 = 0.0; float Value3_N103 = 0.0; float Value4_N103 = 0.0; Node103_Split_Vector( Output_N36, Value1_N103, Value2_N103, Value3_N103, Value4_N103, Globals );
		float4 Value_N104 = float4(0.0); Node104_Construct_Vector( Output_N102.xyz, Value4_N103, Value_N104, Globals );
		
		FinalColor = Value_N104;
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
