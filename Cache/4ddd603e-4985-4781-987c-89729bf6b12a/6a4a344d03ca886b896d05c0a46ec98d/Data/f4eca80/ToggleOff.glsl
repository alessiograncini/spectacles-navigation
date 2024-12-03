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

SPEC_CONST(bool) ENABLE_GLTF_LIGHTING = false;
SPEC_CONST(bool) ENABLE_EMISSIVE = false;
SPEC_CONST(int) NODE_10_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_NORMALMAP = false;
SPEC_CONST(int) NODE_8_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_METALLIC_ROUGHNESS_TEX = false;
SPEC_CONST(int) NODE_11_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_TRANSMISSION = false;
SPEC_CONST(bool) ENABLE_TRANSMISSION_TEX = false;
SPEC_CONST(int) Tweak_N30 = 0;
SPEC_CONST(bool) ENABLE_SHEEN = false;
SPEC_CONST(bool) ENABLE_SHEEN_COLOR_TEX = false;
SPEC_CONST(int) Tweak_N32 = 0;
SPEC_CONST(bool) ENABLE_SHEEN_ROUGHNESS_TEX = false;
SPEC_CONST(int) Tweak_N37 = 0;
SPEC_CONST(bool) ENABLE_CLEARCOAT = false;
SPEC_CONST(bool) ENABLE_CLEARCOAT_TEX = false;
SPEC_CONST(int) Tweak_N44 = 0;
SPEC_CONST(bool) ENABLE_CLEARCOAT_ROUGHNESS_TEX = false;
SPEC_CONST(int) Tweak_N60 = 0;
SPEC_CONST(bool) ENABLE_CLEARCOAT_NORMAL_TEX = false;
SPEC_CONST(int) Tweak_N47 = 0;
SPEC_CONST(bool) ENABLE_VERTEX_COLOR_BASE = false;
SPEC_CONST(bool) ENABLE_BASE_TEX = false;
SPEC_CONST(int) NODE_7_DROPLIST_ITEM = 0;
SPEC_CONST(bool) ENABLE_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_BASE_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_EMISSIVE_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_NORMAL_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_TRANSMISSION_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_CLEARCOAT_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM = false;
SPEC_CONST(bool) ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM = false;


// Material Parameters ( Tweaks )

uniform NF_PRECISION                              float3 emissiveFactor; // Title: Emissive Factor
SC_DECLARE_TEXTURE(emissiveTexture); //           Title: Texture
uniform NF_PRECISION                              float  normalTextureScale; // Title: Scale
SC_DECLARE_TEXTURE(normalTexture); //             Title: Texture
uniform NF_PRECISION                              float  metallicFactor; // Title: Metallic
uniform NF_PRECISION                              float  roughnessFactor; // Title: Roughness
uniform NF_PRECISION                              float  occlusionTextureStrength; // Title: Occlusion Strength
SC_DECLARE_TEXTURE(metallicRoughnessTexture); //  Title: Texture
uniform NF_PRECISION                              float  transmissionFactor; // Title: Factor
SC_DECLARE_TEXTURE(transmissionTexture); //       Title: Texture
SC_DECLARE_TEXTURE(screenTexture); //             Title: Screen Texture
uniform NF_PRECISION                              float3 sheenColorFactor; // Title: Color
SC_DECLARE_TEXTURE(sheenColorTexture); //         Title: Texture
uniform NF_PRECISION                              float  sheenRoughnessFactor; // Title: Roughness Factor
SC_DECLARE_TEXTURE(sheenRoughnessTexture); //     Title: Texture
uniform NF_PRECISION                              float  clearcoatFactor; // Title: Factor
SC_DECLARE_TEXTURE(clearcoatTexture); //          Title: Texture
uniform NF_PRECISION                              float  clearcoatRoughnessFactor; // Title: Roughness Factor
SC_DECLARE_TEXTURE(clearcoatRoughnessTexture); // Title: Texture
SC_DECLARE_TEXTURE(clearcoatNormalTexture); //    Title: Texture
SC_DECLARE_TEXTURE(baseColorTexture); //          Title: Texture
uniform NF_PRECISION                              float4 baseColorFactor; // Title: Base Color
uniform NF_PRECISION                              float2 baseColorTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 baseColorTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  baseColorTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 emissiveTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 emissiveTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  emissiveTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 normalTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 normalTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  normalTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 metallicRoughnessTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 metallicRoughnessTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  metallicRoughnessTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 transmissionTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 transmissionTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  transmissionTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 sheenColorTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 sheenColorTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  sheenColorTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 sheenRoughnessTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 sheenRoughnessTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  sheenRoughnessTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 clearcoatTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 clearcoatTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  clearcoatTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 clearcoatNormalTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 clearcoatNormalTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  clearcoatNormalTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float2 clearcoatRoughnessTexture_offset; // Title: Offset
uniform NF_PRECISION                              float2 clearcoatRoughnessTexture_scale; // Title: Scale
uniform NF_PRECISION                              float  clearcoatRoughnessTexture_rotation; // Title: Rotation
uniform NF_PRECISION                              float  colorMultiplier; // Title: Color Multiplier	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_DebugSheenEnvLightMult_N003;
uniform NF_PRECISION float Port_DebugSheenPunctualLightMult_N003;
uniform NF_PRECISION float Port_Input2_N043;
uniform NF_PRECISION float Port_Input2_N062;
uniform NF_PRECISION float3 Port_SpecularAO_N036;
uniform NF_PRECISION float3 Port_Albedo_N405;
uniform NF_PRECISION float Port_Opacity_N405;
uniform NF_PRECISION float3 Port_Emissive_N405;
uniform NF_PRECISION float Port_Metallic_N405;
uniform NF_PRECISION float3 Port_SpecularAO_N405;
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
	float3 SurfacePosition_WorldSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexTangent_WorldSpace;
	float3 VertexBinormal_WorldSpace;
	float2 Surface_UVCoord0;
	float2 Surface_UVCoord1;
	float2 gScreenCoord;
	float4 VertexColor;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node16_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_GLTF_LIGHTING )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
bool N31_EnableTransmission_evaluate() { return bool( ENABLE_TRANSMISSION ); }
bool N31_EnableSheen_evaluate() { return bool( ENABLE_SHEEN ); }
bool N31_EnableClearcoat_evaluate() { return bool( ENABLE_CLEARCOAT ); }
#define N31_system_linearToSrgb( value ) ssLinear_to_SRGB( value )
#define N31_system_srgbToLinear( value ) ssSRGB_to_Linear( value )
vec4 N31_PbrIn;

bool N31_EnableTransmission;
float N31_Opacity;
vec3 N31_Background;

bool N31_EnableSheen;
vec4 N31_SheenColor;

bool N31_EnableClearcoat;
float N31_ClearcoatBase;
vec4 N31_ClearcoatColor;

vec4 N31_Result;

