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

SC_DECLARE_TEXTURE(capsule_btn_refl_tex_2); // Title: Simple Refl. map 2
SC_DECLARE_TEXTURE(capsule_btn_refl_tex_3); // Title: Simple_reflection_mask
SC_DECLARE_TEXTURE(capsule_btn_refl_tex_1); // Title: Simple Refl. map	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Import_N101;
uniform NF_PRECISION float3 Port_Import_N111;
uniform NF_PRECISION float Port_Input1_N115;
uniform NF_PRECISION float Port_Input2_N115;
uniform NF_PRECISION float Port_Import_N027;
uniform NF_PRECISION float3 Port_Import_N041;
uniform NF_PRECISION float Port_Input1_N045;
uniform NF_PRECISION float Port_Input2_N045;
uniform NF_PRECISION float4 Port_Value0_N007;
uniform NF_PRECISION float Port_Position1_N007;
uniform NF_PRECISION float4 Port_Value1_N007;
uniform NF_PRECISION float Port_Position2_N007;
uniform NF_PRECISION float4 Port_Value2_N007;
uniform NF_PRECISION float Port_Position3_N007;
uniform NF_PRECISION float4 Port_Value3_N007;
uniform NF_PRECISION float4 Port_Value4_N007;
uniform NF_PRECISION float2 Port_Input1_N028;
uniform NF_PRECISION float2 Port_Input2_N028;
uniform NF_PRECISION float4 Port_Value0_N031;
uniform NF_PRECISION float Port_Position1_N031;
uniform NF_PRECISION float4 Port_Value1_N031;
uniform NF_PRECISION float Port_Position2_N031;
uniform NF_PRECISION float4 Port_Value2_N031;
uniform NF_PRECISION float Port_Position3_N031;
uniform NF_PRECISION float4 Port_Value3_N031;
uniform NF_PRECISION float4 Port_Value4_N031;
uniform NF_PRECISION float Port_Value0_N011;
uniform NF_PRECISION float Port_Position1_N011;
uniform NF_PRECISION float Port_Value1_N011;
uniform NF_PRECISION float Port_Position2_N011;
uniform NF_PRECISION float Port_Value2_N011;
uniform NF_PRECISION float Port_Position3_N011;
uniform NF_PRECISION float Port_Value3_N011;
uniform NF_PRECISION float Port_Value4_N011;
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
	
	float3 VertexTangent_WorldSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float2 Surface_UVCoord0;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node101_Float_Import( Import, Value, Globals ) Value = Import
