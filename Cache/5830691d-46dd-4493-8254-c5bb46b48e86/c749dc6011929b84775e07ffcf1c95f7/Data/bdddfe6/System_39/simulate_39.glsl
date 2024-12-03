#version 310 es

#define NODEFLEX 0 // Hack for now to know if a shader is running in Studio or on a released lens

#define SIMULATION_PASS

#define NF_PRECISION highp

#define SC_USE_USER_DEFINED_VS_MAIN

//-----------------------------------------------------------------------



//-----------------------------------------------------------------------


//-----------------------------------------------------------------------
// Standard defines
//-----------------------------------------------------------------------


#pragma paste_to_backend_at_the_top_begin
#define SC_DISABLE_FRUSTUM_CULLING
#define SC_ALLOW_16_TEXTURES
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


uniform int	vfxNumCopies;
uniform bool vfxBatchEnable[32];
uniform mat4 vfxModelMatrix[32];
// uniform mat4 vfxModelMatrixInverse[32];
// uniform mat4 vfxModelViewMatrix[32];
// uniform mat4 vfxModelViewMatrixInverse[32];
// uniform mat4 vfxModelViewProjectionMatrix[32];
// uniform mat4 vfxModelViewProjectionMatrixInverse[32];
// uniform vec3 vfxWorldAabbMin[32];
// uniform vec3 vfxWorldAabbMax[32];

#ifdef VERTEX_SHADER
#define ngsCopyId sc_LocalInstanceID/ssPARTICLE_COUNT_1D_INT
#else
#define ngsCopyId int(Interp_Particle_Index / SC_INT_FALLBACK_FLOAT(ssPARTICLE_COUNT_1D_INT))
#endif


#define ngsLocalAabbMin						vfxLocalAabbMin
#define ngsWorldAabbMin						vfxWorldAabbMin[ngsCopyId]
#define ngsLocalAabbMax						vfxLocalAabbMax
#define ngsWorldAabbMax						vfxWorldAabbMax[ngsCopyId]

#if defined( SIMULATION_PASS )

#define ngsCameraAspect 					vfxCameraAspect
#define ngsCameraNear                       vfxCameraNear
#define ngsCameraFar                        vfxCameraFar
#define ngsCameraPosition                   vfxViewMatrixInverse[3].xyz
#define ngsModelMatrix                      vfxModelMatrix[ngsCopyId]							//ssGetGlobal_Matrix_World()
#define ngsModelMatrixInverse               vfxModelMatrixInverse[ngsCopyId]					//ssGetGlobal_Matrix_World_Inverse()
#define ngsModelViewMatrix                  vfxModelViewMatrix[ngsCopyId]						//ssGetGlobal_Matrix_World_View()
#define ngsModelViewMatrixInverse           vfxModelViewMatrixInverse[ngsCopyId]				//ssGetGlobal_Matrix_World_View_Inverse()
#define ngsModelViewProjectionMatrix        vfxModelViewProjectionMatrix[ngsCopyId]				//ssGetGlobal_Matrix_World_View_Projection()
#define ngsModelViewProjectionMatrixInverse vfxModelViewProjectionMatrixInverse[ngsCopyId]		//ssGetGlobal_Matrix_World_View_Projection_Inverse()
#define ngsProjectionMatrix                 vfxProjectionMatrix									//ssGetGlobal_Matrix_Projection()
#define ngsProjectionMatrixInverse          vfxProjectionMatrixInverse							//ssGetGlobal_Matrix_Projection_Inverse()
#define ngsViewMatrix                       vfxViewMatrix										//ssGetGlobal_Matrix_View()
#define ngsViewMatrixInverse                vfxViewMatrixInverse								//ssGetGlobal_Matrix_View_Inverse()
#define ngsViewProjectionMatrix             vfxViewProjectionMatrix								//ssGetGlobal_Matrix_View_Projection()
#define ngsViewProjectionMatrixInverse      vfxViewProjectionMatrixInverse						//ssGetGlobal_Matrix_View_Projection_Inverse()
#define ngsCameraUp 					    vfxCameraUp
#define ngsCameraForward                    -vfxCameraForward
#define ngsCameraRight                      vfxCameraRight
#define ngsFrame    	                    vfxFrame

#else		

#define ngsCameraAspect 					sc_Camera.aspect;
#define ngsCameraNear                       sc_Camera.clipPlanes.x
#define ngsCameraFar                        sc_Camera.clipPlanes.y
#define ngsCameraPosition                   sc_Camera.position
#define ngsModelMatrix                      vfxModelMatrix[ngsCopyId]							//ssGetGlobal_Matrix_World()
#define ngsModelMatrixInverse               vfxModelMatrixInverse[ngsCopyId]					//ssGetGlobal_Matrix_World_Inverse()
#define ngsModelViewMatrix                  vfxModelViewMatrix[ngsCopyId]						//ssGetGlobal_Matrix_World_View()
#define ngsModelViewMatrixInverse           vfxModelViewMatrixInverse[ngsCopyId]				//ssGetGlobal_Matrix_World_View_Inverse()
#define ngsModelViewProjectionMatrix        vfxModelViewProjectionMatrix[ngsCopyId]				//ssGetGlobal_Matrix_World_View_Projection()
#define ngsModelViewProjectionMatrixInverse vfxModelViewProjectionMatrixInverse[ngsCopyId]		//ssGetGlobal_Matrix_World_View_Projection_Inverse()
#define ngsProjectionMatrix                 sc_ProjectionMatrix									//ssGetGlobal_Matrix_Projection()
#define ngsProjectionMatrixInverse          sc_ProjectionMatrixInverse							//ssGetGlobal_Matrix_Projection_Inverse()
#define ngsViewMatrix                       sc_ViewMatrix										//ssGetGlobal_Matrix_View()
#define ngsViewMatrixInverse                sc_ViewMatrixInverse								//ssGetGlobal_Matrix_View_Inverse()
#define ngsViewProjectionMatrix             sc_ViewProjectionMatrix								//ssGetGlobal_Matrix_View_Projection()
#define ngsViewProjectionMatrixInverse      sc_ViewProjectionMatrixInverse						//ssGetGlobal_Matrix_View_Projection_Inverse()
#define ngsCameraUp 					    sc_ViewMatrixInverse[1].xyz
#define ngsCameraForward                    -sc_ViewMatrixInverse[2].xyz
#define ngsCameraRight                      sc_ViewMatrixInverse[0].xyz
#define ngsFrame 		                    0

#endif
struct ssParticle
{	
	vec3  Position;
	vec3  Velocity;
	vec4  Color;
	float Size;
	float Age; 			// how long the particle has been alive
	float Life;			// the lifespan of the particle
	float Mass;
	mat3  Matrix;
	bool  Dead;
	vec4  Quaternion;
	
	// Custom
	
	float collisionCount_N119;
	
	
	// Calculated
	
	float SpawnOffset;
	float Seed;
	vec2  Seed2000;
	float TimeShift;
	int   Index1D;
	int	  Index1DPerCopy;	// Index1D % numParticlePerCopy
	float Coord1D;
	float Ratio1D;
	float Ratio1DPerCopy;	// Index1DPerCopy / numParticlesPerCopy
	ivec2 Index2D;
	vec2  Coord2D;
	vec2  Ratio2D;
	vec3  Force;
	bool  Spawned;
	float CopyId;
};

ssParticle gParticle;

vec4 matrixToQuaternion(mat3 m)
{
	float fourXSquaredMinus1 = m[0][0] - m[1][1] - m[2][2];
	float fourYSquaredMinus1 = m[1][1] - m[0][0] - m[2][2];
	float fourZSquaredMinus1 = m[2][2] - m[0][0] - m[1][1];
	float fourWSquaredMinus1 = m[0][0] + m[1][1] + m[2][2];
	
	int biggestIndex = 0;
	float fourBiggestSquaredMinus1 = fourWSquaredMinus1;
	if(fourXSquaredMinus1 > fourBiggestSquaredMinus1) {
		fourBiggestSquaredMinus1 = fourXSquaredMinus1;
		biggestIndex = 1;
	}
	if(fourYSquaredMinus1 > fourBiggestSquaredMinus1) {
		fourBiggestSquaredMinus1 = fourYSquaredMinus1;
		biggestIndex = 2;
	}
	if(fourZSquaredMinus1 > fourBiggestSquaredMinus1) {
		fourBiggestSquaredMinus1 = fourZSquaredMinus1;
		biggestIndex = 3;
	}
	
	float biggestVal = sqrt(fourBiggestSquaredMinus1 + 1.0) * (0.5);
	float mult = 0.25 / biggestVal;
	
	if(biggestIndex == 0){
		return vec4(biggestVal, (m[1][2] - m[2][1]) * mult, (m[2][0] - m[0][2]) * mult, (m[0][1] - m[1][0]) * mult);
	}
	else if(biggestIndex == 1){
		return vec4((m[1][2] - m[2][1]) * mult, biggestVal, (m[0][1] + m[1][0]) * mult, (m[2][0] + m[0][2]) * mult);
	}
	else if(biggestIndex == 2){
		return vec4((m[2][0] - m[0][2]) * mult, (m[0][1] + m[1][0]) * mult, biggestVal, (m[1][2] + m[2][1]) * mult);
	}
	else if(biggestIndex == 3){
		return vec4((m[0][1] - m[1][0]) * mult, (m[2][0] + m[0][2]) * mult, (m[1][2] + m[2][1]) * mult, biggestVal);
	}
	else return vec4(1, 0, 0, 0);
}

mat3 quaternionToMatrix(vec4 q)
{  
	mat3 resultMat;
	q = normalize(q.yzwx);
	float qxx = (q.x * q.x);
	float qyy = (q.y * q.y);
	float qzz = (q.z * q.z);
	float qxz = (q.x * q.z);
	float qxy = (q.x * q.y);
	float qyz = (q.y * q.z);
	float qwx = (q.w * q.x);
	float qwy = (q.w * q.y);
	float qwz = (q.w * q.z);
	return mat3(1.0 - 2.0 * (qyy +  qzz), 2.0 * (qxy + qwz), 2.0 * (qxz - qwy), 
		2.0 * (qxy - qwz), 1.0 - 2.0 * (qxx +  qzz), 2.0 * (qyz + qwx),
		2.0 * (qxz + qwy), 2.0 * (qyz - qwx), 1.0 - 2.0 * (qxx +  qyy));
}		
vec4 EncodeFloat32( float v /* 0 - 1 range only */ ) 
{
	vec4 enc = vec4(1.0, 255.0, 65025.0, 16581375.0) * v;
	enc = fract(enc);
	enc -= enc.yzww * vec4(1.0/255.0, 1.0/255.0, 1.0/255.0, 0.0);
	return enc;
}

vec3 EncodeFloat24( float v /* 0 - 1 range only */ ) 
{
	vec4 enc = vec4(1.0, 255.0, 65025.0, 16581375.0) * v;
	enc = fract(enc);
	enc -= enc.yzww * vec4(1.0/255.0, 1.0/255.0, 1.0/255.0, 0.0);
	return enc.rgb;
}

vec2 EncodeFloat16( float v /* 0 - 1 range only */ ) 
{
	vec4 enc = vec4(1.0, 255.0, 65025.0, 16581375.0) * v;
	enc = fract(enc);
	enc -= enc.yzww * vec4(1.0/255.0, 1.0/255.0, 1.0/255.0, 0.0);
	return enc.rg;
}

float EncodeFloat8( float v /* 0 - 1 range only */ ) 
{
	vec4 enc = vec4(1.0, 255.0, 65025.0, 16581375.0) * v;
	enc = fract(enc);
	enc -= enc.yzww * vec4(1.0/255.0, 1.0/255.0, 1.0/255.0, 0.0);
	return enc.r;
}

float DecodeFloat32( vec4 rgba /* 0 - 1 range only */, const bool Quantize ) 
{ 
	if ( Quantize ) 
	rgba = floor(rgba * 255.0 + 0.5) / 255.0;
	return dot( rgba, vec4(1.0, 1.0/255.0, 1.0/65025.0, 1.0/16581375.0) );
}

float DecodeFloat24( vec3 rgb /* 0 - 1 range only */, const bool Quantize ) 
{
	if ( Quantize ) 
	rgb = floor(rgb * 255.0 + 0.5) / 255.0;
	return dot( rgb, vec3(1.0, 1.0/255.0, 1.0/65025.0) );
}

float DecodeFloat16( vec2 rg /* 0 - 1 range only */, const bool Quantize ) 
{
	if ( Quantize ) 
	rg = floor(rg * 255.0 + 0.5) / 255.0;
	return dot( rg, vec2(1.0, 1.0/255.0) );
}

float DecodeFloat8( float r /* 0 - 1 range only */, const bool Quantize ) 
{
	if ( Quantize ) 
	r = floor(r * 255.0 + 0.5) / 255.0;
	return r;
}

#define ssDEFAULT_REMAP_RANGE 0.99999
#define ssDEFAULT_REMAP_RANGE2 1.0

vec4  remap (vec4 value, vec4 oldmin, vec4 oldmax, vec4 newmin, vec4 newmax) { return newmin + (value - oldmin) * (newmax - newmin) / (oldmax - oldmin); }
vec3  remap (vec3 value, vec3 oldmin, vec3 oldmax, vec3 newmin, vec3 newmax) { return newmin + (value - oldmin) * (newmax - newmin) / (oldmax - oldmin); }
vec2  remap (vec2 value, vec2 oldmin, vec2 oldmax, vec2 newmin, vec2 newmax) { return newmin + (value - oldmin) * (newmax - newmin) / (oldmax - oldmin); }
float remap (float value, float oldmin, float oldmax, float newmin, float newmax) { return newmin + (value - oldmin) * (newmax - newmin) / (oldmax - oldmin); }
float remapTo01 (float value) { return (value + 1.0) * 0.5; }
float remapFrom01 (float value ) { return (value * 2.0) - 1.0; }

