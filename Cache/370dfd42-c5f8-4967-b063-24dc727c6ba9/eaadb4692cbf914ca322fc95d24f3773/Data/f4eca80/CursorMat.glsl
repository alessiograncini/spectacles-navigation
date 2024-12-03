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

#define ENABLE_LIGHTING false
#define ENABLE_DIFFUSE_LIGHTING false
#define ENABLE_SPECULAR_LIGHTING false


//-----------------------------------------------------------------------



//-----------------------------------------------------------------------


//-----------------------------------------------------------------------
// Standard defines
//-----------------------------------------------------------------------


#pragma paste_to_backend_at_the_top_begin


#ifdef useTexture
#undef useTexture
#endif

#ifdef isTriggering
#undef isTriggering
#endif

#ifdef multipleInteractorsActive
#undef multipleInteractorsActive
#endif
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

#if defined(SC_ENABLE_RT_CASTER) 
#include <std3_proxy.glsl>
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

const bool SC_ENABLE_SRGB_EMULATION_IN_SHADER = false;


//-----------------------------------------------------------------------
// Varyings
//-----------------------------------------------------------------------

varying vec4 varColor;

//-----------------------------------------------------------------------
// User includes
//-----------------------------------------------------------------------
#include "includes/utils.glsl"		


#include "includes/blend_modes.glsl"
#include "includes/oit.glsl" 

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


//-----------------------------------------------------------------------


// Material Parameters ( Tweaks )

uniform bool                          useTexture;                // Title: Use Texture
SC_DECLARE_TEXTURE(cursorTexture); // Title:                     Custom Map
uniform NF_PRECISION                  float                      circleSquishScale; // Title: Circle Squish Scale
uniform bool                          isTriggering;              // Title: Is Triggering
uniform NF_PRECISION                  float                      outlineOffset; // Title: Outline Offset
uniform NF_PRECISION                  int                        handType; // Title: Hand Type
uniform bool                          multipleInteractorsActive; // Title: Multiple Interactors Active
uniform NF_PRECISION                  float                      maxAlpha; // Title: Max Alpha
uniform NF_PRECISION                  float                      outlineAlpha; // Title: Outline Alpha
uniform NF_PRECISION                  float                      shadowGradientOffset; // Title: Shadow Gradient Offset
uniform NF_PRECISION                  float                      shadowOpacity; // Title: Shadow Opacity	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_RangeMinA_N013;
uniform NF_PRECISION float Port_RangeMaxA_N013;
uniform NF_PRECISION float Port_RangeMinB_N013;
uniform NF_PRECISION float Port_RangeMaxB_N013;
uniform NF_PRECISION float Port_Value_N164;
uniform NF_PRECISION float Port_RangeMinA_N161;
uniform NF_PRECISION float Port_RangeMaxA_N161;
uniform NF_PRECISION float Port_RangeMinB_N161;
uniform NF_PRECISION float Port_RangeMaxB_N161;
uniform NF_PRECISION float2 Port_Center_N019;
uniform NF_PRECISION float2 Port_Input1_N020;
uniform NF_PRECISION float Port_Input1_N027;
uniform NF_PRECISION float Port_Input1_N026;
uniform NF_PRECISION float Port_Input1_N028;
uniform NF_PRECISION float Port_Input1_N029;
uniform NF_PRECISION float2 Port_Default_N010;
uniform NF_PRECISION float Port_RangeMinA_N001;
uniform NF_PRECISION float Port_RangeMaxA_N001;
uniform NF_PRECISION float Port_RangeMinB_N001;
uniform NF_PRECISION float Port_RangeMaxB_N001;
uniform NF_PRECISION float2 Port_Scale_N002;
uniform NF_PRECISION float2 Port_Center_N002;
uniform NF_PRECISION float Port_Value1_N046;
uniform NF_PRECISION float Port_Value2_N046;
uniform NF_PRECISION float Port_Value_N042;
uniform NF_PRECISION float3 Port_Value1_N048;
uniform NF_PRECISION float3 Port_Default_N048;
uniform NF_PRECISION float Port_Input0_N083;
uniform NF_PRECISION float Port_Input1_N083;
uniform NF_PRECISION float Port_Value_N036;
uniform NF_PRECISION float Port_Value_N037;
uniform NF_PRECISION float Port_Input1_N071;
uniform NF_PRECISION float Port_Input1_N097;
uniform NF_PRECISION int Port_Value_N091;
uniform NF_PRECISION int Port_Value_N041;
uniform NF_PRECISION float Port_Input1_N084;
uniform NF_PRECISION float Port_Input1_N035;
uniform NF_PRECISION float Port_Value1_N131;
uniform NF_PRECISION float Port_Input1_N054;
uniform NF_PRECISION float Port_Value_N068;
uniform NF_PRECISION float Port_Value2_N131;
uniform NF_PRECISION float Port_Input1_N094;
uniform NF_PRECISION float Port_Input1_N112;
uniform NF_PRECISION float Port_Value3_N131;
uniform NF_PRECISION float Port_Default_N131;
uniform NF_PRECISION float3 Port_Value1_N014;
uniform NF_PRECISION float Port_Value1_N156;
uniform NF_PRECISION float Port_Value2_N156;
uniform NF_PRECISION float Port_Value3_N156;
uniform NF_PRECISION float Port_Value4_N156;
uniform NF_PRECISION float Port_Default_N156;
uniform NF_PRECISION float Port_Value1_N149;
uniform NF_PRECISION float Port_Value2_N149;
uniform NF_PRECISION float Port_Value3_N149;
uniform NF_PRECISION float Port_RangeMaxB_N151;
uniform NF_PRECISION float Port_RangeMaxB_N152;
uniform NF_PRECISION float Port_Default_N153;
uniform NF_PRECISION float Port_RangeMaxB_N154;
uniform NF_PRECISION float Port_Input1_N143;
uniform NF_PRECISION float Port_RangeMaxB_N146;
uniform NF_PRECISION float Port_Default_N155;
uniform NF_PRECISION float4 Port_Default_N088;
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
	
	#if defined(SC_ENABLE_RT_CASTER) 
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

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	float2 Surface_UVCoord0;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node34_Bool_Parameter( out float Output, ssGlobals Globals ) { Output = ( useTexture ) ? 1.0 : 0.0; }
#define Node7_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node6_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node13_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
void Node164_Float_Value( in float Value, out float Output, ssGlobals Globals )
{ 
	Output = Value + 0.001;
	Output -= 0.001; // LOOK-62828
}
void Node43_Float_Parameter( out float Output, ssGlobals Globals ) { Output = circleSquishScale; }
void Node161_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
#define Node168_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node167_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node19_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node20_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node21_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node27_Is_Greater_or_Equal( Input0, Input1, Output, Globals ) Output = ssLargerOrEqual( Input0, Input1 )
#define Node26_Is_Less_or_Equal( Input0, Input1, Output, Globals ) Output = ssSmallerOrEqual( Input0, Input1 )
#define Node30_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node28_Is_Greater_or_Equal( Input0, Input1, Output, Globals ) Output = ssLargerOrEqual( Input0, Input1 )
#define Node29_Is_Less_or_Equal( Input0, Input1, Output, Globals ) Output = ssSmallerOrEqual( Input0, Input1 )
#define Node31_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node32_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
void Node10_If_else( in float Bool1, in float2 Value1, in float2 Default, out float2 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N6 = float2(0.0); Node6_Surface_UV_Coord( UVCoord_N6, Globals );
		float2 ValueOut_N13 = float2(0.0); Node13_Remap( UVCoord_N6, ValueOut_N13, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N013 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N013 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N013 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N013 ), Globals );
		float Output_N164 = 0.0; Node164_Float_Value( NF_PORT_CONSTANT( float( 2.0 ), Port_Value_N164 ), Output_N164, Globals );
		float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
		float ValueOut_N161 = 0.0; Node161_Remap( Output_N43, ValueOut_N161, NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMinA_N161 ), NF_PORT_CONSTANT( float( 0.2 ), Port_RangeMaxA_N161 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMinB_N161 ), NF_PORT_CONSTANT( float( 0.5 ), Port_RangeMaxB_N161 ), Globals );
		float Output_N168 = 0.0; Node168_Divide( Output_N164, ValueOut_N161, Output_N168, Globals );
		float2 Value_N167 = float2(0.0); Node167_Construct_Vector( Output_N168, Output_N168, Value_N167, Globals );
		float2 CoordsOut_N19 = float2(0.0); Node19_Scale_Coords( ValueOut_N13, Value_N167, NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N019 ), CoordsOut_N19, Globals );
		float2 Output_N20 = float2(0.0); Node20_Add( CoordsOut_N19, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Input1_N020 ), Output_N20, Globals );
		float Value1_N21 = 0.0; float Value2_N21 = 0.0; Node21_Split_Vector( Output_N20, Value1_N21, Value2_N21, Globals );
		float Output_N27 = 0.0; Node27_Is_Greater_or_Equal( Value1_N21, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N027 ), Output_N27, Globals );
		float Output_N26 = 0.0; Node26_Is_Less_or_Equal( Value1_N21, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N026 ), Output_N26, Globals );
		float Result_N30 = 0.0; Node30_And( Output_N27, Output_N26, Result_N30, Globals );
		float Output_N28 = 0.0; Node28_Is_Greater_or_Equal( Value2_N21, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N028 ), Output_N28, Globals );
		float Output_N29 = 0.0; Node29_Is_Less_or_Equal( Value2_N21, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N029 ), Output_N29, Globals );
		float Result_N31 = 0.0; Node31_And( Output_N28, Output_N29, Result_N31, Globals );
		float Result_N32 = 0.0; Node32_And( Result_N30, Result_N31, Result_N32, Globals );
		
		Bool1 = Result_N32;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N6 = float2(0.0); Node6_Surface_UV_Coord( UVCoord_N6, Globals );
			float2 ValueOut_N13 = float2(0.0); Node13_Remap( UVCoord_N6, ValueOut_N13, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N013 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N013 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N013 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N013 ), Globals );
			float Output_N164 = 0.0; Node164_Float_Value( NF_PORT_CONSTANT( float( 2.0 ), Port_Value_N164 ), Output_N164, Globals );
			float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
			float ValueOut_N161 = 0.0; Node161_Remap( Output_N43, ValueOut_N161, NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMinA_N161 ), NF_PORT_CONSTANT( float( 0.2 ), Port_RangeMaxA_N161 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMinB_N161 ), NF_PORT_CONSTANT( float( 0.5 ), Port_RangeMaxB_N161 ), Globals );
			float Output_N168 = 0.0; Node168_Divide( Output_N164, ValueOut_N161, Output_N168, Globals );
			float2 Value_N167 = float2(0.0); Node167_Construct_Vector( Output_N168, Output_N168, Value_N167, Globals );
			float2 CoordsOut_N19 = float2(0.0); Node19_Scale_Coords( ValueOut_N13, Value_N167, NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N019 ), CoordsOut_N19, Globals );
			float2 Output_N20 = float2(0.0); Node20_Add( CoordsOut_N19, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Input1_N020 ), Output_N20, Globals );
			
			Value1 = Output_N20;
		}
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node8_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(cursorTexture, UVCoord, 0.0)
#define Node0_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node1_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node2_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node46_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node59_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
void Node42_Float_Value( in float Value, out float Output, ssGlobals Globals )
{ 
	Output = Value + 0.001;
	Output -= 0.001; // LOOK-62828
}
#define Node44_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node60_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
void Node47_Bool_Parameter( out float Output, ssGlobals Globals ) { Output = ( isTriggering ) ? 1.0 : 0.0; }
void Node48_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Output_N47 = 0.0; Node47_Bool_Parameter( Output_N47, Globals );
		
		Bool1 = Output_N47;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node83_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, Input2 )