#pragma inline 
void N31_main()
{
	N31_Result = N31_PbrIn;
	
	if(N31_EnableSheen || N31_EnableTransmission || N31_EnableClearcoat) {
		N31_Result = N31_system_srgbToLinear( N31_Result );
		
		// Sheen
		if(N31_EnableSheen) {
			float albedoScaling = N31_SheenColor.a;
			N31_Result.rgb = (N31_Result.rgb * albedoScaling) + N31_SheenColor.rgb;
		}
		
		if(N31_EnableTransmission) {
			N31_Result = mix(vec4(N31_Background, 1.0), N31_Result, N31_system_srgbToLinear(N31_Opacity));
			N31_Result.a = 1.0;
		}
		
		if(N31_EnableClearcoat) {
			vec4 clearcoatFinal = N31_ClearcoatBase * N31_system_srgbToLinear(N31_ClearcoatColor);
			N31_Result.rgb += clearcoatFinal.rgb;
		}
		
		N31_Result = N31_system_linearToSrgb(N31_Result);
	}
	
}
float ssPow( float A, float B ) { return ( A <= 0.0 ) ? 0.0 : pow( A, B ); }
vec2  ssPow( vec2  A, vec2  B ) { return vec2( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ) ); }
vec3  ssPow( vec3  A, vec3  B ) { return vec3( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ), ( A.z <= 0.0 ) ? 0.0 : pow( A.z, B.z ) ); }
vec4  ssPow( vec4  A, vec4  B ) { return vec4( ( A.x <= 0.0 ) ? 0.0 : pow( A.x, B.x ), ( A.y <= 0.0 ) ? 0.0 : pow( A.y, B.y ), ( A.z <= 0.0 ) ? 0.0 : pow( A.z, B.z ), ( A.w <= 0.0 ) ? 0.0 : pow( A.w, B.w ) ); }
bool N3_EnableEmissiveTexture_evaluate() { return bool( ENABLE_EMISSIVE ); }
vec4 N3_EmissiveTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(emissiveTexture, coords, 0.0); return _result_memfunc; }
int N3_EmissiveTextureCoord_evaluate() { return int( NODE_10_DROPLIST_ITEM ); }
bool N3_EnableNormalTexture_evaluate() { return bool( ENABLE_NORMALMAP ); }
vec4 N3_NormalTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(normalTexture, coords, 0.0); return _result_memfunc; }
int N3_NormalTextureCoord_evaluate() { return int( NODE_8_DROPLIST_ITEM ); }
bool N3_EnableMetallicRoughnessTexture_evaluate() { return bool( ENABLE_METALLIC_ROUGHNESS_TEX ); }
vec4 N3_MaterialParamsTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(metallicRoughnessTexture, coords, 0.0); return _result_memfunc; }
int N3_MaterialParamsTextureCoord_evaluate() { return int( NODE_11_DROPLIST_ITEM ); }
bool N3_TransmissionEnable_evaluate() { return bool( ENABLE_TRANSMISSION ); }
bool N3_EnableTransmissionTexture_evaluate() { return bool( ENABLE_TRANSMISSION_TEX ); }
vec4 N3_TransmissionTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(transmissionTexture, coords, 0.0); return _result_memfunc; }
int N3_TransmissionTextureCoord_evaluate() { return int( Tweak_N30 ); }
vec4 N3_ScreenTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(screenTexture, coords, 0.0); return _result_memfunc; }
bool N3_SheenEnable_evaluate() { return bool( ENABLE_SHEEN ); }
bool N3_EnableSheenTexture_evaluate() { return bool( ENABLE_SHEEN_COLOR_TEX ); }
vec4 N3_SheenColorTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(sheenColorTexture, coords, 0.0); return _result_memfunc; }
int N3_SheenColorTextureCoord_evaluate() { return int( Tweak_N32 ); }
bool N3_EnableSheenRoughnessTexture_evaluate() { return bool( ENABLE_SHEEN_ROUGHNESS_TEX ); }
vec4 N3_SheenRoughnessTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(sheenRoughnessTexture, coords, 0.0); return _result_memfunc; }
int N3_SheenRoughnessTextureCoord_evaluate() { return int( Tweak_N37 ); }
bool N3_ClearcoatEnable_evaluate() { return bool( ENABLE_CLEARCOAT ); }
bool N3_EnableClearcoatTexture_evaluate() { return bool( ENABLE_CLEARCOAT_TEX ); }
vec4 N3_ClearcoatTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(clearcoatTexture, coords, 0.0); return _result_memfunc; }
int N3_ClearcoatTextureCoord_evaluate() { return int( Tweak_N44 ); }
bool N3_EnableClearCoatRoughnessTexture_evaluate() { return bool( ENABLE_CLEARCOAT_ROUGHNESS_TEX ); }
vec4 N3_ClearcoatRoughnessTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(clearcoatRoughnessTexture, coords, 0.0); return _result_memfunc; }
int N3_ClearcoatRoughnessTextureCoord_evaluate() { return int( Tweak_N60 ); }
bool N3_EnableClearCoatNormalTexture_evaluate() { return bool( ENABLE_CLEARCOAT_NORMAL_TEX ); }
vec4 N3_ClearcoatNormalMap_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(clearcoatNormalTexture, coords, 0.0); return _result_memfunc; }
int N3_ClearcoatNormalMapCoord_evaluate() { return int( Tweak_N47 ); }
bool N3_EnableTextureTransform_evaluate() { return bool( ENABLE_TEXTURE_TRANSFORM ); }
bool N3_EmissiveTextureTransform_evaluate() { return bool( ENABLE_EMISSIVE_TEXTURE_TRANSFORM ); }
bool N3_NormalTextureTransform_evaluate() { return bool( ENABLE_NORMAL_TEXTURE_TRANSFORM ); }
bool N3_MaterialParamsTextureTransform_evaluate() { return bool( ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM ); }
bool N3_TransmissionTextureTransform_evaluate() { return bool( ENABLE_TRANSMISSION_TEXTURE_TRANSFORM ); }
bool N3_SheenColorTextureTransform_evaluate() { return bool( ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM ); }
bool N3_SheenRoughnessTextureTransform_evaluate() { return bool( ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM ); }
bool N3_ClearcoatTextureTransform_evaluate() { return bool( ENABLE_CLEARCOAT_TEXTURE_TRANSFORM ); }
bool N3_ClearcoatNormalTextureTransform_evaluate() { return bool( ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM ); }
bool N3_ClearcoatRoughnessTextureTransform_evaluate() { return bool( ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM ); }
vec3 N3_system_getSurfacePosition() { return tempGlobals.SurfacePosition_WorldSpace; }
vec3 N3_system_getSurfaceNormal() { return tempGlobals.VertexNormal_WorldSpace; }
vec3 N3_system_getSurfaceTangent() { return tempGlobals.VertexTangent_WorldSpace; }
vec3 N3_system_getSurfaceBitangent() { return tempGlobals.VertexBinormal_WorldSpace; }
vec2 N3_system_getSurfaceUVCoord0() { return tempGlobals.Surface_UVCoord0; }
vec2 N3_system_getSurfaceUVCoord1() { return tempGlobals.Surface_UVCoord1; }
vec2 N3_system_getScreenUVCoord() { return tempGlobals.gScreenCoord; }
int N3_system_getDirectionalLightCount() { int _result_builtin = int( 0.0 ); _result_builtin = sc_DirectionalLightsCount; return _result_builtin; }

vec3 N3_system_getDirectionalLightDirection( int index )
{
	vec3 _result_builtin = vec3( 0.0 );
	if ( index < sc_DirectionalLightsCount )
	{
		_result_builtin = -sc_DirectionalLights[index].direction;			
	}
	return _result_builtin;
}

vec3 N3_system_getDirectionalLightColor( int index )
{
	vec3 _result_builtin = vec3( 0.0 );
	if ( index < sc_DirectionalLightsCount )
	{
		_result_builtin = sc_DirectionalLights[index].color.rgb;			
	}
	return _result_builtin;
}

float N3_system_getDirectionalLightIntensity( int index )
{
	float _result_builtin = float( 0.0 );
	if ( index < sc_DirectionalLightsCount )
	{
		_result_builtin = sc_DirectionalLights[index].color.a;			
	}
	return _result_builtin;
}
int N3_system_getPointLightCount() { int _result_builtin = int( 0.0 ); _result_builtin = sc_PointLightsCount; return _result_builtin; }

vec3 N3_system_getPointLightPosition( int index )
{
	vec3 _result_builtin = vec3( 0.0 );
	if ( index < sc_PointLightsCount )
	{
		_result_builtin = sc_PointLights[index].position;
	}
	return _result_builtin;
}

vec3 N3_system_getPointLightColor( int index )
{
	vec3 _result_builtin = vec3( 0.0 );
	if ( index < sc_PointLightsCount )
	{
		_result_builtin = sc_PointLights[index].color.rgb;			
	}
	return _result_builtin;
}

float N3_system_getPointLightIntensity( int index )
{
	float _result_builtin = float( 0.0 );
	if ( index < sc_PointLightsCount )
	{
		_result_builtin = sc_PointLights[index].color.a;			
	}
	return _result_builtin;
}
int N3_system_getAmbientLightCount() { int _result_builtin = int( 0.0 ); _result_builtin = sc_AmbientLightsCount; return _result_builtin; }

vec3 N3_system_getAmbientLightColor( int index )
{
	vec3 _result_builtin = vec3( 0.0 );
	if ( index < sc_AmbientLightsCount )
	{
		_result_builtin = sc_AmbientLights[index].color;			
	}
	return _result_builtin;
}

float N3_system_getAmbientLightIntensity( int index )
{
	float _result_builtin = float( 0.0 );
	if ( index < sc_AmbientLightsCount )
	{
		_result_builtin = sc_AmbientLights[index].intensity;			
	}
	return _result_builtin;
}
vec3 N3_system_getCameraPosition() { return ngsCameraPosition; }
#define N3_system_remap( _value, _oldMin, _oldMax, _newMin, _newMax ) ( ( _newMin ) + ( ( _value) - ( _oldMin ) ) * ( ( _newMax ) - ( _newMin ) ) / ( ( _oldMax ) - ( _oldMin ) ) )
vec3 N3_system_sampleSpecularEnvironment( vec3 direction, float lod ) { vec3 _result_builtin = vec3( 0.0 ); _result_builtin = sampleSpecularEnvmapLod( direction, lod ); return _result_builtin; }
#define N3_system_linearToSrgb( value ) ssLinear_to_SRGB( value )
#define N3_system_srgbToLinear( value ) ssSRGB_to_Linear( value )
float N3_system_pi() { return 3.141592653589793238462643383279; }
float N3_DebugSheenEnvLightMult;
float N3_DebugSheenPunctualLightMult;

vec3 N3_EmissiveColor;
bool N3_EnableEmissiveTexture;

int N3_EmissiveTextureCoord;

bool N3_EnableNormalTexture;
float N3_NormalScale;

int N3_NormalTextureCoord;

float N3_MetallicValue;
float N3_RoughnessValue;
bool N3_EnableMetallicRoughnessTexture;
float N3_OcclusionStrength;

int N3_MaterialParamsTextureCoord;

bool N3_TransmissionEnable;
float N3_TransmissionFactor;
bool N3_EnableTransmissionTexture;

int N3_TransmissionTextureCoord;

bool N3_SheenEnable;
vec3 N3_SheenColorFactor;
bool N3_EnableSheenTexture;

int N3_SheenColorTextureCoord;
float N3_SheenRoughnessFactor;
bool N3_EnableSheenRoughnessTexture;

int N3_SheenRoughnessTextureCoord;

bool N3_ClearcoatEnable;
float N3_ClearcoatFactor;
bool N3_EnableClearcoatTexture;

int N3_ClearcoatTextureCoord;
float N3_ClearcoatRoughnessFactor;
bool N3_EnableClearCoatRoughnessTexture;

int N3_ClearcoatRoughnessTextureCoord;
bool N3_EnableClearCoatNormalTexture;

int N3_ClearcoatNormalMapCoord;

vec3 N3_BaseColorIn;
float N3_OpacityIn;

bool N3_EnableTextureTransform;

bool N3_EmissiveTextureTransform;
vec2 N3_EmissiveTextureOffset;
vec2 N3_EmissiveTextureScale;
float N3_EmissiveTextureRotation;

bool N3_NormalTextureTransform;
vec2 N3_NormalTextureOffset;
vec2 N3_NormalTextureScale;
float N3_NormalTextureRotation;

bool N3_MaterialParamsTextureTransform;
vec2 N3_MaterialParamsTextureOffset;
vec2 N3_MaterialParamsTextureScale;
float N3_MaterialParamsTextureRotation;

bool N3_TransmissionTextureTransform;
vec2 N3_TransmissionTextureOffset;
vec2 N3_TransmissionTextureScale;
float N3_TransmissionTextureRotation;

bool N3_SheenColorTextureTransform;
vec2 N3_SheenColorTextureOffset;
vec2 N3_SheenColorTextureScale;
float N3_SheenColorTextureRotation;
bool N3_SheenRoughnessTextureTransform;
vec2 N3_SheenRoughnessTextureOffset;
vec2 N3_SheenRoughnessTextureScale;
float N3_SheenRoughnessTextureRotation;

