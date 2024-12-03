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

uniform NF_PRECISION                  float  scaleX; // Title: scaleX
uniform NF_PRECISION                  float  scaleFactor; // Title: scaleFactor
uniform NF_PRECISION                  float  scaleY; // Title: scaleY
uniform NF_PRECISION                  float  scaleZ; // Title: scaleZ
uniform NF_PRECISION                  float2 fullScale; // Title: Full Scale
uniform NF_PRECISION                  float2 rawScale; // Title: rawScale
uniform NF_PRECISION                  float  frameMargin; // Title: frameMargin
uniform NF_PRECISION                  float3 touchPosition; // Title: touchPosition
uniform NF_PRECISION                  float2 aspectRatio; // Title: Aspect Ratio
uniform NF_PRECISION                  float  isHovered; // Title: isHovered
SC_DECLARE_TEXTURE(matcapTexture); // Title: MatcapTexture
uniform NF_PRECISION                  float  borderAlpha; // Title: Border Alpha
uniform NF_PRECISION                  float4 scaleHandles; // Title: Scale Handles
uniform NF_PRECISION                  float  backingAlpha; // Title: Backing Alpha
uniform NF_PRECISION                  float  opacity; // Title: opacity
uniform NF_PRECISION                  float  cutOutCenter; // Title: cutOutCenter	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float Port_Input1_N021;
uniform NF_PRECISION float Port_Input2_N014;
uniform NF_PRECISION float Port_Input1_N018;
uniform NF_PRECISION float Port_Input1_N002;
uniform NF_PRECISION float Port_Input2_N019;
uniform NF_PRECISION float Port_Input1_N008;
uniform NF_PRECISION float Port_Input2_N023;
uniform NF_PRECISION float3 Port_Input0_N055;
uniform NF_PRECISION float3 Port_Value_N073;
uniform NF_PRECISION float3 Port_Value_N054;
uniform NF_PRECISION float Port_Input0_N125;
uniform NF_PRECISION float Port_Input1_N084;
uniform NF_PRECISION float Port_Input1_N033;
uniform NF_PRECISION float2 Port_Input0_N096;
uniform NF_PRECISION float Port_Value1_N050;
uniform NF_PRECISION float Port_Value2_N049;
uniform NF_PRECISION float Port_Value2_N064;
uniform NF_PRECISION float Port_Value1_N065;
uniform NF_PRECISION float Port_Input1_N059;
uniform NF_PRECISION float Port_Input1_N062;
uniform NF_PRECISION float Port_RangeMinA_N112;
uniform NF_PRECISION float Port_RangeMaxA_N112;
uniform NF_PRECISION float Port_RangeMinB_N112;
uniform NF_PRECISION float Port_RangeMaxB_N112;
uniform NF_PRECISION float Port_Input1_N072;
uniform NF_PRECISION float Port_RangeMinA_N053;
uniform NF_PRECISION float Port_RangeMaxA_N053;
uniform NF_PRECISION float Port_RangeMinB_N053;
uniform NF_PRECISION float Port_RangeMaxB_N053;
uniform NF_PRECISION float Port_Input1_N160;
uniform NF_PRECISION float Port_Input0_N109;
uniform NF_PRECISION float Port_radius_N104;
uniform NF_PRECISION float Port_borderSoftness_N104;
uniform NF_PRECISION float Port_backingSoftness_N104;
uniform NF_PRECISION float2 Port_borderOffset_N104;
uniform NF_PRECISION float Port_RangeMinA_N110;
uniform NF_PRECISION float Port_RangeMaxA_N110;
uniform NF_PRECISION float Port_RangeMinB_N110;
uniform NF_PRECISION float Port_RangeMaxB_N110;
uniform NF_PRECISION float2 Port_handleOffset_N104;
uniform NF_PRECISION float Port_handleWidth_N104;
uniform NF_PRECISION float Port_handleRadius_N104;
uniform NF_PRECISION float4 Port_Input0_N024;
uniform NF_PRECISION float4 Port_Input1_N024;
uniform NF_PRECISION float Port_Input1_N087;
uniform NF_PRECISION float Port_Input1_N149;
uniform NF_PRECISION float3 Port_Value_N151;
uniform NF_PRECISION float Port_Input1_N052;
uniform NF_PRECISION float Port_RangeMinA_N129;
uniform NF_PRECISION float Port_RangeMaxA_N129;
uniform NF_PRECISION float Port_RangeMinB_N129;
uniform NF_PRECISION float Port_RangeMaxB_N129;
uniform NF_PRECISION float3 Port_Value1_N156;
uniform NF_PRECISION float Port_Input0_N166;
uniform NF_PRECISION float Port_Input1_N165;
uniform NF_PRECISION float Port_Input0_N157;
uniform NF_PRECISION float Port_Input1_N157;
uniform NF_PRECISION float Port_Input0_N107;
uniform NF_PRECISION float Port_Input0_N106;
uniform NF_PRECISION float Port_Input0_N091;
uniform NF_PRECISION float Port_Input1_N085;
uniform NF_PRECISION float2 Port_Input1_N102;
uniform NF_PRECISION float Port_Input1_N093;
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
	
	float4 VertexColor;
	float3 SurfacePosition_ObjectSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

