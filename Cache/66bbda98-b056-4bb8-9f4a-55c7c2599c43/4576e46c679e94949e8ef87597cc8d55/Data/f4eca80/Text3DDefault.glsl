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

SPEC_CONST(bool) backCapPBR = false;
SPEC_CONST(int) DROPLIST_BACK_CAP_MODE = 0;
SPEC_CONST(bool) frontCapPBR = false;
SPEC_CONST(int) DROPLIST_FRONT_CAP_MODE = 0;
SPEC_CONST(bool) outerEdgePBR = false;
SPEC_CONST(int) DROPLIST_OUTER_EDGE_MODE = 0;
SPEC_CONST(bool) innerEdgePBR = false;
SPEC_CONST(int) DROPLIST_INNER_EDGE_MODE = 0;


// Material Parameters ( Tweaks )

SC_DECLARE_TEXTURE(backCapTex); //   Title: Texture
uniform NF_PRECISION                 float2 backCapTexScale; // Title: Scale
uniform NF_PRECISION                 float2 backCapTexOffset; // Title: Offset
uniform NF_PRECISION                 float4 backCapStartingColor; // Title: Starting Color
uniform NF_PRECISION                 float4 backCapEndingColor; // Title: Ending Color
uniform NF_PRECISION                 float  backCapGradientRamp; // Title: Gradient Ramp
uniform NF_PRECISION                 float  backCapMetallic; // Title: Metallic
uniform NF_PRECISION                 float  backCapRoughness; // Title: Roughness
SC_DECLARE_TEXTURE(frontCapTex); //  Title: Texture
uniform NF_PRECISION                 float2 frontCapTexScale; // Title: Scale
uniform NF_PRECISION                 float2 frontCapTexOffset; // Title: Offset
uniform NF_PRECISION                 float4 frontCapStartingColor; // Title: Starting Color
uniform NF_PRECISION                 float4 frontCapEndingColor; // Title: Ending Color
uniform NF_PRECISION                 float  frontCapGradientRamp; // Title: Gradient Ramp
uniform NF_PRECISION                 float  frontCapMetallic; // Title: Metallic
uniform NF_PRECISION                 float  frontCapRoughness; // Title: Roughness
SC_DECLARE_TEXTURE(outerEdgeTex); // Title: Texture
uniform NF_PRECISION                 float2 outerEdgeTexScale; // Title: Scale
uniform NF_PRECISION                 float2 outerEdgeTexOffset; // Title: Offset
uniform NF_PRECISION                 float4 outerEdgeStartingColor; // Title: Starting Color
uniform NF_PRECISION                 float4 outerEdgeEndingColor; // Title: Ending Color
uniform NF_PRECISION                 float  outerEdgeGradientRamp; // Title: Gradient Ramp
uniform NF_PRECISION                 float  outerEdgeMetallic; // Title: Metallic
uniform NF_PRECISION                 float  outerRoughness; // Title: Roughness
SC_DECLARE_TEXTURE(InnerEdgeTex); // Title: Texture
uniform NF_PRECISION                 float2 InnerEdgeTexScale; // Title: Scale
uniform NF_PRECISION                 float2 InnerEdgeTexOffset; // Title: Offset
uniform NF_PRECISION                 float4 InnerEdgeStartingColor; // Title: Starting Color
uniform NF_PRECISION                 float4 InnerEdgeEndingColor; // Title: Ending Color
uniform NF_PRECISION                 float  InnerEdgeGradientRamp; // Title: Gradient Ramp
uniform NF_PRECISION                 float  InnerEdgeMetallic; // Title: Metallic
uniform NF_PRECISION                 float  InnerEdgeRoughness; // Title: Roughness	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float4 Port_Import_N129;
uniform NF_PRECISION float4 Port_Import_N130;
uniform NF_PRECISION float Port_Input0_N143;
uniform NF_PRECISION float Port_Input1_N143;
uniform NF_PRECISION float Port_RangeMinA_N132;
uniform NF_PRECISION float Port_RangeMaxA_N132;
uniform NF_PRECISION float Port_RangeMinB_N132;
uniform NF_PRECISION float Port_RangeMaxB_N132;
uniform NF_PRECISION float2 Port_Import_N133;
uniform NF_PRECISION float2 Port_Center_N134;
uniform NF_PRECISION float2 Port_Import_N135;
uniform NF_PRECISION float Port_RangeMinA_N164;
uniform NF_PRECISION float Port_RangeMaxA_N164;
uniform NF_PRECISION float Port_RangeMinB_N164;
uniform NF_PRECISION float Port_RangeMaxB_N164;
uniform NF_PRECISION float2 Port_Import_N137;
uniform NF_PRECISION float Port_Input1_N142;
uniform NF_PRECISION float Port_Input2_N142;
uniform NF_PRECISION float4 Port_Default_N146;
uniform NF_PRECISION float Port_Opacity_N149;
uniform NF_PRECISION float3 Port_Normal_N149;
uniform NF_PRECISION float3 Port_Emissive_N149;
uniform NF_PRECISION float3 Port_AO_N149;
uniform NF_PRECISION float3 Port_SpecularAO_N149;
uniform NF_PRECISION float4 Port_Import_N098;
uniform NF_PRECISION float4 Port_Import_N099;
uniform NF_PRECISION float Port_Input0_N112;
uniform NF_PRECISION float Port_Input1_N112;
uniform NF_PRECISION float Port_RangeMinA_N101;
uniform NF_PRECISION float Port_RangeMaxA_N101;
uniform NF_PRECISION float Port_RangeMinB_N101;
uniform NF_PRECISION float Port_RangeMaxB_N101;
uniform NF_PRECISION float2 Port_Import_N102;
uniform NF_PRECISION float2 Port_Center_N103;
uniform NF_PRECISION float2 Port_Import_N104;
uniform NF_PRECISION float Port_RangeMinA_N160;
uniform NF_PRECISION float Port_RangeMaxA_N160;
uniform NF_PRECISION float Port_RangeMinB_N160;
uniform NF_PRECISION float Port_RangeMaxB_N160;
uniform NF_PRECISION float2 Port_Import_N106;
uniform NF_PRECISION float Port_Input1_N111;
uniform NF_PRECISION float Port_Input2_N111;
uniform NF_PRECISION float4 Port_Default_N010;
uniform NF_PRECISION float Port_Opacity_N118;
uniform NF_PRECISION float3 Port_Normal_N118;
uniform NF_PRECISION float3 Port_Emissive_N118;
uniform NF_PRECISION float3 Port_AO_N118;
uniform NF_PRECISION float3 Port_SpecularAO_N118;
uniform NF_PRECISION float Port_Input1_N054;
uniform NF_PRECISION float4 Port_Import_N038;
uniform NF_PRECISION float4 Port_Import_N039;
uniform NF_PRECISION float Port_Input0_N066;
uniform NF_PRECISION float Port_Input1_N066;
uniform NF_PRECISION float Port_RangeMinA_N033;
uniform NF_PRECISION float Port_RangeMaxA_N033;
uniform NF_PRECISION float Port_RangeMinB_N033;
uniform NF_PRECISION float Port_RangeMaxB_N033;
uniform NF_PRECISION float2 Port_Import_N017;
uniform NF_PRECISION float2 Port_Center_N047;
uniform NF_PRECISION float2 Port_Import_N058;
uniform NF_PRECISION float Port_RangeMinA_N153;
uniform NF_PRECISION float Port_RangeMaxA_N153;
uniform NF_PRECISION float Port_RangeMinB_N153;
uniform NF_PRECISION float Port_RangeMaxB_N153;
uniform NF_PRECISION float2 Port_Import_N060;
uniform NF_PRECISION float Port_Input1_N065;
uniform NF_PRECISION float Port_Input2_N065;
uniform NF_PRECISION float4 Port_Default_N046;
uniform NF_PRECISION float Port_Opacity_N057;
uniform NF_PRECISION float3 Port_Normal_N057;
uniform NF_PRECISION float3 Port_Emissive_N057;
uniform NF_PRECISION float3 Port_AO_N057;
uniform NF_PRECISION float3 Port_SpecularAO_N057;
uniform NF_PRECISION float4 Port_Import_N020;
uniform NF_PRECISION float4 Port_Import_N021;
uniform NF_PRECISION float Port_Input0_N035;
uniform NF_PRECISION float Port_Input1_N035;
uniform NF_PRECISION float Port_RangeMinA_N023;
uniform NF_PRECISION float Port_RangeMaxA_N023;
uniform NF_PRECISION float Port_RangeMinB_N023;
uniform NF_PRECISION float Port_RangeMaxB_N023;
uniform NF_PRECISION float2 Port_Import_N024;
uniform NF_PRECISION float2 Port_Center_N025;
uniform NF_PRECISION float2 Port_Import_N026;
uniform NF_PRECISION float Port_RangeMinA_N155;
uniform NF_PRECISION float Port_RangeMaxA_N155;
uniform NF_PRECISION float Port_RangeMinB_N155;
uniform NF_PRECISION float Port_RangeMaxB_N155;
uniform NF_PRECISION float2 Port_Import_N028;
uniform NF_PRECISION float Port_Input1_N034;
uniform NF_PRECISION float Port_Input2_N034;
uniform NF_PRECISION float4 Port_Default_N077;
uniform NF_PRECISION float Port_Opacity_N080;
uniform NF_PRECISION float3 Port_Normal_N080;
uniform NF_PRECISION float3 Port_Emissive_N080;
uniform NF_PRECISION float3 Port_AO_N080;
uniform NF_PRECISION float3 Port_SpecularAO_N080;
uniform NF_PRECISION float Port_Input1_N043;
uniform NF_PRECISION float Port_Input1_N014;
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
	float3 VertexNormal_WorldSpace;
	float2 Surface_UVCoord0;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node123_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( backCapPBR )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node151_DropList_Parameter( Output, Globals ) Output = float( DROPLIST_BACK_CAP_MODE )
