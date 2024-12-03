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

uniform NF_PRECISION float  height_gradient; // Title: Height_Gradient
uniform NF_PRECISION float  distance_gradient; // Title: Distance_Gradient
uniform NF_PRECISION float  alpha; // Title: Alpha	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Input1_N021;
uniform NF_PRECISION float4 Port_Value1_N025;
uniform NF_PRECISION float4 Port_Default_N025;
uniform NF_PRECISION float Port_Input1_N040;
uniform NF_PRECISION float Port_Input1_N043;
uniform NF_PRECISION float3 Port_Normal_N014;
uniform NF_PRECISION float Port_Exponent_N014;
uniform NF_PRECISION float Port_Intensity_N014;
uniform NF_PRECISION float Port_Input1_N017;
uniform NF_PRECISION float Port_Input1_N097;
uniform NF_PRECISION float Port_RangeMinA_N103;
uniform NF_PRECISION float Port_RangeMaxA_N103;
uniform NF_PRECISION float Port_RangeMinB_N103;
uniform NF_PRECISION float Port_RangeMaxB_N103;
uniform NF_PRECISION float Port_Input1_N069;
uniform NF_PRECISION float Port_Input2_N069;
uniform NF_PRECISION float Port_Value1_N076;
uniform NF_PRECISION float Port_Value3_N076;
uniform NF_PRECISION float4 Port_Value0_N077;
uniform NF_PRECISION float Port_Position1_N077;
uniform NF_PRECISION float4 Port_Value1_N077;
uniform NF_PRECISION float Port_Position2_N077;
uniform NF_PRECISION float4 Port_Value2_N077;
uniform NF_PRECISION float Port_Position3_N077;
uniform NF_PRECISION float4 Port_Value3_N077;
uniform NF_PRECISION float4 Port_Value4_N077;
uniform NF_PRECISION float Port_Amount_N080;
uniform NF_PRECISION float Port_Input1_N070;
uniform NF_PRECISION float Port_Input1_N071;
uniform NF_PRECISION float4 Port_Value0_N068;
uniform NF_PRECISION float Port_Position1_N068;
uniform NF_PRECISION float4 Port_Value1_N068;
uniform NF_PRECISION float4 Port_Value2_N068;
uniform NF_PRECISION float Port_Input1_N072;
uniform NF_PRECISION float3 Port_Default_N066;
uniform NF_PRECISION float3 Port_Value1_N038;
uniform NF_PRECISION float3 Port_Default_N038;
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

#define Node23_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
#define Node27_Swizzle( Input, Output, Globals ) Output = Input
#define Node24_Swizzle( Input, Output, Globals ) Output = Input.y
#define Node21_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
void Node25_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
		float Output_N24 = 0.0; Node24_Swizzle( Position_N23.xy, Output_N24, Globals );
		float Output_N21 = 0.0; Node21_Is_Less( Output_N24, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N021 ), Output_N21, Globals );
		
		Switch = Output_N21;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
			float Output_N24 = 0.0; Node24_Swizzle( Position_N23.xy, Output_N24, Globals );
			
			Value0 = float4( Output_N24 );
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node32_Swizzle( Input, Output, Globals ) Output = Input.z
#define Node26_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node34_Transform_Vector( VectorIn, VectorOut, Globals ) VectorOut = ( ngsModelMatrix * float4( VectorIn.xyz, 1.0 ) ).xyz

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
		float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
		float Output_N27 = 0.0; Node27_Swizzle( Position_N23.x, Output_N27, Globals );
		float4 Result_N25 = float4(0.0); Node25_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Value1_N025 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N025 ), Result_N25, Globals );
		float Output_N32 = 0.0; Node32_Swizzle( Position_N23, Output_N32, Globals );
		float3 Value_N26 = float3(0.0); Node26_Construct_Vector( Output_N27, Result_N25.x, Output_N32, Value_N26, Globals );
		float3 VectorOut_N34 = float3(0.0); Node34_Transform_Vector( Value_N26, VectorOut_N34, Globals );
		
		WorldPosition = VectorOut_N34;
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
	
	float3 SurfacePosition_ObjectSpace;
	float3 VertexTangent_WorldSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float3 ViewDirWS;
	float3 SurfacePosition_WorldSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node23_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
