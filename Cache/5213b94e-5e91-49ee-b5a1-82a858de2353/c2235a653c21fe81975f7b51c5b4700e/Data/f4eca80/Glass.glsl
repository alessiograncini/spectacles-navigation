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


// Spec Consts

SPEC_CONST(bool) Tweak_N37 = false;


// Material Parameters ( Tweaks )

uniform NF_PRECISION                    float  reflIntensity; // Title: Reflection intensity
SC_DECLARE_TEXTURE(planet_refl_map); // Title: Reflection Map
uniform NF_PRECISION                    float4 Tweak_N2; // Title: Custom Color
uniform NF_PRECISION                    float  colorRatio; // Title: middle color ratio
uniform NF_PRECISION                    float4 Tweak_N8; // Title: Custom Color
uniform NF_PRECISION                    float4 Tweak_N9; // Title: Custom Color
SC_DECLARE_TEXTURE(Tweak_N6); //        Title: AO map	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Import_N006;
uniform NF_PRECISION float3 Port_Import_N013;
uniform NF_PRECISION float2 Port_Scale_N025;
uniform NF_PRECISION float2 Port_Center_N025;
uniform NF_PRECISION float Port_Rotation_N003;
uniform NF_PRECISION float2 Port_Center_N003;
uniform NF_PRECISION float4 Port_Input1_N029;
uniform NF_PRECISION float4 Port_Import_N038;
uniform NF_PRECISION float4 Port_Import_N031;
uniform NF_PRECISION float Port_Input0_N066;
uniform NF_PRECISION float Port_Input1_N066;
uniform NF_PRECISION float Port_RangeMinA_N033;
uniform NF_PRECISION float Port_RangeMaxA_N033;
uniform NF_PRECISION float Port_RangeMinB_N033;
uniform NF_PRECISION float Port_RangeMaxB_N033;
uniform NF_PRECISION float2 Port_Import_N032;
uniform NF_PRECISION float2 Port_Center_N047;
uniform NF_PRECISION float2 Port_Import_N058;
uniform NF_PRECISION float2 Port_Import_N060;
uniform NF_PRECISION float Port_Input1_N065;
uniform NF_PRECISION float Port_Input2_N065;
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
	
	float3 VertexNormal_WorldSpace;
	float3 VertexTangent_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float3 ViewDirWS;
	float3 SurfacePosition_WorldSpace;
	float2 Surface_UVCoord0;
	float2 Surface_UVCoord1;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node54_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( Tweak_N37 )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node1_Float_Parameter( out float Output, ssGlobals Globals ) { Output = reflIntensity; }
#define Node6_Float_Import( Import, Value, Globals ) Value = Import
#define Node10_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node7_Texture_Object_2D_Import( Globals ) /*nothing*/
int N15_NormalSpace;
vec3 N15_system_getSurfaceNormal() { return tempGlobals.VertexNormal_WorldSpace; }
vec3 N15_system_getSurfaceTangent() { return tempGlobals.VertexTangent_WorldSpace; }
vec3 N15_system_getSurfaceBitangent() { return tempGlobals.VertexBinormal_WorldSpace; }
vec3 N15_system_getCameraUp() { return ngsCameraUp; }
vec3 N15_system_getViewVector() { return tempGlobals.ViewDirWS; }
vec3 N15_Normal;
vec2 N15_ReflectionUV;