void Node16_Float_Parameter( out float Output, ssGlobals Globals ) { Output = scaleX; }
#define Node9_Surface_Color( Color, Globals ) Color = Globals.VertexColor
void Node10_Split_Vector( in float4 Value, out float Value1, out float Value2, out float Value3, out float Value4, ssGlobals Globals )
{ 
	Value1 = Value.r;
	Value2 = Value.g;
	Value3 = Value.b;
	Value4 = Value.a;
}
#define Node21_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node14_Multiply( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 * Input2
void Node81_Float_Parameter( out float Output, ssGlobals Globals ) { Output = scaleFactor; }
#define Node99_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node12_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
void Node13_Split_Vector( in float3 Value, out float Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
	Value3 = Value.z;
}
#define Node15_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node22_Float_Parameter( out float Output, ssGlobals Globals ) { Output = scaleY; }
#define Node18_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node2_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node19_Multiply( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 * Input2
#define Node97_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node20_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node7_Float_Parameter( out float Output, ssGlobals Globals ) { Output = scaleZ; }
#define Node8_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node23_Multiply( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 * Input2
#define Node177_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node0_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node17_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
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
	Globals.VertexColor                 = varColor;
	Globals.SurfacePosition_ObjectSpace = ( ngsModelMatrixInverse * float4( varPos, 1.0 ) ).xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 ScreenPosition = vec4( 0.0 );
	float3 WorldPosition  = varPos;
	float3 WorldNormal    = varNormal;
	float3 WorldTangent   = varTangent.xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'WorldPosition'  */
	
	{
		float Output_N16 = 0.0; Node16_Float_Parameter( Output_N16, Globals );
		float4 Color_N9 = float4(0.0); Node9_Surface_Color( Color_N9, Globals );
		float Value1_N10 = 0.0; float Value2_N10 = 0.0; float Value3_N10 = 0.0; float Value4_N10 = 0.0; Node10_Split_Vector( Color_N9, Value1_N10, Value2_N10, Value3_N10, Value4_N10, Globals );
		float Output_N21 = 0.0; Node21_Subtract( Value1_N10, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N021 ), Output_N21, Globals );
		float Output_N14 = 0.0; Node14_Multiply( Output_N16, Output_N21, NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N014 ), Output_N14, Globals );
		float Output_N81 = 0.0; Node81_Float_Parameter( Output_N81, Globals );
		float Output_N99 = 0.0; Node99_Divide( Output_N14, Output_N81, Output_N99, Globals );
		float3 Position_N12 = float3(0.0); Node12_Surface_Position( Position_N12, Globals );
		float Value1_N13 = 0.0; float Value2_N13 = 0.0; float Value3_N13 = 0.0; Node13_Split_Vector( Position_N12, Value1_N13, Value2_N13, Value3_N13, Globals );
		float Output_N15 = 0.0; Node15_Add( Output_N99, Value1_N13, Output_N15, Globals );
		float Output_N22 = 0.0; Node22_Float_Parameter( Output_N22, Globals );
		float Output_N18 = 0.0; Node18_Subtract( Value2_N10, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N018 ), Output_N18, Globals );
		float Output_N2 = 0.0; Node2_Multiply( Output_N18, NF_PORT_CONSTANT( float( -1.0 ), Port_Input1_N002 ), Output_N2, Globals );
		float Output_N19 = 0.0; Node19_Multiply( Output_N22, Output_N2, NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N019 ), Output_N19, Globals );
		float Output_N97 = 0.0; Node97_Divide( Output_N19, Output_N81, Output_N97, Globals );
		float Output_N20 = 0.0; Node20_Add( Output_N97, Value2_N13, Output_N20, Globals );
		float Output_N7 = 0.0; Node7_Float_Parameter( Output_N7, Globals );
		float Output_N8 = 0.0; Node8_Subtract( Value3_N10, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N008 ), Output_N8, Globals );
		float Output_N23 = 0.0; Node23_Multiply( Output_N7, Output_N8, NF_PORT_CONSTANT( float( -1.0 ), Port_Input2_N023 ), Output_N23, Globals );
		float Output_N177 = 0.0; Node177_Divide( Output_N23, Output_N81, Output_N177, Globals );
		float Output_N0 = 0.0; Node0_Add( Value3_N13, Output_N177, Output_N0, Globals );
		float3 Value_N17 = float3(0.0); Node17_Construct_Vector( Output_N15, Output_N20, Output_N0, Value_N17, Globals );
		float3 VectorOut_N11 = float3(0.0); Node11_Transform_Vector( Value_N17, VectorOut_N11, Globals );
		
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
	
	float3 SurfacePosition_ObjectSpace;
	float3 SurfacePosition_ViewSpace;
	float3 VertexNormal_WorldSpace;
	float3 VertexNormal_ViewSpace;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node73_Color_Value( Value, Output, Globals ) Output = Value