vec4  ssEncodeFloat32( float Value, float Min, float Max, float RemapRange )                      { return EncodeFloat32( remap( clamp( Value, Min, Max ), Min, Max, 0.0, RemapRange ) ); }
vec4  ssEncodeFloat32( float Value, float Min, float Max )                     					  { return ssEncodeFloat32( Value, Min, Max, ssDEFAULT_REMAP_RANGE ); }
vec4  ssEncodeFloat32( float Value, float RemapRange )                                            { return ssEncodeFloat32( Value, 0.0, 1.0, RemapRange ); }
vec3  ssEncodeFloat24( float Value, float Min, float Max, float RemapRange )                      { return EncodeFloat24( remap( clamp( Value, Min, Max ), Min, Max, 0.0, RemapRange ) ); }
vec3  ssEncodeFloat24( float Value, float Min, float Max )                     					  { return ssEncodeFloat24( Value, Min, Max, ssDEFAULT_REMAP_RANGE ); }
vec3  ssEncodeFloat24( float Value, float RemapRange )                                            { return ssEncodeFloat24( Value, 0.0, 1.0, RemapRange ); }
vec2  ssEncodeFloat16( float Value, float Min, float Max, float RemapRange )                      { return EncodeFloat16( remap( clamp( Value, Min, Max ), Min, Max, 0.0, RemapRange ) ); }
vec2  ssEncodeFloat16( float Value, float Min, float Max )                     					  { return ssEncodeFloat16( Value, Min, Max, ssDEFAULT_REMAP_RANGE ); }
vec2  ssEncodeFloat16( float Value, float RemapRange )                                            { return ssEncodeFloat16( Value, 0.0, 1.0, RemapRange ); }
float ssEncodeFloat8(  float Value, float Min, float Max, float RemapRange )                      { return remap( clamp( Value, Min, Max ), Min, Max, 0.0, RemapRange ); }
float ssEncodeFloat8(  float Value, float Min, float Max )                     					  { return remap( clamp( Value, Min, Max ), Min, Max, 0.0, ssDEFAULT_REMAP_RANGE2 ); }
float ssEncodeFloat8(  float Value, float RemapRange )                                            { return ssEncodeFloat8( Value, 0.0, 1.0, RemapRange ); }

float ssDecodeFloat32(  vec4 Value, float Min, float Max, const bool Quantize, float RemapRange ) { return remap( DecodeFloat32( Value, Quantize ), 0.0, RemapRange, Min, Max ); }
float ssDecodeFloat32(  vec4 Value, float Min, float Max ) 										  { return ssDecodeFloat32( Value, Min, Max, true, ssDEFAULT_REMAP_RANGE ); }
float ssDecodeFloat32(  vec4 Value, const bool Quantize, float RemapRange )                       { return ssDecodeFloat32( Value, 0.0, 1.0, Quantize, RemapRange ); }
float ssDecodeFloat24(  vec3 Value, float Min, float Max, const bool Quantize, float RemapRange ) { return remap( DecodeFloat24( Value, Quantize ), 0.0, RemapRange, Min, Max ); }
float ssDecodeFloat24(  vec3 Value, float Min, float Max ) 										  { return ssDecodeFloat24( Value, Min, Max, true, ssDEFAULT_REMAP_RANGE ); }
float ssDecodeFloat24(  vec3 Value, const bool Quantize, float RemapRange )                       { return ssDecodeFloat24( Value, 0.0, 1.0, Quantize, RemapRange ); }
float ssDecodeFloat16(  vec2 Value, float Min, float Max, const bool Quantize, float RemapRange ) { return remap( DecodeFloat16( Value, Quantize ), 0.0, RemapRange, Min, Max ); }
float ssDecodeFloat16(  vec2 Value, float Min, float Max ) 										  { return ssDecodeFloat16( Value, Min, Max, true, ssDEFAULT_REMAP_RANGE ); }
float ssDecodeFloat16(  vec2 Value, const bool Quantize, float RemapRange )                       { return ssDecodeFloat16( Value, 0.0, 1.0, Quantize, RemapRange ); }
float ssDecodeFloat8(  float Value, float Min, float Max, const bool Quantize, float RemapRange ) { return remap( DecodeFloat8( Value, Quantize ), 0.0, RemapRange, Min, Max ); }
float ssDecodeFloat8(  float Value, float Min, float Max ) 										  { return ssDecodeFloat8( Value, Min, Max, true, ssDEFAULT_REMAP_RANGE2); }
float ssDecodeFloat8(  float Value, const bool Quantize, float RemapRange )                       { return ssDecodeFloat8( Value, 0.0, 1.0, Quantize, RemapRange ); }

int ssRandLfsr(int n)
{
	return (n * (n * 1471343 + 101146501) + 1559861749) & 0x7fffffff;
}

float ssNormalizeRand(int r)
{
	return float(r) * (1.0 / 2147483647.0);
}

int ssGetRandSeedDim1(int x) 
{
	return x ^ (x * 15299);
}

int ssGetRandSeedDim2(int x, int y) {
	return (x * 15299) ^ (y * 30133);
}

int ssGetRandSeedDim3(int x, int y, int z) 
{
	return (x * 15299) ^ (y * 30133) ^ (z * 17539);
}

int ssGetRandSeedDim4(int x, int y, int z, int w) 
{
	return (x * 15299) ^ (y * 30133) ^ (z * 17539) ^ (w * 12113);
}

//--------------------------------------------------------

float ssRandFloat(int seed)
{
	return ssNormalizeRand(ssRandLfsr(seed));	
}

// All seeds given by the user are interpreted as ints
float rand_float( float Seed ) { return ssRandFloat( ssGetRandSeedDim1(int(Seed)) ); }
float rand_float( vec2 Seed )  { return ssRandFloat( ssGetRandSeedDim2(int(Seed.x), int(Seed.y)) ); }
float rand_float( vec3 Seed )  { return ssRandFloat( ssGetRandSeedDim3(int(Seed.x), int(Seed.y), int(Seed.z)) ); }
float rand_float( vec4 Seed )  { return ssRandFloat( ssGetRandSeedDim4(int(Seed.x), int(Seed.y), int(Seed.z), int(Seed.w)) ); }

//--------------------------------------------------------

vec2 ssRandVec2(int seed) 
{
	int r1 = ssRandLfsr(seed);
	int r2 = ssRandLfsr(seed * 1399);
	return vec2(ssNormalizeRand(r1), ssNormalizeRand(r2));
}

vec2 rand_vec2( float Seed ) { return ssRandVec2( ssGetRandSeedDim1(int(Seed)) ); }
vec2 rand_vec2( vec2 Seed )  { return ssRandVec2( ssGetRandSeedDim2(int(Seed.x), int(Seed.y)) ); }
vec2 rand_vec2( vec3 Seed )  { return ssRandVec2( ssGetRandSeedDim3(int(Seed.x), int(Seed.y), int(Seed.z)) ); }
vec2 rand_vec2( vec4 Seed )  { return ssRandVec2( ssGetRandSeedDim4(int(Seed.x), int(Seed.y), int(Seed.z), int(Seed.w)) ); }

//--------------------------------------------------------

vec3 ssRandVec3(int seed) 
{
	int r1 = ssRandLfsr(seed);
	int r2 = ssRandLfsr(seed * 1399);
	int r3 = ssRandLfsr(seed * 7177);
	return vec3(ssNormalizeRand(r1), ssNormalizeRand(r2), ssNormalizeRand(r3));
}

vec3 rand_vec3( float Seed ) { return ssRandVec3( ssGetRandSeedDim1(int(Seed)) ); }
vec3 rand_vec3( vec2 Seed )  { return ssRandVec3( ssGetRandSeedDim2(int(Seed.x), int(Seed.y)) ); }
vec3 rand_vec3( vec3 Seed )  { return ssRandVec3( ssGetRandSeedDim3(int(Seed.x), int(Seed.y), int(Seed.z)) ); }
vec3 rand_vec3( vec4 Seed )  { return ssRandVec3( ssGetRandSeedDim4(int(Seed.x), int(Seed.y), int(Seed.z), int(Seed.w)) ); }

//--------------------------------------------------------

vec4 ssRandVec4(int seed) 
{
	int r1 = ssRandLfsr(seed);
	int r2 = ssRandLfsr(seed * 1399);
	int r3 = ssRandLfsr(seed * 7177);
	int r4 = ssRandLfsr(seed * 18919);
	return vec4(ssNormalizeRand(r1), ssNormalizeRand(r2), ssNormalizeRand(r3), ssNormalizeRand(r4));
}

vec4 rand_vec4( float Seed ) { return ssRandVec4( ssGetRandSeedDim1(int(Seed)) ); }
vec4 rand_vec4( vec2 Seed )  { return ssRandVec4( ssGetRandSeedDim2(int(Seed.x), int(Seed.y)) ); }
vec4 rand_vec4( vec3 Seed )  { return ssRandVec4( ssGetRandSeedDim3(int(Seed.x), int(Seed.y), int(Seed.z)) ); }
vec4 rand_vec4( vec4 Seed )  { return ssRandVec4( ssGetRandSeedDim4(int(Seed.x), int(Seed.y), int(Seed.z), int(Seed.w)) ); }

//--------------------------------------------------------	


vec4 ssGetParticleRandom( int Dimension, bool UseTime, bool UseNodeID, bool UseParticleID, float NodeID, ssParticle Particle, float ExtraSeed, float Time )
{
	vec4 Random = vec4( 0.0 );
	vec4 seed = vec4(0.0);
	
	if (UseTime) 		seed.x = floor(fract(Time) * 1000.0);
	if (UseParticleID) 	seed.y = float(Particle.Index1D ^ (Particle.Index1D * 15299 + Particle.Index1D));
	if (UseNodeID) 		seed.z = NodeID;
	seed.w = ExtraSeed * 1000.0;	
	
	int seed_i = ssGetRandSeedDim4(int(seed.x), int(seed.y), int(seed.z), int(seed.w));
	
	if 		( Dimension == 1 ) Random.x 	= ssRandFloat(seed_i);
	else if ( Dimension == 2 ) Random.xy 	= ssRandVec2(seed_i); 					
	else if ( Dimension == 3 ) Random.xyz 	= ssRandVec3(seed_i);
	else 					   Random 		= ssRandVec4(seed_i);
	
	return Random;
}

//--------------------------------------------------------			


//--------------------------------------------------------


#if 0

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

#define NF_DISABLE_VERTEX_CHANGES() 				( PreviewEnabled == 1 )		
#define NF_SETUP_PREVIEW_VERTEX()					PreviewInfo.Color = PreviewVertexColor = float4( 0.5 ); PreviewInfo.Saved = false; PreviewVertexSaved = 0.0;
#define NF_SETUP_PREVIEW_PIXEL()					PreviewInfo.Color = PreviewVertexColor; PreviewInfo.Saved = ( PreviewVertexSaved * 1.0 != 0.0 ) ? true : false;
#define NF_PREVIEW_SAVE( xCode, xNodeID, xAlpha ) 	if ( PreviewEnabled == 1 && !PreviewInfo.Saved && xNodeID == PreviewNodeID ) { PreviewInfo.Saved = true; { PreviewInfo.Color = xCode; if ( !xAlpha ) PreviewInfo.Color.a = 1.0; } }
#define NF_PREVIEW_FORCE_SAVE( xCode ) 				if ( PreviewEnabled == 0 ) { PreviewInfo.Saved = true; { PreviewInfo.Color = xCode; } }
#define NF_PREVIEW_OUTPUT_VERTEX()					if ( PreviewInfo.Saved ) { PreviewVertexColor = float4( PreviewInfo.Color.rgb, 1.0 ); PreviewVertexSaved = 1.0; }
#define NF_PREVIEW_OUTPUT_PIXEL()					if ( PreviewEnabled == 1 ) { if ( PreviewInfo.Saved ) { Output_Color0 = float4( PreviewInfo.Color ); } else { Output_Color0 = vec4( 0.0, 0.0, 0.0, 0.0 ); /*FinalColor.a = 1.0;*/ /* this will be an option later */ }  }

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

#ifdef FRAGMENT_SHADER

#define ngsAlphaTest( opacity )

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


//--------------------------------------------------------

SC_DECLARE_TEXTURE(renderTarget0);
SC_DECLARE_TEXTURE(renderTarget1);
SC_DECLARE_TEXTURE(renderTarget2);
SC_DECLARE_TEXTURE(renderTarget3);

//--------------------------------------------------------

uniform highp vec3  vfxLocalAabbMin;
uniform highp vec3  vfxLocalAabbMax;
uniform highp float vfxCameraAspect;
uniform highp float vfxCameraNear;
uniform highp float vfxCameraFar;
uniform highp vec3  vfxCameraUp;
uniform highp vec3  vfxCameraForward;
uniform highp vec3  vfxCameraRight;
uniform highp mat4  vfxProjectionMatrix;
uniform highp mat4  vfxProjectionMatrixInverse;
uniform highp mat4  vfxViewMatrix;
uniform highp mat4  vfxViewMatrixInverse;
uniform highp mat4  vfxViewProjectionMatrix;
uniform highp mat4  vfxViewProjectionMatrixInverse;
uniform       int   vfxFrame;

uniform int 		vfxOffsetInstances;		
uniform int 		vfxOffsetInstancesPrev;
uniform vec2 		ssTARGET_SIZE_INT;
uniform vec2 		ssTARGET_SIZE_FLOAT;
uniform float 		ssTARGET_WIDTH;
uniform int 		ssTARGET_WIDTH_INT;

//--------------------------------------------------------