bool N3_ClearcoatTextureTransform;
vec2 N3_ClearcoatTextureOffset;
vec2 N3_ClearcoatTextureScale;
float N3_ClearcoatTextureRotation;
bool N3_ClearcoatNormalTextureTransform;
vec2 N3_ClearcoatNormalTextureOffset;
vec2 N3_ClearcoatNormalTextureScale;
float N3_ClearcoatNormalTextureRotation;
bool N3_ClearcoatRoughnessTextureTransform;
vec2 N3_ClearcoatRoughnessTextureOffset;
vec2 N3_ClearcoatRoughnessTextureScale;
float N3_ClearcoatRoughnessTextureRotation;

vec3 N3_BaseColor;
float N3_Opacity;
vec3 N3_Normal;
vec3 N3_Emissive;
float N3_Metallic;
float N3_Roughness;
vec4 N3_Occlusion;
vec3 N3_Background;
vec4 N3_SheenOut;
float N3_ClearcoatBase;
vec3 N3_ClearcoatNormal;
float N3_ClearcoatRoughness;

// utils
float N3_clampedDot(vec3 a, vec3 b) { return clamp(dot(a, b), 0.0, 1.0); }
float N3_max3(vec3 v) { return max(max (v.x, v.y), v.z); }

// texture transform
vec2 N3_uvTransform(vec2 uvIn, vec2 offset, vec2 scale, float rotation);
vec2 N3_getUV(int pickUV);

// metallic-roughness
void N3_addEmissiveTexture(inout vec3 emissiveColor);
void N3_addNormalTexture(inout vec3 normal);
void N3_addMaterialParamsTexture(inout float metallic, inout float roughness, inout vec4 occlusion);

// Transmission
void N3_addTransmission(inout vec3 baseColor, inout vec3 emissive, float metallic);

// Sheen
float N3_charlieV(float NdotV, float NdotL);
float N3_charlieD(float roughness, float NdotH);
float N3_albedoScale(vec3 sheenColor);
vec3 N3_getSheenIBL(float NdotV, vec3 reflection, float sheenRoughness, vec3 sheenColor);
vec3 N3_getSheenPunctual(vec3 sheenColor, vec3 N, vec3 V, float NdotV, float alphaG);
void N3_addSheen(vec3 computedNormal, vec4 occlusion);

// Clearcoat
void N3_addClearcoat();

//-----------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------
#pragma inline 
void N3_main()
{
	N3_BaseColor = N3_BaseColorIn;
	N3_Opacity = N3_OpacityIn;
	
	N3_Emissive = N3_EmissiveColor;
	if (N3_EnableEmissiveTexture) {
		N3_addEmissiveTexture(N3_Emissive);
	}
	
	N3_Normal = normalize(N3_system_getSurfaceNormal());
	if (N3_EnableNormalTexture) {
		N3_addNormalTexture(N3_Normal);
	}
	
	N3_Metallic = N3_MetallicValue;
	N3_Roughness = N3_RoughnessValue;
	N3_Occlusion = vec4(vec3(1.0), 0.0);  //(vec3(AO), occlusion strength)
	if (N3_EnableMetallicRoughnessTexture) {
		N3_addMaterialParamsTexture(N3_Metallic, N3_Roughness, N3_Occlusion);
	}
	
	// Transmission modifies base color and emission
	if(N3_TransmissionEnable) {
		N3_addTransmission(N3_BaseColor, N3_Emissive, N3_Metallic);
	}
	
	// Output base color, opacity, and emission in sRGB to pass into PBR node
	N3_BaseColor = N3_system_linearToSrgb(N3_BaseColor);
	N3_Opacity = N3_system_linearToSrgb(N3_Opacity);
	N3_Emissive = N3_system_linearToSrgb(N3_Emissive);
	
	if (N3_SheenEnable) {
		N3_addSheen(N3_Normal, N3_Occlusion);
	}
	
	if (N3_ClearcoatEnable) {      
		N3_addClearcoat();
	}
}

//-----------------------------------------------------------------------
// Texture transform
//-----------------------------------------------------------------------
vec2 N3_uvTransform(vec2 uvIn, vec2 offset, vec2 scale, float rotationAngle) 
{
	float rotationRadians = radians(rotationAngle);
	mat3 translationM =  mat3(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, offset.x, offset.y, 1.0);
	mat3 rotationM = mat3(   cos(rotationRadians),  sin(rotationRadians),  0.0,
		-sin(rotationRadians), cos(rotationRadians),  0.0,
		0.0,            0.0,            1.0);
	mat3 scaleM = mat3(scale.x, 0.0, 0.0, 0.0, scale.y, 0.0, 0.0, 0.0, 1.0);
	mat3 matrix = translationM * rotationM * scaleM;
	return (matrix * vec3(uvIn, 1.0)).xy;
}

vec2 N3_getUV(int pickUV)
{
	vec2 uv = N3_system_getSurfaceUVCoord0();
	if (pickUV == 0) uv = N3_system_getSurfaceUVCoord0();
	if (pickUV == 1) uv = N3_system_getSurfaceUVCoord1();
	return uv;
}

//-----------------------------------------------------------------------
// N3_Emissive
//-----------------------------------------------------------------------
void N3_addEmissiveTexture(inout vec3 emissiveColor) 
{
	vec2 emissiveUV = N3_getUV(N3_EmissiveTextureCoord);
	if (N3_EnableTextureTransform && N3_EmissiveTextureTransform) {
		emissiveUV = N3_uvTransform(emissiveUV, N3_EmissiveTextureOffset, N3_EmissiveTextureScale, N3_EmissiveTextureRotation);
	}
	emissiveColor = N3_system_srgbToLinear(N3_EmissiveTexture_sample(emissiveUV).rgb) * N3_system_srgbToLinear(emissiveColor);
}

//-----------------------------------------------------------------------
// N3_Normal
//-----------------------------------------------------------------------
void N3_addNormalTexture(inout vec3 normal)
{
	vec2 normalUV = N3_getUV(N3_NormalTextureCoord);
	if (N3_EnableTextureTransform && N3_NormalTextureTransform) {
		normalUV = N3_uvTransform(normalUV, N3_NormalTextureOffset, N3_NormalTextureScale, N3_NormalTextureRotation);
	}
	vec3 normalTex = N3_NormalTexture_sample(normalUV).rgb * (255.0 / 128.0) - 1.0; // maps RGB 128 to 0.
	normalTex = mix(vec3(0.0, 0.0, 1.0), normalTex, N3_NormalScale);
	vec3 T = N3_system_getSurfaceTangent();
	vec3 B = N3_system_getSurfaceBitangent();
	mat3 TBN = mat3(T, B, normal);
	normal = normalize(TBN * normalTex);
}

//-----------------------------------------------------------------------
// N3_Metallic-roughness-occlusion
//-----------------------------------------------------------------------
void N3_addMaterialParamsTexture(inout float metallic, inout float roughness, inout vec4 occlusion)
{
	vec2 materialParamsUV = N3_getUV(N3_MaterialParamsTextureCoord);
	if (N3_EnableTextureTransform && N3_MaterialParamsTextureTransform) {
		materialParamsUV = N3_uvTransform(materialParamsUV, N3_MaterialParamsTextureOffset, N3_MaterialParamsTextureScale, N3_MaterialParamsTextureRotation);
	}
	vec3 materialParams = N3_MaterialParamsTexture_sample(materialParamsUV).rgb;
	
	metallic *= materialParams.r;
	roughness *= materialParams.g;
	
	// occlusion strength scales how much AO is applied
	occlusion.a = N3_OcclusionStrength;
	occlusion.rgb = vec3(1.0 + occlusion.a * (materialParams.b - 1.0));
}

//-----------------------------------------------------------------------
// N3_Metallic-roughness-occlusion
//-----------------------------------------------------------------------
void N3_addTransmission(inout vec3 baseColor, inout vec3 emissive, float metallic)
{
	// output screen texture sample for use later in final mix
	N3_Background = N3_system_srgbToLinear(N3_ScreenTexture_sample(N3_system_getScreenUVCoord()).rgb);
	
	float transmissionValue = 1.0;
	if(N3_EnableTransmissionTexture) { 
		vec2 transmissionUV = N3_getUV(N3_TransmissionTextureCoord);
		if (N3_EnableTextureTransform && N3_TransmissionTextureTransform) { 
			transmissionUV = N3_uvTransform(transmissionUV, N3_TransmissionTextureOffset, N3_TransmissionTextureScale, N3_TransmissionTextureRotation);
		}
		transmissionValue = N3_TransmissionTexture_sample(transmissionUV).r;
	}
	transmissionValue *= N3_TransmissionFactor;
	
	// attenuate base color
	vec3 transmissionBaseColor = baseColor;
	baseColor = mix(transmissionBaseColor, vec3(0.0), transmissionValue);
	baseColor = mix(baseColor, transmissionBaseColor, metallic);
	
	// mix background into emissive
	vec3 baseEmission = emissive;
	emissive = mix(vec3(0.0), transmissionBaseColor.rgb, transmissionValue) * N3_Background;
	emissive = mix(emissive, vec3(0.0), metallic) + baseEmission;
}

//-----------------------------------------------------------------------
// Sheen
//-----------------------------------------------------------------------
float N3_charlieV(float NdotV, float NdotL) 
{
	return 1.0 / (4.0 * (NdotL + NdotV - NdotL * NdotV));
}

float N3_charlieD(float roughness, float NdotH)
{
	float invR  = 1.0 / roughness;
	float cos2h = NdotH * NdotH;
	float sin2h = 1.0 - cos2h;
	return (2.0 + invR) * ssPow(sin2h, invR * 0.5) / (2.0 * N3_system_pi());
}