#define Node24_Swizzle( Input, Output, Globals ) Output = Input.y
#define Node40_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
#define Node43_Is_Less( Input0, Input1, Output, Globals ) Output = ssSmaller( Input0, Input1 )
void Node14_Rim( in float3 Normal, in float Exponent, in float Intensity, out float Rim, ssGlobals Globals )
{ 
	Normal.xyz = float3x3( Globals.VertexTangent_WorldSpace, Globals.VertexBinormal_WorldSpace, Globals.VertexNormal_WorldSpace ) * Normal.xyz;
	
	float FacingRatio = abs( dot( -Globals.ViewDirWS, Normal ) );
	
	Rim = pow( 1.0 - FacingRatio, Exponent );
	Rim = max( Rim, 0.0 );
	Rim *= Intensity;
}
#define Node90_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_WorldSpace
#define Node89_Camera_Position( Camera_Position, Globals ) Camera_Position = ngsCameraPosition
#define Node88_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node97_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node103_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
#define Node17_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node18_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node69_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
#define Node75_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
void Node22_Float_Parameter( out float Output, ssGlobals Globals ) { Output = height_gradient; }
#define Node76_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node74_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
void Node8_Float_Parameter( out float Output, ssGlobals Globals ) { Output = distance_gradient; }
#define Node79_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node78_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node77_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float Position3, in float4 Value3, in float4 Value4, out float4 Value, ssGlobals Globals )
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
	
	else
	{
		Value = mix( Value3, Value4, clamp( ( Ratio - Position3 ) / ( 1.0 - Position3 ), 0.0, 1.0 ) );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - 
	
	NF_PREVIEW_SAVE( Value, 77, false )
}
void Node80_Saturation( in float4 Input, in float Amount, out float4 Output, ssGlobals Globals )
{ 
	float DotResult = dot( Input.rgb, float3( 0.299, 0.587, 0.114 ) );
	
	Output = float4( mix( float3( DotResult ), Input.rgb, Amount ), Input.a );
}
#define Node0_Multiply( Input0, Input1, Output, Globals ) Output = float4(Input0) * Input1
#define Node70_Pixelize_Coords( Input0, Input1, Output, Globals ) Output = floor( Input0 * Input1 ) / Input1
#define Node71_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
void Node68_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 68, false )
}
#define Node72_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
#define Node67_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node66_Switch( in float Switch, in float3 Value0, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
		float Output_N24 = 0.0; Node24_Swizzle( Position_N23.xy, Output_N24, Globals );
		float Output_N43 = 0.0; Node43_Is_Less( Output_N24, NF_PORT_CONSTANT( float( 5.0 ), Port_Input1_N043 ), Output_N43, Globals );
		
		Switch = Output_N43;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float Rim_N14 = 0.0; Node14_Rim( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Normal_N014 ), NF_PORT_CONSTANT( float( 7.0 ), Port_Exponent_N014 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Intensity_N014 ), Rim_N14, Globals );
			float3 Position_N90 = float3(0.0); Node90_Surface_Position( Position_N90, Globals );
			float3 Camera_Position_N89 = float3(0.0); Node89_Camera_Position( Camera_Position_N89, Globals );
			float Output_N88 = 0.0; Node88_Distance( Position_N90, Camera_Position_N89, Output_N88, Globals );
			float Output_N97 = 0.0; Node97_Multiply( Output_N88, NF_PORT_CONSTANT( float( 0.005 ), Port_Input1_N097 ), Output_N97, Globals );
			float ValueOut_N103 = 0.0; Node103_Remap( Output_N97, ValueOut_N103, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N103 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N103 ), NF_PORT_CONSTANT( float( -100.0 ), Port_RangeMinB_N103 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMaxB_N103 ), Globals );
			float Output_N17 = 0.0; Node17_Scale_and_Offset( Rim_N14, NF_PORT_CONSTANT( float( 2000.0 ), Port_Input1_N017 ), ValueOut_N103, Output_N17, Globals );
			float Output_N18 = 0.0; Node18_One_Minus( Output_N17, Output_N18, Globals );
			float Output_N69 = 0.0; Node69_Clamp( Output_N18, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N069 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N069 ), Output_N69, Globals );
			float3 Position_N75 = float3(0.0); Node75_Surface_Position( Position_N75, Globals );
			float Output_N22 = 0.0; Node22_Float_Parameter( Output_N22, Globals );
			float3 Value_N76 = float3(0.0); Node76_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N076 ), Output_N22, NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N076 ), Value_N76, Globals );
			float Output_N74 = 0.0; Node74_Distance( Position_N75, Value_N76, Output_N74, Globals );
			float Output_N8 = 0.0; Node8_Float_Parameter( Output_N8, Globals );
			float Output_N79 = 0.0; Node79_One_Minus( Output_N8, Output_N79, Globals );
			float Output_N78 = 0.0; Node78_Multiply( Output_N74, Output_N79, Output_N78, Globals );
			float4 Value_N77 = float4(0.0); Node77_Gradient( Output_N78, NF_PORT_CONSTANT( float4( 1.0, 0.0, 0.0, 1.0 ), Port_Value0_N077 ), NF_PORT_CONSTANT( float( 0.14 ), Port_Position1_N077 ), NF_PORT_CONSTANT( float4( 1.0, 0.578103, 0.0, 1.0 ), Port_Value1_N077 ), NF_PORT_CONSTANT( float( 0.27 ), Port_Position2_N077 ), NF_PORT_CONSTANT( float4( 1.0, 0.832349, 0.473213, 1.0 ), Port_Value2_N077 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Position3_N077 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value3_N077 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value4_N077 ), Value_N77, Globals );
			float4 Output_N80 = float4(0.0); Node80_Saturation( Value_N77, NF_PORT_CONSTANT( float( 1.0 ), Port_Amount_N080 ), Output_N80, Globals );
			float4 Output_N0 = float4(0.0); Node0_Multiply( Output_N69, Output_N80, Output_N0, Globals );
			
			Value0 = Output_N0.xyz;
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		/* Input port: "Value1"  */
		
		{
			float Rim_N14 = 0.0; Node14_Rim( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Normal_N014 ), NF_PORT_CONSTANT( float( 7.0 ), Port_Exponent_N014 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Intensity_N014 ), Rim_N14, Globals );
			float3 Position_N90 = float3(0.0); Node90_Surface_Position( Position_N90, Globals );
			float3 Camera_Position_N89 = float3(0.0); Node89_Camera_Position( Camera_Position_N89, Globals );
			float Output_N88 = 0.0; Node88_Distance( Position_N90, Camera_Position_N89, Output_N88, Globals );
			float Output_N97 = 0.0; Node97_Multiply( Output_N88, NF_PORT_CONSTANT( float( 0.005 ), Port_Input1_N097 ), Output_N97, Globals );
			float ValueOut_N103 = 0.0; Node103_Remap( Output_N97, ValueOut_N103, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N103 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N103 ), NF_PORT_CONSTANT( float( -100.0 ), Port_RangeMinB_N103 ), NF_PORT_CONSTANT( float( -1.0 ), Port_RangeMaxB_N103 ), Globals );
			float Output_N17 = 0.0; Node17_Scale_and_Offset( Rim_N14, NF_PORT_CONSTANT( float( 2000.0 ), Port_Input1_N017 ), ValueOut_N103, Output_N17, Globals );
			float Output_N18 = 0.0; Node18_One_Minus( Output_N17, Output_N18, Globals );
			float Output_N69 = 0.0; Node69_Clamp( Output_N18, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N069 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N069 ), Output_N69, Globals );
			float3 Position_N75 = float3(0.0); Node75_Surface_Position( Position_N75, Globals );
			float Output_N22 = 0.0; Node22_Float_Parameter( Output_N22, Globals );
			float3 Value_N76 = float3(0.0); Node76_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N076 ), Output_N22, NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N076 ), Value_N76, Globals );
			float Output_N74 = 0.0; Node74_Distance( Position_N75, Value_N76, Output_N74, Globals );
			float Output_N8 = 0.0; Node8_Float_Parameter( Output_N8, Globals );
			float Output_N79 = 0.0; Node79_One_Minus( Output_N8, Output_N79, Globals );
			float Output_N78 = 0.0; Node78_Multiply( Output_N74, Output_N79, Output_N78, Globals );
			float4 Value_N77 = float4(0.0); Node77_Gradient( Output_N78, NF_PORT_CONSTANT( float4( 1.0, 0.0, 0.0, 1.0 ), Port_Value0_N077 ), NF_PORT_CONSTANT( float( 0.14 ), Port_Position1_N077 ), NF_PORT_CONSTANT( float4( 1.0, 0.578103, 0.0, 1.0 ), Port_Value1_N077 ), NF_PORT_CONSTANT( float( 0.27 ), Port_Position2_N077 ), NF_PORT_CONSTANT( float4( 1.0, 0.832349, 0.473213, 1.0 ), Port_Value2_N077 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Position3_N077 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value3_N077 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value4_N077 ), Value_N77, Globals );
			float4 Output_N80 = float4(0.0); Node80_Saturation( Value_N77, NF_PORT_CONSTANT( float( 1.0 ), Port_Amount_N080 ), Output_N80, Globals );
			float4 Output_N0 = float4(0.0); Node0_Multiply( Output_N69, Output_N80, Output_N0, Globals );
			float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
			float Output_N24 = 0.0; Node24_Swizzle( Position_N23.xy, Output_N24, Globals );
			float Output_N70 = 0.0; Node70_Pixelize_Coords( Output_N24, NF_PORT_CONSTANT( float( 3.0 ), Port_Input1_N070 ), Output_N70, Globals );
			float Output_N71 = 0.0; Node71_Pow( Output_N70, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N071 ), Output_N71, Globals );
			float4 Value_N68 = float4(0.0); Node68_Gradient( Output_N71, NF_PORT_CONSTANT( float4( 0.837415, 0.83743, 0.83743, 1.0 ), Port_Value0_N068 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Position1_N068 ), NF_PORT_CONSTANT( float4( 0.921431, 0.921447, 0.921447, 1.0 ), Port_Value1_N068 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value2_N068 ), Value_N68, Globals );
			float4 Output_N72 = float4(0.0); Node72_Multiply( Value_N68, NF_PORT_CONSTANT( float( 1.1 ), Port_Input1_N072 ), Output_N72, Globals );
			float4 Output_N67 = float4(0.0); Node67_Multiply( Output_N0, Output_N72, Output_N67, Globals );
			
			Value1 = Output_N67.xyz;
		}
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
void Node38_Switch( in float Switch, in float3 Value0, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float3 Position_N23 = float3(0.0); Node23_Surface_Position( Position_N23, Globals );
		float Output_N24 = 0.0; Node24_Swizzle( Position_N23.xy, Output_N24, Globals );
		float Output_N40 = 0.0; Node40_Is_Less( Output_N24, NF_PORT_CONSTANT( float( 0.1 ), Port_Input1_N040 ), Output_N40, Globals );
		
		Switch = Output_N40;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float3 Result_N66 = float3(0.0); Node66_Switch( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Default_N066 ), Result_N66, Globals );
			
			Value0 = Result_N66;
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		
		Result = Value1;
	}
	else
	{
		
		Result = Default;
	}
}
void Node73_Float_Parameter( out float Output, ssGlobals Globals ) { Output = alpha; }
#define Node86_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
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
		Globals.SurfacePosition_ObjectSpace = ( ngsModelMatrixInverse * float4( varPos, 1.0 ) ).xyz;
		Globals.VertexTangent_WorldSpace    = normalize( varTangent.xyz );
		Globals.VertexNormal_WorldSpace     = normalize( varNormal );
		Globals.VertexBinormal_WorldSpace   = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.SurfacePosition_WorldSpace  = varPos;
		Globals.ViewDirWS                   = normalize( ngsCameraPosition - Globals.SurfacePosition_WorldSpace );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float3 Result_N38 = float3(0.0); Node38_Switch( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Value1_N038 ), NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Default_N038 ), Result_N38, Globals );
		float Output_N73 = 0.0; Node73_Float_Parameter( Output_N73, Globals );
		float4 Value_N86 = float4(0.0); Node86_Construct_Vector( Result_N38, Output_N73, Value_N86, Globals );
		
		FinalColor = Value_N86;
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