#define ssTEXEL_COUNT_INT           4
#define ssTEXEL_COUNT_FLOAT         4.0
#define ssPARTICLE_COUNT_1D_INT		40
#define ssPARTICLE_COUNT_1D_FLOAT	40.0
#define ssPARTICLE_COUNT_2D_INT		ivec2( 40, 1 )
#define ssPARTICLE_COUNT_2D_FLOAT	float2( 40.0, 1.0 )
#define ssPARTICLE_LIFE_MAX 		float( 0.2 )
#define ssPARTICLE_TOTAL_LIFE_MAX 	float( 0.2 )
#define ssPARTICLE_BURST_GROUPS 	float( 1.0 )
#define ssPARTICLE_SPAWN_RATE 		float( 200.0 )
#define ssPARTICLE_BURST_EVERY 		float( 0.005 )
#define ssPARTICLE_DELAY_MAX        float( 0.5 )
#define ssPARTICLE_MASS_MAX         float( 100.0 )
#define ssPARTICLE_SIZE_MAX         float( 100.0 )


//--------------------------------------------------------


int    ssParticle_Index2D_to_Index1D( ivec2 Index2D )  		{ return Index2D.y * ssPARTICLE_COUNT_2D_INT.x + Index2D.x; }
ivec2  ssParticle_Index1D_to_Index2D( int Index1D )	   		{ return ivec2( Index1D % ssPARTICLE_COUNT_2D_INT.x, Index1D / ssPARTICLE_COUNT_2D_INT.x ); }
float  ssParticle_Index1D_to_Coord1D( int Index1D )    		{ return ( float( Index1D ) + 0.5 ) / ssPARTICLE_COUNT_1D_FLOAT; }
float  ssParticle_Index1D_to_Ratio1D( int Index1D )    		{ return float( Index1D ) / max( ssPARTICLE_COUNT_1D_FLOAT - 1.0, 1.0 ); }
float2 ssParticle_Index2D_to_Coord2D( ivec2 Index2D )  		{ return ( float2( Index2D ) + 0.5 ) / ssPARTICLE_COUNT_2D_FLOAT; }
float2 ssParticle_Index2D_to_Ratio2D( ivec2 Index2D )  		{ return float2( Index2D ) / max( ssPARTICLE_COUNT_2D_FLOAT - float2( 1.0, 1.0 ), float2( 1.0, 1.0 ) ); }
int    ssParticle_Coord1D_to_Index1D( float Coord1D )  		{ return int( Coord1D * ssPARTICLE_COUNT_1D_FLOAT ); }
ivec2  ssParticle_Coord2D_to_Index2D( float2 Coord2D ) 		{ return ivec2( Coord2D * ssPARTICLE_COUNT_2D_FLOAT ); }	
float2 ssParticle_Index1D_to_Coord2D( int Index1D )    		{ return ssParticle_Index2D_to_Coord2D( ssParticle_Index1D_to_Index2D( Index1D ) ); }
float  ssParticle_Index2D_to_Coord1D( ivec2 Index2D )  		{ return ssParticle_Index1D_to_Coord1D( ssParticle_Index2D_to_Index1D( Index2D ) ); }
int    ssParticle_Coord2D_to_Index1D( float2 Coord2D ) 		{ return ssParticle_Index2D_to_Index1D( ssParticle_Coord2D_to_Index2D( Coord2D ) ); }
ivec2  ssParticle_Coord1D_to_Index2D( float Coord1D )  		{ return ssParticle_Index1D_to_Index2D( ssParticle_Coord1D_to_Index1D( Coord1D ) ); }
float2 ssParticle_Coord1D_to_Coord2D( float Coord1D )  		{ return ssParticle_Index2D_to_Coord2D( ssParticle_Coord1D_to_Index2D( Coord1D ) ); }	
float  ssParticle_Coord2D_to_Coord1D( float2 Coord2D ) 		{ return ssParticle_Index1D_to_Coord1D( ssParticle_Coord2D_to_Index1D( Coord2D ) ); }


//--------------------------------------------------------


void ssCalculateParticleSeed( inout ssParticle Particle )
{
	#if 0
	// Spawn Once - Live Forever
	//Particle.Seed = rand( vec2( Particle.Ratio1D + 0.141435 ) * 0.6789 );	
	Particle.Seed = Particle.Ratio1D * 0.976379 + 0.151235;
	ivec2 Index2D = ivec2( Particle.Index1D % 400, Particle.Index1D / 400 );	
	Particle.Seed2000 = ( vec2( Index2D ) + vec2( 1.0, 1.0 ) ) / max( vec2( 400.0, 400.0 ) - float2( 1.0, 1.0 ), float2( 1.0, 1.0 ) );
	#else
	// Any time max life is used
	float ElapsedTime = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	
	Particle.Seed = Particle.Ratio1D * 0.976379 + 0.151235;
	Particle.Seed = Particle.Seed + floor( ( ElapsedTime - Particle.SpawnOffset - 0.0 /*delay*/ + 0.0 /*warmup*/  + ssPARTICLE_TOTAL_LIFE_MAX * 2.0 ) / ssPARTICLE_TOTAL_LIFE_MAX ) * 4.32723;
	Particle.Seed = fract( abs( Particle.Seed ) );
	ivec2 Index2D = ivec2( Particle.Index1D % 400, Particle.Index1D / 400 );	
	Particle.Seed2000 = ( vec2( Index2D ) + vec2( 1.0, 1.0 ) ) / max( vec2( 400.0, 400.0 ) - float2( 1.0, 1.0 ), float2( 1.0, 1.0 ) );
	#endif
	
	//ssPRECISION_LIMITER( Particle.Seed )
}


//--------------------------------------------------------


void ssCalculateDynamicAttributes( int InstanceID, inout ssParticle Particle )
{
	Particle.Spawned     	= false;
	Particle.Dead			= false;
	Particle.Force       	= vec3( 0.0 );
	Particle.Index1D     	= InstanceID;
	Particle.Index1DPerCopy = InstanceID % ssPARTICLE_COUNT_1D_INT;
	Particle.Index2D     	= ssParticle_Index1D_to_Index2D( Particle.Index1D );
	Particle.Coord1D     	= ssParticle_Index1D_to_Coord1D( Particle.Index1D );
	Particle.Coord2D     	= ssParticle_Index2D_to_Coord2D( Particle.Index2D );
	Particle.Ratio1D     	= ssParticle_Index1D_to_Ratio1D( Particle.Index1D );
	Particle.Ratio1DPerCopy = ssParticle_Index1D_to_Ratio1D( Particle.Index1DPerCopy );
	Particle.Ratio2D     	= ssParticle_Index2D_to_Ratio2D( Particle.Index2D );
	Particle.Seed        	= 0.0;
	Particle.CopyId			= float(Particle.Index1D / ssPARTICLE_COUNT_1D_INT) ;
	
	#if 0
	Particle.TimeShift   = rand( vec2( Particle.Ratio1D ) * vec2( 0.3452, 0.52254 ) ); // legacy random
	#else
	Particle.TimeShift   = ssRandFloat(Particle.Index1D);
	#endif			
	
	#if 1
	Particle.SpawnOffset = Particle.Ratio1D * ssPARTICLE_LIFE_MAX;	
	#elif  0
	Particle.TimeShift   = 0.0;
	Particle.SpawnOffset = float( Particle.Index1DPerCopy / int( ssPARTICLE_SPAWN_RATE ) ) * ssPARTICLE_BURST_EVERY;
	#else
	Particle.TimeShift   = 0.0;
	Particle.SpawnOffset = 0.0;
	#endif
	
	ssCalculateParticleSeed( Particle );
}


//-----------------------------------------------------------------------


highp vec4  Output_Color0;
highp vec4  Output_Color1;
highp vec4  Output_Color2;
highp vec4  Output_Color3;
highp float Output_Depth;


//-----------------------------------------------------------------------


SC_INTERPOLATION_FLAT varying mediump SC_INT_FALLBACK_FLOAT Interp_Particle_Index;
varying highp vec3     Interp_Particle_Force;
varying highp vec2     Interp_Particle_Coord;

varying highp float3 Interp_Particle_Position;
varying highp float3 Interp_Particle_Velocity;
varying highp float Interp_Particle_Life;
varying highp float Interp_Particle_Age;
varying highp float Interp_Particle_Size;
varying highp float4 Interp_Particle_Color;
varying highp float4 Interp_Particle_Quaternion;
varying highp float Interp_Particle_collisionCount_N119;
varying highp float Interp_Particle_Mass;



//--------------------------------------------------------


#ifdef asdf_____USE_16_BIT_TEXTURES
#define ssENCODE_TO_TARGET0( Value, Min, Max ) fragOut[0] = remap( Value, 0, 65534 );
#define ssENCODE_TO_TARGET1( Value, Min, Max ) fragOut[1] = remap( Value, 0, 65534 );
#define ssENCODE_TO_TARGET2( Value, Min, Max ) fragOut[2] = remap( Value, 0, 65534 );
#define ssENCODE_TO_TARGET3( Value, Min, Max ) fragOut[3] = remap( Value, 0, 65534 );
#else
#define ssENCODE_TO_TARGET0( Value, Min, Max ) rt0 = ssEncodeFloat32( Value, Min, Max );
#define ssENCODE_TO_TARGET1( Value, Min, Max ) rt1 = ssEncodeFloat32( Value, Min, Max );
#define ssENCODE_TO_TARGET2( Value, Min, Max ) rt2 = ssEncodeFloat32( Value, Min, Max );
#define ssENCODE_TO_TARGET3( Value, Min, Max ) rt3 = ssEncodeFloat32( Value, Min, Max );
#endif


//-----------------------------------------------------------------------


int ngsModInt( int x, int y )
{
	return x - ( ( x / y ) * y );
}


//-----------------------------------------------------------------------


