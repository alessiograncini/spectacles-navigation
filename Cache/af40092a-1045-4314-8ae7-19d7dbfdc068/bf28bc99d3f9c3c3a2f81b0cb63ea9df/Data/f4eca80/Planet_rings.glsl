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



// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Rotation_N001;
uniform NF_PRECISION float2 Port_Center_N001;
uniform NF_PRECISION float4 Port_Value0_N000;
uniform NF_PRECISION float Port_Position1_N000;
uniform NF_PRECISION float4 Port_Value1_N000;
uniform NF_PRECISION float Port_Position2_N000;
uniform NF_PRECISION float4 Port_Value2_N000;
uniform NF_PRECISION float Port_Position3_N000;
uniform NF_PRECISION float4 Port_Value3_N000;
uniform NF_PRECISION float Port_Position4_N000;
uniform NF_PRECISION float4 Port_Value4_N000;
uniform NF_PRECISION float Port_Position5_N000;
uniform NF_PRECISION float4 Port_Value5_N000;
uniform NF_PRECISION float Port_Position6_N000;
uniform NF_PRECISION float4 Port_Value6_N000;
uniform NF_PRECISION float4 Port_Value7_N000;
uniform NF_PRECISION float Port_Value0_N002;
uniform NF_PRECISION float Port_Position1_N002;
uniform NF_PRECISION float Port_Value1_N002;
uniform NF_PRECISION float Port_Position2_N002;
uniform NF_PRECISION float Port_Value2_N002;
uniform NF_PRECISION float Port_Position3_N002;
uniform NF_PRECISION float Port_Value3_N002;
uniform NF_PRECISION float Port_Position4_N002;
uniform NF_PRECISION float Port_Value4_N002;
uniform NF_PRECISION float Port_Position5_N002;
uniform NF_PRECISION float Port_Value5_N002;
uniform NF_PRECISION float Port_Position6_N002;
uniform NF_PRECISION float Port_Value6_N002;
uniform NF_PRECISION float Port_Position7_N002;
uniform NF_PRECISION float Port_Value7_N002;
uniform NF_PRECISION float Port_Position8_N002;
uniform NF_PRECISION float Port_Value8_N002;
uniform NF_PRECISION float Port_Position9_N002;
uniform NF_PRECISION float Port_Value9_N002;
uniform NF_PRECISION float Port_Position10_N002;
uniform NF_PRECISION float Port_Value10_N002;
uniform NF_PRECISION float Port_Position11_N002;
uniform NF_PRECISION float Port_Value11_N002;
uniform NF_PRECISION float Port_Position12_N002;
uniform NF_PRECISION float Port_Value12_N002;
uniform NF_PRECISION float Port_Position13_N002;
uniform NF_PRECISION float Port_Value13_N002;
uniform NF_PRECISION float Port_Position14_N002;
uniform NF_PRECISION float Port_Value14_N002;
uniform NF_PRECISION float Port_Value15_N002;
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