#define Node45_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node52_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node124_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = backCapTexScale; }
void Node125_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = backCapTexOffset; }
#define Node48_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node49_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(backCapTex, UVCoord, 0.0)
void Node126_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = backCapStartingColor; }
#define Node129_Float_Import( Import, Value, Globals ) Value = Import
void Node127_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = backCapEndingColor; }
#define Node130_Float_Import( Import, Value, Globals ) Value = Import
#define Node131_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node132_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node133_Float_Import( Import, Value, Globals ) Value = Import
#define Node134_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node135_Float_Import( Import, Value, Globals ) Value = Import
#define Node136_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node163_Float_Parameter( out float Output, ssGlobals Globals ) { Output = backCapGradientRamp; }
#define Node164_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node165_Swizzle( Input, Output, Globals ) Output = float2( 0.0, Input.y )
#define Node137_Float_Import( Import, Value, Globals ) Value = Import
#define Node138_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node139_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node140_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node141_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node142_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node143_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node144_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node145_Float_Export( Value, Export, Globals ) Export = Value
void Node146_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( int( DROPLIST_BACK_CAP_MODE ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			Node45_Texture_2D_Object_Parameter( Globals );
			float2 UVCoord_N52 = float2(0.0); Node52_Surface_UV_Coord( UVCoord_N52, Globals );
			float2 Output_N124 = float2(0.0); Node124_Float_Parameter( Output_N124, Globals );
			float2 Output_N125 = float2(0.0); Node125_Float_Parameter( Output_N125, Globals );
			float2 Output_N48 = float2(0.0); Node48_Scale_and_Offset( UVCoord_N52, Output_N124, Output_N125, Output_N48, Globals );
			float4 Color_N49 = float4(0.0); Node49_Texture_2D_Sample( Output_N48, Color_N49, Globals );
			
			Value0 = Color_N49;
		}
		Result = Value0;
	}
	else if ( int( DROPLIST_BACK_CAP_MODE ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float4 Output_N126 = float4(0.0); Node126_Color_Parameter( Output_N126, Globals );
			float4 Value_N129 = float4(0.0); Node129_Float_Import( Output_N126, Value_N129, Globals );
			float4 Output_N127 = float4(0.0); Node127_Color_Parameter( Output_N127, Globals );
			float4 Value_N130 = float4(0.0); Node130_Float_Import( Output_N127, Value_N130, Globals );
			float2 UVCoord_N131 = float2(0.0); Node131_Surface_UV_Coord( UVCoord_N131, Globals );
			float2 ValueOut_N132 = float2(0.0); Node132_Remap( UVCoord_N131, ValueOut_N132, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N132 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N132 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N132 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N132 ), Globals );
			float2 Value_N133 = float2(0.0); Node133_Float_Import( NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Import_N133 ), Value_N133, Globals );
			float2 CoordsOut_N134 = float2(0.0); Node134_Scale_Coords( ValueOut_N132, Value_N133, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N134 ), CoordsOut_N134, Globals );
			float2 Value_N135 = float2(0.0); Node135_Float_Import( NF_PORT_CONSTANT( float2( 0.0, 1.0 ), Port_Import_N135 ), Value_N135, Globals );
			float2 Output_N136 = float2(0.0); Node136_Subtract( CoordsOut_N134, Value_N135, Output_N136, Globals );
			float Output_N163 = 0.0; Node163_Float_Parameter( Output_N163, Globals );
			float ValueOut_N164 = 0.0; Node164_Remap( Output_N163, ValueOut_N164, NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinA_N164 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N164 ), NF_PORT_CONSTANT( float( -0.99 ), Port_RangeMinB_N164 ), NF_PORT_CONSTANT( float( 0.99 ), Port_RangeMaxB_N164 ), Globals );
			float2 Output_N165 = float2(0.0); Node165_Swizzle( float2( ValueOut_N164 ), Output_N165, Globals );
			float2 Value_N137 = float2(0.0); Node137_Float_Import( Output_N165, Value_N137, Globals );
			float2 Output_N138 = float2(0.0); Node138_Subtract( Value_N137, Value_N135, Output_N138, Globals );
			float Output_N139 = 0.0; Node139_Dot_Product( Output_N136, Output_N138, Output_N139, Globals );
			float Output_N140 = 0.0; Node140_Dot_Product( Output_N138, Output_N138, Output_N140, Globals );
			float Output_N141 = 0.0; Node141_Divide( Output_N139, Output_N140, Output_N141, Globals );
			float Output_N142 = 0.0; Node142_Clamp( Output_N141, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N142 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N142 ), Output_N142, Globals );
			float Output_N143 = 0.0; Node143_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N143 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N143 ), Output_N142, Output_N143, Globals );
			float4 Output_N144 = float4(0.0); Node144_Mix( Value_N129, Value_N130, Output_N143, Output_N144, Globals );
			float4 Export_N145 = float4(0.0); Node145_Float_Export( Output_N144, Export_N145, Globals );
			
			Value1 = Export_N145;
		}
		Result = Value1;
	}
	else if ( int( DROPLIST_BACK_CAP_MODE ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float4 Output_N126 = float4(0.0); Node126_Color_Parameter( Output_N126, Globals );
			
			Value2 = Output_N126;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
void Node147_Float_Parameter( out float Output, ssGlobals Globals ) { Output = backCapMetallic; }
void Node148_Float_Parameter( out float Output, ssGlobals Globals ) { Output = backCapRoughness; }
void Node149_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Globals.VertexNormal_WorldSpace;
	}
	
	
	
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
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node150_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N123 = 0.0; Node123_Bool_Parameter( Output_N123, Globals );
		
		Input0 = Output_N123;
	}
	#endif
	
	if ( bool( backCapPBR ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Result_N146 = float4(0.0); Node146_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N146 ), Result_N146, Globals );
			float Output_N147 = 0.0; Node147_Float_Parameter( Output_N147, Globals );
			float Output_N148 = 0.0; Node148_Float_Parameter( Output_N148, Globals );
			float4 Output_N149 = float4(0.0); Node149_PBR_Lighting( Result_N146.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Opacity_N149 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Normal_N149 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N149 ), Output_N147, Output_N148, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_AO_N149 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N149 ), Output_N149, Globals );
			
			Input1 = Output_N149;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float4 Result_N146 = float4(0.0); Node146_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N146 ), Result_N146, Globals );
			
			Input2 = Result_N146;
		}
		Output = Input2; 
	}
}
void Node115_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( frontCapPBR )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node9_DropList_Parameter( Output, Globals ) Output = float( DROPLIST_FRONT_CAP_MODE )
#define Node3_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node92_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = frontCapTexScale; }
void Node93_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = frontCapTexOffset; }
#define Node7_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node6_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(frontCapTex, UVCoord, 0.0)
void Node95_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = frontCapStartingColor; }
#define Node98_Float_Import( Import, Value, Globals ) Value = Import
void Node96_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = frontCapEndingColor; }
#define Node99_Float_Import( Import, Value, Globals ) Value = Import
#define Node100_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node101_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node102_Float_Import( Import, Value, Globals ) Value = Import
#define Node103_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node104_Float_Import( Import, Value, Globals ) Value = Import
#define Node105_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node159_Float_Parameter( out float Output, ssGlobals Globals ) { Output = frontCapGradientRamp; }
#define Node160_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node161_Swizzle( Input, Output, Globals ) Output = float2( 0.0, Input.y )
#define Node106_Float_Import( Import, Value, Globals ) Value = Import
#define Node107_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node108_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node109_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node110_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node111_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node112_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node113_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node114_Float_Export( Value, Export, Globals ) Export = Value
void Node10_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( int( DROPLIST_FRONT_CAP_MODE ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			Node3_Texture_2D_Object_Parameter( Globals );
			float2 UVCoord_N52 = float2(0.0); Node52_Surface_UV_Coord( UVCoord_N52, Globals );
			float2 Output_N92 = float2(0.0); Node92_Float_Parameter( Output_N92, Globals );
			float2 Output_N93 = float2(0.0); Node93_Float_Parameter( Output_N93, Globals );
			float2 Output_N7 = float2(0.0); Node7_Scale_and_Offset( UVCoord_N52, Output_N92, Output_N93, Output_N7, Globals );
			float4 Color_N6 = float4(0.0); Node6_Texture_2D_Sample( Output_N7, Color_N6, Globals );
			
			Value0 = Color_N6;
		}
		Result = Value0;
	}
	else if ( int( DROPLIST_FRONT_CAP_MODE ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float4 Output_N95 = float4(0.0); Node95_Color_Parameter( Output_N95, Globals );
			float4 Value_N98 = float4(0.0); Node98_Float_Import( Output_N95, Value_N98, Globals );
			float4 Output_N96 = float4(0.0); Node96_Color_Parameter( Output_N96, Globals );
			float4 Value_N99 = float4(0.0); Node99_Float_Import( Output_N96, Value_N99, Globals );
			float2 UVCoord_N100 = float2(0.0); Node100_Surface_UV_Coord( UVCoord_N100, Globals );
			float2 ValueOut_N101 = float2(0.0); Node101_Remap( UVCoord_N100, ValueOut_N101, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N101 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N101 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N101 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N101 ), Globals );
			float2 Value_N102 = float2(0.0); Node102_Float_Import( NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Import_N102 ), Value_N102, Globals );
			float2 CoordsOut_N103 = float2(0.0); Node103_Scale_Coords( ValueOut_N101, Value_N102, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N103 ), CoordsOut_N103, Globals );
			float2 Value_N104 = float2(0.0); Node104_Float_Import( NF_PORT_CONSTANT( float2( 0.0, 1.0 ), Port_Import_N104 ), Value_N104, Globals );
			float2 Output_N105 = float2(0.0); Node105_Subtract( CoordsOut_N103, Value_N104, Output_N105, Globals );
			float Output_N159 = 0.0; Node159_Float_Parameter( Output_N159, Globals );
			float ValueOut_N160 = 0.0; Node160_Remap( Output_N159, ValueOut_N160, NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinA_N160 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N160 ), NF_PORT_CONSTANT( float( -0.99 ), Port_RangeMinB_N160 ), NF_PORT_CONSTANT( float( 0.99 ), Port_RangeMaxB_N160 ), Globals );
			float2 Output_N161 = float2(0.0); Node161_Swizzle( float2( ValueOut_N160 ), Output_N161, Globals );
			float2 Value_N106 = float2(0.0); Node106_Float_Import( Output_N161, Value_N106, Globals );
			float2 Output_N107 = float2(0.0); Node107_Subtract( Value_N106, Value_N104, Output_N107, Globals );
			float Output_N108 = 0.0; Node108_Dot_Product( Output_N105, Output_N107, Output_N108, Globals );
			float Output_N109 = 0.0; Node109_Dot_Product( Output_N107, Output_N107, Output_N109, Globals );
			float Output_N110 = 0.0; Node110_Divide( Output_N108, Output_N109, Output_N110, Globals );
			float Output_N111 = 0.0; Node111_Clamp( Output_N110, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N111 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N111 ), Output_N111, Globals );
			float Output_N112 = 0.0; Node112_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N112 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N112 ), Output_N111, Output_N112, Globals );
			float4 Output_N113 = float4(0.0); Node113_Mix( Value_N98, Value_N99, Output_N112, Output_N113, Globals );
			float4 Export_N114 = float4(0.0); Node114_Float_Export( Output_N113, Export_N114, Globals );
			
			Value1 = Export_N114;
		}
		Result = Value1;
	}
	else if ( int( DROPLIST_FRONT_CAP_MODE ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float4 Output_N95 = float4(0.0); Node95_Color_Parameter( Output_N95, Globals );
			
			Value2 = Output_N95;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
void Node116_Float_Parameter( out float Output, ssGlobals Globals ) { Output = frontCapMetallic; }
void Node117_Float_Parameter( out float Output, ssGlobals Globals ) { Output = frontCapRoughness; }
void Node118_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Globals.VertexNormal_WorldSpace;
	}
	
	
	
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
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node120_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N115 = 0.0; Node115_Bool_Parameter( Output_N115, Globals );
		
		Input0 = Output_N115;
	}
	#endif
	
	if ( bool( frontCapPBR ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Result_N10 = float4(0.0); Node10_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N010 ), Result_N10, Globals );
			float Output_N116 = 0.0; Node116_Float_Parameter( Output_N116, Globals );
			float Output_N117 = 0.0; Node117_Float_Parameter( Output_N117, Globals );
			float4 Output_N118 = float4(0.0); Node118_PBR_Lighting( Result_N10.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Opacity_N118 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Normal_N118 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N118 ), Output_N116, Output_N117, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_AO_N118 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N118 ), Output_N118, Globals );
			
			Input1 = Output_N118;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float4 Result_N10 = float4(0.0); Node10_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N010 ), Result_N10, Globals );
			
			Input2 = Result_N10;
		}
		Output = Input2; 
	}
}
#define Node53_Swizzle( Input, Output, Globals ) Output = Input
#define Node54_Step( Input0, Input1, Output, Globals ) Output = step( Input0, Input1 )
#define Node51_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node70_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( outerEdgePBR )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node41_DropList_Parameter( Output, Globals ) Output = float( DROPLIST_OUTER_EDGE_MODE )
#define Node55_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node84_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = outerEdgeTexScale; }
void Node85_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = outerEdgeTexOffset; }
#define Node83_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node56_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(outerEdgeTex, UVCoord, 0.0)
void Node1_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = outerEdgeStartingColor; }
#define Node38_Float_Import( Import, Value, Globals ) Value = Import
void Node2_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = outerEdgeEndingColor; }
#define Node39_Float_Import( Import, Value, Globals ) Value = Import
#define Node119_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node33_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node17_Float_Import( Import, Value, Globals ) Value = Import
#define Node47_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node58_Float_Import( Import, Value, Globals ) Value = Import
#define Node59_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node15_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outerEdgeGradientRamp; }
#define Node153_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node50_Swizzle( Input, Output, Globals ) Output = float2( 0.0, Input.y )
#define Node60_Float_Import( Import, Value, Globals ) Value = Import
#define Node61_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node62_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node63_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node64_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node65_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node66_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node67_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node68_Float_Export( Value, Export, Globals ) Export = Value
void Node46_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( int( DROPLIST_OUTER_EDGE_MODE ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			Node55_Texture_2D_Object_Parameter( Globals );
			float2 UVCoord_N52 = float2(0.0); Node52_Surface_UV_Coord( UVCoord_N52, Globals );
			float2 Output_N84 = float2(0.0); Node84_Float_Parameter( Output_N84, Globals );
			float2 Output_N85 = float2(0.0); Node85_Float_Parameter( Output_N85, Globals );
			float2 Output_N83 = float2(0.0); Node83_Scale_and_Offset( UVCoord_N52, Output_N84, Output_N85, Output_N83, Globals );
			float4 Color_N56 = float4(0.0); Node56_Texture_2D_Sample( Output_N83, Color_N56, Globals );
			
			Value0 = Color_N56;
		}
		Result = Value0;
	}
	else if ( int( DROPLIST_OUTER_EDGE_MODE ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float4 Output_N1 = float4(0.0); Node1_Color_Parameter( Output_N1, Globals );
			float4 Value_N38 = float4(0.0); Node38_Float_Import( Output_N1, Value_N38, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N39 = float4(0.0); Node39_Float_Import( Output_N2, Value_N39, Globals );
			float2 UVCoord_N119 = float2(0.0); Node119_Surface_UV_Coord( UVCoord_N119, Globals );
			float2 ValueOut_N33 = float2(0.0); Node33_Remap( UVCoord_N119, ValueOut_N33, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N033 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N033 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N033 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N033 ), Globals );
			float2 Value_N17 = float2(0.0); Node17_Float_Import( NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Import_N017 ), Value_N17, Globals );
			float2 CoordsOut_N47 = float2(0.0); Node47_Scale_Coords( ValueOut_N33, Value_N17, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N047 ), CoordsOut_N47, Globals );
			float2 Value_N58 = float2(0.0); Node58_Float_Import( NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Import_N058 ), Value_N58, Globals );
			float2 Output_N59 = float2(0.0); Node59_Subtract( CoordsOut_N47, Value_N58, Output_N59, Globals );
			float Output_N15 = 0.0; Node15_Float_Parameter( Output_N15, Globals );
			float ValueOut_N153 = 0.0; Node153_Remap( Output_N15, ValueOut_N153, NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinA_N153 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N153 ), NF_PORT_CONSTANT( float( -0.01 ), Port_RangeMinB_N153 ), NF_PORT_CONSTANT( float( -1.01 ), Port_RangeMaxB_N153 ), Globals );
			float2 Output_N50 = float2(0.0); Node50_Swizzle( float2( ValueOut_N153 ), Output_N50, Globals );
			float2 Value_N60 = float2(0.0); Node60_Float_Import( Output_N50, Value_N60, Globals );
			float2 Output_N61 = float2(0.0); Node61_Subtract( Value_N60, Value_N58, Output_N61, Globals );
			float Output_N62 = 0.0; Node62_Dot_Product( Output_N59, Output_N61, Output_N62, Globals );
			float Output_N63 = 0.0; Node63_Dot_Product( Output_N61, Output_N61, Output_N63, Globals );
			float Output_N64 = 0.0; Node64_Divide( Output_N62, Output_N63, Output_N64, Globals );
			float Output_N65 = 0.0; Node65_Clamp( Output_N64, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N065 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N065 ), Output_N65, Globals );
			float Output_N66 = 0.0; Node66_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N066 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N066 ), Output_N65, Output_N66, Globals );
			float4 Output_N67 = float4(0.0); Node67_Mix( Value_N38, Value_N39, Output_N66, Output_N67, Globals );
			float4 Export_N68 = float4(0.0); Node68_Float_Export( Output_N67, Export_N68, Globals );
			
			Value1 = Export_N68;
		}
		Result = Value1;
	}
	else if ( int( DROPLIST_OUTER_EDGE_MODE ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float4 Output_N1 = float4(0.0); Node1_Color_Parameter( Output_N1, Globals );
			
			Value2 = Output_N1;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
void Node72_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outerEdgeMetallic; }
void Node73_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outerRoughness; }
void Node57_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Globals.VertexNormal_WorldSpace;
	}
	
	
	
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
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node75_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N70 = 0.0; Node70_Bool_Parameter( Output_N70, Globals );
		
		Input0 = Output_N70;
	}
	#endif
	
	if ( bool( outerEdgePBR ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Result_N46 = float4(0.0); Node46_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N046 ), Result_N46, Globals );
			float Output_N72 = 0.0; Node72_Float_Parameter( Output_N72, Globals );
			float Output_N73 = 0.0; Node73_Float_Parameter( Output_N73, Globals );
			float4 Output_N57 = float4(0.0); Node57_PBR_Lighting( Result_N46.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Opacity_N057 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Normal_N057 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N057 ), Output_N72, Output_N73, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_AO_N057 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N057 ), Output_N57, Globals );
			
			Input1 = Output_N57;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float4 Result_N46 = float4(0.0); Node46_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N046 ), Result_N46, Globals );
			
			Input2 = Result_N46;
		}
		Output = Input2; 
	}
}
void Node76_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( innerEdgePBR )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node11_DropList_Parameter( Output, Globals ) Output = float( DROPLIST_INNER_EDGE_MODE )
#define Node71_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node86_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = InnerEdgeTexScale; }
void Node87_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = InnerEdgeTexOffset; }
#define Node88_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node74_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(InnerEdgeTex, UVCoord, 0.0)
void Node8_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = InnerEdgeStartingColor; }
#define Node20_Float_Import( Import, Value, Globals ) Value = Import
void Node44_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = InnerEdgeEndingColor; }
#define Node21_Float_Import( Import, Value, Globals ) Value = Import
#define Node22_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node23_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node24_Float_Import( Import, Value, Globals ) Value = Import
#define Node25_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node26_Float_Import( Import, Value, Globals ) Value = Import
#define Node27_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node154_Float_Parameter( out float Output, ssGlobals Globals ) { Output = InnerEdgeGradientRamp; }
#define Node155_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node156_Swizzle( Input, Output, Globals ) Output = float2( 0.0, Input.y )
#define Node28_Float_Import( Import, Value, Globals ) Value = Import
#define Node29_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node30_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node31_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node32_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node34_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node35_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node36_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node37_Float_Export( Value, Export, Globals ) Export = Value
void Node77_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( int( DROPLIST_INNER_EDGE_MODE ) == 0 )
	{
		/* Input port: "Value0"  */
		
		{
			Node71_Texture_2D_Object_Parameter( Globals );
			float2 UVCoord_N52 = float2(0.0); Node52_Surface_UV_Coord( UVCoord_N52, Globals );
			float2 Output_N86 = float2(0.0); Node86_Float_Parameter( Output_N86, Globals );
			float2 Output_N87 = float2(0.0); Node87_Float_Parameter( Output_N87, Globals );
			float2 Output_N88 = float2(0.0); Node88_Scale_and_Offset( UVCoord_N52, Output_N86, Output_N87, Output_N88, Globals );
			float4 Color_N74 = float4(0.0); Node74_Texture_2D_Sample( Output_N88, Color_N74, Globals );
			
			Value0 = Color_N74;
		}
		Result = Value0;
	}
	else if ( int( DROPLIST_INNER_EDGE_MODE ) == 1 )
	{
		/* Input port: "Value1"  */
		
		{
			float4 Output_N8 = float4(0.0); Node8_Color_Parameter( Output_N8, Globals );
			float4 Value_N20 = float4(0.0); Node20_Float_Import( Output_N8, Value_N20, Globals );
			float4 Output_N44 = float4(0.0); Node44_Color_Parameter( Output_N44, Globals );
			float4 Value_N21 = float4(0.0); Node21_Float_Import( Output_N44, Value_N21, Globals );
			float2 UVCoord_N22 = float2(0.0); Node22_Surface_UV_Coord( UVCoord_N22, Globals );
			float2 ValueOut_N23 = float2(0.0); Node23_Remap( UVCoord_N22, ValueOut_N23, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N023 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N023 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N023 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N023 ), Globals );
			float2 Value_N24 = float2(0.0); Node24_Float_Import( NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Import_N024 ), Value_N24, Globals );
			float2 CoordsOut_N25 = float2(0.0); Node25_Scale_Coords( ValueOut_N23, Value_N24, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N025 ), CoordsOut_N25, Globals );
			float2 Value_N26 = float2(0.0); Node26_Float_Import( NF_PORT_CONSTANT( float2( 0.0, -0.5 ), Port_Import_N026 ), Value_N26, Globals );
			float2 Output_N27 = float2(0.0); Node27_Subtract( CoordsOut_N25, Value_N26, Output_N27, Globals );
			float Output_N154 = 0.0; Node154_Float_Parameter( Output_N154, Globals );
			float ValueOut_N155 = 0.0; Node155_Remap( Output_N154, ValueOut_N155, NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinA_N155 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N155 ), NF_PORT_CONSTANT( float( -0.51 ), Port_RangeMinB_N155 ), NF_PORT_CONSTANT( float( -1.51 ), Port_RangeMaxB_N155 ), Globals );
			float2 Output_N156 = float2(0.0); Node156_Swizzle( float2( ValueOut_N155 ), Output_N156, Globals );
			float2 Value_N28 = float2(0.0); Node28_Float_Import( Output_N156, Value_N28, Globals );
			float2 Output_N29 = float2(0.0); Node29_Subtract( Value_N28, Value_N26, Output_N29, Globals );
			float Output_N30 = 0.0; Node30_Dot_Product( Output_N27, Output_N29, Output_N30, Globals );
			float Output_N31 = 0.0; Node31_Dot_Product( Output_N29, Output_N29, Output_N31, Globals );
			float Output_N32 = 0.0; Node32_Divide( Output_N30, Output_N31, Output_N32, Globals );
			float Output_N34 = 0.0; Node34_Clamp( Output_N32, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N034 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N034 ), Output_N34, Globals );
			float Output_N35 = 0.0; Node35_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N035 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N035 ), Output_N34, Output_N35, Globals );
			float4 Output_N36 = float4(0.0); Node36_Mix( Value_N20, Value_N21, Output_N35, Output_N36, Globals );
			float4 Export_N37 = float4(0.0); Node37_Float_Export( Output_N36, Export_N37, Globals );
			
			Value1 = Export_N37;
		}
		Result = Value1;
	}
	else if ( int( DROPLIST_INNER_EDGE_MODE ) == 2 )
	{
		/* Input port: "Value2"  */
		
		{
			float4 Output_N8 = float4(0.0); Node8_Color_Parameter( Output_N8, Globals );
			
			Value2 = Output_N8;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
void Node78_Float_Parameter( out float Output, ssGlobals Globals ) { Output = InnerEdgeMetallic; }
void Node79_Float_Parameter( out float Output, ssGlobals Globals ) { Output = InnerEdgeRoughness; }
void Node80_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Globals.VertexNormal_WorldSpace;
	}
	
	
	
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
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node81_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N76 = 0.0; Node76_Bool_Parameter( Output_N76, Globals );
		
		Input0 = Output_N76;
	}
	#endif
	
	if ( bool( innerEdgePBR ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float4 Result_N77 = float4(0.0); Node77_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N077 ), Result_N77, Globals );
			float Output_N78 = 0.0; Node78_Float_Parameter( Output_N78, Globals );
			float Output_N79 = 0.0; Node79_Float_Parameter( Output_N79, Globals );
			float4 Output_N80 = float4(0.0); Node80_PBR_Lighting( Result_N77.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Opacity_N080 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Normal_N080 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N080 ), Output_N78, Output_N79, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_AO_N080 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N080 ), Output_N80, Globals );
			
			Input1 = Output_N80;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float4 Result_N77 = float4(0.0); Node77_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N077 ), Result_N77, Globals );
			
			Input2 = Result_N77;
		}
		Output = Input2; 
	}
}
#define Node42_Swizzle( Input, Output, Globals ) Output = Input.y
#define Node43_Step( Input0, Input1, Output, Globals ) Output = step( Input0, Input1 )
#define Node0_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node12_Swizzle( Input, Output, Globals ) Output = Input.y
#define Node14_Step( Input0, Input1, Output, Globals ) Output = step( Input0, Input1 )
#define Node13_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
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
		
		Globals.BumpedNormal            = float3( 0.0 );
		Globals.ViewDirWS               = rhp.viewDirWS;
		Globals.PositionWS              = rhp.positionWS;
		Globals.VertexNormal_WorldSpace = rhp.normalWS;
		Globals.Surface_UVCoord0        = rhp.uv0;
	} else
	#endif
	
	{
		Globals.BumpedNormal            = float3( 0.0 );
		Globals.ViewDirWS               = normalize(sc_Camera.position - varPos);
		Globals.PositionWS              = varPos;
		Globals.VertexNormal_WorldSpace = normalize( varNormal );
		Globals.Surface_UVCoord0        = varTex01.xy;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Output_N150 = float4(0.0); Node150_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 1.0, 0.0, 0.0, 0.0 ), Output_N150, Globals );
		float4 Output_N120 = float4(0.0); Node120_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 1.0, 0.0, 0.0, 0.0 ), Output_N120, Globals );
		float2 UVCoord_N52 = float2(0.0); Node52_Surface_UV_Coord( UVCoord_N52, Globals );
		float Output_N53 = 0.0; Node53_Swizzle( UVCoord_N52.x, Output_N53, Globals );
		float Output_N54 = 0.0; Node54_Step( Output_N53, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N054 ), Output_N54, Globals );
		float4 Output_N51 = float4(0.0); Node51_Mix( Output_N150, Output_N120, Output_N54, Output_N51, Globals );
		float4 Output_N75 = float4(0.0); Node75_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 1.0, 0.0, 0.0, 0.0 ), Output_N75, Globals );
		float4 Output_N81 = float4(0.0); Node81_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 1.0, 0.0, 0.0, 0.0 ), Output_N81, Globals );
		float Output_N42 = 0.0; Node42_Swizzle( UVCoord_N52, Output_N42, Globals );
		float Output_N43 = 0.0; Node43_Step( Output_N42, NF_PORT_CONSTANT( float( 0.25 ), Port_Input1_N043 ), Output_N43, Globals );
		float4 Output_N0 = float4(0.0); Node0_Mix( Output_N75, Output_N81, Output_N43, Output_N0, Globals );
		float Output_N12 = 0.0; Node12_Swizzle( UVCoord_N52, Output_N12, Globals );
		float Output_N14 = 0.0; Node14_Step( Output_N12, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N014 ), Output_N14, Globals );
		float4 Output_N13 = float4(0.0); Node13_Mix( Output_N51, Output_N0, Output_N14, Output_N13, Globals );
		
		FinalColor = Output_N13;
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