bool ssDecodeParticle( int InstanceID )
{
	gParticle.Position   = vec3( 0.0 );
	gParticle.Velocity   = vec3( 0.0 );
	gParticle.Color      = vec4( 0.0 );
	gParticle.Size       = 0.0; 
	gParticle.Age        = 0.0;
	gParticle.Life       = 0.0;
	gParticle.Mass       = 1.0;
	gParticle.Matrix     = mat3( 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 );
	gParticle.Quaternion = vec4( 0.0, 0.0, 0.0, 1.0 );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssCalculateDynamicAttributes( InstanceID, gParticle );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#ifdef SIMULATION_PASS
	int offsetPixelId = (vfxOffsetInstancesPrev + InstanceID) * ssTEXEL_COUNT_INT;
	#else
	int offsetPixelId = (vfxOffsetInstances + InstanceID) * ssTEXEL_COUNT_INT;
	#endif
	ivec2  Index2D = ivec2( ngsModInt( offsetPixelId, ssTARGET_WIDTH_INT ), offsetPixelId / ssTARGET_WIDTH_INT );			
	float2 Coord   = ( float2( Index2D ) + 0.5 ) / float2(2048.0, ssTARGET_SIZE_FLOAT.y);	
	float2 Offset  = float2( 1.0 / 2048.0, 0.0 ); 			
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	vec2  uv    = vec2( 0.0 );
	float Scalar0 = 0.0;
	float Scalar1 = 0.0;
	float Scalar2 = 0.0;
	float Scalar3 = 0.0;
	float Scalar4 = 0.0;
	float Scalar5 = 0.0;
	float Scalar6 = 0.0;
	float Scalar7 = 0.0;
	float Scalar8 = 0.0;
	float Scalar9 = 0.0;
	float Scalar10 = 0.0;
	float Scalar11 = 0.0;
	float Scalar12 = 0.0;
	float Scalar13 = 0.0;
	float Scalar14 = 0.0;
	float Scalar15 = 0.0;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	uv = Coord + Offset * 0.0;
	{ vec4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, uv, 0.0);
		/*Early exit if the MRT is empty, i.e. dead particle*/
		if (dot(abs(renderTarget0Sample), vec4(1.0)) < 0.00001 || !vfxBatchEnable[ngsCopyId]) return false;   Scalar0  = renderTarget0Sample.x; Scalar1  = renderTarget0Sample.y; Scalar2  = renderTarget0Sample.z; Scalar3  = renderTarget0Sample.w; }
	{ vec4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, uv, 0.0); Scalar4  = renderTarget1Sample.x; Scalar5  = renderTarget1Sample.y; Scalar6  = renderTarget1Sample.z; Scalar7  = renderTarget1Sample.w; }
	{ vec4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, uv, 0.0); Scalar8  = renderTarget2Sample.x; Scalar9  = renderTarget2Sample.y; Scalar10 = renderTarget2Sample.z; Scalar11 = renderTarget2Sample.w; }
	{ vec4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, uv, 0.0); Scalar12 = renderTarget3Sample.x; Scalar13 = renderTarget3Sample.y; Scalar14 = renderTarget3Sample.z; Scalar15 = renderTarget3Sample.w; }
	
	gParticle.Position.x = ssDecodeFloat32( vec4( Scalar0, Scalar1, Scalar2, Scalar3 ), -1000.0, 1000.0 );
	gParticle.Position.y = ssDecodeFloat32( vec4( Scalar4, Scalar5, Scalar6, Scalar7 ), -1000.0, 1000.0 );
	gParticle.Position.z = ssDecodeFloat32( vec4( Scalar8, Scalar9, Scalar10, Scalar11 ), -1000.0, 1000.0 );
	gParticle.Velocity.x = ssDecodeFloat32( vec4( Scalar12, Scalar13, Scalar14, Scalar15 ), -1000.0, 1000.0 );
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	uv = Coord + Offset * 1.0;
	{ vec4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, uv, 0.0); Scalar0  = renderTarget0Sample.x; Scalar1  = renderTarget0Sample.y; Scalar2  = renderTarget0Sample.z; Scalar3  = renderTarget0Sample.w; }
	{ vec4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, uv, 0.0); Scalar4  = renderTarget1Sample.x; Scalar5  = renderTarget1Sample.y; Scalar6  = renderTarget1Sample.z; Scalar7  = renderTarget1Sample.w; }
	{ vec4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, uv, 0.0); Scalar8  = renderTarget2Sample.x; Scalar9  = renderTarget2Sample.y; Scalar10 = renderTarget2Sample.z; Scalar11 = renderTarget2Sample.w; }
	{ vec4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, uv, 0.0); Scalar12 = renderTarget3Sample.x; Scalar13 = renderTarget3Sample.y; Scalar14 = renderTarget3Sample.z; Scalar15 = renderTarget3Sample.w; }
	
	gParticle.Velocity.y = ssDecodeFloat32( vec4( Scalar0, Scalar1, Scalar2, Scalar3 ), -1000.0, 1000.0 );
	gParticle.Velocity.z = ssDecodeFloat32( vec4( Scalar4, Scalar5, Scalar6, Scalar7 ), -1000.0, 1000.0 );
	gParticle.Life = ssDecodeFloat32( vec4( Scalar8, Scalar9, Scalar10, Scalar11 ), 0.0, 0.2 );
	gParticle.Age = ssDecodeFloat32( vec4( Scalar12, Scalar13, Scalar14, Scalar15 ), 0.0, 0.2 );
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	uv = Coord + Offset * 2.0;
	{ vec4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, uv, 0.0); Scalar0  = renderTarget0Sample.x; Scalar1  = renderTarget0Sample.y; Scalar2  = renderTarget0Sample.z; Scalar3  = renderTarget0Sample.w; }
	{ vec4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, uv, 0.0); Scalar4  = renderTarget1Sample.x; Scalar5  = renderTarget1Sample.y; Scalar6  = renderTarget1Sample.z; Scalar7  = renderTarget1Sample.w; }
	{ vec4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, uv, 0.0); Scalar8  = renderTarget2Sample.x; Scalar9  = renderTarget2Sample.y; Scalar10 = renderTarget2Sample.z; Scalar11 = renderTarget2Sample.w; }
	{ vec4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, uv, 0.0); Scalar12 = renderTarget3Sample.x; Scalar13 = renderTarget3Sample.y; Scalar14 = renderTarget3Sample.z; Scalar15 = renderTarget3Sample.w; }
	
	gParticle.Size = ssDecodeFloat16( vec2( Scalar0, Scalar1 ), 0.0, 100.0 );
	gParticle.Quaternion.x = ssDecodeFloat16( vec2( Scalar2, Scalar3 ), -1.0, 1.0 );
	gParticle.Quaternion.y = ssDecodeFloat16( vec2( Scalar4, Scalar5 ), -1.0, 1.0 );
	gParticle.Quaternion.z = ssDecodeFloat16( vec2( Scalar6, Scalar7 ), -1.0, 1.0 );
	gParticle.Quaternion.w = ssDecodeFloat16( vec2( Scalar8, Scalar9 ), -1.0, 1.0 );
	gParticle.Mass = ssDecodeFloat16( vec2( Scalar10, Scalar11 ), 0.0, 100.0 );
	gParticle.Color.x = ssDecodeFloat8( Scalar12, 0.0, 1.00001 );
	gParticle.Color.y = ssDecodeFloat8( Scalar13, 0.0, 1.00001 );
	gParticle.Color.z = ssDecodeFloat8( Scalar14, 0.0, 1.00001 );
	gParticle.Color.w = ssDecodeFloat8( Scalar15, 0.0, 1.00001 );
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	uv = Coord + Offset * 3.0;
	{ vec4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, uv, 0.0); Scalar0  = renderTarget0Sample.x; Scalar1  = renderTarget0Sample.y; Scalar2  = renderTarget0Sample.z; Scalar3  = renderTarget0Sample.w; }
	{ vec4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, uv, 0.0); Scalar4  = renderTarget1Sample.x; Scalar5  = renderTarget1Sample.y; Scalar6  = renderTarget1Sample.z; Scalar7  = renderTarget1Sample.w; }
	{ vec4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, uv, 0.0); Scalar8  = renderTarget2Sample.x; Scalar9  = renderTarget2Sample.y; Scalar10 = renderTarget2Sample.z; Scalar11 = renderTarget2Sample.w; }
	{ vec4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, uv, 0.0); Scalar12 = renderTarget3Sample.x; Scalar13 = renderTarget3Sample.y; Scalar14 = renderTarget3Sample.z; Scalar15 = renderTarget3Sample.w; }
	
	gParticle.collisionCount_N119 = ssDecodeFloat8( Scalar0, 0.0, 255.0 );
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -	
	
	gParticle.Matrix = quaternionToMatrix(gParticle.Quaternion);
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssPRECISION_LIMITER2( gParticle.Velocity )
	ssPRECISION_LIMITER2( gParticle.Position )
	ssPRECISION_LIMITER2( gParticle.Color )
	ssPRECISION_LIMITER2( gParticle.Size )
	ssPRECISION_LIMITER2( gParticle.Mass )
	ssPRECISION_LIMITER2( gParticle.Life )
	
	return true;
}


//--------------------------------------------------------


void ssEncodeParticle( float2 Coord, out vec4 rt0, out vec4 rt1, out vec4 rt2, out vec4 rt3 )
{
	#ifdef FRAGMENT_SHADER
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	int TexelIndex = int( floor( Coord.x * ssTEXEL_COUNT_FLOAT ) );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	vec4  Vector = vec4( 0.0 );
	float Scalar0 = 0.0;
	float Scalar1 = 0.0;
	float Scalar2 = 0.0;
	float Scalar3 = 0.0;
	float Scalar4 = 0.0;
	float Scalar5 = 0.0;
	float Scalar6 = 0.0;
	float Scalar7 = 0.0;
	float Scalar8 = 0.0;
	float Scalar9 = 0.0;
	float Scalar10 = 0.0;
	float Scalar11 = 0.0;
	float Scalar12 = 0.0;
	float Scalar13 = 0.0;
	float Scalar14 = 0.0;
	float Scalar15 = 0.0;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	if ( TexelIndex == 0 )
	{
		Vector.xyzw = ssEncodeFloat32( gParticle.Position.x, -1000.0, 1000.0 ); Scalar0 = Vector.x; Scalar1 = Vector.y; Scalar2 = Vector.z; Scalar3 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Position.y, -1000.0, 1000.0 ); Scalar4 = Vector.x; Scalar5 = Vector.y; Scalar6 = Vector.z; Scalar7 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Position.z, -1000.0, 1000.0 ); Scalar8 = Vector.x; Scalar9 = Vector.y; Scalar10 = Vector.z; Scalar11 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Velocity.x, -1000.0, 1000.0 ); Scalar12 = Vector.x; Scalar13 = Vector.y; Scalar14 = Vector.z; Scalar15 = Vector.w;
	}
	else if ( TexelIndex == 1 )
	{
		Vector.xyzw = ssEncodeFloat32( gParticle.Velocity.y, -1000.0, 1000.0 ); Scalar0 = Vector.x; Scalar1 = Vector.y; Scalar2 = Vector.z; Scalar3 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Velocity.z, -1000.0, 1000.0 ); Scalar4 = Vector.x; Scalar5 = Vector.y; Scalar6 = Vector.z; Scalar7 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Life, 0.0, 0.2 );              Scalar8 = Vector.x; Scalar9 = Vector.y; Scalar10 = Vector.z; Scalar11 = Vector.w;
		Vector.xyzw = ssEncodeFloat32( gParticle.Age, 0.0, 0.2 );               Scalar12 = Vector.x; Scalar13 = Vector.y; Scalar14 = Vector.z; Scalar15 = Vector.w;
	}
	else if ( TexelIndex == 2 )
	{
		Vector.xy = ssEncodeFloat16( gParticle.Size, 0.0, 100.0 );        Scalar0 = Vector.x; Scalar1 = Vector.y;
		Vector.xy = ssEncodeFloat16( gParticle.Quaternion.x, -1.0, 1.0 ); Scalar2 = Vector.x; Scalar3 = Vector.y;
		Vector.xy = ssEncodeFloat16( gParticle.Quaternion.y, -1.0, 1.0 ); Scalar4 = Vector.x; Scalar5 = Vector.y;
		Vector.xy = ssEncodeFloat16( gParticle.Quaternion.z, -1.0, 1.0 ); Scalar6 = Vector.x; Scalar7 = Vector.y;
		Vector.xy = ssEncodeFloat16( gParticle.Quaternion.w, -1.0, 1.0 ); Scalar8 = Vector.x; Scalar9 = Vector.y;
		Vector.xy = ssEncodeFloat16( gParticle.Mass, 0.0, 100.0 );        Scalar10 = Vector.x; Scalar11 = Vector.y;
		Vector.x = ssEncodeFloat8( gParticle.Color.x, 0.0, 1.00001 );     Scalar12 = Vector.x;
		Vector.x = ssEncodeFloat8( gParticle.Color.y, 0.0, 1.00001 );     Scalar13 = Vector.x;
		Vector.x = ssEncodeFloat8( gParticle.Color.z, 0.0, 1.00001 );     Scalar14 = Vector.x;
		Vector.x = ssEncodeFloat8( gParticle.Color.w, 0.0, 1.00001 );     Scalar15 = Vector.x;
	}
	else if ( TexelIndex == 3 )
	{
		Vector.x = ssEncodeFloat8( gParticle.collisionCount_N119, 0.0, 255.0 ); Scalar0 = Vector.x;
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	rt0 = vec4( Scalar0,  Scalar1,  Scalar2,  Scalar3 ); 
	rt1 = vec4( Scalar4,  Scalar5,  Scalar6,  Scalar7 ); 
	rt2 = vec4( Scalar8,  Scalar9,  Scalar10, Scalar11 ); 
	rt3 = vec4( Scalar12, Scalar13, Scalar14, Scalar15 );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	//rt0 = rt1 = rt2 = rt3 = vec4( float( TexelIndex ) / max( ssTEXEL_COUNT_FLOAT - 1.0, 1.0 ), 0.0, 0.0, 1.0 );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#endif
}


//-----------------------------------------------------------------------

#ifndef saturate // HACK 05/15/2019: SAMPLETEX() uses saturate(), but core doesn't define it. This can be removed after Core 10.59.
#define saturate(A) clamp(A, 0.0, 1.0)
#endif

//-----------------------------------------------------------------------


// Material Parameters ( Tweaks )

uniform NF_PRECISION float  particles_speed; // Title: Particles_Speed
uniform NF_PRECISION float  particlesReduce; // Title: Particles_reduce
uniform NF_PRECISION float  Tweak_N12; // Title: Noise_str
uniform NF_PRECISION float  particle_scale; // Title: Particle_Scale	


// Uniforms ( Ports )

#if defined( STUDIO )
uniform NF_PRECISION float3 Port_Import_N216;
uniform NF_PRECISION float Port_Input1_N149;
uniform NF_PRECISION float3 Port_Min_N150;
uniform NF_PRECISION float3 Port_Max_N150;
uniform NF_PRECISION float Port_Import_N151;
uniform NF_PRECISION float Port_Input1_N153;
uniform NF_PRECISION float3 Port_Max_N154;
uniform NF_PRECISION float Port_Import_N157;
uniform NF_PRECISION float3 Port_Import_N158;
uniform NF_PRECISION float Port_Input1_N162;
uniform NF_PRECISION float Port_Input1_N165;
uniform NF_PRECISION float Port_Import_N042;
uniform NF_PRECISION float Port_Import_N043;
uniform NF_PRECISION float Port_Import_N023;
uniform NF_PRECISION float Port_Import_N024;
uniform NF_PRECISION float Port_Import_N053;
uniform NF_PRECISION float3 Port_Import_N054;
uniform NF_PRECISION float3 Port_Import_N187;
uniform NF_PRECISION float Port_Import_N189;
uniform NF_PRECISION float3 Port_Import_N142;
uniform NF_PRECISION float3 Port_Import_N006;
uniform NF_PRECISION float Port_Input1_N014;
uniform NF_PRECISION float3 Port_Import_N206;
uniform NF_PRECISION float3 Port_Import_N208;
uniform NF_PRECISION float3 Port_Import_N318;
uniform NF_PRECISION float Port_Multiplier_N319;
uniform NF_PRECISION float3 Port_Import_N322;
uniform NF_PRECISION float2 Port_Input1_N326;
uniform NF_PRECISION float2 Port_Scale_N327;
uniform NF_PRECISION float2 Port_Input1_N329;
uniform NF_PRECISION float2 Port_Scale_N330;
uniform NF_PRECISION float2 Port_Input1_N332;
uniform NF_PRECISION float2 Port_Scale_N333;
uniform NF_PRECISION float3 Port_Input1_N335;
uniform NF_PRECISION float Port_Import_N126;
uniform NF_PRECISION float Port_Import_N127;
uniform NF_PRECISION float Port_Import_N128;
uniform NF_PRECISION float Port_Input4_N137;
uniform NF_PRECISION float Port_Multiplier_N272;
uniform NF_PRECISION float3 Port_Import_N112;
uniform NF_PRECISION float Port_Value1_N213;
uniform NF_PRECISION float Port_Value2_N213;
uniform NF_PRECISION float Port_Value3_N213;
uniform NF_PRECISION float3 Port_Import_N113;
uniform NF_PRECISION float Port_Import_N114;
uniform NF_PRECISION float Port_Import_N115;
uniform NF_PRECISION float Port_Import_N116;
uniform NF_PRECISION float Port_CollisionCount_N118;
uniform NF_PRECISION float Port_VelocityThreshold_N118;
uniform NF_PRECISION float Port_DefaultFloat_N119;
uniform NF_PRECISION float Port_Input1_N171;
uniform NF_PRECISION float Port_Input1_N109;
uniform NF_PRECISION float Port_Input2_N109;
uniform NF_PRECISION float Port_Input1_N184;
uniform NF_PRECISION float4 Port_Value0_N176;
uniform NF_PRECISION float Port_Position1_N176;
uniform NF_PRECISION float4 Port_Value1_N176;
uniform NF_PRECISION float Port_Position2_N176;
uniform NF_PRECISION float4 Port_Value2_N176;
uniform NF_PRECISION float Port_Position3_N176;
uniform NF_PRECISION float4 Port_Value3_N176;
uniform NF_PRECISION float4 Port_Value4_N176;
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