#define Node11_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node1_Rotate_Coords( in float2 CoordsIn, in float Rotation, in float2 Center, out float2 CoordsOut, ssGlobals Globals )
{ 
	float Sin = sin( radians( Rotation ) );
	float Cos = cos( radians( Rotation ) );
	CoordsOut = CoordsIn - Center;
	CoordsOut = float2( dot( float2( Cos, Sin ), CoordsOut ), dot( float2( -Sin, Cos ), CoordsOut ) ) + Center;
}
void Node0_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float Position3, in float4 Value3, in float Position4, in float4 Value4, in float Position5, in float4 Value5, in float Position6, in float4 Value6, in float4 Value7, out float4 Value, ssGlobals Globals )
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
	
	else if ( Ratio < Position3 )
	{
		Value = mix( Value2, Value3, clamp( ( Ratio - Position2 ) / ( Position3 - Position2 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position4 )
	{
		Value = mix( Value3, Value4, clamp( ( Ratio - Position3 ) / ( Position4 - Position3 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position5 )
	{
		Value = mix( Value4, Value5, clamp( ( Ratio - Position4 ) / ( Position5 - Position4 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position6 )
	{
		Value = mix( Value5, Value6, clamp( ( Ratio - Position5 ) / ( Position6 - Position5 ), 0.0, 1.0 ) );
	}
	
	else
	{
		Value = mix( Value6, Value7, clamp( ( Ratio - Position6 ) / ( 1.0 - Position6 ), 0.0, 1.0 ) );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
	
	NF_PREVIEW_SAVE( Value, 0, false )
}
void Node2_Gradient( in float Ratio, in float Value0, in float Position1, in float Value1, in float Position2, in float Value2, in float Position3, in float Value3, in float Position4, in float Value4, in float Position5, in float Value5, in float Position6, in float Value6, in float Position7, in float Value7, in float Position8, in float Value8, in float Position9, in float Value9, in float Position10, in float Value10, in float Position11, in float Value11, in float Position12, in float Value12, in float Position13, in float Value13, in float Position14, in float Value14, in float Value15, out float Value, ssGlobals Globals )
{ 
	Ratio = fract( Ratio );
	
	if ( Ratio < Position1 )
	{
		Value = mix( Value0, Value1, clamp( Ratio / Position1, 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position2 )
	{
		Value = mix( Value1, Value2, clamp( ( Ratio - Position1 ) / ( Position2 - Position1 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position3 )
	{
		Value = mix( Value2, Value3, clamp( ( Ratio - Position2 ) / ( Position3 - Position2 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position4 )
	{
		Value = mix( Value3, Value4, clamp( ( Ratio - Position3 ) / ( Position4 - Position3 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position5 )
	{
		Value = mix( Value4, Value5, clamp( ( Ratio - Position4 ) / ( Position5 - Position4 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position6 )
	{
		Value = mix( Value5, Value6, clamp( ( Ratio - Position5 ) / ( Position6 - Position5 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position7 )
	{
		Value = mix( Value6, Value7, clamp( ( Ratio - Position6 ) / ( Position7 - Position6 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position8 )
	{
		Value = mix( Value7, Value8, clamp( ( Ratio - Position7 ) / ( Position8 - Position7 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position9 )
	{
		Value = mix( Value8, Value9, clamp( ( Ratio - Position8 ) / ( Position9 - Position8 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position10 )
	{
		Value = mix( Value9, Value10, clamp( ( Ratio - Position9 ) / ( Position10 - Position9 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position11 )
	{
		Value = mix( Value10, Value11, clamp( ( Ratio - Position10 ) / ( Position11 - Position10 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position12 )
	{
		Value = mix( Value11, Value12, clamp( ( Ratio - Position11 ) / ( Position12 - Position11 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position13 )
	{
		Value = mix( Value12, Value13, clamp( ( Ratio - Position12 ) / ( Position13 - Position12 ), 0.0, 1.0 ) );
	}
	
	else if ( Ratio < Position14 )
	{
		Value = mix( Value13, Value14, clamp( ( Ratio - Position13 ) / ( Position14 - Position13 ), 0.0, 1.0 ) );
	}
	
	else
	{
		Value = mix( Value14, Value15, clamp( ( Ratio - Position14 ) / ( 1.0 - Position14 ), 0.0, 1.0 ) );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
	
	NF_PREVIEW_SAVE( float4( Value, Value, Value, 1.0 ), 2, false )
}
#define Node22_Construct_Vector( Value1, Value2, Value, Globals ) Value.rgb = Value1; Value.a = Value2
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
		float2 UVCoord_N11 = float2(0.0); Node11_Surface_UV_Coord( UVCoord_N11, Globals );
		float2 CoordsOut_N1 = float2(0.0); Node1_Rotate_Coords( UVCoord_N11, NF_PORT_CONSTANT( float( -90.0 ), Port_Rotation_N001 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N001 ), CoordsOut_N1, Globals );
		float4 Value_N0 = float4(0.0); Node0_Gradient( CoordsOut_N1.x, NF_PORT_CONSTANT( float4( 0.666667, 0.345098, 0.145098, 1.0 ), Port_Value0_N000 ), NF_PORT_CONSTANT( float( 0.13 ), Port_Position1_N000 ), NF_PORT_CONSTANT( float4( 0.968627, 0.733333, 0.329412, 1.0 ), Port_Value1_N000 ), NF_PORT_CONSTANT( float( 0.18 ), Port_Position2_N000 ), NF_PORT_CONSTANT( float4( 0.988235, 0.627451, 0.0, 1.0 ), Port_Value2_N000 ), NF_PORT_CONSTANT( float( 0.17 ), Port_Position3_N000 ), NF_PORT_CONSTANT( float4( 0.713726, 0.419608, 0.00392157, 1.0 ), Port_Value3_N000 ), NF_PORT_CONSTANT( float( 0.24 ), Port_Position4_N000 ), NF_PORT_CONSTANT( float4( 0.988235, 0.627451, 0.0, 1.0 ), Port_Value4_N000 ), NF_PORT_CONSTANT( float( 0.33 ), Port_Position5_N000 ), NF_PORT_CONSTANT( float4( 0.988235, 0.858824, 0.470588, 1.0 ), Port_Value5_N000 ), NF_PORT_CONSTANT( float( 0.47 ), Port_Position6_N000 ), NF_PORT_CONSTANT( float4( 0.988235, 0.686275, 0.341176, 1.0 ), Port_Value6_N000 ), NF_PORT_CONSTANT( float4( 0.666667, 0.345098, 0.145098, 0.0 ), Port_Value7_N000 ), Value_N0, Globals );
		float Value_N2 = 0.0; Node2_Gradient( CoordsOut_N1.x, NF_PORT_CONSTANT( float( 0.0 ), Port_Value0_N002 ), NF_PORT_CONSTANT( float( 0.06 ), Port_Position1_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N002 ), NF_PORT_CONSTANT( float( 0.08 ), Port_Position2_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N002 ), NF_PORT_CONSTANT( float( 0.09 ), Port_Position3_N002 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N002 ), NF_PORT_CONSTANT( float( 0.1 ), Port_Position4_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value4_N002 ), NF_PORT_CONSTANT( float( 0.16 ), Port_Position5_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value5_N002 ), NF_PORT_CONSTANT( float( 0.18 ), Port_Position6_N002 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value6_N002 ), NF_PORT_CONSTANT( float( 0.19 ), Port_Position7_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value7_N002 ), NF_PORT_CONSTANT( float( 0.3 ), Port_Position8_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value8_N002 ), NF_PORT_CONSTANT( float( 0.35 ), Port_Position9_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value9_N002 ), NF_PORT_CONSTANT( float( 0.36 ), Port_Position10_N002 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value10_N002 ), NF_PORT_CONSTANT( float( 0.37 ), Port_Position11_N002 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value11_N002 ), NF_PORT_CONSTANT( float( 0.41 ), Port_Position12_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value12_N002 ), NF_PORT_CONSTANT( float( 0.45 ), Port_Position13_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value13_N002 ), NF_PORT_CONSTANT( float( 0.51 ), Port_Position14_N002 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value14_N002 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value15_N002 ), Value_N2, Globals );
		float4 Value_N22 = float4(0.0); Node22_Construct_Vector( Value_N0.xyz, Value_N2, Value_N22, Globals );
		
		FinalColor = Value_N22;
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