vec3 N3_getSheenIBL(float NdotV, vec3 reflection, float sheenRoughness, vec3 sheenColor)
{
	// for sheen we start with the rougher mip
	const float envMipMax = 5.0;
	float lod = sheenRoughness * float(envMipMax - 1.0);
	lod = N3_system_remap(lod, 0.0, envMipMax, 3.0, envMipMax);
	
	// Avoid using a LUT and approximate the values analytically
	float alphaG = sheenRoughness*sheenRoughness;
	float a = sheenRoughness < 0.25 ? -339.2 * alphaG + 161.4 * sheenRoughness - 25.9 : -8.48 * alphaG + 14.3 * sheenRoughness - 9.95;
	float b = sheenRoughness < 0.25 ? 44.0 * alphaG - 23.7 * sheenRoughness + 3.26 : 1.97 * alphaG - 3.27 * sheenRoughness + 0.72;
	float DG = exp( a * NdotV + b ) + ( sheenRoughness < 0.25 ? 0.0 : 0.1 * ( sheenRoughness - 0.25 ) );
	DG = clamp(DG * N3_system_pi(), 0.0, 1.0);
	
	vec3 sheenLight = N3_system_sampleSpecularEnvironment(reflection, lod);
	// sheenLight *= N3_DebugSheenEnvLightMult;  //TODO: remove this later
	
	return sheenLight * sheenColor * DG;
}

float N3_albedoScale(vec3 sheenColor) 
{
	return 1.0 - N3_max3(sheenColor) * 0.157;
}

vec3 N3_getSheenPunctual(vec3 sheenColor, vec3 N, vec3 V, float NdotV, float alphaG) 
{
	vec3 sheenPunctual = vec3(0.0);
	const float punctualLightMult = 3.14159;  //scales the light to match PBR
	
	if ( N3_system_getDirectionalLightCount() > 0 ) {
		for ( int i = 0; i < N3_system_getDirectionalLightCount(); i++ )
		{
			vec3 lightColor = N3_system_getDirectionalLightColor(i);
			float lightIntensity = N3_system_getDirectionalLightIntensity(i);
			lightColor *= lightIntensity;
			lightColor *= punctualLightMult;
			// lightColor *= N3_DebugSheenPunctualLightMult;  //TODO: remove this later
			
			vec3 L = normalize(-N3_system_getDirectionalLightDirection(i));
			vec3 H = normalize(L + V);
			float NdotH = N3_clampedDot(N, H);
			float NdotL = N3_clampedDot(N, L);
			
			float sheenDistribution = N3_charlieD(alphaG, NdotH);
			float sheenVisibility = N3_charlieV(NdotV, NdotL);
			sheenPunctual += lightColor * sheenColor * sheenDistribution * sheenVisibility * NdotL;
		}
	}
	if ( N3_system_getPointLightCount() > 0 ) {
		for ( int i = 0; i < N3_system_getPointLightCount(); i++ )
		{
			vec3 lightColor = N3_system_getPointLightColor(i);
			float lightIntensity = N3_system_getPointLightIntensity(i);
			lightColor *= lightIntensity;
			lightColor *= punctualLightMult;
			// lightColor *= N3_DebugSheenPunctualLightMult;  //TODO: remove this later
			
			vec3 lightPosition = N3_system_getPointLightPosition(i);
			vec3 L = normalize(lightPosition - N3_system_getSurfacePosition());
			vec3 H = normalize(L + V);
			float NdotH = N3_clampedDot(N, H);
			float NdotL = N3_clampedDot(N, L);
			
			float sheenDistribution = N3_charlieD(alphaG, NdotH);
			float sheenVisibility = N3_charlieV(NdotV, NdotL);
			sheenPunctual += lightColor * sheenColor * sheenDistribution * sheenVisibility * NdotL;
		}
	}
	if ( N3_system_getAmbientLightCount() > 0 ) {
		for ( int i = 0; i < N3_system_getAmbientLightCount(); i++ )
		{
			vec3  lightColor     = N3_system_getAmbientLightColor(i);
			float lightIntensity = N3_system_getAmbientLightIntensity(i);
			lightColor *= lightIntensity;
			lightColor /= punctualLightMult;
			// lightColor *= N3_DebugSheenPunctualLightMult;  //TODO: remove this later
			
			sheenPunctual += lightColor * sheenColor;
		}
	}
	return sheenPunctual;
}

void N3_addSheen(vec3 computedNormal, vec4 occlusion) 
{
	vec3 sheenColor = N3_SheenColorFactor;
	float sheenRoughness = N3_SheenRoughnessFactor;
	
	if (N3_EnableSheenTexture) {
		vec2 sheenUV = N3_getUV(N3_SheenColorTextureCoord);
		if (N3_EnableTextureTransform && N3_SheenColorTextureTransform) { 
			sheenUV = N3_uvTransform(sheenUV, N3_SheenColorTextureOffset, N3_SheenColorTextureScale, N3_SheenColorTextureRotation);
		}
		sheenColor *= N3_system_srgbToLinear(N3_SheenColorTexture_sample(sheenUV).rgb);
	}
	
	if (N3_EnableSheenRoughnessTexture) {
		vec2 sheenRoughnessUV = N3_getUV(N3_SheenRoughnessTextureCoord);
		if (N3_EnableTextureTransform && N3_SheenRoughnessTextureTransform) { 
			sheenRoughnessUV = N3_uvTransform(sheenRoughnessUV, N3_SheenRoughnessTextureOffset, N3_SheenRoughnessTextureScale, N3_SheenRoughnessTextureRotation);
		}
		sheenRoughness *= N3_system_srgbToLinear(N3_SheenRoughnessTexture_sample(sheenRoughnessUV).a);
	}
	
	// Initialize variables
	sheenRoughness = max(sheenRoughness, 0.0001);
	N3_SheenOut = vec4(0.0);  //(SheenColor.rgb, AlbedoScaling)
	vec3 N = computedNormal;
	vec3 V = normalize(N3_system_getCameraPosition() - N3_system_getSurfacePosition());
	float NdotV = max(N3_clampedDot(N, V), 0.0001);
	float alphaG = sheenRoughness * sheenRoughness;
	
	// Env light
	vec3 reflectionVector = normalize(reflect(-V, N));
	N3_SheenOut.rgb += N3_getSheenIBL(NdotV, reflectionVector, sheenRoughness, sheenColor);
	N3_SheenOut.rgb = mix(N3_SheenOut.rgb, N3_SheenOut.rgb * occlusion.rgb, occlusion.a); // Apply AO
	
	// Punctual lights
	N3_SheenOut.rgb += N3_getSheenPunctual(sheenColor, N, V, NdotV, alphaG);
	
	// Layering
	N3_SheenOut.a = N3_albedoScale(sheenColor);    
}

