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

#define SC_ENABLE_INSTANCED_RENDERING
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

uniform NF_PRECISION              float  noise_freq; // Title: Noise_freq
uniform NF_PRECISION              float  fire_scale; // Title: Fire_scale
uniform NF_PRECISION              float  range; // Title: Range
SC_DECLARE_TEXTURE(Tweak_N14); // Title: Custom Map	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Input1_N009;
uniform NF_PRECISION float Port_Input1_N007;
uniform NF_PRECISION float Port_Value2_N059;
uniform NF_PRECISION float Port_Value3_N059;
uniform NF_PRECISION float Port_Input1_N019;
uniform NF_PRECISION float Port_Multiplier_N024;
uniform NF_PRECISION float Port_Input1_N034;
uniform NF_PRECISION float Port_Value1_N031;
uniform NF_PRECISION float Port_Input1_N032;
uniform NF_PRECISION float Port_RangeMinA_N035;
uniform NF_PRECISION float Port_RangeMaxA_N035;
uniform NF_PRECISION float Port_Input1_N060;
uniform NF_PRECISION float Port_Input1_N029;
uniform NF_PRECISION float Port_Input1_N056;
uniform NF_PRECISION float Port_RangeMinA_N038;
uniform NF_PRECISION float Port_RangeMaxA_N038;
uniform NF_PRECISION float Port_Input1_N054;
uniform NF_PRECISION float Port_RangeMinA_N040;
uniform NF_PRECISION float Port_RangeMaxA_N040;
uniform NF_PRECISION float Port_Input1_N050;
uniform NF_PRECISION float4 Port_Default_N017;
uniform NF_PRECISION float Port_Input0_N006;
uniform NF_PRECISION float Port_Input1_N006;
uniform NF_PRECISION float4 Port_Value0_N010;
uniform NF_PRECISION float Port_Position1_N010;
uniform NF_PRECISION float4 Port_Value1_N010;
uniform NF_PRECISION float4 Port_Value2_N010;
uniform NF_PRECISION float4 Port_Value0_N043;
uniform NF_PRECISION float Port_Position1_N043;
uniform NF_PRECISION float4 Port_Value1_N043;
uniform NF_PRECISION float4 Port_Value2_N043;
uniform NF_PRECISION float4 Port_Value0_N044;
uniform NF_PRECISION float Port_Position1_N044;
uniform NF_PRECISION float4 Port_Value1_N044;
uniform NF_PRECISION float4 Port_Value2_N044;
uniform NF_PRECISION float4 Port_Default_N042;
uniform NF_PRECISION float Port_Rotation_N012;
uniform NF_PRECISION float2 Port_Center_N012;
uniform NF_PRECISION float4 Port_Value0_N049;
uniform NF_PRECISION float Port_Position1_N049;
uniform NF_PRECISION float4 Port_Value1_N049;
uniform NF_PRECISION float4 Port_Value2_N049;
uniform NF_PRECISION float2 Port_Direction_N013;
uniform NF_PRECISION float Port_Speed_N013;
uniform NF_PRECISION float Port_Value2_N001;
#endif	


// Attributes


#ifdef VERTEX_SHADER
attribute vec2 texture3;
#endif



//-----------------------------------------------------------------------



//-----------------------------------------------------------------------

#ifdef VERTEX_SHADER

//----------

// Interpolators

varying float2 Interpolator_UVCoord3;	

//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	float3 SurfacePosition_ObjectSpace;
	float4 VertexColor;
	float2 UVCoord3;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node3_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
#define Node8_Instance_ID( InstanceID, Globals ) InstanceID = floor( float( sc_LocalInstanceID ) + 0.5 )
#define Node9_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node7_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node59_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node58_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node2_Surface_Color( Color, Globals ) Color = Globals.VertexColor
#define Node18_Swizzle( Input, Output, Globals ) Output = Input
#define Node19_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node25_Round( Input0, Output, Globals ) Output = floor( Input0 + 0.5 )
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