#define Node93_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node50_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
void Node38_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outlineOffset; }
void Node36_Float_Value( in float Value, out float Output, ssGlobals Globals )
{ 
	Output = Value + 0.001;
	Output -= 0.001; // LOOK-62828
}
#define Node39_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node80_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
void Node37_Float_Value( in float Value, out float Output, ssGlobals Globals )
{ 
	Output = Value + 0.001;
	Output -= 0.001; // LOOK-62828
}
#define Node40_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node81_Is_Greater( Input0, Input1, Output, Globals ) Output = ssLarger( Input0, Input1 )
#define Node82_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
void Node25_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node72_ATan2( Input0, Input1, Output, Globals ) Output = atan( Input1, Input0 )
#define Node75_PI( Output, Globals ) Output = 3.1415926535897932
#define Node71_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node73_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node74_Mod( Input0, Input1, Output, Globals ) Output = mod( Input0, Input1 )
#define Node96_PI( Output, Globals ) Output = 3.1415926535897932
#define Node97_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node91_Int_Value( Value, Output, Globals ) Output = float(Value)
void Node95_Int_Parameter( out float Output, ssGlobals Globals ) { Output = float(handType); }
#define Node98_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node100_Radians( Input0, Output, Globals ) Output = radians( Input0 )
#define Node99_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node41_Int_Value( Value, Output, Globals ) Output = float(Value)
#define Node45_Radians( Input0, Output, Globals ) Output = radians( Input0 )
#define Node84_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node85_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node78_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node86_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node79_Is_Greater( Input0, Input1, Output, Globals ) Output = ssLarger( Input0, Input1 )
#define Node90_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node35_Is_Not_Equal( Input0, Input1, Output, Globals ) Output = ssNotEqual( Input0, Input1 )
void Node52_Bool_Parameter( out float Output, ssGlobals Globals ) { Output = ( multipleInteractorsActive ) ? 1.0 : 0.0; }
#define Node101_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node92_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node87_Not( Input0, Output, Globals ) Output = ssNot(Input0)
#define Node89_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node53_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node54_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node61_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node56_Cos( Input0, Output, Globals ) Output = cos( Input0 )
#define Node55_Sin( Input0, Output, Globals ) Output = sin( Input0 )
#define Node57_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node62_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node64_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node67_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node68_Float_Value( in float Value, out float Output, ssGlobals Globals )
{ 
	Output = Value + 0.001;
	Output -= 0.001; // LOOK-62828
}
#define Node66_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node65_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node51_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node24_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node94_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node105_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node103_Cos( Input0, Output, Globals ) Output = cos( Input0 )
#define Node102_Sin( Input0, Output, Globals ) Output = sin( Input0 )
#define Node106_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node104_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node107_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node109_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node112_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node108_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node115_Cos( Input0, Output, Globals ) Output = cos( Input0 )
#define Node114_Sin( Input0, Output, Globals ) Output = sin( Input0 )
#define Node116_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node117_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node118_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node119_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node111_Or( A, B, Result, Globals ) Result = ( ( A * 1.0 != 0.0 ) || ( B * 1.0 != 0.0 ) ) ? 1.0 : 0.0
void Node131_If_else( in float Bool1, in float Value1, in float Bool2, in float Value2, in float Bool3, in float Value3, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N50 = 0.0; Node50_Distance( CoordsOut_N2, Value_N46, Output_N50, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N80 = 0.0; Node80_Is_Less( Output_N50, Output_N39, Output_N80, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N81 = 0.0; Node81_Is_Greater( Output_N50, Output_N40, Output_N81, Globals );
		float Result_N82 = 0.0; Node82_And( Output_N80, Output_N81, Result_N82, Globals );
		float Value1_N25 = 0.0; float Value2_N25 = 0.0; Node25_Split_Vector( CoordsOut_N2, Value1_N25, Value2_N25, Globals );
		float Output_N72 = 0.0; Node72_ATan2( Value1_N25, Value2_N25, Output_N72, Globals );
		float Output_N75 = 0.0; Node75_PI( Output_N75, Globals );
		float Output_N71 = 0.0; Node71_Multiply( Output_N75, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
		float Output_N73 = 0.0; Node73_Add( Output_N72, Output_N71, Output_N73, Globals );
		float Output_N74 = 0.0; Node74_Mod( Output_N73, Output_N71, Output_N74, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N78 = 0.0; Node78_Is_Less( Output_N74, Output_N85, Output_N78, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N79 = 0.0; Node79_Is_Greater( Output_N74, Output_N86, Output_N79, Globals );
		float Result_N90 = 0.0; Node90_And( Output_N78, Output_N79, Result_N90, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N92 = 0.0; Node92_And( Result_N90, Result_N101, Result_N92, Globals );
		float Output_N87 = 0.0; Node87_Not( Result_N92, Output_N87, Globals );
		float Result_N89 = 0.0; Node89_And( Result_N82, Output_N87, Result_N89, Globals );
		
		Bool1 = Result_N89;
	}
	/* Input port: "Bool2"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N53 = 0.0; Node53_Add( Output_N39, Output_N40, Output_N53, Globals );
		float Output_N54 = 0.0; Node54_Divide( Output_N53, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N054 ), Output_N54, Globals );
		float2 Value_N61 = float2(0.0); Node61_Construct_Vector( Output_N54, Output_N54, Value_N61, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N56 = 0.0; Node56_Cos( Output_N99, Output_N56, Globals );
		float Output_N55 = 0.0; Node55_Sin( Output_N99, Output_N55, Globals );
		float2 Value_N57 = float2(0.0); Node57_Construct_Vector( Output_N56, Output_N55, Value_N57, Globals );
		float2 Output_N62 = float2(0.0); Node62_Multiply( Value_N61, Value_N57, Output_N62, Globals );
		float Output_N64 = 0.0; Node64_Distance( CoordsOut_N2, Output_N62, Output_N64, Globals );
		float Output_N67 = 0.0; Node67_Subtract( Output_N39, Output_N40, Output_N67, Globals );
		float Output_N68 = 0.0; Node68_Float_Value( NF_PORT_CONSTANT( float( 0.9 ), Port_Value_N068 ), Output_N68, Globals );
		float Output_N66 = 0.0; Node66_Multiply( Output_N67, Output_N68, Output_N66, Globals );
		float Output_N65 = 0.0; Node65_Is_Less( Output_N64, Output_N66, Output_N65, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N51 = 0.0; Node51_And( Output_N65, Result_N101, Result_N51, Globals );
		
		Bool2 = Result_N51;
	}
	/* Input port: "Bool3"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
		float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
		float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N103 = 0.0; Node103_Cos( Output_N85, Output_N103, Globals );
		float Output_N102 = 0.0; Node102_Sin( Output_N85, Output_N102, Globals );
		float2 Value_N106 = float2(0.0); Node106_Construct_Vector( Output_N103, Output_N102, Value_N106, Globals );
		float2 Output_N104 = float2(0.0); Node104_Multiply( Value_N105, Value_N106, Output_N104, Globals );
		float Output_N107 = 0.0; Node107_Distance( CoordsOut_N2, Output_N104, Output_N107, Globals );
		float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
		float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
		float Output_N108 = 0.0; Node108_Is_Less( Output_N107, Output_N112, Output_N108, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N115 = 0.0; Node115_Cos( Output_N86, Output_N115, Globals );
		float Output_N114 = 0.0; Node114_Sin( Output_N86, Output_N114, Globals );
		float2 Value_N116 = float2(0.0); Node116_Construct_Vector( Output_N115, Output_N114, Value_N116, Globals );
		float2 Output_N117 = float2(0.0); Node117_Multiply( Value_N105, Value_N116, Output_N117, Globals );
		float Output_N118 = 0.0; Node118_Distance( CoordsOut_N2, Output_N117, Output_N118, Globals );
		float Output_N119 = 0.0; Node119_Is_Less( Output_N118, Output_N112, Output_N119, Globals );
		float Result_N111 = 0.0; Node111_Or( Output_N108, Output_N119, Result_N111, Globals );
		
		Bool3 = Result_N111;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		
		Result = Value1;
	}
	
	else if ( bool( Bool2 * 1.0 != 0.0 ) )
	{
		
		Result = Value2;
	}
	
	else if ( bool( Bool3 * 1.0 != 0.0 ) )
	{
		
		Result = Value3;
	}
	else
	{
		
		Result = Default;
	}
}
void Node16_Float_Parameter( out float Output, ssGlobals Globals ) { Output = maxAlpha; }
void Node15_Float_Parameter( out float Output, ssGlobals Globals ) { Output = outlineAlpha; }
#define Node17_Min( Input0, Input1, Output, Globals ) Output = min( Input0, Input1 )
#define Node14_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
void Node128_Float_Parameter( out float Output, ssGlobals Globals ) { Output = shadowGradientOffset; }
#define Node132_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node122_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node162_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node138_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node139_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node127_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node121_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node126_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node125_Is_Greater( Input0, Input1, Output, Globals ) Output = ssLarger( Input0, Input1 )
#define Node129_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node130_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
#define Node136_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node134_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node135_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node140_Or( A, B, Result, Globals ) Result = ( ( A * 1.0 != 0.0 ) || ( B * 1.0 != 0.0 ) ) ? 1.0 : 0.0
#define Node150_And( A, B, Result, Globals ) Result = float( ( A * 1.0 != 0.0 ) && ( B * 1.0 != 0.0 ) ? 1.0 : 0.0 )
void Node156_If_else( in float Bool1, in float Value1, in float Bool2, in float Value2, in float Bool3, in float Value3, in float Bool4, in float Value4, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N53 = 0.0; Node53_Add( Output_N39, Output_N40, Output_N53, Globals );
		float Output_N54 = 0.0; Node54_Divide( Output_N53, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N054 ), Output_N54, Globals );
		float2 Value_N61 = float2(0.0); Node61_Construct_Vector( Output_N54, Output_N54, Value_N61, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N56 = 0.0; Node56_Cos( Output_N99, Output_N56, Globals );
		float Output_N55 = 0.0; Node55_Sin( Output_N99, Output_N55, Globals );
		float2 Value_N57 = float2(0.0); Node57_Construct_Vector( Output_N56, Output_N55, Value_N57, Globals );
		float2 Output_N62 = float2(0.0); Node62_Multiply( Value_N61, Value_N57, Output_N62, Globals );
		float Output_N64 = 0.0; Node64_Distance( CoordsOut_N2, Output_N62, Output_N64, Globals );
		float Output_N67 = 0.0; Node67_Subtract( Output_N39, Output_N40, Output_N67, Globals );
		float Output_N68 = 0.0; Node68_Float_Value( NF_PORT_CONSTANT( float( 0.9 ), Port_Value_N068 ), Output_N68, Globals );
		float Output_N66 = 0.0; Node66_Multiply( Output_N67, Output_N68, Output_N66, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N132 = 0.0; Node132_Add( Output_N66, Output_N128, Output_N132, Globals );
		float Output_N122 = 0.0; Node122_Is_Less( Output_N64, Output_N132, Output_N122, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N162 = 0.0; Node162_And( Output_N122, Result_N101, Result_N162, Globals );
		
		Bool1 = Result_N162;
	}
	/* Input port: "Bool2"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N59 = 0.0; Node59_Distance( CoordsOut_N2, Value_N46, Output_N59, Globals );
		float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
		float Output_N42 = 0.0; Node42_Float_Value( NF_PORT_CONSTANT( float( 0.3 ), Port_Value_N042 ), Output_N42, Globals );
		float Output_N44 = 0.0; Node44_Multiply( Output_N43, Output_N42, Output_N44, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N138 = 0.0; Node138_Add( Output_N44, Output_N128, Output_N138, Globals );
		float Output_N139 = 0.0; Node139_Is_Less( Output_N59, Output_N138, Output_N139, Globals );
		
		Bool2 = Output_N139;
	}
	/* Input port: "Bool3"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N50 = 0.0; Node50_Distance( CoordsOut_N2, Value_N46, Output_N50, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N127 = 0.0; Node127_Add( Output_N39, Output_N128, Output_N127, Globals );
		float Output_N121 = 0.0; Node121_Is_Less( Output_N50, Output_N127, Output_N121, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N126 = 0.0; Node126_Subtract( Output_N40, Output_N128, Output_N126, Globals );
		float Output_N125 = 0.0; Node125_Is_Greater( Output_N50, Output_N126, Output_N125, Globals );
		float Result_N129 = 0.0; Node129_And( Output_N121, Output_N125, Result_N129, Globals );
		float Value1_N25 = 0.0; float Value2_N25 = 0.0; Node25_Split_Vector( CoordsOut_N2, Value1_N25, Value2_N25, Globals );
		float Output_N72 = 0.0; Node72_ATan2( Value1_N25, Value2_N25, Output_N72, Globals );
		float Output_N75 = 0.0; Node75_PI( Output_N75, Globals );
		float Output_N71 = 0.0; Node71_Multiply( Output_N75, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
		float Output_N73 = 0.0; Node73_Add( Output_N72, Output_N71, Output_N73, Globals );
		float Output_N74 = 0.0; Node74_Mod( Output_N73, Output_N71, Output_N74, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N78 = 0.0; Node78_Is_Less( Output_N74, Output_N85, Output_N78, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N79 = 0.0; Node79_Is_Greater( Output_N74, Output_N86, Output_N79, Globals );
		float Result_N90 = 0.0; Node90_And( Output_N78, Output_N79, Result_N90, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N92 = 0.0; Node92_And( Result_N90, Result_N101, Result_N92, Globals );
		float Output_N87 = 0.0; Node87_Not( Result_N92, Output_N87, Globals );
		float Result_N130 = 0.0; Node130_And( Result_N129, Output_N87, Result_N130, Globals );
		
		Bool3 = Result_N130;
	}
	/* Input port: "Bool4"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
		float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
		float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N103 = 0.0; Node103_Cos( Output_N85, Output_N103, Globals );
		float Output_N102 = 0.0; Node102_Sin( Output_N85, Output_N102, Globals );
		float2 Value_N106 = float2(0.0); Node106_Construct_Vector( Output_N103, Output_N102, Value_N106, Globals );
		float2 Output_N104 = float2(0.0); Node104_Multiply( Value_N105, Value_N106, Output_N104, Globals );
		float Output_N107 = 0.0; Node107_Distance( CoordsOut_N2, Output_N104, Output_N107, Globals );
		float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
		float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N136 = 0.0; Node136_Add( Output_N112, Output_N128, Output_N136, Globals );
		float Output_N134 = 0.0; Node134_Is_Less( Output_N107, Output_N136, Output_N134, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N115 = 0.0; Node115_Cos( Output_N86, Output_N115, Globals );
		float Output_N114 = 0.0; Node114_Sin( Output_N86, Output_N114, Globals );
		float2 Value_N116 = float2(0.0); Node116_Construct_Vector( Output_N115, Output_N114, Value_N116, Globals );
		float2 Output_N117 = float2(0.0); Node117_Multiply( Value_N105, Value_N116, Output_N117, Globals );
		float Output_N118 = 0.0; Node118_Distance( CoordsOut_N2, Output_N117, Output_N118, Globals );
		float Output_N135 = 0.0; Node135_Is_Less( Output_N118, Output_N136, Output_N135, Globals );
		float Result_N140 = 0.0; Node140_Or( Output_N134, Output_N135, Result_N140, Globals );
		float Value1_N25 = 0.0; float Value2_N25 = 0.0; Node25_Split_Vector( CoordsOut_N2, Value1_N25, Value2_N25, Globals );
		float Output_N72 = 0.0; Node72_ATan2( Value1_N25, Value2_N25, Output_N72, Globals );
		float Output_N75 = 0.0; Node75_PI( Output_N75, Globals );
		float Output_N71 = 0.0; Node71_Multiply( Output_N75, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
		float Output_N73 = 0.0; Node73_Add( Output_N72, Output_N71, Output_N73, Globals );
		float Output_N74 = 0.0; Node74_Mod( Output_N73, Output_N71, Output_N74, Globals );
		float Output_N78 = 0.0; Node78_Is_Less( Output_N74, Output_N85, Output_N78, Globals );
		float Output_N79 = 0.0; Node79_Is_Greater( Output_N74, Output_N86, Output_N79, Globals );
		float Result_N90 = 0.0; Node90_And( Output_N78, Output_N79, Result_N90, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N92 = 0.0; Node92_And( Result_N90, Result_N101, Result_N92, Globals );
		float Result_N150 = 0.0; Node150_And( Result_N140, Result_N92, Result_N150, Globals );
		
		Bool4 = Result_N150;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		
		Result = Value1;
	}
	
	else if ( bool( Bool2 * 1.0 != 0.0 ) )
	{
		
		Result = Value2;
	}
	
	else if ( bool( Bool3 * 1.0 != 0.0 ) )
	{
		
		Result = Value3;
	}
	
	else if ( bool( Bool4 * 1.0 != 0.0 ) )
	{
		
		Result = Value4;
	}
	else
	{
		
		Result = Default;
	}
}
void Node123_Float_Parameter( out float Output, ssGlobals Globals ) { Output = shadowOpacity; }
void Node151_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
void Node152_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
void Node153_If_else( in float Bool1, in float Value1, in float Bool2, in float Value2, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
		float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
		float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N103 = 0.0; Node103_Cos( Output_N85, Output_N103, Globals );
		float Output_N102 = 0.0; Node102_Sin( Output_N85, Output_N102, Globals );
		float2 Value_N106 = float2(0.0); Node106_Construct_Vector( Output_N103, Output_N102, Value_N106, Globals );
		float2 Output_N104 = float2(0.0); Node104_Multiply( Value_N105, Value_N106, Output_N104, Globals );
		float Output_N107 = 0.0; Node107_Distance( CoordsOut_N2, Output_N104, Output_N107, Globals );
		float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
		float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N136 = 0.0; Node136_Add( Output_N112, Output_N128, Output_N136, Globals );
		float Output_N134 = 0.0; Node134_Is_Less( Output_N107, Output_N136, Output_N134, Globals );
		
		Bool1 = Output_N134;
	}
	/* Input port: "Bool2"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
		float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
		float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N115 = 0.0; Node115_Cos( Output_N86, Output_N115, Globals );
		float Output_N114 = 0.0; Node114_Sin( Output_N86, Output_N114, Globals );
		float2 Value_N116 = float2(0.0); Node116_Construct_Vector( Output_N115, Output_N114, Value_N116, Globals );
		float2 Output_N117 = float2(0.0); Node117_Multiply( Value_N105, Value_N116, Output_N117, Globals );
		float Output_N118 = 0.0; Node118_Distance( CoordsOut_N2, Output_N117, Output_N118, Globals );
		float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
		float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N136 = 0.0; Node136_Add( Output_N112, Output_N128, Output_N136, Globals );
		float Output_N135 = 0.0; Node135_Is_Less( Output_N118, Output_N136, Output_N135, Globals );
		
		Bool2 = Output_N135;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
			float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
			float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
			float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
			float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
			float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
			float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
			float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
			float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
			float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
			float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
			float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
			float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
			float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
			float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
			float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
			float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
			float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
			float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
			float Output_N103 = 0.0; Node103_Cos( Output_N85, Output_N103, Globals );
			float Output_N102 = 0.0; Node102_Sin( Output_N85, Output_N102, Globals );
			float2 Value_N106 = float2(0.0); Node106_Construct_Vector( Output_N103, Output_N102, Value_N106, Globals );
			float2 Output_N104 = float2(0.0); Node104_Multiply( Value_N105, Value_N106, Output_N104, Globals );
			float Output_N107 = 0.0; Node107_Distance( CoordsOut_N2, Output_N104, Output_N107, Globals );
			
			Value1 = Output_N107;
		}
		Result = Value1;
	}
	
	else if ( bool( Bool2 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value2"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
			float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
			float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
			float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
			float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
			float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
			float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
			float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
			float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
			float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
			float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
			float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
			float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
			float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
			float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
			float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
			float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
			float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
			float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
			float Output_N115 = 0.0; Node115_Cos( Output_N86, Output_N115, Globals );
			float Output_N114 = 0.0; Node114_Sin( Output_N86, Output_N114, Globals );
			float2 Value_N116 = float2(0.0); Node116_Construct_Vector( Output_N115, Output_N114, Value_N116, Globals );
			float2 Output_N117 = float2(0.0); Node117_Multiply( Value_N105, Value_N116, Output_N117, Globals );
			float Output_N118 = 0.0; Node118_Distance( CoordsOut_N2, Output_N117, Output_N118, Globals );
			
			Value2 = Output_N118;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
void Node154_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
#define Node142_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node143_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node144_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node145_Abs( Input0, Output, Globals ) Output = abs( Input0 )
#define Node147_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node148_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node146_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
void Node155_If_else( in float Bool1, in float Value1, in float Bool2, in float Value2, in float Bool3, in float Value3, in float Bool4, in float Value4, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N53 = 0.0; Node53_Add( Output_N39, Output_N40, Output_N53, Globals );
		float Output_N54 = 0.0; Node54_Divide( Output_N53, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N054 ), Output_N54, Globals );
		float2 Value_N61 = float2(0.0); Node61_Construct_Vector( Output_N54, Output_N54, Value_N61, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N56 = 0.0; Node56_Cos( Output_N99, Output_N56, Globals );
		float Output_N55 = 0.0; Node55_Sin( Output_N99, Output_N55, Globals );
		float2 Value_N57 = float2(0.0); Node57_Construct_Vector( Output_N56, Output_N55, Value_N57, Globals );
		float2 Output_N62 = float2(0.0); Node62_Multiply( Value_N61, Value_N57, Output_N62, Globals );
		float Output_N64 = 0.0; Node64_Distance( CoordsOut_N2, Output_N62, Output_N64, Globals );
		float Output_N67 = 0.0; Node67_Subtract( Output_N39, Output_N40, Output_N67, Globals );
		float Output_N68 = 0.0; Node68_Float_Value( NF_PORT_CONSTANT( float( 0.9 ), Port_Value_N068 ), Output_N68, Globals );
		float Output_N66 = 0.0; Node66_Multiply( Output_N67, Output_N68, Output_N66, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N132 = 0.0; Node132_Add( Output_N66, Output_N128, Output_N132, Globals );
		float Output_N122 = 0.0; Node122_Is_Less( Output_N64, Output_N132, Output_N122, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N162 = 0.0; Node162_And( Output_N122, Result_N101, Result_N162, Globals );
		
		Bool1 = Result_N162;
	}
	/* Input port: "Bool2"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N59 = 0.0; Node59_Distance( CoordsOut_N2, Value_N46, Output_N59, Globals );
		float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
		float Output_N42 = 0.0; Node42_Float_Value( NF_PORT_CONSTANT( float( 0.3 ), Port_Value_N042 ), Output_N42, Globals );
		float Output_N44 = 0.0; Node44_Multiply( Output_N43, Output_N42, Output_N44, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N138 = 0.0; Node138_Add( Output_N44, Output_N128, Output_N138, Globals );
		float Output_N139 = 0.0; Node139_Is_Less( Output_N59, Output_N138, Output_N139, Globals );
		
		Bool2 = Output_N139;
	}
	/* Input port: "Bool3"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N24 = 0.0; Node24_Add( Output_N39, Output_N40, Output_N24, Globals );
		float Output_N94 = 0.0; Node94_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N094 ), Output_N94, Globals );
		float2 Value_N105 = float2(0.0); Node105_Construct_Vector( Output_N94, Output_N94, Value_N105, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N103 = 0.0; Node103_Cos( Output_N85, Output_N103, Globals );
		float Output_N102 = 0.0; Node102_Sin( Output_N85, Output_N102, Globals );
		float2 Value_N106 = float2(0.0); Node106_Construct_Vector( Output_N103, Output_N102, Value_N106, Globals );
		float2 Output_N104 = float2(0.0); Node104_Multiply( Value_N105, Value_N106, Output_N104, Globals );
		float Output_N107 = 0.0; Node107_Distance( CoordsOut_N2, Output_N104, Output_N107, Globals );
		float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
		float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N136 = 0.0; Node136_Add( Output_N112, Output_N128, Output_N136, Globals );
		float Output_N134 = 0.0; Node134_Is_Less( Output_N107, Output_N136, Output_N134, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N115 = 0.0; Node115_Cos( Output_N86, Output_N115, Globals );
		float Output_N114 = 0.0; Node114_Sin( Output_N86, Output_N114, Globals );
		float2 Value_N116 = float2(0.0); Node116_Construct_Vector( Output_N115, Output_N114, Value_N116, Globals );
		float2 Output_N117 = float2(0.0); Node117_Multiply( Value_N105, Value_N116, Output_N117, Globals );
		float Output_N118 = 0.0; Node118_Distance( CoordsOut_N2, Output_N117, Output_N118, Globals );
		float Output_N135 = 0.0; Node135_Is_Less( Output_N118, Output_N136, Output_N135, Globals );
		float Result_N140 = 0.0; Node140_Or( Output_N134, Output_N135, Result_N140, Globals );
		float Value1_N25 = 0.0; float Value2_N25 = 0.0; Node25_Split_Vector( CoordsOut_N2, Value1_N25, Value2_N25, Globals );
		float Output_N72 = 0.0; Node72_ATan2( Value1_N25, Value2_N25, Output_N72, Globals );
		float Output_N75 = 0.0; Node75_PI( Output_N75, Globals );
		float Output_N71 = 0.0; Node71_Multiply( Output_N75, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
		float Output_N73 = 0.0; Node73_Add( Output_N72, Output_N71, Output_N73, Globals );
		float Output_N74 = 0.0; Node74_Mod( Output_N73, Output_N71, Output_N74, Globals );
		float Output_N78 = 0.0; Node78_Is_Less( Output_N74, Output_N85, Output_N78, Globals );
		float Output_N79 = 0.0; Node79_Is_Greater( Output_N74, Output_N86, Output_N79, Globals );
		float Result_N90 = 0.0; Node90_And( Output_N78, Output_N79, Result_N90, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N92 = 0.0; Node92_And( Result_N90, Result_N101, Result_N92, Globals );
		float Result_N150 = 0.0; Node150_And( Result_N140, Result_N92, Result_N150, Globals );
		
		Bool3 = Result_N150;
	}
	/* Input port: "Bool4"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N50 = 0.0; Node50_Distance( CoordsOut_N2, Value_N46, Output_N50, Globals );
		float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
		float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
		float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
		float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
		float Output_N127 = 0.0; Node127_Add( Output_N39, Output_N128, Output_N127, Globals );
		float Output_N121 = 0.0; Node121_Is_Less( Output_N50, Output_N127, Output_N121, Globals );
		float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
		float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
		float Output_N126 = 0.0; Node126_Subtract( Output_N40, Output_N128, Output_N126, Globals );
		float Output_N125 = 0.0; Node125_Is_Greater( Output_N50, Output_N126, Output_N125, Globals );
		float Result_N129 = 0.0; Node129_And( Output_N121, Output_N125, Result_N129, Globals );
		float Value1_N25 = 0.0; float Value2_N25 = 0.0; Node25_Split_Vector( CoordsOut_N2, Value1_N25, Value2_N25, Globals );
		float Output_N72 = 0.0; Node72_ATan2( Value1_N25, Value2_N25, Output_N72, Globals );
		float Output_N75 = 0.0; Node75_PI( Output_N75, Globals );
		float Output_N71 = 0.0; Node71_Multiply( Output_N75, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
		float Output_N73 = 0.0; Node73_Add( Output_N72, Output_N71, Output_N73, Globals );
		float Output_N74 = 0.0; Node74_Mod( Output_N73, Output_N71, Output_N74, Globals );
		float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
		float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
		float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
		float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
		float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
		float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
		float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
		float Output_N41 = 0.0; Node41_Int_Value( NF_PORT_CONSTANT( int( 60 ), Port_Value_N041 ), Output_N41, Globals );
		float Output_N45 = 0.0; Node45_Radians( Output_N41, Output_N45, Globals );
		float Output_N84 = 0.0; Node84_Divide( Output_N45, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float Output_N85 = 0.0; Node85_Add( Output_N99, Output_N84, Output_N85, Globals );
		float Output_N78 = 0.0; Node78_Is_Less( Output_N74, Output_N85, Output_N78, Globals );
		float Output_N86 = 0.0; Node86_Subtract( Output_N99, Output_N84, Output_N86, Globals );
		float Output_N79 = 0.0; Node79_Is_Greater( Output_N74, Output_N86, Output_N79, Globals );
		float Result_N90 = 0.0; Node90_And( Output_N78, Output_N79, Result_N90, Globals );
		float Output_N35 = 0.0; Node35_Is_Not_Equal( Output_N95, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N035 ), Output_N35, Globals );
		float Output_N52 = 0.0; Node52_Bool_Parameter( Output_N52, Globals );
		float Result_N101 = 0.0; Node101_And( Output_N35, Output_N52, Result_N101, Globals );
		float Result_N92 = 0.0; Node92_And( Result_N90, Result_N101, Result_N92, Globals );
		float Output_N87 = 0.0; Node87_Not( Result_N92, Output_N87, Globals );
		float Result_N130 = 0.0; Node130_And( Result_N129, Output_N87, Result_N130, Globals );
		
		Bool4 = Result_N130;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
			float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
			float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
			float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
			float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
			float Output_N53 = 0.0; Node53_Add( Output_N39, Output_N40, Output_N53, Globals );
			float Output_N54 = 0.0; Node54_Divide( Output_N53, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N054 ), Output_N54, Globals );
			float2 Value_N61 = float2(0.0); Node61_Construct_Vector( Output_N54, Output_N54, Value_N61, Globals );
			float Output_N96 = 0.0; Node96_PI( Output_N96, Globals );
			float Output_N97 = 0.0; Node97_Multiply( Output_N96, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N097 ), Output_N97, Globals );
			float Output_N91 = 0.0; Node91_Int_Value( NF_PORT_CONSTANT( int( 45 ), Port_Value_N091 ), Output_N91, Globals );
			float Output_N95 = 0.0; Node95_Int_Parameter( Output_N95, Globals );
			float Output_N98 = 0.0; Node98_Multiply( Output_N91, Output_N95, Output_N98, Globals );
			float Output_N100 = 0.0; Node100_Radians( Output_N98, Output_N100, Globals );
			float Output_N99 = 0.0; Node99_Add( Output_N97, Output_N100, Output_N99, Globals );
			float Output_N56 = 0.0; Node56_Cos( Output_N99, Output_N56, Globals );
			float Output_N55 = 0.0; Node55_Sin( Output_N99, Output_N55, Globals );
			float2 Value_N57 = float2(0.0); Node57_Construct_Vector( Output_N56, Output_N55, Value_N57, Globals );
			float2 Output_N62 = float2(0.0); Node62_Multiply( Value_N61, Value_N57, Output_N62, Globals );
			float Output_N64 = 0.0; Node64_Distance( CoordsOut_N2, Output_N62, Output_N64, Globals );
			float Output_N67 = 0.0; Node67_Subtract( Output_N39, Output_N40, Output_N67, Globals );
			float Output_N68 = 0.0; Node68_Float_Value( NF_PORT_CONSTANT( float( 0.9 ), Port_Value_N068 ), Output_N68, Globals );
			float Output_N66 = 0.0; Node66_Multiply( Output_N67, Output_N68, Output_N66, Globals );
			float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
			float Output_N132 = 0.0; Node132_Add( Output_N66, Output_N128, Output_N132, Globals );
			float Output_N123 = 0.0; Node123_Float_Parameter( Output_N123, Globals );
			float ValueOut_N151 = 0.0; Node151_Remap( Output_N64, ValueOut_N151, Output_N66, Output_N132, Output_N123, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMaxB_N151 ), Globals );
			
			Value1 = ValueOut_N151;
		}
		Result = Value1;
	}
	
	else if ( bool( Bool2 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value2"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
			float Output_N59 = 0.0; Node59_Distance( CoordsOut_N2, Value_N46, Output_N59, Globals );
			float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
			float Output_N42 = 0.0; Node42_Float_Value( NF_PORT_CONSTANT( float( 0.3 ), Port_Value_N042 ), Output_N42, Globals );
			float Output_N44 = 0.0; Node44_Multiply( Output_N43, Output_N42, Output_N44, Globals );
			float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
			float Output_N138 = 0.0; Node138_Add( Output_N44, Output_N128, Output_N138, Globals );
			float Output_N123 = 0.0; Node123_Float_Parameter( Output_N123, Globals );
			float ValueOut_N152 = 0.0; Node152_Remap( Output_N59, ValueOut_N152, Output_N44, Output_N138, Output_N123, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMaxB_N152 ), Globals );
			
			Value2 = ValueOut_N152;
		}
		Result = Value2;
	}
	
	else if ( bool( Bool3 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value3"  */
		
		{
			float Result_N153 = 0.0; Node153_If_else( float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Default_N153 ), Result_N153, Globals );
			float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
			float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
			float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
			float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
			float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
			float Output_N109 = 0.0; Node109_Subtract( Output_N39, Output_N40, Output_N109, Globals );
			float Output_N112 = 0.0; Node112_Divide( Output_N109, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N112 ), Output_N112, Globals );
			float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
			float Output_N136 = 0.0; Node136_Add( Output_N112, Output_N128, Output_N136, Globals );
			float Output_N123 = 0.0; Node123_Float_Parameter( Output_N123, Globals );
			float ValueOut_N154 = 0.0; Node154_Remap( Result_N153, ValueOut_N154, Output_N112, Output_N136, Output_N123, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMaxB_N154 ), Globals );
			
			Value3 = ValueOut_N154;
		}
		Result = Value3;
	}
	
	else if ( bool( Bool4 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value4"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
			float Output_N50 = 0.0; Node50_Distance( CoordsOut_N2, Value_N46, Output_N50, Globals );
			float Output_N38 = 0.0; Node38_Float_Parameter( Output_N38, Globals );
			float Output_N36 = 0.0; Node36_Float_Value( NF_PORT_CONSTANT( float( 0.5 ), Port_Value_N036 ), Output_N36, Globals );
			float Output_N39 = 0.0; Node39_Add( Output_N38, Output_N36, Output_N39, Globals );
			float Output_N37 = 0.0; Node37_Float_Value( NF_PORT_CONSTANT( float( 0.4 ), Port_Value_N037 ), Output_N37, Globals );
			float Output_N40 = 0.0; Node40_Add( Output_N38, Output_N37, Output_N40, Globals );
			float Output_N142 = 0.0; Node142_Add( Output_N39, Output_N40, Output_N142, Globals );
			float Output_N143 = 0.0; Node143_Divide( Output_N142, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N143 ), Output_N143, Globals );
			float Output_N144 = 0.0; Node144_Subtract( Output_N50, Output_N143, Output_N144, Globals );
			float Output_N145 = 0.0; Node145_Abs( Output_N144, Output_N145, Globals );
			float Output_N147 = 0.0; Node147_Subtract( Output_N39, Output_N143, Output_N147, Globals );
			float Output_N128 = 0.0; Node128_Float_Parameter( Output_N128, Globals );
			float Output_N148 = 0.0; Node148_Add( Output_N147, Output_N128, Output_N148, Globals );
			float Output_N123 = 0.0; Node123_Float_Parameter( Output_N123, Globals );
			float ValueOut_N146 = 0.0; Node146_Remap( Output_N145, ValueOut_N146, Output_N147, Output_N148, Output_N123, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMaxB_N146 ), Globals );
			
			Value4 = ValueOut_N146;
		}
		Result = Value4;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node149_Construct_Vector( Value1, Value2, Value3, Value4, Value, Globals ) Value.r = Value1; Value.g = Value2; Value.b = Value3; Value.a = Value4
void Node88_If_else( in float Bool1, in float4 Value1, in float Bool2, in float4 Value2, in float Bool3, in float4 Value3, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
		float Output_N59 = 0.0; Node59_Distance( CoordsOut_N2, Value_N46, Output_N59, Globals );
		float Output_N43 = 0.0; Node43_Float_Parameter( Output_N43, Globals );
		float Output_N42 = 0.0; Node42_Float_Value( NF_PORT_CONSTANT( float( 0.3 ), Port_Value_N042 ), Output_N42, Globals );
		float Output_N44 = 0.0; Node44_Multiply( Output_N43, Output_N42, Output_N44, Globals );
		float Output_N60 = 0.0; Node60_Is_Less( Output_N59, Output_N44, Output_N60, Globals );
		
		Bool1 = Output_N60;
	}
	/* Input port: "Bool2"  */
	
	{
		float Result_N131 = 0.0; Node131_If_else( float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N131 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N131 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value3_N131 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Default_N131 ), Result_N131, Globals );
		
		Bool2 = Result_N131;
	}
	/* Input port: "Bool3"  */
	
	{
		float Result_N156 = 0.0; Node156_If_else( float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N156 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N156 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value3_N156 ), float( 0.0 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value4_N156 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Default_N156 ), Result_N156, Globals );
		
		Bool3 = Result_N156;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Result_N48 = float3(0.0); Node48_If_else( float( 0.0 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 0.0 ), Port_Value1_N048 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Default_N048 ), Result_N48, Globals );
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float2 ValueOut_N1 = float2(0.0); Node1_Remap( UVCoord_N0, ValueOut_N1, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N001 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N001 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N001 ), Globals );
			float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( ValueOut_N1, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_Scale_N002 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Center_N002 ), CoordsOut_N2, Globals );
			float2 Value_N46 = float2(0.0); Node46_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N046 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N046 ), Value_N46, Globals );
			float Output_N59 = 0.0; Node59_Distance( CoordsOut_N2, Value_N46, Output_N59, Globals );
			float Output_N83 = 0.0; Node83_Mix( NF_PORT_CONSTANT( float( 0.7 ), Port_Input0_N083 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N083 ), Output_N59, Output_N83, Globals );
			float4 Value_N93 = float4(0.0); Node93_Construct_Vector( Result_N48, Output_N83, Value_N93, Globals );
			
			Value1 = Value_N93;
		}
		Result = Value1;
	}
	
	else if ( bool( Bool2 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value2"  */
		
		{
			float Output_N16 = 0.0; Node16_Float_Parameter( Output_N16, Globals );
			float Output_N15 = 0.0; Node15_Float_Parameter( Output_N15, Globals );
			float Output_N17 = 0.0; Node17_Min( Output_N16, Output_N15, Output_N17, Globals );
			float4 Value_N14 = float4(0.0); Node14_Construct_Vector( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Value1_N014 ), Output_N17, Value_N14, Globals );
			
			Value2 = Value_N14;
		}
		Result = Value2;
	}
	
	else if ( bool( Bool3 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value3"  */
		
		{
			float Result_N155 = 0.0; Node155_If_else( float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), float( 0.0 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Default_N155 ), Result_N155, Globals );
			float4 Value_N149 = float4(0.0); Node149_Construct_Vector( NF_PORT_CONSTANT( float( 0.6234 ), Port_Value1_N149 ), NF_PORT_CONSTANT( float( 0.3766 ), Port_Value2_N149 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N149 ), Result_N155, Value_N149, Globals );
			
			Value3 = Value_N149;
		}
		Result = Value3;
	}
	else
	{
		
		Result = Default;
	}
}
void Node33_If_else( in float Bool1, in float4 Value1, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Output_N34 = 0.0; Node34_Bool_Parameter( Output_N34, Globals );
		
		Bool1 = Output_N34;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			Node7_Texture_2D_Object_Parameter( Globals );
			float2 Result_N10 = float2(0.0); Node10_If_else( float( 0.0 ), float2( 0.0, 0.0 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Default_N010 ), Result_N10, Globals );
			float4 Color_N8 = float4(0.0); Node8_Texture_2D_Sample( Result_N10, Color_N8, Globals );
			
			Value1 = Color_N8;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float4 Result_N88 = float4(0.0); Node88_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float( 0.0 ), float4( 0.0, 0.0, 0.0, 1.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N088 ), Result_N88, Globals );
			
			Default = Result_N88;
		}
		Result = Default;
	}
}
//-----------------------------------------------------------------------------