//----------

// Functions

void Node61_Spawn_Particle_Local_Space( ssGlobals Globals )
{ 
	ssCalculateParticleSeed( gParticle );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	float DividerF = floor( sqrt( ssPARTICLE_COUNT_1D_FLOAT * float(vfxNumCopies + 1) ) );
	int   DividerI = int( DividerF );
	
	gParticle.Position   = vec3( float( ngsModInt( gParticle.Index1D, DividerI ) ) / DividerF * 2.0 - 1.0, float( gParticle.Index1D / DividerI ) / DividerF * 2.0 - 1.0, 0.0 ) * 20.0 + vec3( 1.0, 1.0, 0.0 );
	gParticle.Velocity   = vec3( 0.0 );
	gParticle.Color	     = vec4( 1.0 ); 
	gParticle.Age        = 0.0;
	gParticle.Life       = ssPARTICLE_LIFE_MAX;  
	gParticle.Size       = 1.0;//mix( 0.4, 0.8, rand( vec2( gParticle.Seed, 0.3453 ) ) );
	gParticle.Mass	     = 1.0; 
	gParticle.Matrix     = mat3( 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0 );
	gParticle.Quaternion = vec4( 0.0, 0.0, 0.0, 1.0 );
}
#define Node216_Float_Import( Import, Value, Globals ) Value = Import
#define Node148_Droplist_Import( Value, Globals ) Value = 0.0
#define Node149_Is_Equal( Input0, Input1, Output, Globals ) Output = ssEqual( Input0, Input1 )
void Node150_Particle_Random( in float3 Min, in float3 Max, out float3 Random, ssGlobals Globals )
{ 
	vec4 RandomVec4 = ssGetParticleRandom( 3, true, true, true, 150.0, gParticle, 0.0, Globals.gTimeElapsed );
	Random = mix( Min, Max, RandomVec4.xyz );
}
#define Node253_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node255_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (float3(Input1) + 1.234e-6)
#define Node151_Float_Import( Import, Value, Globals ) Value = clamp( Import, 0.0, 1.0 )
#define Node152_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node153_Pow( Input0, Input1, Output, Globals ) Output = ( Input0 <= 0.0 ) ? 0.0 : pow( Input0, Input1 )
void Node154_Particle_Random( in float3 Min, in float3 Max, out float3 Random, ssGlobals Globals )
{ 
	vec4 RandomVec4 = ssGetParticleRandom( 3, true, true, true, 154.0, gParticle, 0.0, Globals.gTimeElapsed );
	Random = mix( Min, Max, RandomVec4.xyz );
}
#define Node155_Sqrt( Input0, Output, Globals ) Output = vec3( ( Input0.x <= 0.0 ) ? 0.0 : sqrt( Input0.x ), ( Input0.y <= 0.0 ) ? 0.0 : sqrt( Input0.y ), ( Input0.z <= 0.0 ) ? 0.0 : sqrt( Input0.z ) )
#define Node156_Sqrt( Input0, Output, Globals ) Output = vec3( ( Input0.x <= 0.0 ) ? 0.0 : sqrt( Input0.x ), ( Input0.y <= 0.0 ) ? 0.0 : sqrt( Input0.y ), ( Input0.z <= 0.0 ) ? 0.0 : sqrt( Input0.z ) )
#define Node157_Float_Import( Import, Value, Globals ) Value = Import
#define Node158_Float_Import( Import, Value, Globals ) Value = Import
#define Node256_Multiply( Input0, Input1, Input2, Input3, Output, Globals ) Output = Input0 * Input1 * float3(Input2) * Input3
void Node159_Split_Vector( in float3 Value, out float Value1, out float Value2, out float Value3, ssGlobals Globals )
{ 
	Value1 = Value.x;
	Value2 = Value.y;
	Value3 = Value.z;
}
#define Node160_Abs( Input0, Output, Globals ) Output = abs( Input0 )
void Node161_If_else( in float Bool1, in float Value1, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Value_N148 = 0.0; Node148_Droplist_Import( Value_N148, Globals );
		float Output_N149 = 0.0; Node149_Is_Equal( Value_N148, NF_PORT_CONSTANT( float( 1.0 ), Port_Input1_N149 ), Output_N149, Globals );
		
		Bool1 = Output_N149;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			float Output_N160 = 0.0; Node160_Abs( Value1_N159, Output_N160, Globals );
			
			Value1 = Output_N160;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			
			Default = Value1_N159;
		}
		Result = Default;
	}
}
#define Node162_Is_Equal( Input0, Input1, Output, Globals ) Output = ssEqual( Input0, Input1 )
#define Node163_Abs( Input0, Output, Globals ) Output = abs( Input0 )
void Node164_If_else( in float Bool1, in float Value1, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Value_N148 = 0.0; Node148_Droplist_Import( Value_N148, Globals );
		float Output_N162 = 0.0; Node162_Is_Equal( Value_N148, NF_PORT_CONSTANT( float( 2.0 ), Port_Input1_N162 ), Output_N162, Globals );
		
		Bool1 = Output_N162;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			float Output_N163 = 0.0; Node163_Abs( Value2_N159, Output_N163, Globals );
			
			Value1 = Output_N163;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			
			Default = Value2_N159;
		}
		Result = Default;
	}
}
#define Node165_Is_Equal( Input0, Input1, Output, Globals ) Output = ssEqual( Input0, Input1 )
#define Node166_Abs( Input0, Output, Globals ) Output = abs( Input0 )
void Node167_If_else( in float Bool1, in float Value1, in float Default, out float Result, ssGlobals Globals )
{ 
	/* Input port: "Bool1"  */
	
	{
		float Value_N148 = 0.0; Node148_Droplist_Import( Value_N148, Globals );
		float Output_N165 = 0.0; Node165_Is_Equal( Value_N148, NF_PORT_CONSTANT( float( 3.0 ), Port_Input1_N165 ), Output_N165, Globals );
		
		Bool1 = Output_N165;
	}
	if ( bool( Bool1 * 1.0 != 0.0 ) )
	{
		/* Input port: "Value1"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			float Output_N166 = 0.0; Node166_Abs( Value3_N159, Output_N166, Globals );
			
			Value1 = Output_N166;
		}
		Result = Value1;
	}
	else
	{
		/* Input port: "Default"  */
		
		{
			float3 Random_N150 = float3(0.0); Node150_Particle_Random( NF_PORT_CONSTANT( float3( -1.0, -1.0, -1.0 ), Port_Min_N150 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N150 ), Random_N150, Globals );
			float Output_N253 = 0.0; Node253_Length( Random_N150, Output_N253, Globals );
			float3 Output_N255 = float3(0.0); Node255_Divide( Random_N150, Output_N253, Output_N255, Globals );
			float Value_N151 = 0.0; Node151_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N151 ), Value_N151, Globals );
			float Output_N152 = 0.0; Node152_One_Minus( Value_N151, Output_N152, Globals );
			float Output_N153 = 0.0; Node153_Pow( Output_N152, NF_PORT_CONSTANT( float( 4.0 ), Port_Input1_N153 ), Output_N153, Globals );
			float3 Random_N154 = float3(0.0); Node154_Particle_Random( float3( Output_N153 ), NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Max_N154 ), Random_N154, Globals );
			float3 Output_N155 = float3(0.0); Node155_Sqrt( Random_N154, Output_N155, Globals );
			float3 Output_N156 = float3(0.0); Node156_Sqrt( Output_N155, Output_N156, Globals );
			float Value_N157 = 0.0; Node157_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N157 ), Value_N157, Globals );
			float3 Value_N158 = float3(0.0); Node158_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N158 ), Value_N158, Globals );
			float3 Output_N256 = float3(0.0); Node256_Multiply( Output_N255, Output_N156, Value_N157, Value_N158, Output_N256, Globals );
			float Value1_N159 = 0.0; float Value2_N159 = 0.0; float Value3_N159 = 0.0; Node159_Split_Vector( Output_N256, Value1_N159, Value2_N159, Value3_N159, Globals );
			
			Default = Value3_N159;
		}
		Result = Default;
	}
}
#define Node168_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node169_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node219_Modify_Attribute_Set_Position( Value, Globals ) gParticle.Position = Value
#define Node41_Droplist_Import( Value, Globals ) Value = 1.0
#define Node42_Float_Import( Import, Value, Globals ) Value = Import
#define Node43_Float_Import( Import, Value, Globals ) Value = Import
void Node44_Particle_Random( in float Min, in float Max, out float Random, ssGlobals Globals )
{ 
	vec4 RandomVec4 = ssGetParticleRandom( 1, false, true, true, 44.0, gParticle, 0.0, Globals.gTimeElapsed );
	Random = mix( Min, Max, RandomVec4.x );
}
#define Node49_AABB_Max( AABBMax, Globals ) AABBMax = ngsLocalAabbMax
#define Node45_AABB_Min( AABBMin, Globals ) AABBMin = ngsLocalAabbMin
#define Node46_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
#define Node47_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node48_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
void Node50_Conditional( in float Input0, in float Input1, in float Input2, out float Output, ssGlobals Globals )
{ 
	/* Input port: "Input0"  */
	
	{
		float Value_N41 = 0.0; Node41_Droplist_Import( Value_N41, Globals );
		
		Input0 = Value_N41;
	}
	
	if ( bool( Input0 * 1.0 != 0.0 ) ) 
	{ 
		/* Input port: "Input1"  */
		
		{
			float Value_N42 = 0.0; Node42_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N042 ), Value_N42, Globals );
			float Value_N43 = 0.0; Node43_Float_Import( NF_PORT_CONSTANT( float( 1.2 ), Port_Import_N043 ), Value_N43, Globals );
			float Random_N44 = 0.0; Node44_Particle_Random( Value_N42, Value_N43, Random_N44, Globals );
			float3 AABBMax_N49 = float3(0.0); Node49_AABB_Max( AABBMax_N49, Globals );
			float3 AABBMin_N45 = float3(0.0); Node45_AABB_Min( AABBMin_N45, Globals );
			float3 Output_N46 = float3(0.0); Node46_Subtract( AABBMax_N49, AABBMin_N45, Output_N46, Globals );
			float Output_N47 = 0.0; Node47_Length( Output_N46, Output_N47, Globals );
			float Output_N48 = 0.0; Node48_Divide( Random_N44, Output_N47, Output_N48, Globals );
			
			Input1 = Output_N48;
		}
		Output = Input1; 
	} 
	else 
	{ 
		/* Input port: "Input2"  */
		
		{
			float Value_N42 = 0.0; Node42_Float_Import( NF_PORT_CONSTANT( float( 0.5 ), Port_Import_N042 ), Value_N42, Globals );
			float Value_N43 = 0.0; Node43_Float_Import( NF_PORT_CONSTANT( float( 1.2 ), Port_Import_N043 ), Value_N43, Globals );
			float Random_N44 = 0.0; Node44_Particle_Random( Value_N42, Value_N43, Random_N44, Globals );
			
			Input2 = Random_N44;
		}
		Output = Input2; 
	}
}
#define Node51_Modify_Attribute_Set_Size( Value, Globals ) gParticle.Size = Value
#define Node23_Float_Import( Import, Value, Globals ) Value = Import
#define Node24_Float_Import( Import, Value, Globals ) Value = Import
void Node26_Particle_Random( in float Min, in float Max, out float Random, ssGlobals Globals )
{ 
	vec4 RandomVec4 = ssGetParticleRandom( 1, false, true, true, 26.0, gParticle, 0.0, Globals.gTimeElapsed );
	Random = mix( Min, Max, RandomVec4.x );
}
void Node27_Modify_Attribute_Set_Mass( in float Value, ssGlobals Globals )
{ 
	gParticle.Mass = Value;
	
	gParticle.Mass = max( 0.00001, gParticle.Mass );
}
#define Node53_Float_Import( Import, Value, Globals ) Value = Import
#define Node54_Float_Import( Import, Value, Globals ) Value = Import
#define Node55_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Position
#define Node56_Subtract( Input0, Input1, Output, Globals ) Output = Input0 - Input1
void Node57_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
#define Node59_Multiply( Input0, Input1, Output, Globals ) Output = float3(Input0) * Input1
#define Node60_Modify_Attribute_Add_Force( Value, Globals ) gParticle.Force += Value
#define Node187_Float_Import( Import, Value, Globals ) Value = Import
void Node188_Normalize( in float3 Input0, out float3 Output, ssGlobals Globals )
{ 
	float lengthSquared = dot( Input0, Input0 );
	float l = ( lengthSquared > 0.0 ) ? 1.0 / sqrt( lengthSquared  ) : 0.0;
	Output = Input0 * l;
}
void Node69_Float_Parameter( out float Output, ssGlobals Globals ) { Output = particles_speed; }
#define Node189_Float_Import( Import, Value, Globals ) Value = Import
#define Node190_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node191_Modify_Attribute_Add_Force( Value, Globals ) gParticle.Force += Value
#define Node8_Particle_Get_Attribute( Value, Globals ) Value = clamp( gParticle.Age / gParticle.Life, 0.0, 1.0 )
void Node7_Float_Parameter( out float Output, ssGlobals Globals ) { Output = particlesReduce; }
#define Node10_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node9_Is_Greater( Input0, Input1, Output, Globals ) Output = ssLarger( Input0, Input1 )
void Node11_Kill_Particle( in float Condition, ssGlobals Globals )
{ 
	if ( Condition * 1.0 != 0.0 )
	{
		gParticle.Dead = true;
	}
}
void SpawnParticle( ssGlobals Globals )
{
	Node61_Spawn_Particle_Local_Space( Globals );
	float3 Value_N216 = float3(0.0); Node216_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Import_N216 ), Value_N216, Globals );
	float Result_N161 = 0.0; Node161_If_else( float( 0.0 ), float( 0.0 ), float( 0.0 ), Result_N161, Globals );
	float Result_N164 = 0.0; Node164_If_else( float( 0.0 ), float( 0.0 ), float( 0.0 ), Result_N164, Globals );
	float Result_N167 = 0.0; Node167_If_else( float( 0.0 ), float( 0.0 ), float( 0.0 ), Result_N167, Globals );
	float3 Value_N168 = float3(0.0); Node168_Construct_Vector( Result_N161, Result_N164, Result_N167, Value_N168, Globals );
	float3 Output_N169 = float3(0.0); Node169_Add( Value_N216, Value_N168, Output_N169, Globals );
	Node219_Modify_Attribute_Set_Position( Output_N169, Globals );
	float Output_N50 = 0.0; Node50_Conditional( float( 1.0 ), float( 1.0 ), float( 0.0 ), Output_N50, Globals );
	Node51_Modify_Attribute_Set_Size( Output_N50, Globals );
	float Value_N23 = 0.0; Node23_Float_Import( NF_PORT_CONSTANT( float( 2.0 ), Port_Import_N023 ), Value_N23, Globals );
	float Value_N24 = 0.0; Node24_Float_Import( NF_PORT_CONSTANT( float( 4.0 ), Port_Import_N024 ), Value_N24, Globals );
	float Random_N26 = 0.0; Node26_Particle_Random( Value_N23, Value_N24, Random_N26, Globals );
	Node27_Modify_Attribute_Set_Mass( Random_N26, Globals );
	float Value_N53 = 0.0; Node53_Float_Import( NF_PORT_CONSTANT( float( -20.0 ), Port_Import_N053 ), Value_N53, Globals );
	float3 Value_N54 = float3(0.0); Node54_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Import_N054 ), Value_N54, Globals );
	float3 Value_N55 = float3(0.0); Node55_Particle_Get_Attribute( Value_N55, Globals );
	float3 Output_N56 = float3(0.0); Node56_Subtract( Value_N54, Value_N55, Output_N56, Globals );
	float3 Output_N57 = float3(0.0); Node57_Normalize( Output_N56, Output_N57, Globals );
	float3 Output_N59 = float3(0.0); Node59_Multiply( Value_N53, Output_N57, Output_N59, Globals );
	Node60_Modify_Attribute_Add_Force( Output_N59, Globals );
	float3 Value_N187 = float3(0.0); Node187_Float_Import( NF_PORT_CONSTANT( float3( 0.0, -1.0, 0.0 ), Port_Import_N187 ), Value_N187, Globals );
	float3 Output_N188 = float3(0.0); Node188_Normalize( Value_N187, Output_N188, Globals );
	float Output_N69 = 0.0; Node69_Float_Parameter( Output_N69, Globals );
	float Value_N189 = 0.0; Node189_Float_Import( Output_N69, Value_N189, Globals );
	float3 Output_N190 = float3(0.0); Node190_Multiply( Output_N188, Value_N189, Output_N190, Globals );
	Node191_Modify_Attribute_Add_Force( Output_N190, Globals );
	float Value_N8 = 0.0; Node8_Particle_Get_Attribute( Value_N8, Globals );
	float Output_N7 = 0.0; Node7_Float_Parameter( Output_N7, Globals );
	float Output_N10 = 0.0; Node10_One_Minus( Output_N7, Output_N10, Globals );
	float Output_N9 = 0.0; Node9_Is_Greater( Value_N8, Output_N10, Output_N9, Globals );
	Node11_Kill_Particle( Output_N9, Globals );
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	gParticle.Velocity += gParticle.Force / gParticle.Mass * 0.03333; // make sure the velocity added on spawn is always the same...
	gParticle.Force = vec3( 0.0 );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	//spawn_end
	gParticle.Position = ( ngsModelMatrix * vec4( gParticle.Position, 1.0 ) ).xyz; 
	gParticle.Velocity = mat3( ngsModelMatrix ) * gParticle.Velocity;
	gParticle.Force    = mat3( ngsModelMatrix ) * gParticle.Force;
	gParticle.Matrix   = mat3( ngsModelMatrix ) * gParticle.Matrix;
	gParticle.Size	   = max(length(ngsModelMatrix[0].xyz), max(length(ngsModelMatrix[1].xyz), length(ngsModelMatrix[2].xyz))) * gParticle.Size; 
	
}
#define Node25_Particle_Spawn_End( Globals ) /*nothing*/
#define Node85_Update_Particle_World_Space( Globals ) // does nothing
#define Node142_Float_Import( Import, Value, Globals ) Value = Import
#define Node6_Float_Import( Import, Value, Globals ) Value = Import
#define Node30_Particle_Get_Attribute( Value, Globals ) Value = clamp( gParticle.Age / gParticle.Life, 0.0, 1.0 )
#define Node31_Mix( Input0, Input1, Input2, Output, Globals ) Output = mix( Input0, Input1, float3(Input2) )
#define Node32_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Color
#define Node33_Swizzle( Input, Output, Globals ) Output = Input.a
#define Node182_Construct_Vector( Value1, Value2, Value, Globals ) Value.xyz = Value1; Value.w = Value2
#define Node34_Modify_Attribute_Set_Color( Value, Globals ) gParticle.Color = Value
void Node12_Float_Parameter( out float Output, ssGlobals Globals ) { Output = Tweak_N12; }
#define Node14_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (Input1 + 1.234e-6)
#define Node13_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node206_Float_Import( Import, Value, Globals ) Value = Import
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
#define Node207_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Position
#define Node208_Float_Import( Import, Value, Globals ) Value = Import
#define Node318_Float_Import( Import, Value, Globals ) Value = Import
#define Node319_Elapsed_Time( Multiplier, Time, Globals ) Time = Globals.gTimeElapsedShifted * Multiplier
#define Node320_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node321_Add( Input0, Input1, Input2, Output, Globals ) Output = Input0 + Input1 + Input2
#define Node322_Float_Import( Import, Value, Globals ) Value = Import
#define Node323_Reciprocal( Input0, Output, Globals ) Output = 1.0 / Input0
#define Node324_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node325_Swizzle( Input, Output, Globals ) Output = float2( Input.x, Input.y )
#define Node326_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node327_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
#define Node328_Swizzle( Input, Output, Globals ) Output = float2( Input.y, Input.z )
#define Node329_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node330_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
#define Node331_Swizzle( Input, Output, Globals ) Output = float2( Input.z, Input.x )
#define Node332_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
void Node333_Noise_Simplex( in float2 Seed, in float2 Scale, out float Noise, ssGlobals Globals )
{ 
	ssPRECISION_LIMITER( Seed.x )
	ssPRECISION_LIMITER( Seed.y )
	Seed *= Scale * 0.5;
	Noise = snoise( Seed ) * 0.5 + 0.5;
	ssPRECISION_LIMITER( Noise );
}
#define Node334_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node335_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node336_Subtract_One( Input0, Output, Globals ) Output = Input0 - 1.0
#define Node337_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node338_Modify_Attribute_Add_Force( Value, Globals ) gParticle.Force += Value
#define Node126_Float_Import( Import, Value, Globals ) Value = Import
#define Node127_Float_Import( Import, Value, Globals ) Value = Import
#define Node128_Float_Import( Import, Value, Globals ) Value = Import
#define Node129_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Velocity
#define Node264_Negate( Input0, Output, Globals ) Output = -Input0
#define Node265_Length( Input0, Output, Globals ) Output = length( Input0 )
#define Node130_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node137_Multiply( Input0, Input1, Input2, Input3, Input4, Output, Globals ) Output = float3(Input0) * float3(Input1) * float3(Input2) * Input3 * float3(Input4)
#define Node138_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Velocity
#define Node139_Particle_Get_Attribute( Value, Globals ) Value = gParticle.Mass
#define Node140_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * float3(Input1)
#define Node141_Abs( Input0, Output, Globals ) Output = abs( Input0 )
#define Node272_Delta_Time( Multiplier, Time, Globals ) Time = Globals.gTimeDelta * Multiplier
#define Node273_Divide( Input0, Input1, Output, Globals ) Output = Input0 / (float3(Input1) + 1.234e-6)
#define Node274_Negate( Input0, Output, Globals ) Output = -Input0
#define Node275_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0, Input1, Input2 )
#define Node276_Modify_Attribute_Add_Force( Value, Globals ) gParticle.Force += Value
int N118_OnCollision;
float N118_system_getTimeDelta() { return tempGlobals.gTimeDelta; }
vec3 N118_system_getParticlePosition() { return gParticle.Position; }
vec3 N118_system_getParticleVelocity() { return gParticle.Velocity; }
vec3 N118_system_getParticleForce() { return gParticle.Force; }
float N118_system_getParticleMass() { return gParticle.Mass; }
vec3 N118_PlanePos;
vec3 N118_PlaneNormal;
float N118_Bounciness;
float N118_Friction;
float N118_PlaneOffset;
float N118_CollisionCount;
float N118_VelocityThreshold;
float N118_SetCollisionCount;
vec3 N118_SetForce;
vec3 N118_SetVelocity;
vec3 N118_SetPosition;
float N118_KillParticle;