float snoise(vec2 v) 
{
	if ( DEVICE_IS_FAST )
	{
		// Precompute values for skewed triangular grid
		const vec4 C = vec4(0.211324865405187,
			// (3.0-sqrt(3.0))/6.0
			0.366025403784439,
			// 0.5*(sqrt(3.0)-1.0)
			-0.577350269189626,
			// -1.0 + 2.0 * C.x
			0.024390243902439);
		// 1.0 / 41.0
		
		// First corner (x0)
		vec2 i  = floor(v + dot(v, C.yy));
		vec2 x0 = v - i + dot(i, C.xx);
		
		// Other two corners (x1, x2)
		vec2 i1 = vec2(0.0);
		i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
		vec2 x1 = x0.xy + C.xx - i1;
		vec2 x2 = x0.xy + C.zz;
		
		// Do some permutations to avoid
		// truncation effects in permutation
		i = mod289(i);
		vec3 p = permute(
			permute( i.y + vec3(0.0, i1.y, 1.0))
			+ i.x + vec3(0.0, i1.x, 1.0 ));
		
		vec3 m = max(0.5 - vec3(
				dot(x0,x0),
				dot(x1,x1),
				dot(x2,x2)
			), 0.0);
		
		m = m*m ;
		m = m*m ;
		
		// Gradients:
		//  41 pts uniformly over a line, mapped onto a diamond
		//  The ring size 17*17 = 289 is close to a multiple
		//      of 41 (41*7 = 287)
		
		vec3 x = 2.0 * fract(p * C.www) - 1.0;
		vec3 h = abs(x) - 0.5;
		vec3 ox = floor(x + 0.5);
		vec3 a0 = x - ox;
		
		// Normalise gradients implicitly by scaling m
		// Approximation of: m *= inversesqrt(a0*a0 + h*h);
		m *= 1.79284291400159 - 0.85373472095314 * (a0*a0+h*h);
		
		// Compute final noise value at P
		vec3 g = vec3(0.0);
		g.x  = a0.x  * x0.x  + h.x  * x0.y;
		g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
		return 130.0 * dot(m, g);
	}
	else
	{
		return 0.0;
	}
}
#define Node24_Elapsed_Time( Multiplier, Time, Globals ) Time = Globals.gTimeElapsed * Multiplier
#define Node34_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node30_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node28_Float_Parameter( out float Output, ssGlobals Globals ) { Output = noise_freq; }
#define Node32_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node31_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
void Node22_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
void Node41_Float_Parameter( out float Output, ssGlobals Globals ) { Output = fire_scale; }
#define Node60_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node36_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node29_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node26_Float_Parameter( out float Output, ssGlobals Globals ) { Output = range; }
#define Node27_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node35_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node56_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node57_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node20_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
void Node37_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
#define Node38_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node54_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node55_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node21_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
void Node39_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
#define Node40_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node50_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node15_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node23_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
void Node17_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float4 Color_N2 = float4(0.0); Node2_Surface_Color( Color_N2, Globals );
		float Output_N18 = 0.0; Node18_Swizzle( Color_N2.x, Output_N18, Globals );
		float Output_N19 = 0.0; Node19_Multiply( Output_N18, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N019 ), Output_N19, Globals );
		float Output_N25 = 0.0; Node25_Round( Output_N19, Output_N25, Globals );
		
		Switch = Output_N25;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float Time_N24 = 0.0; Node24_Elapsed_Time( NF_PORT_CONSTANT( float( 0.75 ), Port_Multiplier_N024 ), Time_N24, Globals );
			float4 Color_N2 = float4(0.0); Node2_Surface_Color( Color_N2, Globals );
			float Output_N18 = 0.0; Node18_Swizzle( Color_N2.x, Output_N18, Globals );
			float Output_N19 = 0.0; Node19_Multiply( Output_N18, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N019 ), Output_N19, Globals );
			float Output_N25 = 0.0; Node25_Round( Output_N19, Output_N25, Globals );
			float Output_N34 = 0.0; Node34_Add( Output_N25, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N034 ), Output_N34, Globals );
			float Output_N30 = 0.0; Node30_Add( Time_N24, Output_N34, Output_N30, Globals );
			float Output_N28 = 0.0; Node28_Float_Parameter( Output_N28, Globals );
			float Output_N32 = 0.0; Node32_Multiply( Output_N28, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N032 ), Output_N32, Globals );
			float2 Value_N31 = float2(0.0); Node31_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N031 ), Output_N32, Value_N31, Globals );
			float Noise_N22 = 0.0; Node22_Noise_Simplex( float2( Output_N30 ), Value_N31, Noise_N22, Globals );
			float Output_N41 = 0.0; Node41_Float_Parameter( Output_N41, Globals );
			float Output_N60 = 0.0; Node60_Multiply( Output_N41, NF_PORT_CONSTANT( float( 30.0 ), Port_Input1_N060 ), Output_N60, Globals );
			float Output_N36 = 0.0; Node36_Add( Output_N25, Output_N60, Output_N36, Globals );
			float Output_N29 = 0.0; Node29_Multiply( Output_N36, NF_PORT_CONSTANT( float( 0.05 ), Port_Input1_N029 ), Output_N29, Globals );
			float Output_N26 = 0.0; Node26_Float_Parameter( Output_N26, Globals );
			float Output_N27 = 0.0; Node27_Add( Output_N29, Output_N26, Output_N27, Globals );
			float ValueOut_N35 = 0.0; Node35_Remap( Noise_N22, ValueOut_N35, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N035 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N035 ), Output_N29, Output_N27, Globals );
			float Output_N56 = 0.0; Node56_Multiply( ValueOut_N35, NF_PORT_CONSTANT( float( 0.3 ), Port_Input1_N056 ), Output_N56, Globals );
			float Output_N57 = 0.0; Node57_One_Minus( Output_N56, Output_N57, Globals );
			float3 Value_N20 = float3(0.0); Node20_Construct_Vector( Output_N57, ValueOut_N35, Output_N57, Value_N20, Globals );
			
			Value0 = float4( Value_N20.xyz, 0.0 );
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		/* Input port: "Value1"  */
		
		{
			float Time_N24 = 0.0; Node24_Elapsed_Time( NF_PORT_CONSTANT( float( 0.75 ), Port_Multiplier_N024 ), Time_N24, Globals );
			float4 Color_N2 = float4(0.0); Node2_Surface_Color( Color_N2, Globals );
			float Output_N18 = 0.0; Node18_Swizzle( Color_N2.x, Output_N18, Globals );
			float Output_N19 = 0.0; Node19_Multiply( Output_N18, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N019 ), Output_N19, Globals );
			float Output_N25 = 0.0; Node25_Round( Output_N19, Output_N25, Globals );
			float Output_N34 = 0.0; Node34_Add( Output_N25, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N034 ), Output_N34, Globals );
			float Output_N30 = 0.0; Node30_Add( Time_N24, Output_N34, Output_N30, Globals );
			float Output_N28 = 0.0; Node28_Float_Parameter( Output_N28, Globals );
			float Output_N32 = 0.0; Node32_Multiply( Output_N28, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N032 ), Output_N32, Globals );
			float2 Value_N31 = float2(0.0); Node31_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N031 ), Output_N32, Value_N31, Globals );
			float Noise_N37 = 0.0; Node37_Noise_Simplex( float2( Output_N30 ), Value_N31, Noise_N37, Globals );
			float Output_N41 = 0.0; Node41_Float_Parameter( Output_N41, Globals );
			float Output_N60 = 0.0; Node60_Multiply( Output_N41, NF_PORT_CONSTANT( float( 30.0 ), Port_Input1_N060 ), Output_N60, Globals );
			float Output_N36 = 0.0; Node36_Add( Output_N25, Output_N60, Output_N36, Globals );
			float Output_N29 = 0.0; Node29_Multiply( Output_N36, NF_PORT_CONSTANT( float( 0.05 ), Port_Input1_N029 ), Output_N29, Globals );
			float Output_N26 = 0.0; Node26_Float_Parameter( Output_N26, Globals );
			float Output_N27 = 0.0; Node27_Add( Output_N29, Output_N26, Output_N27, Globals );
			float ValueOut_N38 = 0.0; Node38_Remap( Noise_N37, ValueOut_N38, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N038 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N038 ), Output_N29, Output_N27, Globals );
			float Output_N54 = 0.0; Node54_Multiply( ValueOut_N38, NF_PORT_CONSTANT( float( 0.2 ), Port_Input1_N054 ), Output_N54, Globals );
			float Output_N55 = 0.0; Node55_One_Minus( Output_N54, Output_N55, Globals );
			float3 Value_N21 = float3(0.0); Node21_Construct_Vector( Output_N55, ValueOut_N38, Output_N55, Value_N21, Globals );
			
			Value1 = float4( Value_N21.xyz, 0.0 );
		}
		Result = Value1;
	}
	else if ( ( Switch ) == 2.0 )
	{
		/* Input port: "Value2"  */
		
		{
			float Time_N24 = 0.0; Node24_Elapsed_Time( NF_PORT_CONSTANT( float( 0.75 ), Port_Multiplier_N024 ), Time_N24, Globals );
			float4 Color_N2 = float4(0.0); Node2_Surface_Color( Color_N2, Globals );
			float Output_N18 = 0.0; Node18_Swizzle( Color_N2.x, Output_N18, Globals );
			float Output_N19 = 0.0; Node19_Multiply( Output_N18, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N019 ), Output_N19, Globals );
			float Output_N25 = 0.0; Node25_Round( Output_N19, Output_N25, Globals );
			float Output_N34 = 0.0; Node34_Add( Output_N25, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N034 ), Output_N34, Globals );
			float Output_N30 = 0.0; Node30_Add( Time_N24, Output_N34, Output_N30, Globals );
			float Output_N28 = 0.0; Node28_Float_Parameter( Output_N28, Globals );
			float Output_N32 = 0.0; Node32_Multiply( Output_N28, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N032 ), Output_N32, Globals );
			float2 Value_N31 = float2(0.0); Node31_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N031 ), Output_N32, Value_N31, Globals );
			float Noise_N39 = 0.0; Node39_Noise_Simplex( float2( Output_N30 ), Value_N31, Noise_N39, Globals );
			float Output_N41 = 0.0; Node41_Float_Parameter( Output_N41, Globals );
			float Output_N60 = 0.0; Node60_Multiply( Output_N41, NF_PORT_CONSTANT( float( 30.0 ), Port_Input1_N060 ), Output_N60, Globals );
			float Output_N36 = 0.0; Node36_Add( Output_N25, Output_N60, Output_N36, Globals );
			float Output_N29 = 0.0; Node29_Multiply( Output_N36, NF_PORT_CONSTANT( float( 0.05 ), Port_Input1_N029 ), Output_N29, Globals );
			float Output_N26 = 0.0; Node26_Float_Parameter( Output_N26, Globals );
			float Output_N27 = 0.0; Node27_Add( Output_N29, Output_N26, Output_N27, Globals );
			float ValueOut_N40 = 0.0; Node40_Remap( Noise_N39, ValueOut_N40, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N040 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N040 ), Output_N29, Output_N27, Globals );
			float Output_N50 = 0.0; Node50_Multiply( ValueOut_N40, NF_PORT_CONSTANT( float( 0.1 ), Port_Input1_N050 ), Output_N50, Globals );
			float Output_N15 = 0.0; Node15_One_Minus( Output_N50, Output_N15, Globals );
			float3 Value_N23 = float3(0.0); Node23_Construct_Vector( Output_N15, ValueOut_N40, Output_N15, Value_N23, Globals );
			
			Value2 = float4( Value_N23.xyz, 0.0 );
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node16_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node6_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node61_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node5_Transform_Vector( VectorIn, VectorOut, Globals ) VectorOut = ( ngsModelMatrix * float4( VectorIn.xyz, 1.0 ) ).xyz

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
	Globals.VertexColor                 = varColor;
	Globals.UVCoord3                    = texture3;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 ScreenPosition = vec4( 0.0 );
	float3 WorldPosition  = varPos;
	float3 WorldNormal    = varNormal;
	float3 WorldTangent   = varTangent.xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'WorldPosition'  */
	
	{
		float3 Position_N3 = float3(0.0); Node3_Surface_Position( Position_N3, Globals );
		float InstanceID_N8 = 0.0; Node8_Instance_ID( InstanceID_N8, Globals );
		float Output_N9 = 0.0; Node9_Multiply( InstanceID_N8, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N009 ), Output_N9, Globals );
		float Output_N7 = 0.0; Node7_Add( Output_N9, NF_PORT_CONSTANT( float( -1.0 ), Port_Input1_N007 ), Output_N7, Globals );
		float3 Value_N59 = float3(0.0); Node59_Construct_Vector( Output_N7, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N059 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value3_N059 ), Value_N59, Globals );
		float3 Output_N58 = float3(0.0); Node58_Multiply( Position_N3, Value_N59, Output_N58, Globals );
		float4 Result_N17 = float4(0.0); Node17_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N017 ), Result_N17, Globals );
		float3 Output_N16 = float3(0.0); Node16_Multiply( Output_N58, Result_N17.xyz, Output_N16, Globals );
		float Output_N41 = 0.0; Node41_Float_Parameter( Output_N41, Globals );
		float Output_N6 = 0.0; Node6_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N006 ), NF_PORT_CONSTANT( float( 0.2 ), Port_Input1_N006 ), Output_N41, Output_N6, Globals );
		float3 Output_N61 = float3(0.0); Node61_Multiply( Output_N16, Output_N6, Output_N61, Globals );
		float3 VectorOut_N5 = float3(0.0); Node5_Transform_Vector( Output_N61, VectorOut_N5, Globals );
		
		WorldPosition = VectorOut_N5;
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
	
	Interpolator_UVCoord3 = Globals.UVCoord3;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	NF_PREVIEW_OUTPUT_VERTEX()
}

