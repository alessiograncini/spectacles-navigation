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

uniform NF_PRECISION                                     float4 baseColor; // Title: Base Color
SC_DECLARE_TEXTURE(additional_settings_btn_refl_tex); // Title: Simple Refl. map
uniform NF_PRECISION                                     float  triggered; // Title: triggered
uniform NF_PRECISION                                     float  isToggle; // Title: isToggle
uniform NF_PRECISION                                     float4 hoverColor; // Title: Hover Color
uniform NF_PRECISION                                     float  hovered; // Title: Hovered
SC_DECLARE_TEXTURE(icon); //                             Title: Icon A
uniform NF_PRECISION                                     float2 iconScale; // Title: Icon Scale
uniform NF_PRECISION                                     float  alpha; // Title: Alpha	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float3 Port_Import_N054;
uniform NF_PRECISION float2 Port_Input1_N009;
uniform NF_PRECISION float2 Port_Input2_N009;
uniform NF_PRECISION float4 Port_Value_N026;
uniform NF_PRECISION float4 Port_Value_N027;
uniform NF_PRECISION float Port_Position1_N007;
uniform NF_PRECISION float4 Port_Input1_N019;
uniform NF_PRECISION float Port_Position2_N007;
uniform NF_PRECISION float4 Port_Value2_N007;
uniform NF_PRECISION float4 Port_Value3_N007;
uniform NF_PRECISION float Port_Input1_N014;
uniform NF_PRECISION float Port_Input0_N038;
uniform NF_PRECISION float4 Port_Input1_N043;
uniform NF_PRECISION float4 Port_Input2_N043;
uniform NF_PRECISION float Port_Input1_N031;
uniform NF_PRECISION float Port_Input1_N028;
uniform NF_PRECISION float Port_Input2_N028;
uniform NF_PRECISION float Port_Input1_N022;
uniform NF_PRECISION float Port_Input1_N034;
uniform NF_PRECISION float Port_Input1_N041;
uniform NF_PRECISION float2 Port_Center_N002;
uniform NF_PRECISION float Port_Input0_N018;
uniform NF_PRECISION float Port_Input1_N018;
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
	
	float3 SurfacePosition_ViewSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexTangent_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float3 VertexNormal_ViewSpace;
	float3 VertexNormal_ObjectSpace;
	float2 Surface_UVCoord0;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node5_Float_Parameter( out float4 Output, ssGlobals Globals ) { Output = baseColor; }
#define Node25_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node50_Texture_Object_2D_Import( Globals ) /*nothing*/
int N44_NormalSpace;
vec3 N44_system_getSurfacePositionCameraSpace() { return tempGlobals.SurfacePosition_ViewSpace; }
vec3 N44_system_getSurfaceNormal() { return tempGlobals.VertexNormal_WorldSpace; }
vec3 N44_system_getSurfaceTangent() { return tempGlobals.VertexTangent_WorldSpace; }
vec3 N44_system_getSurfaceBitangent() { return tempGlobals.VertexBinormal_WorldSpace; }
mat4 N44_system_getMatrixView() { return ngsViewMatrix; }
vec3 N44_Normal;
vec2 N44_ReflectionUV;