//-----------------------------------------------------------------------
// Clearcoat
//-----------------------------------------------------------------------
void N3_addClearcoat() 
{
	N3_ClearcoatBase = 1.0;
	N3_ClearcoatRoughness = 1.0;
	N3_ClearcoatNormal = vec3(0.0, 0.0, 1.0);       
	
	// Base
	if(N3_EnableClearcoatTexture){
		vec2 clearcoatUV = N3_getUV(N3_ClearcoatTextureCoord);
		if (N3_EnableTextureTransform && N3_ClearcoatTextureTransform) { 
			clearcoatUV = N3_uvTransform(clearcoatUV, N3_ClearcoatTextureOffset, N3_ClearcoatTextureScale, N3_ClearcoatTextureRotation);
		}            
		N3_ClearcoatBase = N3_system_srgbToLinear(N3_ClearcoatTexture_sample(clearcoatUV).r);
	}
	N3_ClearcoatBase *= N3_ClearcoatFactor;
	
	// N3_Roughness      
	if(N3_EnableClearCoatRoughnessTexture){
		vec2 clearcoatRoughnessUV = N3_getUV(N3_ClearcoatRoughnessTextureCoord);
		if (N3_EnableTextureTransform && N3_ClearcoatRoughnessTextureTransform) { 
			clearcoatRoughnessUV = N3_uvTransform(clearcoatRoughnessUV, N3_ClearcoatRoughnessTextureOffset, N3_ClearcoatRoughnessTextureScale, N3_ClearcoatRoughnessTextureRotation);
		}                        
		N3_ClearcoatRoughness = N3_system_srgbToLinear(N3_ClearcoatRoughnessTexture_sample(clearcoatRoughnessUV).g);
	}
	N3_ClearcoatRoughness *= N3_ClearcoatRoughnessFactor;            
	
	// N3_Normal
	if(N3_EnableClearCoatNormalTexture){
		vec2 clearcoatNormalUV = N3_getUV(N3_ClearcoatNormalMapCoord);
		if (N3_EnableTextureTransform && N3_ClearcoatNormalTextureTransform) { 
			clearcoatNormalUV = N3_uvTransform(clearcoatNormalUV, N3_ClearcoatNormalTextureOffset, N3_ClearcoatNormalTextureScale, N3_ClearcoatNormalTextureRotation);
		}
		N3_ClearcoatNormal = N3_ClearcoatNormalMap_sample(clearcoatNormalUV).rgb;
		N3_ClearcoatNormal *= (255.0/128.0) - 1.0;
	}
}
void Node18_Float_Parameter( out float3 Output, ssGlobals Globals ) { Output = emissiveFactor; }
void Node223_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_EMISSIVE )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node75_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node10_DropList_Parameter( Output, Globals ) Output = float( NODE_10_DROPLIST_ITEM )
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
void Node9_Float_Parameter( out float Output, ssGlobals Globals ) { Output = normalTextureScale; }
void Node43_Conditional( in float Input0, in float Input1, in float Input2, out float Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N354 = 0.0; Node354_Bool_Parameter( Output_N354, Globals );
		
		Input0 = Output_N354;
	}
	#endif
	
	if ( bool( ENABLE_NORMALMAP ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float Output_N9 = 0.0; Node9_Float_Parameter( Output_N9, Globals );
			
			Input1 = Output_N9;
		}
		Output = Input1; 
	} 
	else 
	{ 
		
		Output = Input2; 
	}
}
#define Node180_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node8_DropList_Parameter( Output, Globals ) Output = float( NODE_8_DROPLIST_ITEM )
void Node242_Float_Parameter( out float Output, ssGlobals Globals ) { Output = metallicFactor; }
void Node243_Float_Parameter( out float Output, ssGlobals Globals ) { Output = roughnessFactor; }
void Node6_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_METALLIC_ROUGHNESS_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node20_Float_Parameter( out float Output, ssGlobals Globals ) { Output = occlusionTextureStrength; }
void Node62_Conditional( in float Input0, in float Input1, in float Input2, out float Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N6 = 0.0; Node6_Bool_Parameter( Output_N6, Globals );
		
		Input0 = Output_N6;
	}
	#endif
	
	if ( bool( ENABLE_METALLIC_ROUGHNESS_TEX ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float Output_N20 = 0.0; Node20_Float_Parameter( Output_N20, Globals );
			
			Input1 = Output_N20;
		}
		Output = Input1; 
	} 
	else 
	{ 
		
		Output = Input2; 
	}
}
#define Node220_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node11_DropList_Parameter( Output, Globals ) Output = float( NODE_11_DROPLIST_ITEM )
void Node410_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_TRANSMISSION )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node360_Float_Parameter( out float Output, ssGlobals Globals ) { Output = transmissionFactor; }
void Node441_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_TRANSMISSION_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node440_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node30_DropList_Parameter( Output, Globals ) Output = float( Tweak_N30 )
#define Node210_Texture_2D_Object_Parameter( Globals ) /*nothing*/
void Node33_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SHEEN )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node45_Color_Parameter( out float3 Output, ssGlobals Globals ) { Output = sheenColorFactor; }
void Node41_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SHEEN_COLOR_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node39_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node32_DropList_Parameter( Output, Globals ) Output = float( Tweak_N32 )
void Node27_Float_Parameter( out float Output, ssGlobals Globals ) { Output = sheenRoughnessFactor; }
void Node42_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SHEEN_ROUGHNESS_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node25_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node37_DropList_Parameter( Output, Globals ) Output = float( Tweak_N37 )
void Node411_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node198_Float_Parameter( out float Output, ssGlobals Globals ) { Output = clearcoatFactor; }
void Node197_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node252_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node44_DropList_Parameter( Output, Globals ) Output = float( Tweak_N44 )
void Node353_Float_Parameter( out float Output, ssGlobals Globals ) { Output = clearcoatRoughnessFactor; }
void Node350_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_ROUGHNESS_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node351_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node60_DropList_Parameter( Output, Globals ) Output = float( Tweak_N60 )
void Node389_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_NORMAL_TEX )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
#define Node390_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node47_DropList_Parameter( Output, Globals ) Output = float( Tweak_N47 )
bool N35_EnableVertexColor_evaluate() { return bool( ENABLE_VERTEX_COLOR_BASE ); }
bool N35_EnableBaseTexture_evaluate() { return bool( ENABLE_BASE_TEX ); }
vec4 N35_BaseTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(baseColorTexture, coords, 0.0); return _result_memfunc; }
int N35_BaseColorTextureCoord_evaluate() { return int( NODE_7_DROPLIST_ITEM ); }
bool N35_EnableTextureTransform_evaluate() { return bool( ENABLE_TEXTURE_TRANSFORM ); }
bool N35_BaseTextureTransform_evaluate() { return bool( ENABLE_BASE_TEXTURE_TRANSFORM ); }
vec2 N35_system_getSurfaceUVCoord0() { return tempGlobals.Surface_UVCoord0; }
vec2 N35_system_getSurfaceUVCoord1() { return tempGlobals.Surface_UVCoord1; }
vec4 N35_system_getSurfaceColor() { return tempGlobals.VertexColor; }
#define N35_system_linearToSrgb( value ) ssLinear_to_SRGB( value )
#define N35_system_srgbToLinear( value ) ssSRGB_to_Linear( value )
bool N35_EnableVertexColor;
bool N35_EnableBaseTexture;

int N35_BaseColorTextureCoord;
vec4 N35_BaseColorFactor;

bool N35_EnableTextureTransform;
bool N35_BaseTextureTransform;
vec2 N35_BaseTextureOffset;
vec2 N35_BaseTextureScale;
float N35_BaseTextureRotation;

vec3 N35_BaseColor;
float N35_Opacity;
vec4 N35_UnlitColor;

vec2 N35_uvTransform(vec2 uvIn, vec2 offset, vec2 scale, float rotation) {
	mat3 translationM =  mat3(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, offset.x, offset.y, 1.0);
	mat3 rotationM = mat3(   cos(rotation),  sin(rotation),  0.0,
		-sin(rotation), cos(rotation),  0.0,
		0.0,            0.0,            1.0);
	mat3 scaleM = mat3(scale.x, 0.0, 0.0, 0.0, scale.y, 0.0, 0.0, 0.0, 1.0);
	mat3 matrix = translationM * rotationM * scaleM;
	return (matrix * vec3(uvIn, 1.0)).xy;
}

vec2 N35_getUV(int pickUV){
	vec2 uv = N35_system_getSurfaceUVCoord0();
	if (pickUV == 0) uv = N35_system_getSurfaceUVCoord0();
	if (pickUV == 1) uv = N35_system_getSurfaceUVCoord1();
	return uv;
}