vec3 N118_integrateForces() {
	vec3 velocity = N118_system_getParticleVelocity() + N118_system_getParticleForce()/ max(0.00001, N118_system_getParticleMass()) * vec3(N118_system_getTimeDelta());
	return velocity * vec3(N118_system_getTimeDelta()) + N118_system_getParticlePosition();
}

vec3 N118_getCollisionVelocity(vec3 N, float b, float f){
	vec3 Vn = dot(N, N118_system_getParticleVelocity()) * N;
	vec3 Vt = N118_system_getParticleVelocity() - Vn;
	Vt *= (1.0 - f);
	Vn *= b;
	return Vt - Vn;
}

struct N118_CollisionPlane {
	bool isColliding;
	vec3 velocity;
	vec3 position;
	vec3 force;
};

N118_CollisionPlane N118_planeCollision(N118_CollisionPlane collisionPlane) {
	
	collisionPlane.isColliding = false;
	collisionPlane.velocity = N118_system_getParticleVelocity();
	collisionPlane.force = N118_system_getParticleForce();
	collisionPlane.position = N118_system_getParticlePosition();
	
	// Collision detection, use the next frame"s position
	vec3 ptNextFrame = N118_integrateForces();
	vec3 planeNormal = normalize(N118_PlaneNormal);
	float planeDotPt = dot(planeNormal, ptNextFrame - N118_PlanePos) - N118_PlaneOffset;
	
	// Collision response
	if(planeDotPt < 0.0) {
		collisionPlane.isColliding = true;
		collisionPlane.velocity = N118_getCollisionVelocity(planeNormal, N118_Bounciness, N118_Friction);
		
		// Kill forces if particle isn"t bouncing
		collisionPlane.force *= length(collisionPlane.velocity) > N118_VelocityThreshold ? 1.0 : 0.0;
		
		// Move current particle position to sit on the plane 
		float correction = dot(planeNormal, N118_system_getParticlePosition() - N118_PlanePos) - N118_PlaneOffset;
		collisionPlane.position += (planeNormal * -correction);
	}
	return collisionPlane;
}

