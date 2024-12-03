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

uniform NF_PRECISION float  startWidth; // Title: Start Width
uniform NF_PRECISION float  endWidth; // Title: End Width
uniform NF_PRECISION int    visualStyle; // Title: Pointer Visual Style
uniform NF_PRECISION float4 startColor; // Title: Start Color
uniform NF_PRECISION float4 endColor; // Title: End Color
uniform NF_PRECISION float  maxAlpha; // Title: maxAlpha	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform bool         Port_Value_N008;
uniform NF_PRECISION float3 Port_Import_N042;
uniform NF_PRECISION float3 Port_Import_N043;
uniform NF_PRECISION float Port_Import_N020;
uniform NF_PRECISION float Port_Import_N021;
uniform NF_PRECISION float Port_Import_N019;
uniform NF_PRECISION float Port_Input1_N014;
uniform NF_PRECISION float Port_Import_N044;
uniform NF_PRECISION float3 Port_Import_N052;
uniform NF_PRECISION float3 Port_Import_N016;
uniform NF_PRECISION float Port_Value3_N040;
uniform NF_PRECISION float Port_Import_N064;
uniform NF_PRECISION float3 Port_Import_N028;
uniform NF_PRECISION float Port_Value3_N060;
uniform NF_PRECISION float Port_Import_N074;
uniform NF_PRECISION float4 Port_Import_N032;
uniform NF_PRECISION float4 Port_Import_N033;
uniform NF_PRECISION float Port_Import_N034;
uniform NF_PRECISION float Port_Import_N076;
uniform NF_PRECISION float Port_Position1_N073;
uniform NF_PRECISION float Port_Value2_N067;
uniform NF_PRECISION float Port_Position2_N073;
uniform NF_PRECISION float Port_Position1_N070;
uniform NF_PRECISION float Port_Position1_N066;
uniform NF_PRECISION float4 Port_Value0_N077;
uniform NF_PRECISION float Port_Position1_N077;
uniform NF_PRECISION float4 Port_Value2_N077;
#endif	



//-----------------------------------------------------------------------



//-----------------------------------------------------------------------

#ifdef VERTEX_SHADER

//----------

// Attributes

attribute vec3 direction;
attribute vec3 prevSegment;	

//----------

// Globals

struct ssGlobals
{
	float gTimeElapsed;
	float gTimeDelta;
	float gTimeElapsedShifted;
	
	float2 Surface_UVCoord0;
	float3 SurfacePosition_WorldSpace;
	float3 ViewDirWS;
};

ssGlobals tempGlobals;
#define scCustomCodeUniform	

//----------

// Functions

