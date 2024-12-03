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
#define SC_DISABLE_FRUSTUM_CULLING


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

uniform NF_PRECISION              float  heating; // Title: Heating
SC_DECLARE_TEXTURE(Tweak_N16); // Title: Noise_texture	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Input1_N019;
uniform NF_PRECISION float Port_Input0_N003;
uniform NF_PRECISION float Port_Input1_N003;
uniform NF_PRECISION float2 Port_Input1_N002;
uniform NF_PRECISION float4 Port_Value0_N009;
uniform NF_PRECISION float Port_Position1_N009;
uniform NF_PRECISION float4 Port_Value1_N009;
uniform NF_PRECISION float4 Port_Value2_N009;
uniform NF_PRECISION float Port_Multiplier_N007;
uniform NF_PRECISION float Port_Input1_N026;
uniform NF_PRECISION float2 Port_Center_N014;
uniform NF_PRECISION float2 Port_Import_N031;
uniform NF_PRECISION float2 Port_Import_N030;
uniform NF_PRECISION float Port_Import_N029;
uniform NF_PRECISION float2 Port_Import_N023;
uniform NF_PRECISION float2 Port_Direction_N001;
uniform NF_PRECISION float Port_Speed_N001;
uniform NF_PRECISION float2 Port_Scale_N008;
uniform NF_PRECISION float2 Port_Center_N008;
uniform NF_PRECISION float Port_Input1_N024;
uniform NF_PRECISION float Port_Input1_N025;
uniform NF_PRECISION float Port_Input0_N018;
uniform NF_PRECISION float Port_Input1_N018;
uniform NF_PRECISION float Port_Input0_N035;
uniform NF_PRECISION float Port_Input1_N035;
uniform NF_PRECISION float Port_Input1_N037;
#endif	



//-----------------------------------------------------------------------



//-----------------------------------------------------------------------

#ifdef VERTEX_SHADER

//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	float3 SurfacePosition_ObjectSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node10_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
void Node13_Float_Parameter( out float Output, ssGlobals Globals ) { Output = heating; }
#define Node19_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node12_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node11_Transform_Vector( VectorIn, VectorOut, Globals ) VectorOut = ( ngsModelMatrix * float4( VectorIn.xyz, 1.0 ) ).xyz

//-----------------------------------------------------------------------