//-----------------------------------------------------------------------

#endif // #ifdef VERTEX_SHADER

//-----------------------------------------------------------------------

#ifdef FRAGMENT_SHADER

//-----------------------------------------------------------------------------

//----------

// Interpolators

varying float2 Interpolator_UVCoord3;	

//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	float4 VertexColor;
	float2 UVCoord3;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node2_Surface_Color( Color, Globals ) Color = Globals.VertexColor
#define Node18_Swizzle( Input, Output, Globals ) Output = Input
#define Node19_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node25_Round( Input0, Output, Globals ) Output = floor( Input0 + 0.5 )
#define Node0_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.UVCoord3
#define Node11_Swizzle( Input, Output, Globals ) Output = Input.y
void Node10_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 10, false )
}
void Node43_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 43, false )
}
void Node44_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 44, false )
}
void Node42_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float4 Color_N2 = float4(0.0); Node2_Surface_Color( Color_N2, Globals );
		float Output_N18 = 0.0; Node18_Swizzle( Color_N2.x, Output_N18, Globals );
		float Output_N19 = 0.0; Node19_Multiply( Output_N18, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N019 ), Output_N19, Globals );
		float Output_N25 = 0.0; Node25_Round( Output_N19, Output_N25, Globals );
		
		Switch = Output_N25;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Output_N11 = 0.0; Node11_Swizzle( UVCoord_N0, Output_N11, Globals );
			float4 Value_N10 = float4(0.0); Node10_Gradient( Output_N11, NF_PORT_CONSTANT( float4( 1.0, 0.68368, 0.145296, 1.0 ), Port_Value0_N010 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Position1_N010 ), NF_PORT_CONSTANT( float4( 1.0, 0.995392, 0.937377, 1.0 ), Port_Value1_N010 ), NF_PORT_CONSTANT( float4( 1.0, 0.682353, 0.145098, 1.0 ), Port_Value2_N010 ), Value_N10, Globals );
			
			Value0 = Value_N10;
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Output_N11 = 0.0; Node11_Swizzle( UVCoord_N0, Output_N11, Globals );
			float4 Value_N43 = float4(0.0); Node43_Gradient( Output_N11, NF_PORT_CONSTANT( float4( 1.0, 0.563622, 0.165759, 1.0 ), Port_Value0_N043 ), NF_PORT_CONSTANT( float( 0.51 ), Port_Position1_N043 ), NF_PORT_CONSTANT( float4( 1.0, 0.662745, 0.0901961, 1.0 ), Port_Value1_N043 ), NF_PORT_CONSTANT( float4( 1.0, 0.560784, 0.164706, 1.0 ), Port_Value2_N043 ), Value_N43, Globals );
			
			Value1 = Value_N43;
		}
		Result = Value1;
	}
	else if ( ( Switch ) == 2.0 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Output_N11 = 0.0; Node11_Swizzle( UVCoord_N0, Output_N11, Globals );
			float4 Value_N44 = float4(0.0); Node44_Gradient( Output_N11, NF_PORT_CONSTANT( float4( 1.0, 0.366949, 0.11696, 1.0 ), Port_Value0_N044 ), NF_PORT_CONSTANT( float( 0.55 ), Port_Position1_N044 ), NF_PORT_CONSTANT( float4( 1.0, 0.563622, 0.165759, 1.0 ), Port_Value1_N044 ), NF_PORT_CONSTANT( float4( 1.0, 0.364706, 0.113725, 1.0 ), Port_Value2_N044 ), Value_N44, Globals );
			
			Value2 = Value_N44;
		}
		Result = Value2;
	}
	else
	{
		
		Result = Default;
	}
}
#define Node46_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.UVCoord3
void Node12_Rotate_Coords( in float2 CoordsIn, in float Rotation, in float2 Center, out float2 CoordsOut, ssGlobals Globals )
{ 
	float Sin = sin( radians( Rotation ) );
	float Cos = cos( radians( Rotation ) );
	CoordsOut = CoordsIn - Center;
	CoordsOut = float2( dot( float2( Cos, Sin ), CoordsOut ), dot( float2( -Sin, Cos ), CoordsOut ) ) + Center;
}
void Node49_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 49, false )
}
#define Node14_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node13_Scroll_Coords( CoordsIn, Direction, Speed, CoordsOut, Globals ) CoordsOut = CoordsIn + ( Globals.gTimeElapsed * Speed * Direction )
#define Node45_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(Tweak_N14, UVCoord, 0.0)
#define Node52_Swizzle( Input, Output, Globals ) Output = Input
#define Node47_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node53_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
void Node51_Blend( in float4 Base, in float4 Color, out float4 Output, ssGlobals Globals )
{ 
	// Blend Mode: Normal
	
	Output.rgb = Color.rgb;
	Output.rgb = mix( Base.rgb, Output.rgb, Color.a );
	Output.a = Base.a;
}
#define Node1_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
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
		Globals.VertexColor = varColor;
		Globals.UVCoord3    = Interpolator_UVCoord3;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Result_N42 = float4(0.0); Node42_Switch( float( 0.0 ), float4( 1.0, 0.0, 0.0, 0.0 ), float4( 0.0, 1.0, 0.0, 0.0 ), float4( 0.0, 0.0, 1.0, 0.0 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 0.0 ), Port_Default_N042 ), Result_N42, Globals );
		float2 UVCoord_N46 = float2(0.0); Node46_Surface_UV_Coord( UVCoord_N46, Globals );
		float2 CoordsOut_N12 = float2(0.0); Node12_Rotate_Coords( UVCoord_N46, NF_PORT_CONSTANT( float( 90.0 ), Port_Rotation_N012 ), NF_PORT_CONSTANT( float2( 0.5, 0.5 ), Port_Center_N012 ), CoordsOut_N12, Globals );
		float4 Value_N49 = float4(0.0); Node49_Gradient( CoordsOut_N12.x, NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value0_N049 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Position1_N049 ), NF_PORT_CONSTANT( float4( 1.0, 0.00392157, 0.0, 1.0 ), Port_Value1_N049 ), NF_PORT_CONSTANT( float4( 1.0, 1.0, 1.0, 1.0 ), Port_Value2_N049 ), Value_N49, Globals );
		Node14_Texture_2D_Object_Parameter( Globals );
		float2 CoordsOut_N13 = float2(0.0); Node13_Scroll_Coords( UVCoord_N46, NF_PORT_CONSTANT( float2( 0.0, 2.0 ), Port_Direction_N013 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Speed_N013 ), CoordsOut_N13, Globals );
		float4 Color_N45 = float4(0.0); Node45_Texture_2D_Sample( CoordsOut_N13, Color_N45, Globals );
		float Output_N52 = 0.0; Node52_Swizzle( Color_N45.x, Output_N52, Globals );
		float Output_N47 = 0.0; Node47_One_Minus( Output_N52, Output_N47, Globals );
		float4 Value_N53 = float4(0.0); Node53_Construct_Vector( Value_N49.xyz, Output_N47, Value_N53, Globals );
		float4 Output_N51 = float4(0.0); Node51_Blend( Result_N42, Value_N53, Output_N51, Globals );
		float4 Value_N1 = float4(0.0); Node1_Construct_Vector( Output_N51.xyz, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N001 ), Value_N1, Globals );
		
		FinalColor = Value_N1;
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