#pragma inline 
void N15_main()
{
	// get normal in World Space
	vec3 normal = N15_Normal;
	
	if(N15_NormalSpace == 1)
	{	// tangent to world
		mat3 tangentToWorld = mat3(
			N15_system_getSurfaceTangent(),
			N15_system_getSurfaceBitangent(),
			N15_system_getSurfaceNormal()
		);
		normal = normalize(tangentToWorld * normal);
	}
	
	// Construct a rotation matrix using view direction and camera up,
	// then use it to rotate the world normal. This prevents puffing
	// and warping effects when the object is close to the edge of 
	// the viewing area.
	vec3 forward = normalize(-N15_system_getViewVector());
	vec3 right = normalize(cross(forward, N15_system_getCameraUp()));
	vec3 up = cross(right, forward);
	mat3 rotationMat = mat3(
		right.x,	 up.x, forward.x,
		right.y,	 up.y, forward.y,
		right.z,	 up.z, forward.z
	);
	normal = rotationMat * normal;
	
	// convert to UVs
	N15_ReflectionUV = normal.xy * 0.5 + 0.5;
}
#define Node14_Droplist_Import( Value, Globals ) Value = 1.0
#define Node13_Float_Import( Import, Value, Globals ) Value = Import
void Node15_Matcap_Reflection( in float NormalSpace, in float3 Normal, out float2 ReflectionUV, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	ReflectionUV = vec2( 0.0 );
	
	
	N15_NormalSpace = int( NormalSpace );
	N15_Normal = Normal;
	
	N15_main();
	
	ReflectionUV = N15_ReflectionUV;
}
#define Node16_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(planet_refl_map, UVCoord, 0.0)
#define Node39_Multiply( Input0, Input1, Output, Globals ) Output = float4(Input0) * Input1
#define Node40_Float_Export( Value, Export, Globals ) Export = Value
#define Node11_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node25_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
void Node3_Rotate_Coords( in float2 CoordsIn, in float Rotation, in float2 Center, out float2 CoordsOut, ssGlobals Globals )
{ 
	float Sin = sin( radians( Rotation ) );
	float Cos = cos( radians( Rotation ) );
	CoordsOut = CoordsIn - Center;
	CoordsOut = float2( dot( float2( Cos, Sin ), CoordsOut ), dot( float2( -Sin, Cos ), CoordsOut ) ) + Center;
}
void Node2_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = Tweak_N2; }
void Node12_Float_Parameter( out float Output, ssGlobals Globals ) { Output = colorRatio; }
void Node8_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = Tweak_N8; }
void Node9_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = Tweak_N9; }
void Node0_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
{ 
	Ratio = clamp( Ratio, 0.0, 1.0 );
	
	if ( Ratio < Position1 )
	{
		Value = mix( Value0, Value1, clamp( Ratio / Position1, 0.0, 1.0 ) );
	}
	
	else
	{
		Value = mix( Value1, Value2, clamp( ( Ratio - Position1 ) / ( 1.0 - Position1 ), 0.0, 1.0 ) );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
	
	NF_PREVIEW_SAVE( Value, 0, false )
}
#define Node17_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node36_Split_Vector( in float4 Value, out float3 Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.rgb;
	Value2 = Value.a;
}
#define Node38_Float_Import( Import, Value, Globals ) Value = Import
#define Node31_Float_Import( Import, Value, Globals ) Value = Import
#define Node119_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node33_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node32_Float_Import( Import, Value, Globals ) Value = Import
#define Node47_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node58_Float_Import( Import, Value, Globals ) Value = Import
#define Node59_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node60_Float_Import( Import, Value, Globals ) Value = Import
#define Node61_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node62_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node63_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node64_Divide( Input0, Input1, Output, Globals ) Output = Input0 / Input1
#define Node65_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node66_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node67_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node68_Float_Export( Value, Export, Globals ) Export = Value
#define Node29_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, Input2 )
#define Node37_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
void Node55_If_else( in float Bool1, in float4 Value1, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	if ( bool( Tweak_N37 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float Output_N1 = 0.0; Node1_Float_Parameter( Output_N1, Globals );
			float Value_N6 = 0.0; Node6_Float_Import( Output_N1, Value_N6, Globals );
			Node10_Texture_2D_Object_Parameter( Globals );
			Node7_Texture_Object_2D_Import( Globals );
			float Value_N14 = 0.0; Node14_Droplist_Import( Value_N14, Globals );
			float3 Value_N13 = float3(0.0); Node13_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Import_N013 ), Value_N13, Globals );
			float2 ReflectionUV_N15 = float2(0.0); Node15_Matcap_Reflection( Value_N14, Value_N13, ReflectionUV_N15, Globals );
			float4 Color_N16 = float4(0.0); Node16_Texture_2D_Sample( ReflectionUV_N15, Color_N16, Globals );
			float4 Output_N39 = float4(0.0); Node39_Multiply( Value_N6, Color_N16, Output_N39, Globals );
			float4 Export_N40 = float4(0.0); Node40_Float_Export( Output_N39, Export_N40, Globals );
			float2 UVCoord_N11 = float2(0.0); Node11_Surface_UV_Coord( UVCoord_N11, Globals );
			float2 CoordsOut_N25 = float2(0.0); Node25_Scale_Coords( UVCoord_N11, NF_PORT_CONSTANT( float2( 5.0, 5.0 ), Port_Scale_N025 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N025 ), CoordsOut_N25, Globals );
			float2 CoordsOut_N3 = float2(0.0); Node3_Rotate_Coords( CoordsOut_N25, NF_PORT_CONSTANT( float( 90.0 ), Port_Rotation_N003 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N003 ), CoordsOut_N3, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float Output_N12 = 0.0; Node12_Float_Parameter( Output_N12, Globals );
			float4 Output_N8 = float4(0.0); Node8_Color_Parameter( Output_N8, Globals );
			float4 Output_N9 = float4(0.0); Node9_Color_Parameter( Output_N9, Globals );
			float4 Value_N0 = float4(0.0); Node0_Gradient( CoordsOut_N3.x, Output_N2, Output_N12, Output_N8, Output_N9, Value_N0, Globals );
			float4 Output_N17 = float4(0.0); Node17_Add( Export_N40, Value_N0, Output_N17, Globals );
			float3 Value1_N36 = float3(0.0); float Value2_N36 = 0.0; Node36_Split_Vector( Output_N17, Value1_N36, Value2_N36, Globals );
			float4 Value_N38 = float4(0.0); Node38_Float_Import( NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 1.0 ), Port_Import_N038 ), Value_N38, Globals );
			float4 Value_N31 = float4(0.0); Node31_Float_Import( NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Import_N031 ), Value_N31, Globals );
			float2 UVCoord_N119 = float2(0.0); Node119_Surface_UV_Coord( UVCoord_N119, Globals );
			float2 ValueOut_N33 = float2(0.0); Node33_Remap( UVCoord_N119, ValueOut_N33, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N033 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N033 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMinB_N033 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N033 ), Globals );
			float2 Value_N32 = float2(0.0); Node32_Float_Import( UVCoord_N11, Value_N32, Globals );
			float2 CoordsOut_N47 = float2(0.0); Node47_Scale_Coords( ValueOut_N33, Value_N32, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N047 ), CoordsOut_N47, Globals );
			float2 Value_N58 = float2(0.0); Node58_Float_Import( NF_PORT_CONSTANT( float2( 0.0, 0.65 ), Port_Import_N058 ), Value_N58, Globals );
			float2 Output_N59 = float2(0.0); Node59_Subtract( CoordsOut_N47, Value_N58, Output_N59, Globals );
			float2 Value_N60 = float2(0.0); Node60_Float_Import( NF_PORT_CONSTANT( float2( 0.0, -0.5 ), Port_Import_N060 ), Value_N60, Globals );
			float2 Output_N61 = float2(0.0); Node61_Subtract( Value_N60, Value_N58, Output_N61, Globals );
			float Output_N62 = 0.0; Node62_Dot_Product( Output_N59, Output_N61, Output_N62, Globals );
			float Output_N63 = 0.0; Node63_Dot_Product( Output_N61, Output_N61, Output_N63, Globals );
			float Output_N64 = 0.0; Node64_Divide( Output_N62, Output_N63, Output_N64, Globals );
			float Output_N65 = 0.0; Node65_Clamp( Output_N64, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N065 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N065 ), Output_N65, Globals );
			float Output_N66 = 0.0; Node66_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N066 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N066 ), Output_N65, Output_N66, Globals );
			float4 Output_N67 = float4(0.0); Node67_Mix( Value_N38, Value_N31, Output_N66, Output_N67, Globals );
			float4 Export_N68 = float4(0.0); Node68_Float_Export( Output_N67, Export_N68, Globals );
			float4 Output_N29 = float4(0.0); Node29_Mix( float4( Value2_N36 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Input1_N029 ), Export_N68, Output_N29, Globals );
			float4 Value_N37 = float4(0.0); Node37_Construct_Vector( Value1_N36, Output_N29.x, Value_N37, Globals );
			
			Value1 = Value_N37;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float Output_N1 = 0.0; Node1_Float_Parameter( Output_N1, Globals );
			float Value_N6 = 0.0; Node6_Float_Import( Output_N1, Value_N6, Globals );
			Node10_Texture_2D_Object_Parameter( Globals );
			Node7_Texture_Object_2D_Import( Globals );
			float Value_N14 = 0.0; Node14_Droplist_Import( Value_N14, Globals );
			float3 Value_N13 = float3(0.0); Node13_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Import_N013 ), Value_N13, Globals );
			float2 ReflectionUV_N15 = float2(0.0); Node15_Matcap_Reflection( Value_N14, Value_N13, ReflectionUV_N15, Globals );
			float4 Color_N16 = float4(0.0); Node16_Texture_2D_Sample( ReflectionUV_N15, Color_N16, Globals );
			float4 Output_N39 = float4(0.0); Node39_Multiply( Value_N6, Color_N16, Output_N39, Globals );
			float4 Export_N40 = float4(0.0); Node40_Float_Export( Output_N39, Export_N40, Globals );
			float2 UVCoord_N11 = float2(0.0); Node11_Surface_UV_Coord( UVCoord_N11, Globals );
			float2 CoordsOut_N25 = float2(0.0); Node25_Scale_Coords( UVCoord_N11, NF_PORT_CONSTANT( float2( 5.0, 5.0 ), Port_Scale_N025 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N025 ), CoordsOut_N25, Globals );
			float2 CoordsOut_N3 = float2(0.0); Node3_Rotate_Coords( CoordsOut_N25, NF_PORT_CONSTANT( float( 90.0 ), Port_Rotation_N003 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N003 ), CoordsOut_N3, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float Output_N12 = 0.0; Node12_Float_Parameter( Output_N12, Globals );
			float4 Output_N8 = float4(0.0); Node8_Color_Parameter( Output_N8, Globals );
			float4 Output_N9 = float4(0.0); Node9_Color_Parameter( Output_N9, Globals );
			float4 Value_N0 = float4(0.0); Node0_Gradient( CoordsOut_N3.x, Output_N2, Output_N12, Output_N8, Output_N9, Value_N0, Globals );
			float4 Output_N17 = float4(0.0); Node17_Add( Export_N40, Value_N0, Output_N17, Globals );
			
			Default = Output_N17;
		}
		Result = Default;
	}
}
#define Node18_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node19_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord1
#define Node20_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(Tweak_N6, UVCoord, 0.0)
void Node21_Blend( in float4 Base, in float4 Color, out float4 Output, ssGlobals Globals )
{ 
	// Blend Mode: Multiply
	
	Output.rgb = Color.rgb * Base.rgb;
	Output.rgb = mix( Base.rgb, Output.rgb, Color.a );
	Output.a = Base.a;
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
		
		Globals.VertexNormal_WorldSpace    = rhp.normalWS;
		Globals.VertexTangent_WorldSpace   = rhp.tangentWS.xyz;
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
		Globals.SurfacePosition_WorldSpace = rhp.positionWS;
		Globals.ViewDirWS                  = rhp.viewDirWS;
		Globals.Surface_UVCoord0           = rhp.uv0;
		Globals.Surface_UVCoord1           = rhp.uv1;
	} else
	#endif
	
	{
		Globals.VertexNormal_WorldSpace    = normalize( varNormal );
		Globals.VertexTangent_WorldSpace   = normalize( varTangent.xyz );
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.SurfacePosition_WorldSpace = varPos;
		Globals.ViewDirWS                  = normalize( ngsCameraPosition - Globals.SurfacePosition_WorldSpace );
		Globals.Surface_UVCoord0           = varTex01.xy;
		Globals.Surface_UVCoord1           = varTex01.zw;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Result_N55 = float4(0.0); Node55_If_else( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Result_N55, Globals );
		Node18_Texture_2D_Object_Parameter( Globals );
		float2 UVCoord_N19 = float2(0.0); Node19_Surface_UV_Coord( UVCoord_N19, Globals );
		float4 Color_N20 = float4(0.0); Node20_Texture_2D_Sample( UVCoord_N19, Color_N20, Globals );
		float4 Output_N21 = float4(0.0); Node21_Blend( Result_N55, Color_N20, Output_N21, Globals );
		
		FinalColor = Output_N21;
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