void main() 
{
	
	
	NF_SETUP_PREVIEW_VERTEX()
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	sc_Vertex_t v;
	ngsVertexShaderBegin( v );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssGlobals Globals;	
	Globals.gTimeElapsed = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	Globals.gTimeDelta   = ( overrideTimeEnabled == 1 ) ? overrideTimeDelta : sc_TimeDelta;
	Globals.SurfacePosition_ObjectSpace = ( ngsModelMatrixInverse * float4( varPos, 1.0 ) ).xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 ScreenPosition = vec4( 0.0 );
	float3 WorldPosition  = varPos;
	float3 WorldNormal    = varNormal;
	float3 WorldTangent   = varTangent.xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'WorldPosition'  */
	
	{
		float3 Position_N10 = float3(0.0); Node10_Surface_Position( Position_N10, Globals );
		float Output_N13 = 0.0; Node13_Float_Parameter( Output_N13, Globals );
		float Output_N19 = 0.0; Node19_Multiply( Output_N13, NF_PORT_CONSTANT( float( 2.5 ), Port_Input1_N019 ), Output_N19, Globals );
		float3 Output_N12 = float3(0.0); Node12_Multiply( Position_N10, Output_N19, Output_N12, Globals );
		float3 VectorOut_N11 = float3(0.0); Node11_Transform_Vector( Output_N12, VectorOut_N11, Globals );
		
		WorldPosition = VectorOut_N11;
	}
	
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

#define Node17_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node2_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node3_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
void Node9_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 9, false )
}
#define Node5_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node16_Texture_2D_Object_Parameter( Globals ) /*nothing*/
float ssSqrt( float A ) { return ( A <= 0.0 ) ? 0.0 : sqrt( A ); }
vec2  ssSqrt( vec2  A ) { return vec2( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ) ); }
vec3  ssSqrt( vec3  A ) { return vec3( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ), ( A.z <= 0.0 ) ? 0.0 : sqrt( A.z ) ); }
vec4  ssSqrt( vec4  A ) { return vec4( ( A.x <= 0.0 ) ? 0.0 : sqrt( A.x ), ( A.y <= 0.0 ) ? 0.0 : sqrt( A.y ), ( A.z <= 0.0 ) ? 0.0 : sqrt( A.z ), ( A.w <= 0.0 ) ? 0.0 : sqrt( A.w ) ); }
float ssATan( float A ) { return ( A == 0.0 ) ? 0.0 : atan( A ); }
vec2  ssATan( vec2  A ) { return vec2( ( A.x == 0.0 ) ? 0.0 : atan( A.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y ) ); }
vec3  ssATan( vec3  A ) { return vec3( ( A.x == 0.0 ) ? 0.0 : atan( A.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y ), ( A.z == 0.0 ) ? 0.0 : atan( A.z ) ); }
vec4  ssATan( vec4  A ) { return vec4( ( A.x == 0.0 ) ? 0.0 : atan( A.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y ), ( A.z == 0.0 ) ? 0.0 : atan( A.z ), ( A.w == 0.0 ) ? 0.0 : atan( A.w ) ); }
float ssATan( float A, float B ) { return ( A == 0.0 ) ? 0.0 : atan( A, B ); }
vec2  ssATan( vec2  A, vec2 B ) { return vec2( ( A.x == 0.0 ) ? 0.0 : atan( A.x, B.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y, B.y ) ); }
vec3  ssATan( vec3  A, vec3 B ) { return vec3( ( A.x == 0.0 ) ? 0.0 : atan( A.x, B.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y, B.y ), ( A.z == 0.0 ) ? 0.0 : atan( A.z, B.z ) ); }
vec4  ssATan( vec4  A, vec4 B ) { return vec4( ( A.x == 0.0 ) ? 0.0 : atan( A.x, B.x ), ( A.y == 0.0 ) ? 0.0 : atan( A.y, B.y ), ( A.z == 0.0 ) ? 0.0 : atan( A.z, B.z ), ( A.w == 0.0 ) ? 0.0 : atan( A.w, B.w ) ); }
bool N32_Direction;
#define N32_system_remap( _value, _oldMin, _oldMax, _newMin, _newMax ) ( ( _newMin ) + ( ( _value) - ( _oldMin ) ) * ( ( _newMax ) - ( _newMin ) ) / ( ( _oldMax ) - ( _oldMin ) ) )
float N32_system_pi() { return 3.141592653589793238462643383279; }
vec2 N32_UV;
vec2 N32_Scale;
float N32_RotationOffset;
vec2 N32_Center;

vec2 N32_PolarCoordinates;

vec2 N32_scaleAndRotateCoords(vec2 coordsIn, vec2 scale, float rotation, vec2 center){
	float Sin = sin( radians( rotation ) );
	float Cos = cos( radians( rotation ) );
	vec2 coordsOut = coordsIn - center;
	return vec2( dot( vec2( Cos, Sin ), coordsOut ), dot( vec2( -Sin, Cos ), coordsOut ) ) * scale + center;
}