void main() 
{
	if (bool(sc_DepthOnly)) {
		return;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	sc_DiscardStereoFragment();
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	NF_SETUP_PREVIEW_PIXEL()
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 FinalColor = float4( 1.0, 1.0, 1.0, 1.0 );
	
	
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssGlobals Globals;	
	Globals.gTimeElapsed = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	Globals.gTimeDelta   = ( overrideTimeEnabled == 1 ) ? overrideTimeDelta : sc_TimeDelta;
	
	
	#if defined(SC_ENABLE_RT_CASTER) 
	if (bool(sc_ProxyMode)) {
		RayHitPayload rhp = GetRayTracingHitData();
		
		if (bool(sc_NoEarlyZ)) {
			if (rhp.id.x != uint(instance_id)) {
				return;
			}
		}
		
		Globals.Surface_UVCoord0 = rhp.uv0;
	} else
	#endif
	
	{
		Globals.Surface_UVCoord0 = varTex01.xy;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Result_N33 = float4(0.0); Node33_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Result_N33, Globals );
		
		FinalColor = Result_N33;
	}
	ngsAlphaTest( FinalColor.a );
	
	
	
	
	
	
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	#if defined(SC_ENABLE_RT_CASTER) 
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
	
	
}

#endif // #ifdef FRAGMENT_SHADER