#define Node25_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node102_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node103_Surface_Tangent( Tangent, Globals ) Tangent = Globals.VertexTangent_WorldSpace
#define Node104_Surface_Bitangent( Binormal, Globals ) Binormal = Globals.VertexBinormal_WorldSpace
#define Node108_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_WorldSpace
#define Node110_Construct_Matrix( Column0, Column1, Column2, Matrix, Globals ) Matrix = mat3( Column0, Column1, Column2 )
#define Node111_Float_Import( Import, Value, Globals ) Value = Import
#define Node112_Transform_by_Matrix( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node113_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
#define Node114_Transform_Vector( VectorIn, VectorOut, Globals ) VectorOut = ( ngsViewMatrix * float4( VectorIn.xyz, 0.0 ) ).xyz
#define Node115_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * float3(Input1) + float3(Input2)
#define Node116_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(capsule_btn_refl_tex_2, UVCoord, 0.0)
#define Node117_Multiply( Input0, Input1, Output, Globals ) Output = float4(Input0) * Input1
#define Node118_Float_Export( Value, Export, Globals ) Export = Value
#define Node14_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node15_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node10_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(capsule_btn_refl_tex_3, UVCoord, 0.0)
#define Node2_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node27_Float_Import( Import, Value, Globals ) Value = Import
#define Node6_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node36_Texture_Object_2D_Import( Globals ) /*nothing*/
#define Node37_Surface_Tangent( Tangent, Globals ) Tangent = Globals.VertexTangent_WorldSpace
#define Node38_Surface_Bitangent( Binormal, Globals ) Binormal = Globals.VertexBinormal_WorldSpace
#define Node39_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_WorldSpace
#define Node40_Construct_Matrix( Column0, Column1, Column2, Matrix, Globals ) Matrix = mat3( Column0, Column1, Column2 )
#define Node41_Float_Import( Import, Value, Globals ) Value = Import
#define Node42_Transform_by_Matrix( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node43_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
#define Node44_Transform_Vector( VectorIn, VectorOut, Globals ) VectorOut = ( ngsViewMatrix * float4( VectorIn.xyz, 0.0 ) ).xyz
#define Node45_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * float3(Input1) + float3(Input2)
#define Node47_Texture_2D_Sample( UVCoord, Color, Globals ) Color = SC_SAMPLE_TEX_R(capsule_btn_refl_tex_1, UVCoord, 0.0)
#define Node54_Multiply( Input0, Input1, Output, Globals ) Output = float4(Input0) * Input1
#define Node55_Float_Export( Value, Export, Globals ) Export = Value
void Node7_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float Position3, in float4 Value3, in float4 Value4, out float4 Value, ssGlobals Globals )
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
}
#define Node17_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
#define Node28_Scale_and_Offset( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 + Input2
#define Node29_Length( Input0, Output, Globals ) Output = length( Input0 )
void Node31_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float Position3, in float4 Value3, in float4 Value4, out float4 Value, ssGlobals Globals )
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
}
#define Node60_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, Input2 )
void Node11_Gradient( in float Ratio, in float Value0, in float Position1, in float Value1, in float Position2, in float Value2, in float Position3, in float Value3, in float Value4, out float Value, ssGlobals Globals )
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
}
#define Node12_Construct_Vector( Value1, Value2, Value, Globals ) Value.rgb = Value1; Value.a = Value2
#define Node100_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
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
		
		Globals.VertexTangent_WorldSpace  = rhp.tangentWS.xyz;
		Globals.VertexNormal_WorldSpace   = rhp.normalWS;
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
		Globals.Surface_UVCoord0          = rhp.uv0;
	} else
	#endif
	
	{
		Globals.VertexTangent_WorldSpace  = normalize( varTangent.xyz );
		Globals.VertexNormal_WorldSpace   = normalize( varNormal );
		Globals.VertexBinormal_WorldSpace = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.Surface_UVCoord0          = varTex01.xy;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float Value_N101 = 0.0; Node101_Float_Import( NF_PORT_CONSTANT( float( 0.6 ), Port_Import_N101 ), Value_N101, Globals );
		Node25_Texture_2D_Object_Parameter( Globals );
		Node102_Texture_Object_2D_Import( Globals );
		float3 Tangent_N103 = float3(0.0); Node103_Surface_Tangent( Tangent_N103, Globals );
		float3 Binormal_N104 = float3(0.0); Node104_Surface_Bitangent( Binormal_N104, Globals );
		float3 Normal_N108 = float3(0.0); Node108_Surface_Normal( Normal_N108, Globals );
		mat3 Matrix_N110 = mat3(0.0); Node110_Construct_Matrix( Tangent_N103, Binormal_N104, Normal_N108, Matrix_N110, Globals );
		float3 Value_N111 = float3(0.0); Node111_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Import_N111 ), Value_N111, Globals );
		float3 Output_N112 = float3(0.0); Node112_Transform_by_Matrix( Matrix_N110, Value_N111, Output_N112, Globals );
		float3 Output_N113 = float3(0.0); Node113_Normalize( Output_N112, Output_N113, Globals );
		float3 VectorOut_N114 = float3(0.0); Node114_Transform_Vector( Output_N113, VectorOut_N114, Globals );
		float3 Output_N115 = float3(0.0); Node115_Scale_and_Offset( VectorOut_N114, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N115 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Input2_N115 ), Output_N115, Globals );
		float4 Color_N116 = float4(0.0); Node116_Texture_2D_Sample( Output_N115.xy, Color_N116, Globals );
		float4 Output_N117 = float4(0.0); Node117_Multiply( Value_N101, Color_N116, Output_N117, Globals );
		float4 Export_N118 = float4(0.0); Node118_Float_Export( Output_N117, Export_N118, Globals );
		Node14_Texture_2D_Object_Parameter( Globals );
		float2 UVCoord_N15 = float2(0.0); Node15_Surface_UV_Coord( UVCoord_N15, Globals );
		float4 Color_N10 = float4(0.0); Node10_Texture_2D_Sample( UVCoord_N15, Color_N10, Globals );
		float4 Output_N2 = float4(0.0); Node2_Multiply( Export_N118, Color_N10, Output_N2, Globals );
		float Value_N27 = 0.0; Node27_Float_Import( NF_PORT_CONSTANT( float( 0.7 ), Port_Import_N027 ), Value_N27, Globals );
		Node6_Texture_2D_Object_Parameter( Globals );
		Node36_Texture_Object_2D_Import( Globals );
		float3 Tangent_N37 = float3(0.0); Node37_Surface_Tangent( Tangent_N37, Globals );
		float3 Binormal_N38 = float3(0.0); Node38_Surface_Bitangent( Binormal_N38, Globals );
		float3 Normal_N39 = float3(0.0); Node39_Surface_Normal( Normal_N39, Globals );
		mat3 Matrix_N40 = mat3(0.0); Node40_Construct_Matrix( Tangent_N37, Binormal_N38, Normal_N39, Matrix_N40, Globals );
		float3 Value_N41 = float3(0.0); Node41_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 1.0 ), Port_Import_N041 ), Value_N41, Globals );
		float3 Output_N42 = float3(0.0); Node42_Transform_by_Matrix( Matrix_N40, Value_N41, Output_N42, Globals );
		float3 Output_N43 = float3(0.0); Node43_Normalize( Output_N42, Output_N43, Globals );
		float3 VectorOut_N44 = float3(0.0); Node44_Transform_Vector( Output_N43, VectorOut_N44, Globals );
		float3 Output_N45 = float3(0.0); Node45_Scale_and_Offset( VectorOut_N44, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N045 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Input2_N045 ), Output_N45, Globals );
		float4 Color_N47 = float4(0.0); Node47_Texture_2D_Sample( Output_N45.xy, Color_N47, Globals );
		float4 Output_N54 = float4(0.0); Node54_Multiply( Value_N27, Color_N47, Output_N54, Globals );
		float4 Export_N55 = float4(0.0); Node55_Float_Export( Output_N54, Export_N55, Globals );
		float4 Value_N7 = float4(0.0); Node7_Gradient( Export_N55.x, NF_PORT_CONSTANT( float4( 0.149996, 0.149996, 0.149996, 1.0 ), Port_Value0_N007 ), NF_PORT_CONSTANT( float( 0.33 ), Port_Position1_N007 ), NF_PORT_CONSTANT( float4( 0.0500038, 0.0489967, 0.0500038, 1.0 ), Port_Value1_N007 ), NF_PORT_CONSTANT( float( 0.66 ), Port_Position2_N007 ), NF_PORT_CONSTANT( float4( 0.549996, 0.526299, 0.505989, 1.0 ), Port_Value2_N007 ), NF_PORT_CONSTANT( float( 0.51 ), Port_Position3_N007 ), NF_PORT_CONSTANT( float4( 0.663355, 0.635569, 0.59736, 1.0 ), Port_Value3_N007 ), NF_PORT_CONSTANT( float4( 0.298039, 0.286275, 0.294118, 1.0 ), Port_Value4_N007 ), Value_N7, Globals );
		float2 UVCoord_N17 = float2(0.0); Node17_Surface_UV_Coord( UVCoord_N17, Globals );
		float2 Output_N28 = float2(0.0); Node28_Scale_and_Offset( UVCoord_N17, NF_PORT_CONSTANT( float2( 1.0, 2.35 ), Port_Input1_N028 ), NF_PORT_CONSTANT( float2( -0.5, -1.18 ), Port_Input2_N028 ), Output_N28, Globals );
		float Output_N29 = 0.0; Node29_Length( Output_N28, Output_N29, Globals );
		float4 Value_N31 = float4(0.0); Node31_Gradient( Output_N29, NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 1.0 ), Port_Value0_N031 ), NF_PORT_CONSTANT( float( 0.33 ), Port_Position1_N031 ), NF_PORT_CONSTANT( float4( 0.309804, 0.309804, 0.309804, 1.0 ), Port_Value1_N031 ), NF_PORT_CONSTANT( float( 0.58 ), Port_Position2_N031 ), NF_PORT_CONSTANT( float4( 0.949996, 0.949996, 0.949996, 1.0 ), Port_Value2_N031 ), NF_PORT_CONSTANT( float( 0.8 ), Port_Position3_N031 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 1.0 ), Port_Value3_N031 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 0.0, 1.0 ), Port_Value4_N031 ), Value_N31, Globals );
		float4 Output_N60 = float4(0.0); Node60_Mix( Value_N7, Value_N31, Value_N31, Output_N60, Globals );
		float Value_N11 = 0.0; Node11_Gradient( Value_N7.x, NF_PORT_CONSTANT( float( 0.1 ), Port_Value0_N011 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Position1_N011 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N011 ), NF_PORT_CONSTANT( float( 0.55 ), Port_Position2_N011 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N011 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Position3_N011 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Value3_N011 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value4_N011 ), Value_N11, Globals );
		float4 Value_N12 = float4(0.0); Node12_Construct_Vector( Output_N60.xyz, Value_N11, Value_N12, Globals );
		float4 Output_N100 = float4(0.0); Node100_Add( Output_N2, Value_N12, Output_N100, Globals );
		
		FinalColor = Output_N100;
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