#pragma inline 
void N118_main()
{
	N118_CollisionPlane collisionPlane;
	collisionPlane = N118_planeCollision(collisionPlane);
	N118_KillParticle = 0.0;
	N118_SetCollisionCount = floor(N118_CollisionCount);
	
	//Collided
	if (collisionPlane.isColliding){
		N118_SetCollisionCount += 1.0;
	}
	
	// Bounce
	N118_SetPosition = collisionPlane.position;
	N118_SetForce = collisionPlane.force;
	N118_SetVelocity = collisionPlane.velocity;
	
	// Stop
	if(N118_OnCollision == 1 && N118_SetCollisionCount > 0.0){
		N118_SetForce = vec3(0.0);
		N118_SetVelocity = vec3(0.0);
	}
	
	//Kill
	if(N118_OnCollision == 2 && N118_SetCollisionCount > 0.0){
		N118_KillParticle = 1.0;
	}
}
#define Node111_Droplist_Import( Value, Globals ) Value = 0.0
#define Node112_Float_Import( Import, Value, Globals ) Value = Import
#define Node213_Construct_Vector( Value1, Value2, Value3, Value, Globals ) Value.x = Value1; Value.y = Value2; Value.z = Value3
#define Node212_Add( Input0, Input1, Output, Globals ) Output = Input0 + Input1
#define Node113_Float_Import( Import, Value, Globals ) Value = Import
#define Node114_Float_Import( Import, Value, Globals ) Value = clamp( Import, 0.0, 1.0 )
#define Node115_Float_Import( Import, Value, Globals ) Value = clamp( Import, 0.0, 1.0 )
#define Node116_Float_Import( Import, Value, Globals ) Value = Import
void Node118_Collision_Plane( in float OnCollision, in float3 PlanePos, in float3 PlaneNormal, in float Bounciness, in float Friction, in float PlaneOffset, in float CollisionCount, in float VelocityThreshold, out float SetCollisionCount, out float3 SetForce, out float3 SetVelocity, out float3 SetPosition, out float KillParticle, ssGlobals Globals )
{ 
	tempGlobals = Globals;
	
	SetCollisionCount = float( 0.0 );
	SetForce = vec3( 0.0 );
	SetVelocity = vec3( 0.0 );
	SetPosition = vec3( 0.0 );
	KillParticle = float( 0.0 );
	
	
	N118_OnCollision = int( OnCollision );
	N118_PlanePos = PlanePos;
	N118_PlaneNormal = PlaneNormal;
	N118_Bounciness = Bounciness;
	N118_Friction = Friction;
	N118_PlaneOffset = PlaneOffset;
	N118_CollisionCount = CollisionCount;
	N118_VelocityThreshold = VelocityThreshold;
	
	N118_main();
	
	SetCollisionCount = N118_SetCollisionCount;
	SetForce = N118_SetForce;
	SetVelocity = N118_SetVelocity;
	SetPosition = N118_SetPosition;
	KillParticle = N118_KillParticle;
}
void Node119_Modify_Attribute_Set_Custom( in float Value, in float DefaultFloat, ssGlobals Globals )
{ 
	if ( gParticle.Spawned )
	gParticle.collisionCount_N119 = DefaultFloat;
	else
	
	gParticle.collisionCount_N119 = Value;
}
#define Node120_Modify_Attribute_Set_Force( Value, Globals ) gParticle.Force = Value
#define Node121_Modify_Attribute_Set_Velocity( Value, Globals ) gParticle.Velocity = Value
#define Node122_Modify_Attribute_Set_Position( Value, Globals ) gParticle.Position = Value
void Node123_Kill_Particle( in float Condition, ssGlobals Globals )
{ 
	if ( Condition * 1.0 != 0.0 )
	{
		gParticle.Dead = true;
	}
}
#define Node105_Particle_Get_Attribute( Value, Globals ) Value = clamp( gParticle.Age / gParticle.Life, 0.0, 1.0 )
#define Node106_One_Minus( Input0, Output, Globals ) Output = 1.0 - Input0
#define Node171_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node108_Sin( Input0, Output, Globals ) Output = sin( Input0 )
#define Node109_Clamp( Input0, Input1, Input2, Output, Globals ) Output = clamp( Input0 + 0.001, Input1 + 0.001, Input2 + 0.001 ) - 0.001
void Node29_Float_Parameter( out float Output, ssGlobals Globals ) { Output = particle_scale; }
#define Node172_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
#define Node107_Modify_Attribute_Set_Size( Value, Globals ) gParticle.Size = Value
#define Node174_Surface_Position( Position, Globals ) Position = varPos
#define Node175_Camera_Position( Camera_Position, Globals ) Camera_Position = ngsCameraPosition
#define Node173_Distance( Input0, Input1, Output, Globals ) Output = distance( Input0, Input1 )
#define Node183_Abs( Input0, Output, Globals ) Output = abs( Input0 )
#define Node184_Multiply( Input0, Input1, Output, Globals ) Output = Input0 * Input1
void Node176_Gradient( in float Ratio, in float4 Value0, in float Position1, in float4 Value1, in float Position2, in float4 Value2, in float Position3, in float4 Value3, in float4 Value4, out float4 Value, ssGlobals Globals )
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
	
	NF_PREVIEW_SAVE( Value, 176, false )
}
#define Node177_Modify_Attribute_Set_Color( Value, Globals ) //disabled
void Node99_Kill_Particle( in float Condition, ssGlobals Globals )
{ 
	if ( Condition * 1.0 != 0.0 )
	{
		gParticle.Dead = true;
	}
}

//-----------------------------------------------------------------------

void main() 
{
	sc_Vertex_t v = sc_LoadVertexAttributes();
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	int InstanceID = sc_LocalInstanceID;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssDecodeParticle( InstanceID );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	ssGlobals Globals;
	Globals.gTimeElapsed        = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : sc_TimeElapsed;
	Globals.gTimeDelta          = ( overrideTimeEnabled == 1 ) ? overrideTimeDelta : max( sc_TimeDelta, ssDELTA_TIME_MIN );
	Globals.gTimeElapsedShifted = Globals.gTimeElapsed - gParticle.TimeShift * Globals.gTimeDelta - 0.0;
	
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	/* Warmup */
	
	float Warmup = 0.0;
	float Delay  = 0.0;
	
	#if 0
	
	Warmup = 1.0;
	
	int Frames = 1;
	if ( ngsFrame < 2 )
	{
		Globals.gTimeDelta = 0.0333333;
		Globals.gTimeElapsed -= 1.0;
		Globals.gTimeElapsedShifted -= 1.0;
		Frames = 30;
	}
	
	for ( int i = 0; i < Frames; i++ )
	
	#endif
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	{
		#if 1 // continuous
		
		gParticle.Age = mod( Globals.gTimeElapsedShifted - gParticle.SpawnOffset + Warmup, ssPARTICLE_TOTAL_LIFE_MAX );
		bool Dead = ( Globals.gTimeElapsed - gParticle.SpawnOffset < Delay - Warmup || gParticle.Age > ssPARTICLE_LIFE_MAX ) ? true : false;
		
		if ( !Dead && gParticle.Life <= 0.0001 || mod( Globals.gTimeElapsed - gParticle.SpawnOffset - Delay + Warmup, ssPARTICLE_TOTAL_LIFE_MAX ) <= Globals.gTimeDelta )
		{
			SpawnParticle( Globals );
			gParticle.Spawned = true;
		}
		
		#elif 0 // burst
		
		gParticle.Age = mod( Globals.gTimeElapsedShifted - gParticle.SpawnOffset + Warmup, ssPARTICLE_TOTAL_LIFE_MAX );
		bool Dead = ( Globals.gTimeElapsed - gParticle.SpawnOffset < Delay - Warmup || gParticle.Age > ssPARTICLE_LIFE_MAX ) ? true : false;
		
		// epsilong to avoid decompression precision
		
		if ( !Dead && ( gParticle.Life < 0.0001 || mod( Globals.gTimeElapsed - gParticle.SpawnOffset - Delay + Warmup, ssPARTICLE_TOTAL_LIFE_MAX ) <= Globals.gTimeDelta ) )
		{
			SpawnParticle( Globals );
			gParticle.Spawned = true;
		}
		
		#elif 0 // once - live forever
		
		if ( gParticle.Life < 0.1 )
		{
			SpawnParticle( Globals );
			gParticle.Spawned = true;	
			gParticle.Age  = Globals.gTimeElapsedShifted;
		}
		
		gParticle.Life = 1.0;
		
		#else // once - max life
		
		gParticle.Age = Globals.gTimeElapsedShifted + Warmup;
		
		if ( gParticle.Age >= ssPARTICLE_LIFE_MAX )
		{
			gParticle.Spawned = false;
			gParticle.Life = 0.0;
			gParticle.Age  = 0.0;
		}
		else if ( gParticle.Life < 0.1 )
		{
			gParticle.Life = ssPARTICLE_LIFE_MAX;
			SpawnParticle( Globals );
			gParticle.Spawned = true;
			gParticle.Age  = 0.0;					
		}
		else 
		{
			gParticle.Age = Globals.gTimeElapsedShifted + Warmup;
		}
		
		#endif
		
		// Spawn kill
		
		
		if (gParticle.Dead) 
		{  
			sc_SetClipPosition( vec4(vec3(4334.0), 0.0) );
			return;
		}
		
		
		// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
		
		// Execution Code
		Node25_Particle_Spawn_End( Globals );
		Node85_Update_Particle_World_Space( Globals );
		float3 Value_N142 = float3(0.0); Node142_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 0.0, 0.0 ), Port_Import_N142 ), Value_N142, Globals );
		float3 Value_N6 = float3(0.0); Node6_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N006 ), Value_N6, Globals );
		float Value_N30 = 0.0; Node30_Particle_Get_Attribute( Value_N30, Globals );
		float3 Output_N31 = float3(0.0); Node31_Mix( Value_N142, Value_N6, Value_N30, Output_N31, Globals );
		float4 Value_N32 = float4(0.0); Node32_Particle_Get_Attribute( Value_N32, Globals );
		float Output_N33 = 0.0; Node33_Swizzle( Value_N32, Output_N33, Globals );
		float4 Value_N182 = float4(0.0); Node182_Construct_Vector( Output_N31, Output_N33, Value_N182, Globals );
		Node34_Modify_Attribute_Set_Color( Value_N182, Globals );
		float Output_N12 = 0.0; Node12_Float_Parameter( Output_N12, Globals );
		float Output_N14 = 0.0; Node14_Divide( Output_N12, NF_PORT_CONSTANT( float( 5.0 ), Port_Input1_N014 ), Output_N14, Globals );
		float3 Value_N13 = float3(0.0); Node13_Construct_Vector( Output_N12, Output_N14, Output_N12, Value_N13, Globals );
		float3 Value_N206 = float3(0.0); Node206_Float_Import( Value_N13, Value_N206, Globals );
		float3 Value_N207 = float3(0.0); Node207_Particle_Get_Attribute( Value_N207, Globals );
		float3 Value_N208 = float3(0.0); Node208_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 0.0, 0.0 ), Port_Import_N208 ), Value_N208, Globals );
		float3 Value_N318 = float3(0.0); Node318_Float_Import( NF_PORT_CONSTANT( float3( 2.0, 2.0, 2.0 ), Port_Import_N318 ), Value_N318, Globals );
		float Time_N319 = 0.0; Node319_Elapsed_Time( NF_PORT_CONSTANT( float( 1.0 ), Port_Multiplier_N319 ), Time_N319, Globals );
		float3 Output_N320 = float3(0.0); Node320_Multiply( Value_N318, Time_N319, Output_N320, Globals );
		float3 Output_N321 = float3(0.0); Node321_Add( Value_N207, Value_N208, Output_N320, Output_N321, Globals );
		float3 Value_N322 = float3(0.0); Node322_Float_Import( NF_PORT_CONSTANT( float3( 1.0, 1.0, 1.0 ), Port_Import_N322 ), Value_N322, Globals );
		float3 Output_N323 = float3(0.0); Node323_Reciprocal( Value_N322, Output_N323, Globals );
		float3 Output_N324 = float3(0.0); Node324_Multiply( Output_N321, Output_N323, Output_N324, Globals );
		float2 Output_N325 = float2(0.0); Node325_Swizzle( Output_N324.xy, Output_N325, Globals );
		float2 Output_N326 = float2(0.0); Node326_Add( Output_N325, NF_PORT_CONSTANT( float2( 4.38271, 0.35927 ), Port_Input1_N326 ), Output_N326, Globals );
		float Noise_N327 = 0.0; Node327_Noise_Simplex( Output_N326, NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Scale_N327 ), Noise_N327, Globals );
		float2 Output_N328 = float2(0.0); Node328_Swizzle( Output_N324, Output_N328, Globals );
		float2 Output_N329 = float2(0.0); Node329_Add( Output_N328, NF_PORT_CONSTANT( float2( 0.3452, 2.23425 ), Port_Input1_N329 ), Output_N329, Globals );
		float Noise_N330 = 0.0; Node330_Noise_Simplex( Output_N329, NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Scale_N330 ), Noise_N330, Globals );
		float2 Output_N331 = float2(0.0); Node331_Swizzle( Output_N324, Output_N331, Globals );
		float2 Output_N332 = float2(0.0); Node332_Add( Output_N331, NF_PORT_CONSTANT( float2( 2.05939, 0.877664 ), Port_Input1_N332 ), Output_N332, Globals );
		float Noise_N333 = 0.0; Node333_Noise_Simplex( Output_N332, NF_PORT_CONSTANT( float2( 1.0, 1.0 ), Port_Scale_N333 ), Noise_N333, Globals );
		float3 Value_N334 = float3(0.0); Node334_Construct_Vector( Noise_N327, Noise_N330, Noise_N333, Value_N334, Globals );
		float3 Output_N335 = float3(0.0); Node335_Multiply( Value_N334, NF_PORT_CONSTANT( float3( 2.0, 2.0, 2.0 ), Port_Input1_N335 ), Output_N335, Globals );
		float3 Output_N336 = float3(0.0); Node336_Subtract_One( Output_N335, Output_N336, Globals );
		float3 Output_N337 = float3(0.0); Node337_Multiply( Value_N206, Output_N336, Output_N337, Globals );
		Node338_Modify_Attribute_Add_Force( Output_N337, Globals );
		float Value_N126 = 0.0; Node126_Float_Import( NF_PORT_CONSTANT( float( 0.05 ), Port_Import_N126 ), Value_N126, Globals );
		float Value_N127 = 0.0; Node127_Float_Import( NF_PORT_CONSTANT( float( 1.2 ), Port_Import_N127 ), Value_N127, Globals );
		float Value_N128 = 0.0; Node128_Float_Import( NF_PORT_CONSTANT( float( 1.0 ), Port_Import_N128 ), Value_N128, Globals );
		float3 Value_N129 = float3(0.0); Node129_Particle_Get_Attribute( Value_N129, Globals );
		float3 Output_N264 = float3(0.0); Node264_Negate( Value_N129, Output_N264, Globals );
		float Output_N265 = 0.0; Node265_Length( Value_N129, Output_N265, Globals );
		float3 Output_N130 = float3(0.0); Node130_Multiply( Output_N264, Output_N265, Output_N130, Globals );
		float3 Output_N137 = float3(0.0); Node137_Multiply( Value_N126, Value_N127, Value_N128, Output_N130, NF_PORT_CONSTANT( float( 0.5 ), Port_Input4_N137 ), Output_N137, Globals );
		float3 Value_N138 = float3(0.0); Node138_Particle_Get_Attribute( Value_N138, Globals );
		float Value_N139 = 0.0; Node139_Particle_Get_Attribute( Value_N139, Globals );
		float3 Output_N140 = float3(0.0); Node140_Multiply( Value_N138, Value_N139, Output_N140, Globals );
		float3 Output_N141 = float3(0.0); Node141_Abs( Output_N140, Output_N141, Globals );
		float Time_N272 = 0.0; Node272_Delta_Time( NF_PORT_CONSTANT( float( 1.0 ), Port_Multiplier_N272 ), Time_N272, Globals );
		float3 Output_N273 = float3(0.0); Node273_Divide( Output_N141, Time_N272, Output_N273, Globals );
		float3 Output_N274 = float3(0.0); Node274_Negate( Output_N273, Output_N274, Globals );
		float3 Output_N275 = float3(0.0); Node275_Clamp( Output_N137, Output_N274, Output_N273, Output_N275, Globals );
		Node276_Modify_Attribute_Add_Force( Output_N275, Globals );
		float Value_N111 = 0.0; Node111_Droplist_Import( Value_N111, Globals );
		float3 Value_N112 = float3(0.0); Node112_Float_Import( NF_PORT_CONSTANT( float3( 0.0, -3.0, 0.0 ), Port_Import_N112 ), Value_N112, Globals );
		float3 Value_N213 = float3(0.0); Node213_Construct_Vector( NF_PORT_CONSTANT( float( 0.0 ), Port_Value1_N213 ), NF_PORT_CONSTANT( float( -30.0 ), Port_Value2_N213 ), NF_PORT_CONSTANT( float( 0.0 ), Port_Value3_N213 ), Value_N213, Globals );
		float3 Output_N212 = float3(0.0); Node212_Add( Value_N112, Value_N213, Output_N212, Globals );
		float3 Value_N113 = float3(0.0); Node113_Float_Import( NF_PORT_CONSTANT( float3( 0.0, 1.0, 0.0 ), Port_Import_N113 ), Value_N113, Globals );
		float Value_N114 = 0.0; Node114_Float_Import( NF_PORT_CONSTANT( float( 0.0 ), Port_Import_N114 ), Value_N114, Globals );
		float Value_N115 = 0.0; Node115_Float_Import( NF_PORT_CONSTANT( float( 0.0 ), Port_Import_N115 ), Value_N115, Globals );
		float Value_N116 = 0.0; Node116_Float_Import( NF_PORT_CONSTANT( float( 0.0 ), Port_Import_N116 ), Value_N116, Globals );
		float SetCollisionCount_N118 = 0.0; float3 SetForce_N118 = float3(0.0); float3 SetVelocity_N118 = float3(0.0); float3 SetPosition_N118 = float3(0.0); float KillParticle_N118 = 0.0; Node118_Collision_Plane( Value_N111, Output_N212, Value_N113, Value_N114, Value_N115, Value_N116, NF_PORT_CONSTANT( float( 0.0 ), Port_CollisionCount_N118 ), NF_PORT_CONSTANT( float( 2.0 ), Port_VelocityThreshold_N118 ), SetCollisionCount_N118, SetForce_N118, SetVelocity_N118, SetPosition_N118, KillParticle_N118, Globals );
		Node119_Modify_Attribute_Set_Custom( SetCollisionCount_N118, NF_PORT_CONSTANT( float( 0.0 ), Port_DefaultFloat_N119 ), Globals );
		Node120_Modify_Attribute_Set_Force( SetForce_N118, Globals );
		Node121_Modify_Attribute_Set_Velocity( SetVelocity_N118, Globals );
		Node122_Modify_Attribute_Set_Position( SetPosition_N118, Globals );
		Node123_Kill_Particle( KillParticle_N118, Globals );
		float Value_N105 = 0.0; Node105_Particle_Get_Attribute( Value_N105, Globals );
		float Output_N106 = 0.0; Node106_One_Minus( Value_N105, Output_N106, Globals );
		float Output_N171 = 0.0; Node171_Multiply( Output_N106, NF_PORT_CONSTANT( float( 3.0 ), Port_Input1_N171 ), Output_N171, Globals );
		float Output_N108 = 0.0; Node108_Sin( Output_N171, Output_N108, Globals );
		float Output_N109 = 0.0; Node109_Clamp( Output_N108, NF_PORT_CONSTANT( float( 0.0 ), Port_Input1_N109 ), NF_PORT_CONSTANT( float( 1.0 ), Port_Input2_N109 ), Output_N109, Globals );
		float Output_N29 = 0.0; Node29_Float_Parameter( Output_N29, Globals );
		float Output_N172 = 0.0; Node172_Multiply( Output_N109, Output_N29, Output_N172, Globals );
		Node107_Modify_Attribute_Set_Size( Output_N172, Globals );
		float3 Position_N174 = float3(0.0); Node174_Surface_Position( Position_N174, Globals );
		float3 Camera_Position_N175 = float3(0.0); Node175_Camera_Position( Camera_Position_N175, Globals );
		float Output_N173 = 0.0; Node173_Distance( Position_N174, Camera_Position_N175, Output_N173, Globals );
		float Output_N183 = 0.0; Node183_Abs( Output_N173, Output_N183, Globals );
		float Output_N184 = 0.0; Node184_Multiply( Output_N183, NF_PORT_CONSTANT( float( 0.0001 ), Port_Input1_N184 ), Output_N184, Globals );
		float4 Value_N176 = float4(0.0); Node176_Gradient( Output_N184, NF_PORT_CONSTANT( float4( 1.0, 0.0, 0.0, 1.0 ), Port_Value0_N176 ), NF_PORT_CONSTANT( float( 0.25 ), Port_Position1_N176 ), NF_PORT_CONSTANT( float4( 0.0, 1.0, 0.0, 1.0 ), Port_Value1_N176 ), NF_PORT_CONSTANT( float( 0.5 ), Port_Position2_N176 ), NF_PORT_CONSTANT( float4( 1.0, 0.0, 1.0, 1.0 ), Port_Value2_N176 ), NF_PORT_CONSTANT( float( 0.75 ), Port_Position3_N176 ), NF_PORT_CONSTANT( float4( 0.0, 0.0, 1.0, 1.0 ), Port_Value3_N176 ), NF_PORT_CONSTANT( float4( 1.0, 0.0, 0.0, 1.0 ), Port_Value4_N176 ), Value_N176, Globals );
		Node177_Modify_Attribute_Set_Color( Value_N176, Globals );
		float Value_N8 = 0.0; Node8_Particle_Get_Attribute( Value_N8, Globals );
		float Output_N7 = 0.0; Node7_Float_Parameter( Output_N7, Globals );
		float Output_N10 = 0.0; Node10_One_Minus( Output_N7, Output_N10, Globals );
		float Output_N9 = 0.0; Node9_Is_Greater( Value_N8, Output_N10, Output_N9, Globals );
		Node99_Kill_Particle( Output_N9, Globals );
		
		
		// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
		
		// Convert matrix to quaternion
		gParticle.Quaternion = matrixToQuaternion(gParticle.Matrix);
		
		// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
		
		// Update kill //
		
		
		if (gParticle.Dead) 
		{  
			sc_SetClipPosition( vec4(vec3(4334.0), 0.0) );
			return;
		}
		
		
		float DeltaTime = clamp( Globals.gTimeDelta, 0.0001, 0.5 );
		float Drift = 0.005;
		//vec3  Force = gParticle.Force;
		//float Mass  = gParticle.Mass;
		
		#if 1
		
		gParticle.Force.x = ( abs(gParticle.Force.x) < Drift ) ? 0.0 : gParticle.Force.x;
		gParticle.Force.y = ( abs(gParticle.Force.y) < Drift ) ? 0.0 : gParticle.Force.y;
		gParticle.Force.z = ( abs(gParticle.Force.z) < Drift ) ? 0.0 : gParticle.Force.z;
		
		gParticle.Mass = max( Drift, gParticle.Mass );
		
		#endif
		
		gParticle.Velocity += gParticle.Force / gParticle.Mass * DeltaTime;	
		
		gParticle.Velocity.x = ( abs(gParticle.Velocity.x) < Drift ) ? 0.0 : gParticle.Velocity.x;
		gParticle.Velocity.y = ( abs(gParticle.Velocity.y) < Drift ) ? 0.0 : gParticle.Velocity.y;
		gParticle.Velocity.z = ( abs(gParticle.Velocity.z) < Drift ) ? 0.0 : gParticle.Velocity.z;
		
		gParticle.Position += gParticle.Velocity * DeltaTime;	
		
		// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
		
		#if 0
		{
			ssCalculateDynamicAttributes( InstanceID, gParticle );
			
			Globals.gTimeElapsed += Globals.gTimeDelta;
			Globals.gTimeElapsedShifted += Globals.gTimeDelta;
			
			//float ElapsedTime = ( overrideTimeEnabled == 1 ) ? overrideTimeElapsed : Globals.gTimeElapsed;
			//gParticle.Seed = rand( gParticle.Coord2D + floor( ( ElapsedTime - gParticle.SpawnOffset + ssPARTICLE_LIFE_MAX * 2.0 ) / ssPARTICLE_LIFE_MAX ) * 4.32422 );
		}
		#endif
	}
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	
	float2 QuadSize = vec2( ssTEXEL_COUNT_FLOAT, 1.0 ) / vec2(2048.0, ssTARGET_SIZE_FLOAT.y);				
	float2 Offset;   
	
	int offsetID = vfxOffsetInstances + sc_LocalInstanceID;
	int particleRow = 2048 / ssTEXEL_COUNT_INT;
	Offset.x = float( offsetID % particleRow);
	Offset.y = float( offsetID / particleRow);		
	Offset *= QuadSize; // bring into 0-1 range
	
	
	float2 Vertex;   
	Vertex.x = v.texture0.x < 0.5 ? 0.0 : QuadSize.x;  //creates a thin quad to fit into 0-1 space
	Vertex.y = v.texture0.y < 0.5 ? 0.0 : QuadSize.y;
	Vertex += Offset;;					
	
	sc_SetClipPosition( vec4( Vertex * 2.0 - 1.0, 1.0, 1.0 ) );
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	Interp_Particle_Index = SC_INT_FALLBACK_FLOAT(sc_LocalInstanceID);
	Interp_Particle_Coord = v.texture0;
	Interp_Particle_Force = gParticle.Force;
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	Interp_Particle_Position = gParticle.Position;
	Interp_Particle_Velocity = gParticle.Velocity;
	Interp_Particle_Life = gParticle.Life;
	Interp_Particle_Age = gParticle.Age;
	Interp_Particle_Size = gParticle.Size;
	Interp_Particle_Color = gParticle.Color;
	Interp_Particle_Quaternion = gParticle.Quaternion;
	Interp_Particle_collisionCount_N119 = gParticle.collisionCount_N119;
	Interp_Particle_Mass = gParticle.Mass;
	
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	// Final kill //
	
	
	if (gParticle.Dead) 
	{  
		sc_SetClipPosition( vec4(vec3(4334.0), 0.0) );
		return;
	}
	
	
	if ( ( overrideTimeEnabled == 1 ) && overrideTimeDelta == 0.0 )
	{
		sc_SetClipPosition( ( sc_LocalInstanceID == 0 ) ? vec4( v.texture0.xy * 2.0 - 1.0, 1.0, 1.0 ) : vec4( 0.0 ) );
		varTex0 = v.texture0.xy;
	}
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
	
	
};