#define Node54_Color_Value( Value, Output, Globals ) Output = Value
void Node130_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = fullScale; }
void Node83_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node132_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node125_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node84_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node31_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_ObjectSpace
void Node32_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = rawScale; }
#define Node96_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node39_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node47_Min( Input0, Input1, Output, Globals ) Output = min( Input0, Input1 )
#define Node3_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float2(Input1)
#define Node30_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node29_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (float2(Input1) + 1.234e-6)
void Node81_Float_Parameter( out float Output, ssGlobals Globals ) { Output = scaleFactor; }
#define Node79_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node35_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node50_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node56_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node49_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node48_Step( Input0, Input1, Output, Globals ) Output = step( Input0, Input1 )
#define Node36_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float2(Input2) )
#define Node51_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node34_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node82_Float_Parameter( out float Output, ssGlobals Globals ) { Output = frameMargin; }
#define Node60_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node63_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node64_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node65_Construct_Vector( Value1, Value2, Value, Globals ) Value.x = Value1; Value.y = Value2
#define Node66_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float2(Input2) )
#define Node80_Multiply( Input0, Input1, Output, Globals ) Output = float2(Input0) * Input1
#define Node59_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float2(Input1)
#define Node61_Multiply( Input0, Input1, Output, Globals ) Output = float2(Input0) * Input1
#define Node62_Add( Input0, Input1, Output, Globals ) Output = Input0 + float2(Input1)
#define Node98_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node37_Construct_Vector( Value1, Value, Globals ) Value.xy = Value1
void Node40_Float_Parameter( out float3 Output, ssGlobals Globals ) { Output = touchPosition; }
#define Node41_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node5_Float_Parameter( out float2 Output, ssGlobals Globals ) { Output = aspectRatio; }
#define Node28_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node6_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node33_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
void Node112_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
#define Node72_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node26_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float3(Input2) )
void Node53_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
#define Node160_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
void Node94_Float_Parameter( out float Output, ssGlobals Globals ) { Output = isHovered; }
#define Node95_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node55_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float3(Input2) )

vec4  N25_base;
vec4  N25_blend;
vec4 N25_result; 

#pragma inline 
void N25_main()
{
	float opacity = max( N25_blend.a, N25_base.a );
	vec3 col = N25_blend.rgb * N25_blend.a + N25_base.rgb * N25_base.a;
	N25_result = vec4( col, opacity );
}
vec4 N78_MatcapTexture_sample( vec2 coords ) { vec4 _result_memfunc = vec4( 0.0 ); _result_memfunc = SC_SAMPLE_TEX_R(matcapTexture, coords, 0.0); return _result_memfunc; }
vec3 N78_system_getSurfacePositionCameraSpace() { return tempGlobals.SurfacePosition_ViewSpace; }
float N78_DoSample;
vec3 N78_Normal;
vec4 N78_ReflectionSample;

// adopted from Jennifer Fullerton"s Ben Cloward MatCap Node
#pragma inline 
void N78_main()
{
	// get normal in view space
	vec3 normal = N78_Normal;
	
	N78_ReflectionSample = vec4(0., 0., 0., 0.);
	if( N78_DoSample > 0. ) {
		// technique from Ben Cloward:
		// use Camera Space Position and N78_Normal to create matcap UVs
		vec2 ReflectionUV = cross(normalize(N78_system_getSurfacePositionCameraSpace()), normal).yx;
		ReflectionUV.x *= -1.0; // flip U coordinate so it renders correctly
		ReflectionUV = ReflectionUV * 0.5 + 0.5;	// remap [0,1]
		N78_ReflectionSample = N78_MatcapTexture_sample( ReflectionUV );
	}
	
}
#define Node141_Texture_2D_Object_Parameter( Globals ) /*nothing*/
float N104_radius;
float N104_borderSoftness;
float N104_backingSoftness;
vec2 N104_position;
vec2 N104_scale;
vec2 N104_borderOffset;
vec2 N104_backingOffset;
vec2 N104_handleOffset;
float N104_handleWidth;
float N104_handleRadius;
vec4 N104_scaleHandles;
float N104_borderSelect;
float N104_backingSelect;
float N104_handleSelect; 