#pragma inline 
void N35_main()
{    
	
	vec4 col = N35_BaseColorFactor;
	if (N35_EnableBaseTexture) {
		vec2 baseUV = N35_getUV(N35_BaseColorTextureCoord);
		if (N35_EnableTextureTransform && N35_BaseTextureTransform) {
			baseUV = N35_uvTransform(baseUV, N35_BaseTextureOffset, N35_BaseTextureScale, N35_BaseTextureRotation);
		}
		col *= N35_system_srgbToLinear(N35_BaseTexture_sample(baseUV));
	}
	if (N35_EnableVertexColor) {
		col *= N35_system_getSurfaceColor();
	}
	N35_BaseColor = col.rgb;    //linear
	N35_Opacity = col.a;        //linear
	N35_UnlitColor = N35_system_linearToSrgb(col);
}
void Node40_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_VERTEX_COLOR_BASE )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
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
#define Node28_Texture_2D_Object_Parameter( Globals ) /*nothing*/
#define Node7_DropList_Parameter( Output, Globals ) Output = float( NODE_7_DROPLIST_ITEM )
void Node5_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = baseColorFactor; }
void Node48_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node88_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_BASE_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node46_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = baseColorTexture_offset; }
void Node49_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = baseColorTexture_scale; }
void Node50_Float_Parameter( out float Output, ssGlobals Globals ) { Output = baseColorTexture_rotation; }
void Node35_Unlit( in float EnableVertexColor, in float EnableBaseTexture, in float BaseColorTextureCoord, in float4 BaseColorFactor, in float EnableTextureTransform, in float BaseTextureTransform, in float2 BaseTextureOffset, in float2 BaseTextureScale, in float BaseTextureRotation, out float3 BaseColor, out float Opacity, out float4 UnlitColor, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	BaseColor = vec3( 0.0 );
	Opacity = float( 0.0 );
	UnlitColor = vec4( 0.0 );
	
	
	N35_EnableVertexColor = bool( ENABLE_VERTEX_COLOR_BASE );
	N35_EnableBaseTexture = bool( ENABLE_BASE_TEX );
	N35_BaseColorTextureCoord = int( NODE_7_DROPLIST_ITEM );
	N35_BaseColorFactor = BaseColorFactor;
	N35_EnableTextureTransform = bool( ENABLE_TEXTURE_TRANSFORM );
	N35_BaseTextureTransform = bool( ENABLE_BASE_TEXTURE_TRANSFORM );
	N35_BaseTextureOffset = BaseTextureOffset;
	N35_BaseTextureScale = BaseTextureScale;
	N35_BaseTextureRotation = BaseTextureRotation;
	
	N35_main();
	
	BaseColor = N35_BaseColor;
	Opacity = N35_Opacity;
	UnlitColor = N35_UnlitColor;
}
void Node87_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_EMISSIVE_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node54_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = emissiveTexture_offset; }
void Node55_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = emissiveTexture_scale; }
void Node56_Float_Parameter( out float Output, ssGlobals Globals ) { Output = emissiveTexture_rotation; }
void Node86_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_NORMAL_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node51_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = normalTexture_offset; }
void Node52_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = normalTexture_scale; }
void Node53_Float_Parameter( out float Output, ssGlobals Globals ) { Output = normalTexture_rotation; }
void Node85_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node57_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = metallicRoughnessTexture_offset; }
void Node58_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = metallicRoughnessTexture_scale; }
void Node59_Float_Parameter( out float Output, ssGlobals Globals ) { Output = metallicRoughnessTexture_rotation; }
void Node84_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_TRANSMISSION_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node19_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = transmissionTexture_offset; }
void Node26_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = transmissionTexture_scale; }
void Node29_Float_Parameter( out float Output, ssGlobals Globals ) { Output = transmissionTexture_rotation; }
void Node83_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node63_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = sheenColorTexture_offset; }
void Node64_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = sheenColorTexture_scale; }
void Node65_Float_Parameter( out float Output, ssGlobals Globals ) { Output = sheenColorTexture_rotation; }
void Node82_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node66_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = sheenRoughnessTexture_offset; }
void Node67_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = sheenRoughnessTexture_scale; }
void Node68_Float_Parameter( out float Output, ssGlobals Globals ) { Output = sheenRoughnessTexture_rotation; }
void Node81_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node69_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatTexture_offset; }
void Node70_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatTexture_scale; }
void Node71_Float_Parameter( out float Output, ssGlobals Globals ) { Output = clearcoatTexture_rotation; }
void Node80_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node76_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatNormalTexture_offset; }
void Node77_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatNormalTexture_scale; }
void Node78_Float_Parameter( out float Output, ssGlobals Globals ) { Output = clearcoatNormalTexture_rotation; }
void Node13_Bool_Parameter( out float Output, ssGlobals Globals )
{ 
	if ( ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM )
	{
		Output = 1.001;
	}
	else
	{
		Output = 0.001;
	}
	
	Output -= 0.001; // LOOK-62828
}
void Node72_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatRoughnessTexture_offset; }
void Node73_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = clearcoatRoughnessTexture_scale; }
void Node74_Float_Parameter( out float Output, ssGlobals Globals ) { Output = clearcoatRoughnessTexture_rotation; }
void Node3_METALLIC_ROUGHNESS( in float DebugSheenEnvLightMult, in float DebugSheenPunctualLightMult, in float3 EmissiveColor, in float EnableEmissiveTexture, in float EmissiveTextureCoord, in float EnableNormalTexture, in float NormalScale, in float NormalTextureCoord, in float MetallicValue, in float RoughnessValue, in float EnableMetallicRoughnessTexture, in float OcclusionStrength, in float MaterialParamsTextureCoord, in float TransmissionEnable, in float TransmissionFactor, in float EnableTransmissionTexture, in float TransmissionTextureCoord, in float SheenEnable, in float3 SheenColorFactor, in float EnableSheenTexture, in float SheenColorTextureCoord, in float SheenRoughnessFactor, in float EnableSheenRoughnessTexture, in float SheenRoughnessTextureCoord, in float ClearcoatEnable, in float ClearcoatFactor, in float EnableClearcoatTexture, in float ClearcoatTextureCoord, in float ClearcoatRoughnessFactor, in float EnableClearCoatRoughnessTexture, in float ClearcoatRoughnessTextureCoord, in float EnableClearCoatNormalTexture, in float ClearcoatNormalMapCoord, in float3 BaseColorIn, in float OpacityIn, in float EnableTextureTransform, in float EmissiveTextureTransform, in float2 EmissiveTextureOffset, in float2 EmissiveTextureScale, in float EmissiveTextureRotation, in float NormalTextureTransform, in float2 NormalTextureOffset, in float2 NormalTextureScale, in float NormalTextureRotation, in float MaterialParamsTextureTransform, in float2 MaterialParamsTextureOffset, in float2 MaterialParamsTextureScale, in float MaterialParamsTextureRotation, in float TransmissionTextureTransform, in float2 TransmissionTextureOffset, in float2 TransmissionTextureScale, in float TransmissionTextureRotation, in float SheenColorTextureTransform, in float2 SheenColorTextureOffset, in float2 SheenColorTextureScale, in float SheenColorTextureRotation, in float SheenRoughnessTextureTransform, in float2 SheenRoughnessTextureOffset, in float2 SheenRoughnessTextureScale, in float SheenRoughnessTextureRotation, in float ClearcoatTextureTransform, in float2 ClearcoatTextureOffset, in float2 ClearcoatTextureScale, in float ClearcoatTextureRotation, in float ClearcoatNormalTextureTransform, in float2 ClearcoatNormalTextureOffset, in float2 ClearcoatNormalTextureScale, in float ClearcoatNormalTextureRotation, in float ClearcoatRoughnessTextureTransform, in float2 ClearcoatRoughnessTextureOffset, in float2 ClearcoatRoughnessTextureScale, in float ClearcoatRoughnessTextureRotation, out float3 BaseColor, out float Opacity, out float3 Normal, out float3 Emissive, out float Metallic, out float Roughness, out float4 Occlusion, out float3 Background, out float4 SheenOut, out float ClearcoatBase, out float3 ClearcoatNormal, out float ClearcoatRoughness, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	BaseColor = vec3( 0.0 );
	Opacity = float( 0.0 );
	Normal = vec3( 0.0 );
	Emissive = vec3( 0.0 );
	Metallic = float( 0.0 );
	Roughness = float( 0.0 );
	Occlusion = vec4( 0.0 );
	Background = vec3( 0.0 );
	SheenOut = vec4( 0.0 );
	ClearcoatBase = float( 0.0 );
	ClearcoatNormal = vec3( 0.0 );
	ClearcoatRoughness = float( 0.0 );
	
	
	N3_DebugSheenEnvLightMult = DebugSheenEnvLightMult;
	N3_DebugSheenPunctualLightMult = DebugSheenPunctualLightMult;
	N3_EmissiveColor = EmissiveColor;
	N3_EnableEmissiveTexture = bool( ENABLE_EMISSIVE );
	N3_EmissiveTextureCoord = int( NODE_10_DROPLIST_ITEM );
	N3_EnableNormalTexture = bool( ENABLE_NORMALMAP );
	N3_NormalScale = NormalScale;
	N3_NormalTextureCoord = int( NODE_8_DROPLIST_ITEM );
	N3_MetallicValue = MetallicValue;
	N3_RoughnessValue = RoughnessValue;
	N3_EnableMetallicRoughnessTexture = bool( ENABLE_METALLIC_ROUGHNESS_TEX );
	N3_OcclusionStrength = OcclusionStrength;
	N3_MaterialParamsTextureCoord = int( NODE_11_DROPLIST_ITEM );
	N3_TransmissionEnable = bool( ENABLE_TRANSMISSION );
	N3_TransmissionFactor = TransmissionFactor;
	N3_EnableTransmissionTexture = bool( ENABLE_TRANSMISSION_TEX );
	N3_TransmissionTextureCoord = int( Tweak_N30 );
	N3_SheenEnable = bool( ENABLE_SHEEN );
	N3_SheenColorFactor = SheenColorFactor;
	N3_EnableSheenTexture = bool( ENABLE_SHEEN_COLOR_TEX );
	N3_SheenColorTextureCoord = int( Tweak_N32 );
	N3_SheenRoughnessFactor = SheenRoughnessFactor;
	N3_EnableSheenRoughnessTexture = bool( ENABLE_SHEEN_ROUGHNESS_TEX );
	N3_SheenRoughnessTextureCoord = int( Tweak_N37 );
	N3_ClearcoatEnable = bool( ENABLE_CLEARCOAT );
	N3_ClearcoatFactor = ClearcoatFactor;
	N3_EnableClearcoatTexture = bool( ENABLE_CLEARCOAT_TEX );
	N3_ClearcoatTextureCoord = int( Tweak_N44 );
	N3_ClearcoatRoughnessFactor = ClearcoatRoughnessFactor;
	N3_EnableClearCoatRoughnessTexture = bool( ENABLE_CLEARCOAT_ROUGHNESS_TEX );
	N3_ClearcoatRoughnessTextureCoord = int( Tweak_N60 );
	N3_EnableClearCoatNormalTexture = bool( ENABLE_CLEARCOAT_NORMAL_TEX );
	N3_ClearcoatNormalMapCoord = int( Tweak_N47 );
	N3_BaseColorIn = BaseColorIn;
	N3_OpacityIn = OpacityIn;
	N3_EnableTextureTransform = bool( ENABLE_TEXTURE_TRANSFORM );
	N3_EmissiveTextureTransform = bool( ENABLE_EMISSIVE_TEXTURE_TRANSFORM );
	N3_EmissiveTextureOffset = EmissiveTextureOffset;
	N3_EmissiveTextureScale = EmissiveTextureScale;
	N3_EmissiveTextureRotation = EmissiveTextureRotation;
	N3_NormalTextureTransform = bool( ENABLE_NORMAL_TEXTURE_TRANSFORM );
	N3_NormalTextureOffset = NormalTextureOffset;
	N3_NormalTextureScale = NormalTextureScale;
	N3_NormalTextureRotation = NormalTextureRotation;
	N3_MaterialParamsTextureTransform = bool( ENABLE_METALLIC_ROUGHNESS_TEXTURE_TRANSFORM );
	N3_MaterialParamsTextureOffset = MaterialParamsTextureOffset;
	N3_MaterialParamsTextureScale = MaterialParamsTextureScale;
	N3_MaterialParamsTextureRotation = MaterialParamsTextureRotation;
	N3_TransmissionTextureTransform = bool( ENABLE_TRANSMISSION_TEXTURE_TRANSFORM );
	N3_TransmissionTextureOffset = TransmissionTextureOffset;
	N3_TransmissionTextureScale = TransmissionTextureScale;
	N3_TransmissionTextureRotation = TransmissionTextureRotation;
	N3_SheenColorTextureTransform = bool( ENABLE_SHEEN_COLOR_TEXTURE_TRANSFORM );
	N3_SheenColorTextureOffset = SheenColorTextureOffset;
	N3_SheenColorTextureScale = SheenColorTextureScale;
	N3_SheenColorTextureRotation = SheenColorTextureRotation;
	N3_SheenRoughnessTextureTransform = bool( ENABLE_SHEEN_ROUGHNESS_TEXTURE_TRANSFORM );
	N3_SheenRoughnessTextureOffset = SheenRoughnessTextureOffset;
	N3_SheenRoughnessTextureScale = SheenRoughnessTextureScale;
	N3_SheenRoughnessTextureRotation = SheenRoughnessTextureRotation;
	N3_ClearcoatTextureTransform = bool( ENABLE_CLEARCOAT_TEXTURE_TRANSFORM );
	N3_ClearcoatTextureOffset = ClearcoatTextureOffset;
	N3_ClearcoatTextureScale = ClearcoatTextureScale;
	N3_ClearcoatTextureRotation = ClearcoatTextureRotation;
	N3_ClearcoatNormalTextureTransform = bool( ENABLE_CLEARCOAT_NORMAL_TEXTURE_TRANSFORM );
	N3_ClearcoatNormalTextureOffset = ClearcoatNormalTextureOffset;
	N3_ClearcoatNormalTextureScale = ClearcoatNormalTextureScale;
	N3_ClearcoatNormalTextureRotation = ClearcoatNormalTextureRotation;
	N3_ClearcoatRoughnessTextureTransform = bool( ENABLE_CLEARCOAT_ROUGHNESS_TEXTURE_TRANSFORM );
	N3_ClearcoatRoughnessTextureOffset = ClearcoatRoughnessTextureOffset;
	N3_ClearcoatRoughnessTextureScale = ClearcoatRoughnessTextureScale;
	N3_ClearcoatRoughnessTextureRotation = ClearcoatRoughnessTextureRotation;
	
	N3_main();
	
	BaseColor = N3_BaseColor;
	Opacity = N3_Opacity;
	Normal = N3_Normal;
	Emissive = N3_Emissive;
	Metallic = N3_Metallic;
	Roughness = N3_Roughness;
	Occlusion = N3_Occlusion;
	Background = N3_Background;
	SheenOut = N3_SheenOut;
	ClearcoatBase = N3_ClearcoatBase;
	ClearcoatNormal = N3_ClearcoatNormal;
	ClearcoatRoughness = N3_ClearcoatRoughness;
}
void Node36_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 AO, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = Normal;
	}
	
	
	Opacity = clamp( Opacity, 0.0, 1.0 ); 		
	
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
		Emissive = max( Emissive, 0.0 );	
		
		Metallic = clamp( Metallic, 0.0, 1.0 );
		
		Roughness = clamp( Roughness, 0.0, 1.0 );	
		
		AO = clamp( AO, vec3( 0.0 ), vec3( 1.0 ) );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node405_PBR_Lighting( in float3 Albedo, in float Opacity, in float3 Normal, in float3 Emissive, in float Metallic, in float Roughness, in float3 SpecularAO, out float4 Output, ssGlobals Globals )
{ 
	if ( !sc_ProjectiveShadowsCaster )
	{
		Globals.BumpedNormal = float3x3( Globals.VertexTangent_WorldSpace, Globals.VertexBinormal_WorldSpace, Globals.VertexNormal_WorldSpace ) * Normal;
	}
	
	
	
	ngsAlphaTest( Opacity );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if SC_RT_RECEIVER_MODE
	sc_WriteReceiverData( Globals.PositionWS, Globals.BumpedNormal, Roughness );
	#else 
	
	
	
	if ( sc_ProjectiveShadowsCaster )
	{
		Output = float4( Albedo, Opacity );
	}
	else
	{
		Roughness = clamp( Roughness, 0.0, 1.0 );	
		vec3 AO = vec3( 1.0 );
		Output = ngsCalculateLighting( Albedo, Opacity, Globals.BumpedNormal, Globals.PositionWS, Globals.ViewDirWS, Emissive, Metallic, Roughness, AO, SpecularAO );
	}			
	
	Output = max( Output, 0.0 );
	
	#endif //#if SC_RT_RECEIVER_MODE
}
void Node31_FINAL_OPACITY( in float4 PbrIn, in float EnableTransmission, in float Opacity, in float3 Background, in float EnableSheen, in float4 SheenColor, in float EnableClearcoat, in float ClearcoatBase, in float4 ClearcoatColor, out float4 Result, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	Result = vec4( 0.0 );
	
	
	N31_PbrIn = PbrIn;
	N31_EnableTransmission = bool( ENABLE_TRANSMISSION );
	N31_Opacity = Opacity;
	N31_Background = Background;
	N31_EnableSheen = bool( ENABLE_SHEEN );
	N31_SheenColor = SheenColor;
	N31_EnableClearcoat = bool( ENABLE_CLEARCOAT );
	N31_ClearcoatBase = ClearcoatBase;
	N31_ClearcoatColor = ClearcoatColor;
	
	N31_main();
	
	Result = N31_Result;
}
void Node17_Conditional( in float Input0, in float4 Input1, in float4 Input2, out float4 Output, ssGlobals Globals )
{ 
	#if 0
	/* Input port: "Input0"  */
	
	{
		float Output_N16 = 0.0; Node16_Bool_Parameter( Output_N16, Globals );
		
		Input0 = Output_N16;
	}
	#endif
	
	if ( bool( ENABLE_GLTF_LIGHTING ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float3 Output_N18 = float3(0.0); Node18_Float_Parameter( Output_N18, Globals );
			float Output_N223 = 0.0; Node223_Bool_Parameter( Output_N223, Globals );
			Node75_Texture_2D_Object_Parameter( Globals );
			float Output_N10 = 0.0; Node10_DropList_Parameter( Output_N10, Globals );
			float Output_N354 = 0.0; Node354_Bool_Parameter( Output_N354, Globals );
			float Output_N43 = 0.0; Node43_Conditional( float( 1.0 ), float( 1.0 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Input2_N043 ), Output_N43, Globals );
			Node180_Texture_2D_Object_Parameter( Globals );
			float Output_N8 = 0.0; Node8_DropList_Parameter( Output_N8, Globals );
			float Output_N242 = 0.0; Node242_Float_Parameter( Output_N242, Globals );
			float Output_N243 = 0.0; Node243_Float_Parameter( Output_N243, Globals );
			float Output_N6 = 0.0; Node6_Bool_Parameter( Output_N6, Globals );
			float Output_N62 = 0.0; Node62_Conditional( float( 1.0 ), float( 1.0 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Input2_N062 ), Output_N62, Globals );
			Node220_Texture_2D_Object_Parameter( Globals );
			float Output_N11 = 0.0; Node11_DropList_Parameter( Output_N11, Globals );
			float Output_N410 = 0.0; Node410_Bool_Parameter( Output_N410, Globals );
			float Output_N360 = 0.0; Node360_Float_Parameter( Output_N360, Globals );
			float Output_N441 = 0.0; Node441_Bool_Parameter( Output_N441, Globals );
			Node440_Texture_2D_Object_Parameter( Globals );
			float Output_N30 = 0.0; Node30_DropList_Parameter( Output_N30, Globals );
			Node210_Texture_2D_Object_Parameter( Globals );
			float Output_N33 = 0.0; Node33_Bool_Parameter( Output_N33, Globals );
			float3 Output_N45 = float3(0.0); Node45_Color_Parameter( Output_N45, Globals );
			float Output_N41 = 0.0; Node41_Bool_Parameter( Output_N41, Globals );
			Node39_Texture_2D_Object_Parameter( Globals );
			float Output_N32 = 0.0; Node32_DropList_Parameter( Output_N32, Globals );
			float Output_N27 = 0.0; Node27_Float_Parameter( Output_N27, Globals );
			float Output_N42 = 0.0; Node42_Bool_Parameter( Output_N42, Globals );
			Node25_Texture_2D_Object_Parameter( Globals );
			float Output_N37 = 0.0; Node37_DropList_Parameter( Output_N37, Globals );
			float Output_N411 = 0.0; Node411_Bool_Parameter( Output_N411, Globals );
			float Output_N198 = 0.0; Node198_Float_Parameter( Output_N198, Globals );
			float Output_N197 = 0.0; Node197_Bool_Parameter( Output_N197, Globals );
			Node252_Texture_2D_Object_Parameter( Globals );
			float Output_N44 = 0.0; Node44_DropList_Parameter( Output_N44, Globals );
			float Output_N353 = 0.0; Node353_Float_Parameter( Output_N353, Globals );
			float Output_N350 = 0.0; Node350_Bool_Parameter( Output_N350, Globals );
			Node351_Texture_2D_Object_Parameter( Globals );
			float Output_N60 = 0.0; Node60_DropList_Parameter( Output_N60, Globals );
			float Output_N389 = 0.0; Node389_Bool_Parameter( Output_N389, Globals );
			Node390_Texture_2D_Object_Parameter( Globals );
			float Output_N47 = 0.0; Node47_DropList_Parameter( Output_N47, Globals );
			float Output_N40 = 0.0; Node40_Bool_Parameter( Output_N40, Globals );
			float Output_N121 = 0.0; Node121_Bool_Parameter( Output_N121, Globals );
			Node28_Texture_2D_Object_Parameter( Globals );
			float Output_N7 = 0.0; Node7_DropList_Parameter( Output_N7, Globals );
			float4 Output_N5 = float4(0.0); Node5_Color_Parameter( Output_N5, Globals );
			float Output_N48 = 0.0; Node48_Bool_Parameter( Output_N48, Globals );
			float Output_N88 = 0.0; Node88_Bool_Parameter( Output_N88, Globals );
			float2 Output_N46 = float2(0.0); Node46_Float_Parameter( Output_N46, Globals );
			float2 Output_N49 = float2(0.0); Node49_Float_Parameter( Output_N49, Globals );
			float Output_N50 = 0.0; Node50_Float_Parameter( Output_N50, Globals );
			float3 BaseColor_N35 = float3(0.0); float Opacity_N35 = 0.0; float4 UnlitColor_N35 = float4(0.0); Node35_Unlit( Output_N40, Output_N121, Output_N7, Output_N5, Output_N48, Output_N88, Output_N46, Output_N49, Output_N50, BaseColor_N35, Opacity_N35, UnlitColor_N35, Globals );
			float Output_N87 = 0.0; Node87_Bool_Parameter( Output_N87, Globals );
			float2 Output_N54 = float2(0.0); Node54_Float_Parameter( Output_N54, Globals );
			float2 Output_N55 = float2(0.0); Node55_Float_Parameter( Output_N55, Globals );
			float Output_N56 = 0.0; Node56_Float_Parameter( Output_N56, Globals );
			float Output_N86 = 0.0; Node86_Bool_Parameter( Output_N86, Globals );
			float2 Output_N51 = float2(0.0); Node51_Float_Parameter( Output_N51, Globals );
			float2 Output_N52 = float2(0.0); Node52_Float_Parameter( Output_N52, Globals );
			float Output_N53 = 0.0; Node53_Float_Parameter( Output_N53, Globals );
			float Output_N85 = 0.0; Node85_Bool_Parameter( Output_N85, Globals );
			float2 Output_N57 = float2(0.0); Node57_Float_Parameter( Output_N57, Globals );
			float2 Output_N58 = float2(0.0); Node58_Float_Parameter( Output_N58, Globals );
			float Output_N59 = 0.0; Node59_Float_Parameter( Output_N59, Globals );
			float Output_N84 = 0.0; Node84_Bool_Parameter( Output_N84, Globals );
			float2 Output_N19 = float2(0.0); Node19_Float_Parameter( Output_N19, Globals );
			float2 Output_N26 = float2(0.0); Node26_Float_Parameter( Output_N26, Globals );
			float Output_N29 = 0.0; Node29_Float_Parameter( Output_N29, Globals );
			float Output_N83 = 0.0; Node83_Bool_Parameter( Output_N83, Globals );
			float2 Output_N63 = float2(0.0); Node63_Float_Parameter( Output_N63, Globals );
			float2 Output_N64 = float2(0.0); Node64_Float_Parameter( Output_N64, Globals );
			float Output_N65 = 0.0; Node65_Float_Parameter( Output_N65, Globals );
			float Output_N82 = 0.0; Node82_Bool_Parameter( Output_N82, Globals );
			float2 Output_N66 = float2(0.0); Node66_Float_Parameter( Output_N66, Globals );
			float2 Output_N67 = float2(0.0); Node67_Float_Parameter( Output_N67, Globals );
			float Output_N68 = 0.0; Node68_Float_Parameter( Output_N68, Globals );
			float Output_N81 = 0.0; Node81_Bool_Parameter( Output_N81, Globals );
			float2 Output_N69 = float2(0.0); Node69_Float_Parameter( Output_N69, Globals );
			float2 Output_N70 = float2(0.0); Node70_Float_Parameter( Output_N70, Globals );
			float Output_N71 = 0.0; Node71_Float_Parameter( Output_N71, Globals );
			float Output_N80 = 0.0; Node80_Bool_Parameter( Output_N80, Globals );
			float2 Output_N76 = float2(0.0); Node76_Float_Parameter( Output_N76, Globals );
			float2 Output_N77 = float2(0.0); Node77_Float_Parameter( Output_N77, Globals );
			float Output_N78 = 0.0; Node78_Float_Parameter( Output_N78, Globals );
			float Output_N13 = 0.0; Node13_Bool_Parameter( Output_N13, Globals );
			float2 Output_N72 = float2(0.0); Node72_Float_Parameter( Output_N72, Globals );
			float2 Output_N73 = float2(0.0); Node73_Float_Parameter( Output_N73, Globals );
			float Output_N74 = 0.0; Node74_Float_Parameter( Output_N74, Globals );
			float3 BaseColor_N3 = float3(0.0); float Opacity_N3 = 0.0; float3 Normal_N3 = float3(0.0); float3 Emissive_N3 = float3(0.0); float Metallic_N3 = 0.0; float Roughness_N3 = 0.0; float4 Occlusion_N3 = float4(0.0); float3 Background_N3 = float3(0.0); float4 SheenOut_N3 = float4(0.0); float ClearcoatBase_N3 = 0.0; float3 ClearcoatNormal_N3 = float3(0.0); float ClearcoatRoughness_N3 = 0.0; Node3_METALLIC_ROUGHNESS( NF_PORT_CONSTANT( float( 1.0 ), Port_DebugSheenEnvLightMult_N003 ), NF_PORT_CONSTANT( float( 1.0 ), Port_DebugSheenPunctualLightMult_N003 ), Output_N18, Output_N223, Output_N10, Output_N354, Output_N43, Output_N8, Output_N242, Output_N243, Output_N6, Output_N62, Output_N11, Output_N410, Output_N360, Output_N441, Output_N30, Output_N33, Output_N45, Output_N41, Output_N32, Output_N27, Output_N42, Output_N37, Output_N411, Output_N198, Output_N197, Output_N44, Output_N353, Output_N350, Output_N60, Output_N389, Output_N47, BaseColor_N35, Opacity_N35, Output_N48, Output_N87, Output_N54, Output_N55, Output_N56, Output_N86, Output_N51, Output_N52, Output_N53, Output_N85, Output_N57, Output_N58, Output_N59, Output_N84, Output_N19, Output_N26, Output_N29, Output_N83, Output_N63, Output_N64, Output_N65, Output_N82, Output_N66, Output_N67, Output_N68, Output_N81, Output_N69, Output_N70, Output_N71, Output_N80, Output_N76, Output_N77, Output_N78, Output_N13, Output_N72, Output_N73, Output_N74, BaseColor_N3, Opacity_N3, Normal_N3, Emissive_N3, Metallic_N3, Roughness_N3, Occlusion_N3, Background_N3, SheenOut_N3, ClearcoatBase_N3, ClearcoatNormal_N3, ClearcoatRoughness_N3, Globals );
			float4 Output_N36 = float4(0.0); Node36_PBR_Lighting( BaseColor_N3, Opacity_N3, Normal_N3, Emissive_N3, Metallic_N3, Roughness_N3, Occlusion_N3.xyz, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N036 ), Output_N36, Globals );
			float4 Output_N405 = float4(0.0); Node405_PBR_Lighting( NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Albedo_N405 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Opacity_N405 ), ClearcoatNormal_N3, NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Emissive_N405 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Metallic_N405 ), ClearcoatRoughness_N3, NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_SpecularAO_N405 ), Output_N405, Globals );
			float4 Result_N31 = float4(0.0); Node31_FINAL_OPACITY( Output_N36, Output_N410, Opacity_N3, Background_N3, Output_N33, SheenOut_N3, Output_N411, ClearcoatBase_N3, Output_N405, Result_N31, Globals );
			
			Input1 = Result_N31;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float Output_N40 = 0.0; Node40_Bool_Parameter( Output_N40, Globals );
			float Output_N121 = 0.0; Node121_Bool_Parameter( Output_N121, Globals );
			Node28_Texture_2D_Object_Parameter( Globals );
			float Output_N7 = 0.0; Node7_DropList_Parameter( Output_N7, Globals );
			float4 Output_N5 = float4(0.0); Node5_Color_Parameter( Output_N5, Globals );
			float Output_N48 = 0.0; Node48_Bool_Parameter( Output_N48, Globals );
			float Output_N88 = 0.0; Node88_Bool_Parameter( Output_N88, Globals );
			float2 Output_N46 = float2(0.0); Node46_Float_Parameter( Output_N46, Globals );
			float2 Output_N49 = float2(0.0); Node49_Float_Parameter( Output_N49, Globals );
			float Output_N50 = 0.0; Node50_Float_Parameter( Output_N50, Globals );
			float3 BaseColor_N35 = float3(0.0); float Opacity_N35 = 0.0; float4 UnlitColor_N35 = float4(0.0); Node35_Unlit( Output_N40, Output_N121, Output_N7, Output_N5, Output_N48, Output_N88, Output_N46, Output_N49, Output_N50, BaseColor_N35, Opacity_N35, UnlitColor_N35, Globals );
			
			Input2 = UnlitColor_N35;
		}
		Output = Input2; 
	}
}
void Node89_Float_Parameter( out float Output, ssGlobals Globals ) { Output = colorMultiplier; }
#define Node90_Add_One( Input0, Output, Globals ) Output = Input0 + 1.0
#define Node91_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
void Node92_Split_Vector( in float4 Value, out float Value1, out float Value2, out float Value3, out float Value4, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
	Value3 = Value.z;
	Value4 = Value.w;
}
#define Node93_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
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
		
		Globals.BumpedNormal               = float3( 0.0 );
		Globals.ViewDirWS                  = rhp.viewDirWS;
		Globals.PositionWS                 = rhp.positionWS;
		Globals.SurfacePosition_WorldSpace = rhp.positionWS;
		Globals.VertexNormal_WorldSpace    = rhp.normalWS;
		Globals.VertexTangent_WorldSpace   = rhp.tangentWS.xyz;
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * rhp.tangentWS.w;
		Globals.Surface_UVCoord0           = rhp.uv0;
		Globals.Surface_UVCoord1           = rhp.uv1;
		
		float4                             emitterPositionCS = ngsViewProjectionMatrix * float4( rhp.positionWS , 1.0 );
		Globals.gScreenCoord               = (emitterPositionCS.xy / emitterPositionCS.w) * 0.5 + 0.5;
		
		Globals.VertexColor                = rhp.color;
	} else
	#endif
	
	{
		Globals.BumpedNormal               = float3( 0.0 );
		Globals.ViewDirWS                  = normalize(sc_Camera.position - varPos);
		Globals.PositionWS                 = varPos;
		Globals.SurfacePosition_WorldSpace = varPos;
		Globals.VertexNormal_WorldSpace    = normalize( varNormal );
		Globals.VertexTangent_WorldSpace   = normalize( varTangent.xyz );
		Globals.VertexBinormal_WorldSpace  = cross( Globals.VertexNormal_WorldSpace, Globals.VertexTangent_WorldSpace.xyz ) * varTangent.w;
		Globals.Surface_UVCoord0           = varTex01.xy;
		Globals.Surface_UVCoord1           = varTex01.zw;
		
		#ifdef                             VERTEX_SHADER
		
		float4                             Result = ngsViewProjectionMatrix * float4( varPos, 1.0 );
		Result.xyz                         /= Result.w; /* map from clip space to NDC space. keep w around so we can re-project back to world*/
		Globals.gScreenCoord               = Result.xy * 0.5 + 0.5;
		
		#else
		
		Globals.gScreenCoord               = getScreenUV().xy;
		
		#endif
		
		Globals.VertexColor                = varColor;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float4 Output_N17 = float4(0.0); Node17_Conditional( float( 1.0 ), float4( 1.0, 1.0, 1.0, 1.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Output_N17, Globals );
		float Output_N89 = 0.0; Node89_Float_Parameter( Output_N89, Globals );
		float Output_N90 = 0.0; Node90_Add_One( Output_N89, Output_N90, Globals );
		float4 Output_N91 = float4(0.0); Node91_Multiply( Output_N17, Output_N90, Output_N91, Globals );
		float Value1_N92 = 0.0; float Value2_N92 = 0.0; float Value3_N92 = 0.0; float Value4_N92 = 0.0; Node92_Split_Vector( Output_N17, Value1_N92, Value2_N92, Value3_N92, Value4_N92, Globals );
		float4 Value_N93 = float4(0.0); Node93_Construct_Vector( Output_N91.xyz, Value4_N92, Value_N93, Globals );
		
		FinalColor = Value_N93;
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