#pragma inline 
void N44_main()
{
	// get normal in view space
	vec3 normal = N44_Normal;
	
	if(N44_NormalSpace == 2)
	{	// tangent to world
		mat3 tangentToWorld = mat3(
			N44_system_getSurfaceTangent(),
			N44_system_getSurfaceBitangent(),
			N44_system_getSurfaceNormal()
		);
		normal = normalize(tangentToWorld * normal);
	}
	
	if(N44_NormalSpace > 0)
	{	// world to view
		normal = mat3(N44_system_getMatrixView()) * normal;
	}
	
	// technique from Ben Cloward:
	// use Camera Space Position and N44_Normal to create matcap UVs
	N44_ReflectionUV = cross(normalize(N44_system_getSurfacePositionCameraSpace()), normal).yx;
	N44_ReflectionUV.x *= -1.0; // flip U coordinate so it renders correctly
	N44_ReflectionUV = N44_ReflectionUV * 0.5 + 0.5;	// remap [0,1]
}
#define Node42_Droplist_Import( Value, Globals ) Value = 0.0
#define Node6_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_ViewSpace
#define Node54_Float_Import( Import, Value, Globals ) Value = Import
void Node44_Matcap_Reflection( in float NormalSpace, in float3 Normal, out float2 ReflectionUV, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	ReflectionUV = vec2( 0.0 );
	
	
	N44_NormalSpace = int( NormalSpace );
	N44_Normal = Normal;
	
	N44_main();
	
	ReflectionUV = N44_ReflectionUV;
}
#define Node53_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(additional_settings_btn_refl_tex, UVCoord, 0.0)
#define Node51_Float_Export( Value, Export, Globals ) Export = Value
#define Node8_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_ObjectSpace
void Node32_Split_Vector( in float4 Value, out float2 Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.xy;
	Value2 = Value.z;
	Value3 = Value.w;
}
#define Node9_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node10_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node26_Color_Value( Value, Output, Globals ) Output = Value
#define Node27_Color_Value( Value, Output, Globals ) Output = Value
void Node24_Float_Parameter( out float Output, ssGlobals Globals ) { Output = triggered; }
#define Node17_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node19_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
void Node7_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float4 Value3, out float4 Value, ssGlobals Globals )
{ 
	Ratio = clamp( Ratio, 0.0, 1.0 );
	
	if ( Ratio < Position1 )
	{
		Value = mix( Value0, Value1, clamp( Ratio / Position1, 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position2 )
	{
		Value = mix( Value1, Value2, clamp( ( Ratio - Position1 ) / ( Position2 - Position1 ), 0.0, 1.0 ) );
	}
	
	else
	{
		Value = mix( Value2, Value3, clamp( ( Ratio - Position2 ) / ( 1.0 - Position2 ), 0.0, 1.0 ) );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
	
	NF_PREVIEW_SAVE( Value, 7, false )
}
#define Node100_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node14_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
#define Node15_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node39_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node38_Subtract( Input0, Input1, Output, Globals ) Output = float4(Input0) - Input1
#define Node43_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
void Node40_Float_Parameter( out float Output, ssGlobals Globals ) { Output = isToggle; }
#define Node46_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node45_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node33_Float_Parameter( out float4 Output, ssGlobals Globals ) { Output = hoverColor; }
void Node37_Float_Parameter( out float Output, ssGlobals Globals ) { Output = hovered; }
#define Node31_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node28_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node22_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node34_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node41_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node36_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node35_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node29_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node12_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node16_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = iconScale; }
#define Node2_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node30_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(icon, UVCoord, 0.0)
void Node13_Split_Vector( in float4 Value, out float3 Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.rgb;
	Value2 = Value.a;
}
#define Node11_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, Input2 )
#define Node18_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, Input2 )
#define Node23_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node20_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
void Node1_Float_Parameter( out float Output, ssGlobals Globals ) { Output = alpha; }
#define Node21_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node3_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
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
		
		Globals.SurfacePosition_ViewSpace = ( ngsViewMatrix * float4( rhp.positionWS, 1.0 ) ).xyz;
		Globals.VertexNormal_WorldSpace   = rhp.normalWS;
		Globals.VertexTangent_WorldSpace  = rhp.tangentWS.xyz;
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
		Globals.VertexNormal_ViewSpace    = normalize( ( ngsViewMatrix * float4( Globals.VertexNormal_WorldSpace, 0.0 ) ).xyz );
		Globals.VertexNormal_ObjectSpace  = normalize( ( ngsModelMatrixInverse * float4( Globals.VertexNormal_WorldSpace, 0.0 ) ).xyz );
		Globals.Surface_UVCoord0          = rhp.uv0;
	} else
	#endif
	
	{
		Globals.SurfacePosition_ViewSpace = ( ngsViewMatrix * float4( varPos, 1.0 ) ).xyz;
		Globals.VertexNormal_WorldSpace   = normalize( varNormal );
		Globals.VertexTangent_WorldSpace  = normalize( varTangent.xyz );
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.VertexNormal_ViewSpace    = normalize( ( ngsViewMatrix * float4( Globals.VertexNormal_WorldSpace, 0.0 ) ).xyz );
		Globals.VertexNormal_ObjectSpace  = normalize( ( ngsModelMatrixInverse * float4( Globals.VertexNormal_WorldSpace, 0.0 ) ).xyz );
		Globals.Surface_UVCoord0          = varTex01.xy;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Output_N5 = float4(0.0); Node5_Float_Parameter( Output_N5, Globals );
		Node25_Texture_2D_Object_Parameter( Globals );
		Node50_Texture_Object_2D_Import( Globals );
		float Value_N42 = 0.0; Node42_Droplist_Import( Value_N42, Globals );
		float3 Normal_N6 = float3(0.0); Node6_Surface_Normal( Normal_N6, Globals );
		float3 Value_N54 = float3(0.0); Node54_Float_Import( Normal_N6, Value_N54, Globals );
		float2 ReflectionUV_N44 = float2(0.0); Node44_Matcap_Reflection( Value_N42, Value_N54, ReflectionUV_N44, Globals );
		float4 Color_N53 = float4(0.0); Node53_Texture_2D_Sample( ReflectionUV_N44, Color_N53, Globals );
		float4 Export_N51 = float4(0.0); Node51_Float_Export( Color_N53, Export_N51, Globals );
		float3 Normal_N8 = float3(0.0); Node8_Surface_Normal( Normal_N8, Globals );
		float2 Value1_N32 = float2(0.0); float Value2_N32 = 0.0; float Value3_N32 = 0.0; Node32_Split_Vector( float4( Normal_N8.xyz, 0.0 ), Value1_N32, Value2_N32, Value3_N32, Globals );
		float2 Output_N9 = float2(0.0); Node9_Scale_and_Offset( Value1_N32, NF_PORT_CONSTANT( float2( 0.85, 0.85 ), Port_Input1_N009 ), NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Input2_N009 ), Output_N9, Globals );
		float Output_N10 = 0.0; Node10_Length( Output_N9, Output_N10, Globals );
		float4 Output_N26 = float4(0.0); Node26_Color_Value( NF_PORT_CONSTANT( float4( 0.2, 0.2, 0.2, 1.0 ), Port_Value_N026 ), Output_N26, Globals );
		float4 Output_N27 = float4(0.0); Node27_Color_Value( NF_PORT_CONSTANT( float4( 0.594049, 0.594049, 0.594049, 1.0 ), Port_Value_N027 ), Output_N27, Globals );
		float Output_N24 = 0.0; Node24_Float_Parameter( Output_N24, Globals );
		float4 Output_N17 = float4(0.0); Node17_Mix( Output_N26, Output_N27, Output_N24, Output_N17, Globals );
		float4 Output_N19 = float4(0.0); Node19_Max( Output_N17, NF_PORT_CONSTANT( float4( 0.4, 0.4, 0.4, 1.0 ), Port_Input1_N019 ), Output_N19, Globals );
		float4 Value_N7 = float4(0.0); Node7_Gradient( Output_N10, Output_N17, NF_PORT_CONSTANT( float( 0.47 ), Port_Position1_N007 ), Output_N19, NF_PORT_CONSTANT( float( 0.7 ), Port_Position2_N007 ), NF_PORT_CONSTANT( float4( 0.8, 0.8, 0.8, 1.0 ), Port_Value2_N007 ), NF_PORT_CONSTANT( float4( 0.800977, 0.800977, 0.800977, 1.0 ), Port_Value3_N007 ), Value_N7, Globals );
		float4 Output_N100 = float4(0.0); Node100_Add( Export_N51, Value_N7, Output_N100, Globals );
		float4 Output_N14 = float4(0.0); Node14_Multiply( Output_N100, NF_PORT_CONSTANT( float( 1.2 ), Port_Input1_N014 ), Output_N14, Globals );
		float4 Output_N15 = float4(0.0); Node15_Multiply( Output_N5, Output_N14, Output_N15, Globals );
		float4 Output_N39 = float4(0.0); Node39_Multiply( Output_N5, Value_N7, Output_N39, Globals );
		float4 Output_N38 = float4(0.0); Node38_Subtract( NF_PORT_CONSTANT( float( 1.3 ), Port_Input0_N038 ), Output_N39, Output_N38, Globals );
		float4 Output_N43 = float4(0.0); Node43_Clamp( Output_N38, NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Input1_N043 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Input2_N043 ), Output_N43, Globals );
		float Output_N40 = 0.0; Node40_Float_Parameter( Output_N40, Globals );
		float Output_N46 = 0.0; Node46_Multiply( Output_N40, Output_N24, Output_N46, Globals );
		float4 Output_N45 = float4(0.0); Node45_Mix( Output_N15, Output_N43, Output_N46, Output_N45, Globals );
		float4 Output_N33 = float4(0.0); Node33_Float_Parameter( Output_N33, Globals );
		float Output_N37 = 0.0; Node37_Float_Parameter( Output_N37, Globals );
		float Output_N31 = 0.0; Node31_Multiply( Output_N10, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N031 ), Output_N31, Globals );
		float Output_N28 = 0.0; Node28_Clamp( Output_N31, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N028 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N028 ), Output_N28, Globals );
		float Output_N22 = 0.0; Node22_Pow( Output_N28, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N022 ), Output_N22, Globals );
		float Output_N34 = 0.0; Node34_Pow( Output_N22, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N034 ), Output_N34, Globals );
		float Output_N41 = 0.0; Node41_Multiply( Output_N34, NF_PORT_CONSTANT( float( 2.5 ), Port_Input1_N041 ), Output_N41, Globals );
		float Output_N36 = 0.0; Node36_Multiply( Output_N37, Output_N41, Output_N36, Globals );
		float4 Output_N35 = float4(0.0); Node35_Mix( Output_N45, Output_N33, Output_N36, Output_N35, Globals );
		Node29_Texture_2D_Object_Parameter( Globals );
		float2 UVCoord_N12 = float2(0.0); Node12_Surface_UV_Coord( UVCoord_N12, Globals );
		float2 Output_N16 = float2(0.0); Node16_Float_Parameter( Output_N16, Globals );
		float2 CoordsOut_N2 = float2(0.0); Node2_Scale_Coords( UVCoord_N12, Output_N16, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N002 ), CoordsOut_N2, Globals );
		float4 Color_N30 = float4(0.0); Node30_Texture_2D_Sample( CoordsOut_N2, Color_N30, Globals );
		float3 Value1_N13 = float3(0.0); float Value2_N13 = 0.0; Node13_Split_Vector( Color_N30, Value1_N13, Value2_N13, Globals );
		float4 Output_N11 = float4(0.0); Node11_Mix( Output_N35, float4( Value1_N13.xyz, 0.0 ), float4( Value2_N13 ), Output_N11, Globals );
		float Output_N18 = 0.0; Node18_Mix( NF_PORT_CONSTANT( float( 0.33 ), Port_Input0_N018 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N018 ), Output_N24, Output_N18, Globals );
		float Output_N23 = 0.0; Node23_Max( Output_N22, Output_N18, Output_N23, Globals );
		float Output_N20 = 0.0; Node20_Max( Value2_N13, Output_N23, Output_N20, Globals );
		float Output_N1 = 0.0; Node1_Float_Parameter( Output_N1, Globals );
		float Output_N21 = 0.0; Node21_Multiply( Output_N20, Output_N1, Output_N21, Globals );
		float4 Value_N3 = float4(0.0); Node3_Construct_Vector( Output_N11.xyz, Output_N21, Value_N3, Globals );
		
		FinalColor = Value_N3;
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