#define Node0_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node12_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node9_Surface_Position( Position, Globals ) Position = Globals.SurfacePosition_WorldSpace
void Node8_Bool_Value( in bool Value, out float Output, ssGlobals Globals )
{ 
	Output = ( Value ) ? 1.001 : 0.001;
	Output -= 0.001; // LOOK-62828
}
#define Node7_View_Vector( ViewVector, Globals ) ViewVector = Globals.ViewDirWS
#define Node42_Float_Import( Import, Value, Globals ) Value = Import
void Node45_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
void Node29_Custom_Vertex_Attribute( out float3 _Attribute, ssGlobals Globals )
{ 
	#ifndef SIMULATION_PASS
	_Attribute = vec3( direction );
	#endif
}
#define Node43_Float_Import( Import, Value, Globals ) Value = Import
void Node46_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
#define Node55_Cross( A, B, Result, Globals ) Result = cross( A, B )
void Node47_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
void Node17_Float_Parameter( out float Output, ssGlobals Globals ) { Output = startWidth; }
#define Node20_Float_Import( Import, Value, Globals ) Value = Import
#define Node21_Float_Import( Import, Value, Globals ) Value = Import
#define Node22_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node18_Float_Parameter( out float Output, ssGlobals Globals ) { Output = endWidth; }
#define Node19_Float_Import( Import, Value, Globals ) Value = Import
#define Node39_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node23_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node24_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node14_Divide( Input0, Input1, Output, Globals ) Output = Input0 / Input1
#define Node25_Float_Export( Value, Export, Globals ) Export = Value
#define Node44_Float_Import( Import, Value, Globals ) Value = Import
void Node58_Custom_Vertex_Attribute( out float3 _Attribute, ssGlobals Globals )
{ 
	#ifndef SIMULATION_PASS
	_Attribute = vec3( prevSegment );
	#endif
}
#define Node52_Float_Import( Import, Value, Globals ) Value = Import
void Node59_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
#define Node53_Cross( A, B, Result, Globals ) Result = cross( A, B )
#define Node51_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node57_Divide( Input0, Input1, Output, Globals ) Output = Input0 / Input1
#define Node48_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node50_Float_Export( Value, Export, Globals ) Export = Value
#define Node16_Float_Import( Import, Value, Globals ) Value = Import
void Node38_Split_Vector( in float3 Value, out float Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
	Value3 = Value.z;
}
#define Node49_Negate( Input0, Output, Globals ) Output = -Input0
#define Node40_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node64_Float_Import( Import, Value, Globals ) Value = Import
#define Node28_Float_Import( Import, Value, Globals ) Value = Import
void Node54_Split_Vector( in float3 Value, out float Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
	Value3 = Value.z;
}
#define Node56_Negate( Input0, Output, Globals ) Output = -Input0
#define Node60_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node61_Dot_Product( Input0, Input1, Output, Globals ) Output = dot( Input0, Input1 )
#define Node65_Divide( Input0, Input1, Output, Globals ) Output = Input0 / Input1
#define Node62_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node27_Float_Export( Value, Export, Globals ) Export = Value
void Node63_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Output_N8 = 0.0; Node8_Bool_Value( NF_PORT_CONSTANT( bool( 1 ), Port_Value_N008 ), Output_N8, Globals );
		
		Bool1 = Output_N8;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 ViewVector_N7 = float3(0.0); Node7_View_Vector( ViewVector_N7, Globals );
			float3 Value_N42 = float3(0.0); Node42_Float_Import( ViewVector_N7, Value_N42, Globals );
			float3 Output_N45 = float3(0.0); Node45_Normalize( Value_N42, Output_N45, Globals );
			float3 _Attribute_N29 = float3(0.0); Node29_Custom_Vertex_Attribute( _Attribute_N29, Globals );
			float3 Value_N43 = float3(0.0); Node43_Float_Import( _Attribute_N29, Value_N43, Globals );
			float3 Output_N46 = float3(0.0); Node46_Normalize( Value_N43, Output_N46, Globals );
			float3 Result_N55 = float3(0.0); Node55_Cross( Output_N45, Output_N46, Result_N55, Globals );
			float3 Output_N47 = float3(0.0); Node47_Normalize( Result_N55, Output_N47, Globals );
			float Output_N17 = 0.0; Node17_Float_Parameter( Output_N17, Globals );
			float Value_N20 = 0.0; Node20_Float_Import( Output_N17, Value_N20, Globals );
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N21 = 0.0; Node21_Float_Import( Value2_N12, Value_N21, Globals );
			float Output_N22 = 0.0; Node22_Multiply( Value_N20, Value_N21, Output_N22, Globals );
			float Output_N18 = 0.0; Node18_Float_Parameter( Output_N18, Globals );
			float Value_N19 = 0.0; Node19_Float_Import( Output_N18, Value_N19, Globals );
			float Output_N39 = 0.0; Node39_One_Minus( Value_N21, Output_N39, Globals );
			float Output_N23 = 0.0; Node23_Multiply( Value_N19, Output_N39, Output_N23, Globals );
			float Output_N24 = 0.0; Node24_Add( Output_N22, Output_N23, Output_N24, Globals );
			float Output_N14 = 0.0; Node14_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N014 ), Output_N14, Globals );
			float Export_N25 = 0.0; Node25_Float_Export( Output_N14, Export_N25, Globals );
			float Value_N44 = 0.0; Node44_Float_Import( Export_N25, Value_N44, Globals );
			float3 _Attribute_N58 = float3(0.0); Node58_Custom_Vertex_Attribute( _Attribute_N58, Globals );
			float3 Value_N52 = float3(0.0); Node52_Float_Import( _Attribute_N58, Value_N52, Globals );
			float3 Output_N59 = float3(0.0); Node59_Normalize( Value_N52, Output_N59, Globals );
			float3 Result_N53 = float3(0.0); Node53_Cross( Value_N42, Output_N59, Result_N53, Globals );
			float Output_N51 = 0.0; Node51_Dot_Product( Output_N47, Result_N53, Output_N51, Globals );
			float Output_N57 = 0.0; Node57_Divide( Value_N44, Output_N51, Output_N57, Globals );
			float3 Output_N48 = float3(0.0); Node48_Multiply( Output_N47, Output_N57, Output_N48, Globals );
			float3 Export_N50 = float3(0.0); Node50_Float_Export( Output_N48, Export_N50, Globals );
			
			Value1 = Export_N50;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 _Attribute_N29 = float3(0.0); Node29_Custom_Vertex_Attribute( _Attribute_N29, Globals );
			float3 Value_N16 = float3(0.0); Node16_Float_Import( _Attribute_N29, Value_N16, Globals );
			float Value1_N38 = 0.0; float Value2_N38 = 0.0; float Value3_N38 = 0.0; Node38_Split_Vector( Value_N16, Value1_N38, Value2_N38, Value3_N38, Globals );
			float Output_N49 = 0.0; Node49_Negate( Value2_N38, Output_N49, Globals );
			float3 Value_N40 = float3(0.0); Node40_Construct_Vector( Output_N49, Value1_N38, NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N040 ), Value_N40, Globals );
			float Output_N17 = 0.0; Node17_Float_Parameter( Output_N17, Globals );
			float Value_N20 = 0.0; Node20_Float_Import( Output_N17, Value_N20, Globals );
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N21 = 0.0; Node21_Float_Import( Value2_N12, Value_N21, Globals );
			float Output_N22 = 0.0; Node22_Multiply( Value_N20, Value_N21, Output_N22, Globals );
			float Output_N18 = 0.0; Node18_Float_Parameter( Output_N18, Globals );
			float Value_N19 = 0.0; Node19_Float_Import( Output_N18, Value_N19, Globals );
			float Output_N39 = 0.0; Node39_One_Minus( Value_N21, Output_N39, Globals );
			float Output_N23 = 0.0; Node23_Multiply( Value_N19, Output_N39, Output_N23, Globals );
			float Output_N24 = 0.0; Node24_Add( Output_N22, Output_N23, Output_N24, Globals );
			float Output_N14 = 0.0; Node14_Divide( Output_N24, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N014 ), Output_N14, Globals );
			float Export_N25 = 0.0; Node25_Float_Export( Output_N14, Export_N25, Globals );
			float Value_N64 = 0.0; Node64_Float_Import( Export_N25, Value_N64, Globals );
			float3 _Attribute_N58 = float3(0.0); Node58_Custom_Vertex_Attribute( _Attribute_N58, Globals );
			float3 Value_N28 = float3(0.0); Node28_Float_Import( _Attribute_N58, Value_N28, Globals );
			float Value1_N54 = 0.0; float Value2_N54 = 0.0; float Value3_N54 = 0.0; Node54_Split_Vector( Value_N28, Value1_N54, Value2_N54, Value3_N54, Globals );
			float Output_N56 = 0.0; Node56_Negate( Value2_N54, Output_N56, Globals );
			float3 Value_N60 = float3(0.0); Node60_Construct_Vector( Output_N56, Value1_N54, NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N060 ), Value_N60, Globals );
			float Output_N61 = 0.0; Node61_Dot_Product( Value_N40, Value_N60, Output_N61, Globals );
			float Output_N65 = 0.0; Node65_Divide( Value_N64, Output_N61, Output_N65, Globals );
			float3 Output_N62 = float3(0.0); Node62_Multiply( Value_N40, Output_N65, Output_N62, Globals );
			float3 Export_N27 = float3(0.0); Node27_Float_Export( Output_N62, Export_N27, Globals );
			
			Default = Export_N27;
		}
		Result = Default;
	}
}
#define Node11_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node10_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node3_If_else( in float Bool1, in float3 Value1, in float3 Default, out float3 Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
		float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
		
		Bool1 = Value1_N12;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Position_N9 = float3(0.0); Node9_Surface_Position( Position_N9, Globals );
			float3 Result_N63 = float3(0.0); Node63_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), Result_N63, Globals );
			float3 Output_N11 = float3(0.0); Node11_Subtract( Position_N9, Result_N63, Output_N11, Globals );
			
			Value1 = Output_N11;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Position_N9 = float3(0.0); Node9_Surface_Position( Position_N9, Globals );
			float3 Result_N63 = float3(0.0); Node63_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 0.0, 0.0, 0.0 ), Result_N63, Globals );
			float3 Output_N10 = float3(0.0); Node10_Add( Position_N9, Result_N63, Output_N10, Globals );
			
			Default = Output_N10;
		}
		Result = Default;
	}
}

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
	Globals.Surface_UVCoord0           = v.texture0;
	Globals.SurfacePosition_WorldSpace = varPos;
	Globals.ViewDirWS                  = normalize( ngsCameraPosition - Globals.SurfacePosition_WorldSpace );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float4 ScreenPosition = vec4( 0.0 );
	float3 WorldPosition  = varPos;
	float3 WorldNormal    = varNormal;
	float3 WorldTangent   = varTangent.xyz;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Input port: 'WorldPosition'  */
	
	{
		float3 Result_N3 = float3(0.0); Node3_If_else( float( 0.0 ), float3( 0.0, 0.0, 0.0 ), float3( 1.0, 0.0, 0.0 ), Result_N3, Globals );
		
		WorldPosition = Result_N3;
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

void Node75_Int_Parameter( out float Output, ssGlobals Globals ) { Output = float(visualStyle); }
#define Node74_Float_Import( Import, Value, Globals ) Value = Import
void Node6_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = startColor; }
#define Node32_Float_Import( Import, Value, Globals ) Value = Import
void Node2_Color_Parameter( out float4 Output, ssGlobals Globals ) { Output = endColor; }
#define Node33_Float_Import( Import, Value, Globals ) Value = Import
#define Node0_Surface_UV_Coord( UVCoord, Globals ) UVCoord = Globals.Surface_UVCoord0
void Node12_Split_Vector( in float2 Value, out float Value1, out float Value2, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
}
#define Node34_Float_Import( Import, Value, Globals ) Value = Import
#define Node30_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float4(Input2) )
void Node36_Float_Parameter( out float Output, ssGlobals Globals ) { Output = maxAlpha; }
#define Node76_Float_Import( Import, Value, Globals ) Value = clamp( Import, 0.0, 1.0 )
#define Node68_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node67_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
void Node73_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float4 Value3, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 73, false )
}
void Node70_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 70, false )
}
void Node66_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 66, false )
}
void Node77_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float4 Value2, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 77, false )
}
void Node37_Switch( in float Switch, in float4 Value0, in float4 Value1, in float4 Value2, in float4 Value3, in float4 Value4, in float4 Default, out float4 Result, ssGlobals Globals )
{ 
	/* Input port: "Switch"  */
	
	{
		float Output_N75 = 0.0; Node75_Int_Parameter( Output_N75, Globals );
		float Value_N74 = 0.0; Node74_Float_Import( Output_N75, Value_N74, Globals );
		
		Switch = Value_N74;
	}
	Switch = floor( Switch );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	if ( ( Switch ) == 0.0 )
	{
		/* Input port: "Value0"  */
		
		{
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			
			Value0 = Value_N68;
		}
		Result = Value0;
	}
	else if ( ( Switch ) == 1.0 )
	{
		/* Input port: "Value1"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			float4 Value_N67 = float4(0.0); Node67_Construct_Vector( Output_N30.xyz, NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N067 ), Value_N67, Globals );
			float4 Value_N73 = float4(0.0); Node73_Gradient( Value_N34, Value_N68, NF_PORT_CONSTANT( float( 0.3 ), Port_Position1_N073 ), Value_N67, NF_PORT_CONSTANT( float( 0.7 ), Port_Position2_N073 ), Value_N67, Value_N68, Value_N73, Globals );
			
			Value1 = Value_N73;
		}
		Result = Value1;
	}
	else if ( ( Switch ) == 2.0 )
	{
		/* Input port: "Value2"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			float4 Value_N67 = float4(0.0); Node67_Construct_Vector( Output_N30.xyz, NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N067 ), Value_N67, Globals );
			float4 Value_N70 = float4(0.0); Node70_Gradient( Value_N34, Value_N68, NF_PORT_CONSTANT( float( 1.0 ), Port_Position1_N070 ), Value_N67, Value_N67, Value_N70, Globals );
			
			Value2 = Value_N70;
		}
		Result = Value2;
	}
	else if ( ( Switch ) == 3.0 )
	{
		/* Input port: "Value3"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float4 Value_N67 = float4(0.0); Node67_Construct_Vector( Output_N30.xyz, NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N067 ), Value_N67, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			float4 Value_N66 = float4(0.0); Node66_Gradient( Value_N34, Value_N67, NF_PORT_CONSTANT( float( 0.2 ), Port_Position1_N066 ), Value_N67, Value_N68, Value_N66, Globals );
			
			Value3 = Value_N66;
		}
		Result = Value3;
	}
	else if ( ( Switch ) == 4.0 )
	{
		/* Input port: "Value4"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			float4 Value_N77 = float4(0.0); Node77_Gradient( Value_N34, NF_PORT_CONSTANT( float4( 1.0, 1.0, 0.0, 0.0 ), Port_Value0_N077 ), NF_PORT_CONSTANT( float( 0.7 ), Port_Position1_N077 ), Value_N68, NF_PORT_CONSTANT( float4( 1.0, 1.0, 0.0, 0.0 ), Port_Value2_N077 ), Value_N77, Globals );
			
			Value4 = Value_N77;
		}
		Result = Value4;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float2 UVCoord_N0 = float2(0.0); Node0_Surface_UV_Coord( UVCoord_N0, Globals );
			float Value1_N12 = 0.0; float Value2_N12 = 0.0; Node12_Split_Vector( UVCoord_N0, Value1_N12, Value2_N12, Globals );
			float Value_N34 = 0.0; Node34_Float_Import( Value2_N12, Value_N34, Globals );
			float4 Output_N6 = float4(0.0); Node6_Color_Parameter( Output_N6, Globals );
			float4 Value_N32 = float4(0.0); Node32_Float_Import( Output_N6, Value_N32, Globals );
			float4 Output_N2 = float4(0.0); Node2_Color_Parameter( Output_N2, Globals );
			float4 Value_N33 = float4(0.0); Node33_Float_Import( Output_N2, Value_N33, Globals );
			float4 Output_N30 = float4(0.0); Node30_Mix( Value_N32, Value_N33, Value_N34, Output_N30, Globals );
			float Output_N36 = 0.0; Node36_Float_Parameter( Output_N36, Globals );
			float Value_N76 = 0.0; Node76_Float_Import( Output_N36, Value_N76, Globals );
			float4 Value_N68 = float4(0.0); Node68_Construct_Vector( Output_N30.xyz, Value_N76, Value_N68, Globals );
			float4 Value_N67 = float4(0.0); Node67_Construct_Vector( Output_N30.xyz, NF_PORT_CONSTANT( float( 0.0 ), Port_Value2_N067 ), Value_N67, Globals );
			float4 Value_N70 = float4(0.0); Node70_Gradient( Value_N34, Value_N68, NF_PORT_CONSTANT( float( 1.0 ), Port_Position1_N070 ), Value_N67, Value_N67, Value_N70, Globals );
			
			Default = Value_N70;
		}
		Result = Default;
	}
}
#define Node31_Float_Export( Value, Export, Globals ) Export = Value
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
		float4 Result_N37 = float4(0.0); Node37_Switch( float( 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), float4( 0.0, 0.0, 0.0, 0.0 ), Result_N37, Globals );
		float4 Export_N31 = float4(0.0); Node31_Float_Export( Result_N37, Export_N31, Globals );
		
		FinalColor = Export_N31;
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