ssGlobals tempGlobals;
#define scCustomCodeUniform

//-----------------------------------------------------------------------------
/*
#ifdef USE_16_BIT_TEXTURES
layout(location = 0) out highp uvec4 fragOut[4];
#endif
*/
//-----------------------------------------------------------------------------

void main() 
{
	sc_DiscardStereoFragment();
	
	float4 renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, vec2( 0.5 ), 0.0);
	float4 renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, vec2( 0.5 ), 0.0);
	float4 renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, vec2( 0.5 ), 0.0);
	float4 renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, vec2( 0.5 ), 0.0);
	
	// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
	
	#if __VERSION__ == 100
	{
		gl_FragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
	}				 
	#else
	{
		vec4 Data0 = vec4( 0.0 );
		vec4 Data1 = vec4( 0.0 );
		vec4 Data2 = vec4( 0.0 );
		vec4 Data3 = vec4( 0.0 );
		
		if ( ( overrideTimeEnabled == 1 ) && overrideTimeDelta == 0.0 )
		{
			renderTarget0Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget0, varTex0, 0.0);
			renderTarget1Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget1, varTex0, 0.0);
			renderTarget2Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget2, varTex0, 0.0);
			renderTarget3Sample = SC_SAMPLE_TEX_LEVEL_R(renderTarget3, varTex0, 0.0);
			
			Data0 = renderTarget0Sample;
			Data1 = renderTarget1Sample;
			Data2 = renderTarget2Sample;
			Data3 = renderTarget3Sample;
		}
		else
		{
			gParticle.Position = Interp_Particle_Position;
			gParticle.Velocity = Interp_Particle_Velocity;
			gParticle.Life = Interp_Particle_Life;
			gParticle.Age = Interp_Particle_Age;
			gParticle.Size = Interp_Particle_Size;
			gParticle.Color = Interp_Particle_Color;
			gParticle.Quaternion = Interp_Particle_Quaternion;
			gParticle.collisionCount_N119 = Interp_Particle_collisionCount_N119;
			gParticle.Mass = Interp_Particle_Mass;
			
			
			// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
			
			ssEncodeParticle( Interp_Particle_Coord, Data0, Data1, Data2, Data3 );
			
			// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
			
			#if 0
			{
				float TexelRatio = floor( Interp_Particle_Coord.x * 5.0 ) / 4.0;
				Data0 = vec4( TexelRatio, 0.0, 0.0, 1.0 );
				Data1 = vec4( TexelRatio, 0.0, 0.0, 1.0 );
				Data2 = vec4( TexelRatio, 0.0, 0.0, 1.0 );
				Data3 = vec4( TexelRatio, 0.0, 0.0, 1.0 );
			}	
			#endif
			
			// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
			
			#ifndef MOBILE
			if ( dot( Data0.xyzw + Data1.xyzw + Data2.xyzw + Data3.xyzw, vec4( 0.23454 ) ) == 0.3423183476 )
			Data0.xyzw += SC_EPSILON; // fix for missing parameters in UI
			#endif
		}
		
		// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
		
		sc_writeFragData0( Data0 );
		sc_writeFragData1( Data1 );
		sc_writeFragData2( Data2 );
		sc_writeFragData3( Data3 );
	}
	#endif
}

#endif //FRAGMENT SHADER