#pragma inline 
void N32_main()
{
	vec2 uv = N32_UV;
	vec2 scale = N32_Scale * 2.0; // fix scale so default value of 1 produces a radius of 1
	uv = N32_scaleAndRotateCoords(uv, scale, N32_RotationOffset, N32_Center);
	
	// shift uv range to [-0.5, 0.5]
	uv -= N32_Center;
	
	float r = ssSqrt(uv.x * uv.x + uv.y * uv.y);
	float theta = ssATan(uv.y, uv.x);
	
	if(N32_Direction) {	// counter-clockwise
		theta = N32_system_remap(theta, -N32_system_pi(), N32_system_pi(), 0.0, 1.0);
	} else {			// clockwise
		theta = N32_system_remap(theta, -N32_system_pi(), N32_system_pi(), 1.0, 0.0);
	}	
	
	N32_PolarCoordinates = vec2(r, theta);
}
#define Node28_Droplist_Import( Value, Globals ) Value = 1.0
#define Node7_Elapsed_Time( Multiplier, Time, Globals ) Time = Globals.gTimeElapsed * Multiplier
#define Node26_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node14_Rotate_Coords( in float2 CoordsIn, in float Rotation, in float2 Center, out float2 CoordsOut, ssGlobals Globals )
{ 
	float Sin = sin( radians( Rotation ) );
	float Cos = cos( radians( Rotation ) );
	CoordsOut = CoordsIn - Center;
	CoordsOut = float2( dot( float2( Cos, Sin ), CoordsOut ), dot( float2( -Sin, Cos ), CoordsOut ) ) + Center;
}
#define Node31_Float_Import( Import, Value, Globals ) Value = Import
#define Node30_Float_Import( Import, Value, Globals ) Value = Import
#define Node29_Float_Import( Import, Value, Globals ) Value = Import
#define Node23_Float_Import( Import, Value, Globals ) Value = Import
void Node32_Polar_Coordinates( in float Direction, in float2 UV, in float2 Scale, in float RotationOffset, in float2 Center, out float2 PolarCoordinates, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	PolarCoordinates = vec2( 0.0 );
	
	
	N32_Direction = bool( Direction );
	N32_UV = UV;
	N32_Scale = Scale;
	N32_RotationOffset = RotationOffset;
	N32_Center = Center;
	
	N32_main();
	
	PolarCoordinates = N32_PolarCoordinates;
}
#define Node33_Float_Export( Value, Export, Globals ) Export = Value
#define Node1_Scroll_Coords( CoordsIn, Direction, Speed, CoordsOut, Globals ) CoordsOut = CoordsIn + ( Globals.gTimeElapsed * Speed * Direction )
#define Node8_Scale_Coords( CoordsIn, Scale, Center, CoordsOut, Globals ) CoordsOut.xy = ( CoordsIn.xy - Center ) * Scale + Center
#define Node15_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(Tweak_N16, UVCoord, 0.0)
#define Node21_Swizzle( Input, Output, Globals ) Output = Input
#define Node24_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node20_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node25_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
void Node13_Float_Parameter( out float Output, ssGlobals Globals ) { Output = heating; }
#define Node18_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node35_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node36_Min( Input0, Input1, Output, Globals ) Output = min( Input0, Input1 )
#define Node34_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node0_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node37_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
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
	
	
	{
		Globals.Surface_UVCoord0 = varTex01.xy;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float2 UVCoord_N17 = float2(0.0); Node17_Surface_UV_Coord( UVCoord_N17, Globals );
		float Output_N2 = 0.0; Node2_Distance( UVCoord_N17, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Input1_N002 ), Output_N2, Globals );
		float Output_N3 = 0.0; Node3_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N003 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N003 ), Output_N2, Output_N3, Globals );
		float4 Value_N9 = float4(0.0); Node9_Gradient( Output_N3, NF_PORT_CONSTANT( float4( 1.0, 0.789944, 0.000869764, 1.0 ), Port_Value0_N009 ), NF_PORT_CONSTANT( float( 0.3 ), Port_Position1_N009 ), NF_PORT_CONSTANT( float4( 1.0, 0.318013, 0.0943923, 1.0 ), Port_Value1_N009 ), NF_PORT_CONSTANT( float4( 1.0, 0.149126, 0.0, 1.0 ), Port_Value2_N009 ), Value_N9, Globals );
		float Output_N5 = 0.0; Node5_One_Minus( Output_N3, Output_N5, Globals );
		Node16_Texture_2D_Object_Parameter( Globals );
		float Value_N28 = 0.0; Node28_Droplist_Import( Value_N28, Globals );
		float Time_N7 = 0.0; Node7_Elapsed_Time( NF_PORT_CONSTANT( float( 1.0 ), Port_Multiplier_N007 ), Time_N7, Globals );
		float Output_N26 = 0.0; Node26_Multiply( Time_N7, NF_PORT_CONSTANT( float( 12.0 ), Port_Input1_N026 ), Output_N26, Globals );
		float2 CoordsOut_N14 = float2(0.0); Node14_Rotate_Coords( UVCoord_N17, Output_N26, NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N014 ), CoordsOut_N14, Globals );
		float2 Value_N31 = float2(0.0); Node31_Float_Import( CoordsOut_N14, Value_N31, Globals );
		float2 Value_N30 = float2(0.0); Node30_Float_Import( NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Import_N030 ), Value_N30, Globals );
		float Value_N29 = 0.0; Node29_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N029 ), Value_N29, Globals );
		float2 Value_N23 = float2(0.0); Node23_Float_Import( NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Import_N023 ), Value_N23, Globals );
		float2 PolarCoordinates_N32 = float2(0.0); Node32_Polar_Coordinates( Value_N28, Value_N31, Value_N30, Value_N29, Value_N23, PolarCoordinates_N32, Globals );
		float2 Export_N33 = float2(0.0); Node33_Float_Export( PolarCoordinates_N32, Export_N33, Globals );
		float2 CoordsOut_N1 = float2(0.0); Node1_Scroll_Coords( Export_N33, NF_PORT_CONSTANT( float2( -1.0, 0.0 ), Port_Direction_N001 ), NF_PORT_CONSTANT( float( 2.0 ), Port_Speed_N001 ), CoordsOut_N1, Globals );
		float2 CoordsOut_N8 = float2(0.0); Node8_Scale_Coords( CoordsOut_N1, NF_PORT_CONSTANT( float2( 1.0, 4.0 ), Port_Scale_N008 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N008 ), CoordsOut_N8, Globals );
		float4 Color_N15 = float4(0.0); Node15_Texture_2D_Sample( CoordsOut_N8, Color_N15, Globals );
		float Output_N21 = 0.0; Node21_Swizzle( Color_N15.x, Output_N21, Globals );
		float Output_N24 = 0.0; Node24_Pow( Output_N21, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N024 ), Output_N24, Globals );
		float Output_N20 = 0.0; Node20_Multiply( Output_N5, Output_N24, Output_N20, Globals );
		float Output_N25 = 0.0; Node25_Pow( Output_N20, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N025 ), Output_N25, Globals );
		float Output_N13 = 0.0; Node13_Float_Parameter( Output_N13, Globals );
		float Output_N18 = 0.0; Node18_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N018 ), NF_PORT_CONSTANT( float( 0.2 ), Port_Input1_N018 ), Output_N13, Output_N18, Globals );
		float Output_N35 = 0.0; Node35_Smoothstep( NF_PORT_CONSTANT( float( 1.0 ), Port_Input0_N035 ), NF_PORT_CONSTANT( float( 0.8 ), Port_Input1_N035 ), Output_N13, Output_N35, Globals );
		float Output_N36 = 0.0; Node36_Min( Output_N18, Output_N35, Output_N36, Globals );
		float Output_N34 = 0.0; Node34_Multiply( Output_N25, Output_N36, Output_N34, Globals );
		float4 Value_N0 = float4(0.0); Node0_Construct_Vector( Value_N9.xyz, Output_N34, Value_N0, Globals );
		float4 Output_N37 = float4(0.0); Node37_Multiply( Value_N0, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N037 ), Output_N37, Globals );
		
		FinalColor = Output_N37;
	}
	ngsAlphaTest( FinalColor.a );
	
	
	
	
	
	
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
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