float N104_saturate( float t ) {
	return clamp( t, 0., 1. );
}

float N104_roundedBox(vec2 N104_position, vec2 halfSize, float cornerRadius) {
	N104_position = abs(N104_position) - halfSize + cornerRadius;
	return length(max(N104_position, 0.0)) + min(max(N104_position.x, N104_position.y), 0.0) - cornerRadius;
}

const float N104_CORNER_SIZE = 5.;

#pragma inline 
void N104_main()
{
	
	vec2 halfSize = N104_scale * .5;
	
	N104_borderSelect = N104_roundedBox( N104_position, halfSize - N104_borderOffset, N104_radius );
	N104_borderSelect = 1. - N104_saturate( smoothstep( 0., N104_borderSoftness, N104_borderSelect ) );
	
	N104_backingSelect = N104_roundedBox( N104_position, halfSize - N104_backingOffset, N104_radius );
	N104_backingSelect = 1. - N104_saturate( smoothstep( 0., N104_backingSoftness, N104_backingSelect ) );
	
	N104_handleSelect = N104_roundedBox( N104_position, halfSize - N104_handleOffset, N104_handleRadius );
	N104_handleSelect = N104_saturate( smoothstep( -N104_handleWidth * .5, 0., N104_handleSelect ) ) - N104_saturate( smoothstep( 0., N104_handleWidth * .5, N104_handleSelect ) ); 
	
	float corners = 0.;
	// top right
	corners += smoothstep( halfSize.y - N104_CORNER_SIZE, halfSize.y, N104_position.y ) * smoothstep( halfSize.x - N104_CORNER_SIZE, halfSize.x, N104_position.x ) * N104_scaleHandles.x; 
	// bottom right
	corners += smoothstep( -halfSize.y + N104_CORNER_SIZE, -halfSize.y, N104_position.y ) * smoothstep( halfSize.x - N104_CORNER_SIZE, halfSize.x, N104_position.x ) * N104_scaleHandles.y; 
	// bottom left
	corners += smoothstep( -halfSize.y + N104_CORNER_SIZE, -halfSize.y, N104_position.y ) * smoothstep( -halfSize.x + N104_CORNER_SIZE, -halfSize.x, N104_position.x ) * N104_scaleHandles.z; 
	// top left
	corners += smoothstep( halfSize.y - N104_CORNER_SIZE, halfSize.y, N104_position.y ) * smoothstep( -halfSize.x + N104_CORNER_SIZE, -halfSize.x, N104_position.x )  * N104_scaleHandles.w;
	
	// apply corners
	N104_handleSelect *= corners; 
	
}
#define Node111_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node74_Float_Parameter( out float Output, ssGlobals Globals ) { Output = borderAlpha; }
void Node110_Remap( in float ValueIn, out float ValueOut, in float RangeMinA, in float RangeMaxA, in float RangeMinB, in float RangeMaxB, ssGlobals Globals )
{ 
	ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB;
	ValueOut = ( RangeMaxB > RangeMinB ) ? clamp( ValueOut, RangeMinB, RangeMaxB ) : clamp( ValueOut, RangeMaxB, RangeMinB );
}
void Node1_Float_Parameter( out float4 Output, ssGlobals Globals ) { Output = scaleHandles; }
void Node104_RoundedBoxSDF( in float radius, in float borderSoftness, in float backingSoftness, in float2 position, in float2 scale, in float2 borderOffset, in float2 backingOffset, in float2 handleOffset, in float handleWidth, in float handleRadius, in float4 scaleHandles, out float borderSelect, out float backingSelect, out float handleSelect, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	borderSelect = float( 0.0 );
	backingSelect = float( 0.0 );
	handleSelect = float( 0.0 );
	
	
	N104_radius = radius;
	N104_borderSoftness = borderSoftness;
	N104_backingSoftness = backingSoftness;
	N104_position = position;
	N104_scale = scale;
	N104_borderOffset = borderOffset;
	N104_backingOffset = backingOffset;
	N104_handleOffset = handleOffset;
	N104_handleWidth = handleWidth;
	N104_handleRadius = handleRadius;
	N104_scaleHandles = scaleHandles;
	
	N104_main();
	
	borderSelect = N104_borderSelect;
	backingSelect = N104_backingSelect;
	handleSelect = N104_handleSelect;
}
#define Node109_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node142_Surface_Normal( Normal, Globals ) Normal = Globals.VertexNormal_ViewSpace
void Node78_MatCap_Reflection_With_If( in float DoSample, in float3 Normal, out float4 ReflectionSample, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	ReflectionSample = vec4( 0.0 );
	
	
	N78_DoSample = DoSample;
	N78_Normal = Normal;
	
	N78_main();
	
	ReflectionSample = N78_ReflectionSample;
}
#define Node87_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node24_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
#define Node58_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node149_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float4(Input1)
#define Node75_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node176_Construct_Vector( Value1, Value2, Value, Globals ) Value.rgb = Value1; Value.a = Value2
#define Node151_Color_Value( Value, Output, Globals ) Output = Value
void Node27_Float_Parameter( out float Output, ssGlobals Globals ) { Output = backingAlpha; }
#define Node52_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node129_Remap( ValueIn, ValueOut, RangeMinA, RangeMaxA, RangeMinB, RangeMaxB, Globals ) ValueOut = ( ( ValueIn - RangeMinA ) / ( RangeMaxA - RangeMinA ) ) * ( RangeMaxB - RangeMinB ) + RangeMinB
#define Node169_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
#define Node76_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node42_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
void Node25_Blend( in float4 base, in float4 blend, out float4 result, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	result = vec4( 0.0 );
	
	
	N25_base = base;
	N25_blend = blend;
	
	N25_main();
	
	result = N25_result;
}
#define Node166_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node165_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node159_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node157_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node158_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node156_Construct_Vector( Value1, Value2, Value, Globals ) Value.rgb = Value1; Value.a = Value2
#define Node100_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node77_Split_Vector( in float4 Value, out float3 Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.rgb;
	Value2 = Value.a;
}
#define Node57_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node88_Float_Parameter( out float Output, ssGlobals Globals ) { Output = opacity; }
void Node103_Float_Parameter( out float Output, ssGlobals Globals ) { Output = cutOutCenter; }
#define Node107_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node91_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node70_Construct_Vector( Value1, Value, Globals ) Value.xy = Value1
#define Node115_Abs( Input0, Output, Globals ) Output = abs( Input0 )
#define Node85_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - float2(Input1)
#define Node102_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node86_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node105_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node106_Smoothstep( Input0, Input1, Input2, Output, Globals ) Output = smoothstep( Input0, Input1, Input2 )
#define Node101_Max( Input0, Input1, Output, Globals ) Output = max( Input0, Input1 )
#define Node89_Multiply( Input0, Input1, Input2, Output, Globals ) Output = Input0 * Input1 * Input2
#define Node90_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node93_Step( Input0, Input1, Output, Globals ) Output = step( Input0, Input1 )
void Node92_Discard( in float4 Input0, in float Input1, out float4 Output, ssGlobals Globals )
{ 
	Output = Input0;
	
	#ifdef FRAGMENT_SHADER
	if ( Input1 * 1.0 != 0.0 )
	{
		discard;
	}	
	#endif
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
	
	
	{
		Globals.SurfacePosition_ObjectSpace = ( ngsModelMatrixInverse * float4( varPos, 1.0 ) ).xyz;
		Globals.SurfacePosition_ViewSpace   = ( ngsViewMatrix * float4( varPos, 1.0 ) ).xyz;
		Globals.VertexNormal_WorldSpace     = normalize( varNormal );
		Globals.VertexNormal_ViewSpace      = normalize( ( ngsViewMatrix * float4( Globals.VertexNormal_WorldSpace, 0.0 ) ).xyz );
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'FinalColor'  */
	
	{
		float3 Output_N73 = float3(0.0); Node73_Color_Value( NF_PORT_CONSTANT( float3( 0.59913, 0.319539, 0.0 ), Port_Value_N073 ), Output_N73, Globals );
		float3 Output_N54 = float3(0.0); Node54_Color_Value( NF_PORT_CONSTANT( float3( 0.752499, 0.717098, 0.0442664 ), Port_Value_N054 ), Output_N54, Globals );
		float2 Output_N130 = float2(0.0); Node130_Float_Parameter( Output_N130, Globals );
		float Value1_N83 = 0.0; float Value2_N83 = 0.0; Node83_Split_Vector( Output_N130, Value1_N83, Value2_N83, Globals );
		float Output_N132 = 0.0; Node132_Max( Value1_N83, Value2_N83, Output_N132, Globals );
		float Output_N125 = 0.0; Node125_Divide( NF_PORT_CONSTANT( float( 1.0 ), Port_Input0_N125 ), Output_N132, Output_N125, Globals );
		float Output_N84 = 0.0; Node84_Multiply( Output_N125, NF_PORT_CONSTANT( float( 6.0 ), Port_Input1_N084 ), Output_N84, Globals );
		float3 Position_N31 = float3(0.0); Node31_Surface_Position( Position_N31, Globals );
		float2 Output_N32 = float2(0.0); Node32_Float_Parameter( Output_N32, Globals );
		float2 Output_N96 = float2(0.0); Node96_Add( NF_PORT_CONSTANT( float2( -0.25, -0.25 ), Port_Input0_N096 ), Output_N32, Output_N96, Globals );
		float Value1_N39 = 0.0; float Value2_N39 = 0.0; Node39_Split_Vector( Output_N96, Value1_N39, Value2_N39, Globals );
		float Output_N47 = 0.0; Node47_Min( Value1_N39, Value2_N39, Output_N47, Globals );
		float2 Output_N3 = float2(0.0); Node3_Multiply( Position_N31.xy, Output_N47, Output_N3, Globals );
		float Output_N30 = 0.0; Node30_Max( Value1_N39, Value2_N39, Output_N30, Globals );
		float2 Output_N29 = float2(0.0); Node29_Divide( Output_N3, Output_N30, Output_N29, Globals );
		float Output_N81 = 0.0; Node81_Float_Parameter( Output_N81, Globals );
		float Output_N79 = 0.0; Node79_Divide( Output_N81, Output_N47, Output_N79, Globals );
		float Output_N35 = 0.0; Node35_Divide( Output_N30, Output_N47, Output_N35, Globals );
		float2 Value_N50 = float2(0.0); Node50_Construct_Vector( NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N050 ), Output_N35, Value_N50, Globals );
		float Output_N56 = 0.0; Node56_Divide( Output_N30, Output_N47, Output_N56, Globals );
		float2 Value_N49 = float2(0.0); Node49_Construct_Vector( Output_N56, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N049 ), Value_N49, Globals );
		float Output_N48 = 0.0; Node48_Step( Value1_N39, Value2_N39, Output_N48, Globals );
		float2 Output_N36 = float2(0.0); Node36_Mix( Value_N50, Value_N49, Output_N48, Output_N36, Globals );
		float2 Output_N51 = float2(0.0); Node51_Multiply( float2( Output_N79 ), Output_N36, Output_N51, Globals );
		float2 Output_N34 = float2(0.0); Node34_Multiply( Output_N29, Output_N51, Output_N34, Globals );
		float Output_N82 = 0.0; Node82_Float_Parameter( Output_N82, Globals );
		float Output_N60 = 0.0; Node60_Divide( Output_N82, Output_N81, Output_N60, Globals );
		float Output_N63 = 0.0; Node63_Divide( Output_N47, Output_N30, Output_N63, Globals );
		float2 Value_N64 = float2(0.0); Node64_Construct_Vector( Output_N63, NF_PORT_CONSTANT( float( 1.0 ), Port_Value2_N064 ), Value_N64, Globals );
		float2 Value_N65 = float2(0.0); Node65_Construct_Vector( NF_PORT_CONSTANT( float( 1.0 ), Port_Value1_N065 ), Output_N63, Value_N65, Globals );
		float2 Output_N66 = float2(0.0); Node66_Mix( Value_N64, Value_N65, Output_N48, Output_N66, Globals );
		float2 Output_N80 = float2(0.0); Node80_Multiply( Output_N79, Output_N66, Output_N80, Globals );
		float2 Output_N59 = float2(0.0); Node59_Multiply( Output_N80, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N059 ), Output_N59, Globals );
		float2 Output_N61 = float2(0.0); Node61_Multiply( Output_N60, Output_N59, Output_N61, Globals );
		float2 Output_N62 = float2(0.0); Node62_Add( Output_N61, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N062 ), Output_N62, Globals );
		float2 Output_N98 = float2(0.0); Node98_Divide( Output_N34, Output_N62, Output_N98, Globals );
		float2 Value_N37 = float2(0.0); Node37_Construct_Vector( Output_N98, Value_N37, Globals );
		float3 Output_N40 = float3(0.0); Node40_Float_Parameter( Output_N40, Globals );
		float2 Output_N41 = float2(0.0); Node41_Subtract( Value_N37, Output_N40.xy, Output_N41, Globals );
		float2 Output_N5 = float2(0.0); Node5_Float_Parameter( Output_N5, Globals );
		float2 Output_N28 = float2(0.0); Node28_Divide( Output_N41, Output_N5, Output_N28, Globals );
		float Output_N6 = 0.0; Node6_Length( Output_N28, Output_N6, Globals );
		float Output_N33 = 0.0; Node33_Smoothstep( Output_N84, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N033 ), Output_N6, Output_N33, Globals );
		float ValueOut_N112 = 0.0; Node112_Remap( Output_N33, ValueOut_N112, NF_PORT_CONSTANT( float( 0.5 ), Port_RangeMinA_N112 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N112 ), NF_PORT_CONSTANT( float( 0.33 ), Port_RangeMinB_N112 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N112 ), Globals );
		float Output_N72 = 0.0; Node72_Pow( ValueOut_N112, NF_PORT_CONSTANT( float( 6.0 ), Port_Input1_N072 ), Output_N72, Globals );
		float3 Output_N26 = float3(0.0); Node26_Mix( Output_N73, Output_N54, Output_N72, Output_N26, Globals );
		float ValueOut_N53 = 0.0; Node53_Remap( Output_N33, ValueOut_N53, NF_PORT_CONSTANT( float( 0.2 ), Port_RangeMinA_N053 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N053 ), NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinB_N053 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxB_N053 ), Globals );
		float Output_N160 = 0.0; Node160_Pow( ValueOut_N53, NF_PORT_CONSTANT( float( 1.5 ), Port_Input1_N160 ), Output_N160, Globals );
		float Output_N94 = 0.0; Node94_Float_Parameter( Output_N94, Globals );
		float Output_N95 = 0.0; Node95_Multiply( Output_N160, Output_N94, Output_N95, Globals );
		float3 Output_N55 = float3(0.0); Node55_Mix( NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Input0_N055 ), Output_N26, Output_N95, Output_N55, Globals );
		Node141_Texture_2D_Object_Parameter( Globals );
		float2 Output_N111 = float2(0.0); Node111_Multiply( Value_N37, Output_N130, Output_N111, Globals );
		float Output_N74 = 0.0; Node74_Float_Parameter( Output_N74, Globals );
		float ValueOut_N110 = 0.0; Node110_Remap( Output_N74, ValueOut_N110, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N110 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N110 ), NF_PORT_CONSTANT( float( 5.0 ), Port_RangeMinB_N110 ), NF_PORT_CONSTANT( float( 2.75 ), Port_RangeMaxB_N110 ), Globals );
		float4 Output_N1 = float4(0.0); Node1_Float_Parameter( Output_N1, Globals );
		float borderSelect_N104 = 0.0; float backingSelect_N104 = 0.0; float handleSelect_N104 = 0.0; Node104_RoundedBoxSDF( NF_PORT_CONSTANT( float( 1.0 ), Port_radius_N104 ), NF_PORT_CONSTANT( float( 3.5 ), Port_borderSoftness_N104 ), NF_PORT_CONSTANT( float( 5.0 ), Port_backingSoftness_N104 ), Output_N111, Output_N130, NF_PORT_CONSTANT( float2( 2.0, 2.0 ), Port_borderOffset_N104 ), float2( ValueOut_N110 ), NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_handleOffset_N104 ), NF_PORT_CONSTANT( float( 0.5 ), Port_handleWidth_N104 ), NF_PORT_CONSTANT( float( 1.66 ), Port_handleRadius_N104 ), Output_N1, borderSelect_N104, backingSelect_N104, handleSelect_N104, Globals );
		float Output_N109 = 0.0; Node109_Subtract( NF_PORT_CONSTANT( float( 1.0 ), Port_Input0_N109 ), borderSelect_N104, Output_N109, Globals );
		float3 Normal_N142 = float3(0.0); Node142_Surface_Normal( Normal_N142, Globals );
		float4 ReflectionSample_N78 = float4(0.0); Node78_MatCap_Reflection_With_If( Output_N109, Normal_N142, ReflectionSample_N78, Globals );
		float Output_N87 = 0.0; Node87_Pow( Output_N109, NF_PORT_CONSTANT( float( 2.75 ), Port_Input1_N087 ), Output_N87, Globals );
		float4 Output_N24 = float4(0.0); Node24_Mix( NF_PORT_CONSTANT( float4( 0.612177, 0.612177, 0.612177, 1.0 ), Port_Input0_N024 ), NF_PORT_CONSTANT( float4( 0.738949, 0.738949, 0.738949, 1.0 ), Port_Input1_N024 ), Output_N87, Output_N24, Globals );
		float4 Output_N58 = float4(0.0); Node58_Max( ReflectionSample_N78, Output_N24, Output_N58, Globals );
		float4 Output_N149 = float4(0.0); Node149_Multiply( Output_N58, NF_PORT_CONSTANT( float( 1.75 ), Port_Input1_N149 ), Output_N149, Globals );
		float Output_N75 = 0.0; Node75_Multiply( Output_N74, Output_N109, Output_N75, Globals );
		float4 Value_N176 = float4(0.0); Node176_Construct_Vector( Output_N149.xyz, Output_N75, Value_N176, Globals );
		float3 Output_N151 = float3(0.0); Node151_Color_Value( NF_PORT_CONSTANT( float3( 0.0196078, 0.0196078, 0.0196078 ), Port_Value_N151 ), Output_N151, Globals );
		float Output_N27 = 0.0; Node27_Float_Parameter( Output_N27, Globals );
		float Output_N52 = 0.0; Node52_Multiply( Output_N27, NF_PORT_CONSTANT( float( 0.7 ), Port_Input1_N052 ), Output_N52, Globals );
		float ValueOut_N129 = 0.0; Node129_Remap( Output_N74, ValueOut_N129, NF_PORT_CONSTANT( float( 0.0 ), Port_RangeMinA_N129 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMaxA_N129 ), NF_PORT_CONSTANT( float( 1.0 ), Port_RangeMinB_N129 ), NF_PORT_CONSTANT( float( 0.33 ), Port_RangeMaxB_N129 ), Globals );
		float Output_N169 = 0.0; Node169_Pow( backingSelect_N104, ValueOut_N129, Output_N169, Globals );
		float Output_N76 = 0.0; Node76_Multiply( Output_N52, Output_N169, Output_N76, Globals );
		float4 Value_N42 = float4(0.0); Node42_Construct_Vector( Output_N151, Output_N76, Value_N42, Globals );
		float4 result_N25 = float4(0.0); Node25_Blend( Value_N176, Value_N42, result_N25, Globals );
		float Output_N166 = 0.0; Node166_Multiply( NF_PORT_CONSTANT( float( 5.5 ), Port_Input0_N166 ), Output_N125, Output_N166, Globals );
		float Output_N165 = 0.0; Node165_Smoothstep( Output_N166, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N165 ), Output_N6, Output_N165, Globals );
		float Output_N159 = 0.0; Node159_Multiply( Output_N94, Output_N165, Output_N159, Globals );
		float Output_N157 = 0.0; Node157_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N157 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N157 ), handleSelect_N104, Output_N157, Globals );
		float Output_N158 = 0.0; Node158_Multiply( Output_N159, Output_N157, Output_N158, Globals );
		float4 Value_N156 = float4(0.0); Node156_Construct_Vector( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Value1_N156 ), Output_N158, Value_N156, Globals );
		float4 Output_N100 = float4(0.0); Node100_Mix( result_N25, Value_N156, Output_N158, Output_N100, Globals );
		float3 Value1_N77 = float3(0.0); float Value2_N77 = 0.0; Node77_Split_Vector( Output_N100, Value1_N77, Value2_N77, Globals );
		float3 Output_N57 = float3(0.0); Node57_Add( Output_N55, Value1_N77, Output_N57, Globals );
		float Output_N88 = 0.0; Node88_Float_Parameter( Output_N88, Globals );
		float Output_N103 = 0.0; Node103_Float_Parameter( Output_N103, Globals );
		float Output_N107 = 0.0; Node107_Subtract( NF_PORT_CONSTANT( float( 1.0 ), Port_Input0_N107 ), Output_N103, Output_N107, Globals );
		float Output_N91 = 0.0; Node91_Divide( NF_PORT_CONSTANT( float( 1.0 ), Port_Input0_N091 ), Output_N132, Output_N91, Globals );
		float2 Value_N70 = float2(0.0); Node70_Construct_Vector( Output_N34, Value_N70, Globals );
		float2 Output_N115 = float2(0.0); Node115_Abs( Value_N70, Output_N115, Globals );
		float2 Output_N85 = float2(0.0); Node85_Subtract( Output_N115, NF_PORT_CONSTANT( float( 0.5 ), Port_Input1_N085 ), Output_N85, Globals );
		float2 Output_N102 = float2(0.0); Node102_Max( Output_N85, NF_PORT_CONSTANT( float2( 0.0, 0.0 ), Port_Input1_N102 ), Output_N102, Globals );
		float2 Output_N86 = float2(0.0); Node86_Divide( Output_N102, Output_N5, Output_N86, Globals );
		float Output_N105 = 0.0; Node105_Length( Output_N86, Output_N105, Globals );
		float Output_N106 = 0.0; Node106_Smoothstep( NF_PORT_CONSTANT( float( 0.0 ), Port_Input0_N106 ), Output_N91, Output_N105, Output_N106, Globals );
		float Output_N101 = 0.0; Node101_Max( Output_N107, Output_N106, Output_N101, Globals );
		float Output_N89 = 0.0; Node89_Multiply( Value2_N77, Output_N88, Output_N101, Output_N89, Globals );
		float4 Value_N90 = float4(0.0); Node90_Construct_Vector( Output_N57, Output_N89, Value_N90, Globals );
		float Output_N93 = 0.0; Node93_Step( Output_N89, NF_PORT_CONSTANT( float( 0.0001 ), Port_Input1_N093 ), Output_N93, Globals );
		float4 Output_N92 = float4(0.0); Node92_Discard( Value_N90, Output_N93, Output_N92, Globals );
		
		FinalColor = Output_N92;
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
