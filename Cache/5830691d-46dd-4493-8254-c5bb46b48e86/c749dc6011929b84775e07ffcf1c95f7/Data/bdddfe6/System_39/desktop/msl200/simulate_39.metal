#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
//efine SC_DISABLE_FRUSTUM_CULLING
#define SC_ALLOW_16_TEXTURES
#define SC_ENABLE_INSTANCED_RENDERING
namespace SNAP_VS {
int sc_GetStereoViewIndex()
{
    return 0;
}
}
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_SampleTexture
        #define sc_SampleTexture sc_SampleTextureBiasOrLevel
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
//SG_REFLECTION_BEGIN(200)
//attribute vec4 boneData 5
//attribute vec3 blendShape0Pos 6
//attribute vec3 blendShape0Normal 12
//attribute vec3 blendShape1Pos 7
//attribute vec3 blendShape1Normal 13
//attribute vec3 blendShape2Pos 8
//attribute vec3 blendShape2Normal 14
//attribute vec3 blendShape3Pos 9
//attribute vec3 blendShape4Pos 10
//attribute vec3 blendShape5Pos 11
//attribute vec4 position 0
//attribute vec3 normal 1
//attribute vec4 tangent 2
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec3 positionNext 15
//attribute vec3 positionPrevious 16
//attribute vec4 strandProperties 17
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//sampler sampler renderTarget0SmpSC 2:21
//sampler sampler renderTarget1SmpSC 2:22
//sampler sampler renderTarget2SmpSC 2:23
//sampler sampler renderTarget3SmpSC 2:24
//texture texture2D renderTarget0 2:2:2:21
//texture texture2D renderTarget1 2:3:2:22
//texture texture2D renderTarget2 2:4:2:23
//texture texture2D renderTarget3 2:5:2:24
//ubo float sc_BonesUBO 2:0:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:32:7872 {
//sc_PointLight_t sc_PointLights 0:[3]:80
//bool sc_PointLights.falloffEnabled 0
//float sc_PointLights.falloffEndDistance 4
//float sc_PointLights.negRcpFalloffEndDistance4 8
//float sc_PointLights.angleScale 12
//float sc_PointLights.angleOffset 16
//float3 sc_PointLights.direction 32
//float3 sc_PointLights.position 48
//float4 sc_PointLights.color 64
//sc_DirectionalLight_t sc_DirectionalLights 240:[5]:32
//float3 sc_DirectionalLights.direction 0
//float4 sc_DirectionalLights.color 16
//sc_AmbientLight_t sc_AmbientLights 400:[3]:32
//float3 sc_AmbientLights.color 0
//float sc_AmbientLights.intensity 16
//sc_LightEstimationData_t sc_LightEstimationData 496
//sc_SphericalGaussianLight_t sc_LightEstimationData.sg 0:[12]:48
//float3 sc_LightEstimationData.sg.color 0
//float sc_LightEstimationData.sg.sharpness 16
//float3 sc_LightEstimationData.sg.axis 32
//float3 sc_LightEstimationData.ambientLight 576
//float4 sc_EnvmapDiffuseSize 1088
//float4 sc_EnvmapDiffuseDims 1104
//float4 sc_EnvmapDiffuseView 1120
//float4 sc_EnvmapSpecularSize 1136
//float4 sc_EnvmapSpecularDims 1152
//float4 sc_EnvmapSpecularView 1168
//float3 sc_EnvmapRotation 1184
//float sc_EnvmapExposure 1200
//float3 sc_Sh 1216:[9]:16
//float sc_ShIntensity 1360
//float4 sc_Time 1376
//float4 sc_UniformConstants 1392
//float4 sc_GeometryInfo 1408
//float4x4 sc_ModelViewProjectionMatrixArray 1424:[2]:64
//float4x4 sc_ModelViewProjectionMatrixInverseArray 1552:[2]:64
//float4x4 sc_ViewProjectionMatrixArray 1680:[2]:64
//float4x4 sc_ViewProjectionMatrixInverseArray 1808:[2]:64
//float4x4 sc_ModelViewMatrixArray 1936:[2]:64
//float4x4 sc_ModelViewMatrixInverseArray 2064:[2]:64
//float3x3 sc_ViewNormalMatrixArray 2192:[2]:48
//float3x3 sc_ViewNormalMatrixInverseArray 2288:[2]:48
//float4x4 sc_ProjectionMatrixArray 2384:[2]:64
//float4x4 sc_ProjectionMatrixInverseArray 2512:[2]:64
//float4x4 sc_ViewMatrixArray 2640:[2]:64
//float4x4 sc_ViewMatrixInverseArray 2768:[2]:64
//float4x4 sc_PrevFrameViewProjectionMatrixArray 2896:[2]:64
//float4x4 sc_ModelMatrix 3024
//float4x4 sc_ModelMatrixInverse 3088
//float3x3 sc_NormalMatrix 3152
//float3x3 sc_NormalMatrixInverse 3200
//float4x4 sc_PrevFrameModelMatrix 3248
//float4x4 sc_PrevFrameModelMatrixInverse 3312
//float3 sc_LocalAabbMin 3376
//float3 sc_LocalAabbMax 3392
//float3 sc_WorldAabbMin 3408
//float3 sc_WorldAabbMax 3424
//float4 sc_WindowToViewportTransform 3440
//sc_Camera_t sc_Camera 3456
//float3 sc_Camera.position 0
//float sc_Camera.aspect 16
//float2 sc_Camera.clipPlanes 24
//float sc_ShadowDensity 3488
//float4 sc_ShadowColor 3504
//float4x4 sc_ProjectorMatrix 3520
//float _sc_GetFramebufferColorInvalidUsageMarker 3584
//float shaderComplexityValue 3588
//float sc_DisableFrustumCullingMarker 3592
//float4 weights0 3600
//float4 weights1 3616
//float4 weights2 3632
//float4 sc_StereoClipPlanes 3648:[2]:16
//int sc_FallbackInstanceID 3680
//float _sc_framebufferFetchMarker 3684
//float2 sc_TAAJitterOffset 3688
//float strandWidth 3696
//float strandTaper 3700
//float4 sc_StrandDataMapTextureSize 3712
//float clumpInstanceCount 3728
//float clumpRadius 3732
//float clumpTipScale 3736
//float hairstyleInstanceCount 3740
//float hairstyleNoise 3744
//float4 sc_ScreenTextureSize 3760
//float4 sc_ScreenTextureDims 3776
//float4 sc_ScreenTextureView 3792
//float correctedIntensity 3808
//float4 intensityTextureSize 3824
//float4 intensityTextureDims 3840
//float4 intensityTextureView 3856
//float3x3 intensityTextureTransform 3872
//float4 intensityTextureUvMinMax 3920
//float4 intensityTextureBorderColor 3936
//float reflBlurWidth 3952
//float reflBlurMinRough 3956
//float reflBlurMaxRough 3960
//int overrideTimeEnabled 3964
//float overrideTimeElapsed 3968
//float overrideTimeDelta 3972
//int vfxNumCopies 3976
//bool vfxBatchEnable 3980:[32]:4
//float4x4 vfxModelMatrix 4112:[32]:64
//float4 renderTarget0Size 6160
//float4 renderTarget0Dims 6176
//float4 renderTarget0View 6192
//float3x3 renderTarget0Transform 6208
//float4 renderTarget0UvMinMax 6256
//float4 renderTarget0BorderColor 6272
//float4 renderTarget1Size 6288
//float4 renderTarget1Dims 6304
//float4 renderTarget1View 6320
//float3x3 renderTarget1Transform 6336
//float4 renderTarget1UvMinMax 6384
//float4 renderTarget1BorderColor 6400
//float4 renderTarget2Size 6416
//float4 renderTarget2Dims 6432
//float4 renderTarget2View 6448
//float3x3 renderTarget2Transform 6464
//float4 renderTarget2UvMinMax 6512
//float4 renderTarget2BorderColor 6528
//float4 renderTarget3Size 6544
//float4 renderTarget3Dims 6560
//float4 renderTarget3View 6576
//float3x3 renderTarget3Transform 6592
//float4 renderTarget3UvMinMax 6640
//float4 renderTarget3BorderColor 6656
//float3 vfxLocalAabbMin 6672
//float3 vfxLocalAabbMax 6688
//float vfxCameraAspect 6704
//float vfxCameraNear 6708
//float vfxCameraFar 6712
//float3 vfxCameraUp 6720
//float3 vfxCameraForward 6736
//float3 vfxCameraRight 6752
//float4x4 vfxProjectionMatrix 6768
//float4x4 vfxProjectionMatrixInverse 6832
//float4x4 vfxViewMatrix 6896
//float4x4 vfxViewMatrixInverse 6960
//float4x4 vfxViewProjectionMatrix 7024
//float4x4 vfxViewProjectionMatrixInverse 7088
//int vfxFrame 7152
//int vfxOffsetInstances 7156
//int vfxOffsetInstancesPrev 7160
//float2 ssTARGET_SIZE_INT 7168
//float2 ssTARGET_SIZE_FLOAT 7176
//float ssTARGET_WIDTH 7184
//int ssTARGET_WIDTH_INT 7188
//float particles_speed 7192
//float particlesReduce 7196
//float Tweak_N12 7200
//float particle_scale 7204
//float3 Port_Import_N216 7216
//float Port_Input1_N149 7232
//float3 Port_Min_N150 7248
//float3 Port_Max_N150 7264
//float Port_Import_N151 7280
//float Port_Input1_N153 7284
//float3 Port_Max_N154 7296
//float Port_Import_N157 7312
//float3 Port_Import_N158 7328
//float Port_Input1_N162 7344
//float Port_Input1_N165 7348
//float Port_Import_N042 7352
//float Port_Import_N043 7356
//float Port_Import_N023 7360
//float Port_Import_N024 7364
//float Port_Import_N053 7368
//float3 Port_Import_N054 7376
//float3 Port_Import_N187 7392
//float Port_Import_N189 7408
//float3 Port_Import_N142 7424
//float3 Port_Import_N006 7440
//float Port_Input1_N014 7456
//float3 Port_Import_N206 7472
//float3 Port_Import_N208 7488
//float3 Port_Import_N318 7504
//float Port_Multiplier_N319 7520
//float3 Port_Import_N322 7536
//float2 Port_Input1_N326 7552
//float2 Port_Scale_N327 7560
//float2 Port_Input1_N329 7568
//float2 Port_Scale_N330 7576
//float2 Port_Input1_N332 7584
//float2 Port_Scale_N333 7592
//float3 Port_Input1_N335 7600
//float Port_Import_N126 7616
//float Port_Import_N127 7620
//float Port_Import_N128 7624
//float Port_Input4_N137 7628
//float Port_Multiplier_N272 7632
//float3 Port_Import_N112 7648
//float Port_Value1_N213 7664
//float Port_Value2_N213 7668
//float Port_Value3_N213 7672
//float3 Port_Import_N113 7680
//float Port_Import_N114 7696
//float Port_Import_N115 7700
//float Port_Import_N116 7704
//float Port_CollisionCount_N118 7708
//float Port_VelocityThreshold_N118 7712
//float Port_DefaultFloat_N119 7716
//float Port_Input1_N171 7720
//float Port_Input1_N109 7724
//float Port_Input2_N109 7728
//float Port_Input1_N184 7732
//float4 Port_Value0_N176 7744
//float Port_Position1_N176 7760
//float4 Port_Value1_N176 7776
//float Port_Position2_N176 7792
//float4 Port_Value2_N176 7808
//float Port_Position3_N176 7824
//float4 Port_Value3_N176 7840
//float4 Port_Value4_N176 7856
//}
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget0 1000
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget1 1001
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget2 1002
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget3 1003
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget0 1004
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget1 1005
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget2 1006
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget3 1007
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget0 1008
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget1 1009
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget2 1010
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget3 1011
//spec_const bool renderTarget0HasSwappedViews 1012
//spec_const bool renderTarget1HasSwappedViews 1013
//spec_const bool renderTarget2HasSwappedViews 1014
//spec_const bool renderTarget3HasSwappedViews 1015
//spec_const int SC_DEVICE_CLASS 1016
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 1017
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 1018
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 1019
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 1020
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 1021
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 1022
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 1023
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 1024
//spec_const int renderTarget0Layout 1025
//spec_const int renderTarget1Layout 1026
//spec_const int renderTarget2Layout 1027
//spec_const int renderTarget3Layout 1028
//spec_const int sc_StereoRenderingMode 1029
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1030
//SG_REFLECTION_END
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget0 [[function_constant(1000)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget0) ? SC_USE_CLAMP_TO_BORDER_renderTarget0 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget1 [[function_constant(1001)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget1) ? SC_USE_CLAMP_TO_BORDER_renderTarget1 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget2 [[function_constant(1002)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget2) ? SC_USE_CLAMP_TO_BORDER_renderTarget2 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget3 [[function_constant(1003)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget3) ? SC_USE_CLAMP_TO_BORDER_renderTarget3 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget0 [[function_constant(1004)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget0_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget0) ? SC_USE_UV_MIN_MAX_renderTarget0 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget1 [[function_constant(1005)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget1_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget1) ? SC_USE_UV_MIN_MAX_renderTarget1 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget2 [[function_constant(1006)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget2_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget2) ? SC_USE_UV_MIN_MAX_renderTarget2 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget3 [[function_constant(1007)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget3_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget3) ? SC_USE_UV_MIN_MAX_renderTarget3 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget0 [[function_constant(1008)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget0_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget0) ? SC_USE_UV_TRANSFORM_renderTarget0 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget1 [[function_constant(1009)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget1_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget1) ? SC_USE_UV_TRANSFORM_renderTarget1 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget2 [[function_constant(1010)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget2_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget2) ? SC_USE_UV_TRANSFORM_renderTarget2 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget3 [[function_constant(1011)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget3_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget3) ? SC_USE_UV_TRANSFORM_renderTarget3 : false;
constant bool renderTarget0HasSwappedViews [[function_constant(1012)]];
constant bool renderTarget0HasSwappedViews_tmp = is_function_constant_defined(renderTarget0HasSwappedViews) ? renderTarget0HasSwappedViews : false;
constant bool renderTarget1HasSwappedViews [[function_constant(1013)]];
constant bool renderTarget1HasSwappedViews_tmp = is_function_constant_defined(renderTarget1HasSwappedViews) ? renderTarget1HasSwappedViews : false;
constant bool renderTarget2HasSwappedViews [[function_constant(1014)]];
constant bool renderTarget2HasSwappedViews_tmp = is_function_constant_defined(renderTarget2HasSwappedViews) ? renderTarget2HasSwappedViews : false;
constant bool renderTarget3HasSwappedViews [[function_constant(1015)]];
constant bool renderTarget3HasSwappedViews_tmp = is_function_constant_defined(renderTarget3HasSwappedViews) ? renderTarget3HasSwappedViews : false;
constant int SC_DEVICE_CLASS [[function_constant(1016)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 [[function_constant(1017)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 [[function_constant(1018)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 [[function_constant(1019)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 [[function_constant(1020)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget3 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 [[function_constant(1021)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 [[function_constant(1022)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 [[function_constant(1023)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 [[function_constant(1024)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget3 : -1;
constant int renderTarget0Layout [[function_constant(1025)]];
constant int renderTarget0Layout_tmp = is_function_constant_defined(renderTarget0Layout) ? renderTarget0Layout : 0;
constant int renderTarget1Layout [[function_constant(1026)]];
constant int renderTarget1Layout_tmp = is_function_constant_defined(renderTarget1Layout) ? renderTarget1Layout : 0;
constant int renderTarget2Layout [[function_constant(1027)]];
constant int renderTarget2Layout_tmp = is_function_constant_defined(renderTarget2Layout) ? renderTarget2Layout : 0;
constant int renderTarget3Layout [[function_constant(1028)]];
constant int renderTarget3Layout_tmp = is_function_constant_defined(renderTarget3Layout) ? renderTarget3Layout : 0;
constant int sc_StereoRenderingMode [[function_constant(1029)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1030)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
struct ssParticle
{
float3 Position;
float3 Velocity;
float4 Color;
float Size;
float Age;
float Life;
float Mass;
float3x3 Matrix;
bool Dead;
float4 Quaternion;
float collisionCount_N119;
float SpawnOffset;
float Seed;
float2 Seed2000;
float TimeShift;
int Index1D;
int Index1DPerCopy;
float Coord1D;
float Ratio1D;
float Ratio1DPerCopy;
int2 Index2D;
float2 Coord2D;
float2 Ratio2D;
float3 Force;
bool Spawned;
float CopyId;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
};
struct N118_CollisionPlane
{
bool isColliding;
float3 velocity;
float3 position;
float3 force;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int vfxNumCopies;
int vfxBatchEnable[32];
float4x4 vfxModelMatrix[32];
float4 renderTarget0Size;
float4 renderTarget0Dims;
float4 renderTarget0View;
float3x3 renderTarget0Transform;
float4 renderTarget0UvMinMax;
float4 renderTarget0BorderColor;
float4 renderTarget1Size;
float4 renderTarget1Dims;
float4 renderTarget1View;
float3x3 renderTarget1Transform;
float4 renderTarget1UvMinMax;
float4 renderTarget1BorderColor;
float4 renderTarget2Size;
float4 renderTarget2Dims;
float4 renderTarget2View;
float3x3 renderTarget2Transform;
float4 renderTarget2UvMinMax;
float4 renderTarget2BorderColor;
float4 renderTarget3Size;
float4 renderTarget3Dims;
float4 renderTarget3View;
float3x3 renderTarget3Transform;
float4 renderTarget3UvMinMax;
float4 renderTarget3BorderColor;
float3 vfxLocalAabbMin;
float3 vfxLocalAabbMax;
float vfxCameraAspect;
float vfxCameraNear;
float vfxCameraFar;
float3 vfxCameraUp;
float3 vfxCameraForward;
float3 vfxCameraRight;
float4x4 vfxProjectionMatrix;
float4x4 vfxProjectionMatrixInverse;
float4x4 vfxViewMatrix;
float4x4 vfxViewMatrixInverse;
float4x4 vfxViewProjectionMatrix;
float4x4 vfxViewProjectionMatrixInverse;
int vfxFrame;
int vfxOffsetInstances;
int vfxOffsetInstancesPrev;
float2 ssTARGET_SIZE_INT;
float2 ssTARGET_SIZE_FLOAT;
float ssTARGET_WIDTH;
int ssTARGET_WIDTH_INT;
float particles_speed;
float particlesReduce;
float Tweak_N12;
float particle_scale;
float3 Port_Import_N216;
float Port_Input1_N149;
float3 Port_Min_N150;
float3 Port_Max_N150;
float Port_Import_N151;
float Port_Input1_N153;
float3 Port_Max_N154;
float Port_Import_N157;
float3 Port_Import_N158;
float Port_Input1_N162;
float Port_Input1_N165;
float Port_Import_N042;
float Port_Import_N043;
float Port_Import_N023;
float Port_Import_N024;
float Port_Import_N053;
float3 Port_Import_N054;
float3 Port_Import_N187;
float Port_Import_N189;
float3 Port_Import_N142;
float3 Port_Import_N006;
float Port_Input1_N014;
float3 Port_Import_N206;
float3 Port_Import_N208;
float3 Port_Import_N318;
float Port_Multiplier_N319;
float3 Port_Import_N322;
float2 Port_Input1_N326;
float2 Port_Scale_N327;
float2 Port_Input1_N329;
float2 Port_Scale_N330;
float2 Port_Input1_N332;
float2 Port_Scale_N333;
float3 Port_Input1_N335;
float Port_Import_N126;
float Port_Import_N127;
float Port_Import_N128;
float Port_Input4_N137;
float Port_Multiplier_N272;
float3 Port_Import_N112;
float Port_Value1_N213;
float Port_Value2_N213;
float Port_Value3_N213;
float3 Port_Import_N113;
float Port_Import_N114;
float Port_Import_N115;
float Port_Import_N116;
float Port_CollisionCount_N118;
float Port_VelocityThreshold_N118;
float Port_DefaultFloat_N119;
float Port_Input1_N171;
float Port_Input1_N109;
float Port_Input2_N109;
float Port_Input1_N184;
float4 Port_Value0_N176;
float Port_Position1_N176;
float4 Port_Value1_N176;
float Port_Position2_N176;
float4 Port_Value2_N176;
float Port_Position3_N176;
float4 Port_Value3_N176;
float4 Port_Value4_N176;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct sc_Set2
{
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> renderTarget0 [[id(2)]];
texture2d<float> renderTarget1 [[id(3)]];
texture2d<float> renderTarget2 [[id(4)]];
texture2d<float> renderTarget3 [[id(5)]];
sampler renderTarget0SmpSC [[id(21)]];
sampler renderTarget1SmpSC [[id(22)]];
sampler renderTarget2SmpSC [[id(23)]];
sampler renderTarget3SmpSC [[id(24)]];
constant userUniformsObj* UserUniforms [[id(32)]];
};
struct main_vert_out
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
int Interp_Particle_Index [[user(locn11)]];
float3 Interp_Particle_Force [[user(locn12)]];
float2 Interp_Particle_Coord [[user(locn13)]];
float3 Interp_Particle_Position [[user(locn14)]];
float3 Interp_Particle_Velocity [[user(locn15)]];
float Interp_Particle_Life [[user(locn16)]];
float Interp_Particle_Age [[user(locn17)]];
float Interp_Particle_Size [[user(locn18)]];
float4 Interp_Particle_Color [[user(locn19)]];
float4 Interp_Particle_Quaternion [[user(locn20)]];
float Interp_Particle_collisionCount_N119 [[user(locn21)]];
float Interp_Particle_Mass [[user(locn22)]];
float4 gl_Position [[position]];
};
struct main_vert_in
{
float4 position [[attribute(0)]];
float3 normal [[attribute(1)]];
float4 tangent [[attribute(2)]];
float2 texture0 [[attribute(3)]];
float2 texture1 [[attribute(4)]];
float4 boneData [[attribute(5)]];
float3 blendShape0Pos [[attribute(6)]];
float3 blendShape1Pos [[attribute(7)]];
float3 blendShape2Pos [[attribute(8)]];
float3 blendShape3Pos [[attribute(9)]];
float3 blendShape4Pos [[attribute(10)]];
float3 blendShape5Pos [[attribute(11)]];
float3 blendShape0Normal [[attribute(12)]];
float3 blendShape1Normal [[attribute(13)]];
float3 blendShape2Normal [[attribute(14)]];
float3 positionNext [[attribute(15)]];
float3 positionPrevious [[attribute(16)]];
float4 strandProperties [[attribute(17)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
bool ssDecodeParticle(thread const int& InstanceID,thread uint& gl_InstanceIndex,constant userUniformsObj& UserUniforms,thread texture2d<float> renderTarget0,thread sampler renderTarget0SmpSC,thread texture2d<float> renderTarget1,thread sampler renderTarget1SmpSC,thread texture2d<float> renderTarget2,thread sampler renderTarget2SmpSC,thread texture2d<float> renderTarget3,thread sampler renderTarget3SmpSC,thread ssParticle& gParticle)
{
gParticle.Position=float3(0.0);
gParticle.Velocity=float3(0.0);
gParticle.Color=float4(0.0);
gParticle.Size=0.0;
gParticle.Age=0.0;
gParticle.Life=0.0;
gParticle.Mass=1.0;
gParticle.Matrix=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
gParticle.Quaternion=float4(0.0,0.0,0.0,1.0);
int param=InstanceID;
ssParticle param_1=gParticle;
param_1.Spawned=false;
param_1.Dead=false;
param_1.Force=float3(0.0);
param_1.Index1D=param;
param_1.Index1DPerCopy=param%40;
int l9_0=param_1.Index1D;
int2 l9_1=int2(l9_0%40,l9_0/40);
param_1.Index2D=l9_1;
int l9_2=param_1.Index1D;
float l9_3=(float(l9_2)+0.5)/40.0;
param_1.Coord1D=l9_3;
int2 l9_4=param_1.Index2D;
float2 l9_5=(float2(l9_4)+float2(0.5))/float2(40.0,1.0);
param_1.Coord2D=l9_5;
int l9_6=param_1.Index1D;
float l9_7=float(l9_6)/39.0;
param_1.Ratio1D=l9_7;
int l9_8=param_1.Index1DPerCopy;
float l9_9=float(l9_8)/39.0;
param_1.Ratio1DPerCopy=l9_9;
int2 l9_10=param_1.Index2D;
float2 l9_11=float2(l9_10)/float2(39.0,1.0);
param_1.Ratio2D=l9_11;
param_1.Seed=0.0;
param_1.CopyId=float(param_1.Index1D/40);
int l9_12=param_1.Index1D;
int l9_13=l9_12;
int l9_14=((l9_13*((l9_13*1471343)+101146501))+1559861749)&2147483647;
int l9_15=l9_14;
float l9_16=float(l9_15)*4.6566129e-10;
float l9_17=l9_16;
param_1.TimeShift=l9_17;
param_1.SpawnOffset=param_1.Ratio1D*0.2;
ssParticle l9_18=param_1;
float l9_19;
if (UserUniforms.overrideTimeEnabled==1)
{
l9_19=UserUniforms.overrideTimeElapsed;
}
else
{
l9_19=UserUniforms.sc_Time.x;
}
float l9_20=l9_19;
l9_18.Seed=(l9_18.Ratio1D*0.97637898)+0.151235;
l9_18.Seed+=(floor(((((l9_20-l9_18.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_18.Seed=fract(abs(l9_18.Seed));
int2 l9_21=int2(l9_18.Index1D%400,l9_18.Index1D/400);
l9_18.Seed2000=(float2(l9_21)+float2(1.0))/float2(399.0);
param_1=l9_18;
gParticle=param_1;
int offsetPixelId=(UserUniforms.vfxOffsetInstancesPrev+InstanceID)*4;
int param_2=offsetPixelId;
int param_3=UserUniforms.ssTARGET_WIDTH_INT;
int l9_22=param_2-((param_2/param_3)*param_3);
int2 Index2D=int2(l9_22,offsetPixelId/UserUniforms.ssTARGET_WIDTH_INT);
float2 Coord=(float2(Index2D)+float2(0.5))/float2(2048.0,UserUniforms.ssTARGET_SIZE_FLOAT.y);
float2 Offset=float2(0.00048828125,0.0);
float2 uv=float2(0.0);
float Scalar0=0.0;
float Scalar1=0.0;
float Scalar2=0.0;
float Scalar3=0.0;
float Scalar4=0.0;
float Scalar5=0.0;
float Scalar6=0.0;
float Scalar7=0.0;
float Scalar8=0.0;
float Scalar9=0.0;
float Scalar10=0.0;
float Scalar11=0.0;
float Scalar12=0.0;
float Scalar13=0.0;
float Scalar14=0.0;
float Scalar15=0.0;
uv=Coord+(Offset*0.0);
int l9_23=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_24=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_24=0;
}
else
{
l9_24=gl_InstanceIndex%2;
}
int l9_25=l9_24;
l9_23=1-l9_25;
}
else
{
int l9_26=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_26=0;
}
else
{
l9_26=gl_InstanceIndex%2;
}
int l9_27=l9_26;
l9_23=l9_27;
}
int l9_28=l9_23;
int param_4=renderTarget0Layout_tmp;
int param_5=l9_28;
float2 param_6=uv;
bool param_7=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_8=UserUniforms.renderTarget0Transform;
int2 param_9=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_10=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_11=UserUniforms.renderTarget0UvMinMax;
bool param_12=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_13=UserUniforms.renderTarget0BorderColor;
float param_14=0.0;
bool l9_29=param_12&&(!param_10);
float l9_30=1.0;
float l9_31=param_6.x;
int l9_32=param_9.x;
if (l9_32==1)
{
l9_31=fract(l9_31);
}
else
{
if (l9_32==2)
{
float l9_33=fract(l9_31);
float l9_34=l9_31-l9_33;
float l9_35=step(0.25,fract(l9_34*0.5));
l9_31=mix(l9_33,1.0-l9_33,fast::clamp(l9_35,0.0,1.0));
}
}
param_6.x=l9_31;
float l9_36=param_6.y;
int l9_37=param_9.y;
if (l9_37==1)
{
l9_36=fract(l9_36);
}
else
{
if (l9_37==2)
{
float l9_38=fract(l9_36);
float l9_39=l9_36-l9_38;
float l9_40=step(0.25,fract(l9_39*0.5));
l9_36=mix(l9_38,1.0-l9_38,fast::clamp(l9_40,0.0,1.0));
}
}
param_6.y=l9_36;
if (param_10)
{
bool l9_41=param_12;
bool l9_42;
if (l9_41)
{
l9_42=param_9.x==3;
}
else
{
l9_42=l9_41;
}
float l9_43=param_6.x;
float l9_44=param_11.x;
float l9_45=param_11.z;
bool l9_46=l9_42;
float l9_47=l9_30;
float l9_48=fast::clamp(l9_43,l9_44,l9_45);
float l9_49=step(abs(l9_43-l9_48),9.9999997e-06);
l9_47*=(l9_49+((1.0-float(l9_46))*(1.0-l9_49)));
l9_43=l9_48;
param_6.x=l9_43;
l9_30=l9_47;
bool l9_50=param_12;
bool l9_51;
if (l9_50)
{
l9_51=param_9.y==3;
}
else
{
l9_51=l9_50;
}
float l9_52=param_6.y;
float l9_53=param_11.y;
float l9_54=param_11.w;
bool l9_55=l9_51;
float l9_56=l9_30;
float l9_57=fast::clamp(l9_52,l9_53,l9_54);
float l9_58=step(abs(l9_52-l9_57),9.9999997e-06);
l9_56*=(l9_58+((1.0-float(l9_55))*(1.0-l9_58)));
l9_52=l9_57;
param_6.y=l9_52;
l9_30=l9_56;
}
float2 l9_59=param_6;
bool l9_60=param_7;
float3x3 l9_61=param_8;
if (l9_60)
{
l9_59=float2((l9_61*float3(l9_59,1.0)).xy);
}
float2 l9_62=l9_59;
float2 l9_63=l9_62;
float2 l9_64=l9_63;
param_6=l9_64;
float l9_65=param_6.x;
int l9_66=param_9.x;
bool l9_67=l9_29;
float l9_68=l9_30;
if ((l9_66==0)||(l9_66==3))
{
float l9_69=l9_65;
float l9_70=0.0;
float l9_71=1.0;
bool l9_72=l9_67;
float l9_73=l9_68;
float l9_74=fast::clamp(l9_69,l9_70,l9_71);
float l9_75=step(abs(l9_69-l9_74),9.9999997e-06);
l9_73*=(l9_75+((1.0-float(l9_72))*(1.0-l9_75)));
l9_69=l9_74;
l9_65=l9_69;
l9_68=l9_73;
}
param_6.x=l9_65;
l9_30=l9_68;
float l9_76=param_6.y;
int l9_77=param_9.y;
bool l9_78=l9_29;
float l9_79=l9_30;
if ((l9_77==0)||(l9_77==3))
{
float l9_80=l9_76;
float l9_81=0.0;
float l9_82=1.0;
bool l9_83=l9_78;
float l9_84=l9_79;
float l9_85=fast::clamp(l9_80,l9_81,l9_82);
float l9_86=step(abs(l9_80-l9_85),9.9999997e-06);
l9_84*=(l9_86+((1.0-float(l9_83))*(1.0-l9_86)));
l9_80=l9_85;
l9_76=l9_80;
l9_79=l9_84;
}
param_6.y=l9_76;
l9_30=l9_79;
float2 l9_87=param_6;
int l9_88=param_4;
int l9_89=param_5;
float l9_90=param_14;
float2 l9_91=l9_87;
int l9_92=l9_88;
int l9_93=l9_89;
float3 l9_94=float3(0.0);
if (l9_92==0)
{
l9_94=float3(l9_91,0.0);
}
else
{
if (l9_92==1)
{
l9_94=float3(l9_91.x,(l9_91.y*0.5)+(0.5-(float(l9_93)*0.5)),0.0);
}
else
{
l9_94=float3(l9_91,float(l9_93));
}
}
float3 l9_95=l9_94;
float3 l9_96=l9_95;
float2 l9_97=l9_96.xy;
float l9_98=l9_90;
float4 l9_99=renderTarget0.sample(renderTarget0SmpSC,l9_97,level(l9_98));
float4 l9_100=l9_99;
float4 l9_101=l9_100;
if (param_12)
{
l9_101=mix(param_13,l9_101,float4(l9_30));
}
float4 l9_102=l9_101;
float4 renderTarget0Sample=l9_102;
float4 l9_103=renderTarget0Sample;
bool l9_104=dot(abs(l9_103),float4(1.0))<9.9999997e-06;
bool l9_105;
if (!l9_104)
{
int l9_106=gl_InstanceIndex;
l9_105=!(UserUniforms.vfxBatchEnable[l9_106/40]!=0);
}
else
{
l9_105=l9_104;
}
if (l9_105)
{
return false;
}
Scalar0=renderTarget0Sample.x;
Scalar1=renderTarget0Sample.y;
Scalar2=renderTarget0Sample.z;
Scalar3=renderTarget0Sample.w;
int l9_107=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_108=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_108=0;
}
else
{
l9_108=gl_InstanceIndex%2;
}
int l9_109=l9_108;
l9_107=1-l9_109;
}
else
{
int l9_110=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_110=0;
}
else
{
l9_110=gl_InstanceIndex%2;
}
int l9_111=l9_110;
l9_107=l9_111;
}
int l9_112=l9_107;
int param_15=renderTarget1Layout_tmp;
int param_16=l9_112;
float2 param_17=uv;
bool param_18=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_19=UserUniforms.renderTarget1Transform;
int2 param_20=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_21=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_22=UserUniforms.renderTarget1UvMinMax;
bool param_23=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_24=UserUniforms.renderTarget1BorderColor;
float param_25=0.0;
bool l9_113=param_23&&(!param_21);
float l9_114=1.0;
float l9_115=param_17.x;
int l9_116=param_20.x;
if (l9_116==1)
{
l9_115=fract(l9_115);
}
else
{
if (l9_116==2)
{
float l9_117=fract(l9_115);
float l9_118=l9_115-l9_117;
float l9_119=step(0.25,fract(l9_118*0.5));
l9_115=mix(l9_117,1.0-l9_117,fast::clamp(l9_119,0.0,1.0));
}
}
param_17.x=l9_115;
float l9_120=param_17.y;
int l9_121=param_20.y;
if (l9_121==1)
{
l9_120=fract(l9_120);
}
else
{
if (l9_121==2)
{
float l9_122=fract(l9_120);
float l9_123=l9_120-l9_122;
float l9_124=step(0.25,fract(l9_123*0.5));
l9_120=mix(l9_122,1.0-l9_122,fast::clamp(l9_124,0.0,1.0));
}
}
param_17.y=l9_120;
if (param_21)
{
bool l9_125=param_23;
bool l9_126;
if (l9_125)
{
l9_126=param_20.x==3;
}
else
{
l9_126=l9_125;
}
float l9_127=param_17.x;
float l9_128=param_22.x;
float l9_129=param_22.z;
bool l9_130=l9_126;
float l9_131=l9_114;
float l9_132=fast::clamp(l9_127,l9_128,l9_129);
float l9_133=step(abs(l9_127-l9_132),9.9999997e-06);
l9_131*=(l9_133+((1.0-float(l9_130))*(1.0-l9_133)));
l9_127=l9_132;
param_17.x=l9_127;
l9_114=l9_131;
bool l9_134=param_23;
bool l9_135;
if (l9_134)
{
l9_135=param_20.y==3;
}
else
{
l9_135=l9_134;
}
float l9_136=param_17.y;
float l9_137=param_22.y;
float l9_138=param_22.w;
bool l9_139=l9_135;
float l9_140=l9_114;
float l9_141=fast::clamp(l9_136,l9_137,l9_138);
float l9_142=step(abs(l9_136-l9_141),9.9999997e-06);
l9_140*=(l9_142+((1.0-float(l9_139))*(1.0-l9_142)));
l9_136=l9_141;
param_17.y=l9_136;
l9_114=l9_140;
}
float2 l9_143=param_17;
bool l9_144=param_18;
float3x3 l9_145=param_19;
if (l9_144)
{
l9_143=float2((l9_145*float3(l9_143,1.0)).xy);
}
float2 l9_146=l9_143;
float2 l9_147=l9_146;
float2 l9_148=l9_147;
param_17=l9_148;
float l9_149=param_17.x;
int l9_150=param_20.x;
bool l9_151=l9_113;
float l9_152=l9_114;
if ((l9_150==0)||(l9_150==3))
{
float l9_153=l9_149;
float l9_154=0.0;
float l9_155=1.0;
bool l9_156=l9_151;
float l9_157=l9_152;
float l9_158=fast::clamp(l9_153,l9_154,l9_155);
float l9_159=step(abs(l9_153-l9_158),9.9999997e-06);
l9_157*=(l9_159+((1.0-float(l9_156))*(1.0-l9_159)));
l9_153=l9_158;
l9_149=l9_153;
l9_152=l9_157;
}
param_17.x=l9_149;
l9_114=l9_152;
float l9_160=param_17.y;
int l9_161=param_20.y;
bool l9_162=l9_113;
float l9_163=l9_114;
if ((l9_161==0)||(l9_161==3))
{
float l9_164=l9_160;
float l9_165=0.0;
float l9_166=1.0;
bool l9_167=l9_162;
float l9_168=l9_163;
float l9_169=fast::clamp(l9_164,l9_165,l9_166);
float l9_170=step(abs(l9_164-l9_169),9.9999997e-06);
l9_168*=(l9_170+((1.0-float(l9_167))*(1.0-l9_170)));
l9_164=l9_169;
l9_160=l9_164;
l9_163=l9_168;
}
param_17.y=l9_160;
l9_114=l9_163;
float2 l9_171=param_17;
int l9_172=param_15;
int l9_173=param_16;
float l9_174=param_25;
float2 l9_175=l9_171;
int l9_176=l9_172;
int l9_177=l9_173;
float3 l9_178=float3(0.0);
if (l9_176==0)
{
l9_178=float3(l9_175,0.0);
}
else
{
if (l9_176==1)
{
l9_178=float3(l9_175.x,(l9_175.y*0.5)+(0.5-(float(l9_177)*0.5)),0.0);
}
else
{
l9_178=float3(l9_175,float(l9_177));
}
}
float3 l9_179=l9_178;
float3 l9_180=l9_179;
float2 l9_181=l9_180.xy;
float l9_182=l9_174;
float4 l9_183=renderTarget1.sample(renderTarget1SmpSC,l9_181,level(l9_182));
float4 l9_184=l9_183;
float4 l9_185=l9_184;
if (param_23)
{
l9_185=mix(param_24,l9_185,float4(l9_114));
}
float4 l9_186=l9_185;
float4 renderTarget1Sample=l9_186;
Scalar4=renderTarget1Sample.x;
Scalar5=renderTarget1Sample.y;
Scalar6=renderTarget1Sample.z;
Scalar7=renderTarget1Sample.w;
int l9_187=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_188=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_188=0;
}
else
{
l9_188=gl_InstanceIndex%2;
}
int l9_189=l9_188;
l9_187=1-l9_189;
}
else
{
int l9_190=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_190=0;
}
else
{
l9_190=gl_InstanceIndex%2;
}
int l9_191=l9_190;
l9_187=l9_191;
}
int l9_192=l9_187;
int param_26=renderTarget2Layout_tmp;
int param_27=l9_192;
float2 param_28=uv;
bool param_29=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_30=UserUniforms.renderTarget2Transform;
int2 param_31=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_32=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_33=UserUniforms.renderTarget2UvMinMax;
bool param_34=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_35=UserUniforms.renderTarget2BorderColor;
float param_36=0.0;
bool l9_193=param_34&&(!param_32);
float l9_194=1.0;
float l9_195=param_28.x;
int l9_196=param_31.x;
if (l9_196==1)
{
l9_195=fract(l9_195);
}
else
{
if (l9_196==2)
{
float l9_197=fract(l9_195);
float l9_198=l9_195-l9_197;
float l9_199=step(0.25,fract(l9_198*0.5));
l9_195=mix(l9_197,1.0-l9_197,fast::clamp(l9_199,0.0,1.0));
}
}
param_28.x=l9_195;
float l9_200=param_28.y;
int l9_201=param_31.y;
if (l9_201==1)
{
l9_200=fract(l9_200);
}
else
{
if (l9_201==2)
{
float l9_202=fract(l9_200);
float l9_203=l9_200-l9_202;
float l9_204=step(0.25,fract(l9_203*0.5));
l9_200=mix(l9_202,1.0-l9_202,fast::clamp(l9_204,0.0,1.0));
}
}
param_28.y=l9_200;
if (param_32)
{
bool l9_205=param_34;
bool l9_206;
if (l9_205)
{
l9_206=param_31.x==3;
}
else
{
l9_206=l9_205;
}
float l9_207=param_28.x;
float l9_208=param_33.x;
float l9_209=param_33.z;
bool l9_210=l9_206;
float l9_211=l9_194;
float l9_212=fast::clamp(l9_207,l9_208,l9_209);
float l9_213=step(abs(l9_207-l9_212),9.9999997e-06);
l9_211*=(l9_213+((1.0-float(l9_210))*(1.0-l9_213)));
l9_207=l9_212;
param_28.x=l9_207;
l9_194=l9_211;
bool l9_214=param_34;
bool l9_215;
if (l9_214)
{
l9_215=param_31.y==3;
}
else
{
l9_215=l9_214;
}
float l9_216=param_28.y;
float l9_217=param_33.y;
float l9_218=param_33.w;
bool l9_219=l9_215;
float l9_220=l9_194;
float l9_221=fast::clamp(l9_216,l9_217,l9_218);
float l9_222=step(abs(l9_216-l9_221),9.9999997e-06);
l9_220*=(l9_222+((1.0-float(l9_219))*(1.0-l9_222)));
l9_216=l9_221;
param_28.y=l9_216;
l9_194=l9_220;
}
float2 l9_223=param_28;
bool l9_224=param_29;
float3x3 l9_225=param_30;
if (l9_224)
{
l9_223=float2((l9_225*float3(l9_223,1.0)).xy);
}
float2 l9_226=l9_223;
float2 l9_227=l9_226;
float2 l9_228=l9_227;
param_28=l9_228;
float l9_229=param_28.x;
int l9_230=param_31.x;
bool l9_231=l9_193;
float l9_232=l9_194;
if ((l9_230==0)||(l9_230==3))
{
float l9_233=l9_229;
float l9_234=0.0;
float l9_235=1.0;
bool l9_236=l9_231;
float l9_237=l9_232;
float l9_238=fast::clamp(l9_233,l9_234,l9_235);
float l9_239=step(abs(l9_233-l9_238),9.9999997e-06);
l9_237*=(l9_239+((1.0-float(l9_236))*(1.0-l9_239)));
l9_233=l9_238;
l9_229=l9_233;
l9_232=l9_237;
}
param_28.x=l9_229;
l9_194=l9_232;
float l9_240=param_28.y;
int l9_241=param_31.y;
bool l9_242=l9_193;
float l9_243=l9_194;
if ((l9_241==0)||(l9_241==3))
{
float l9_244=l9_240;
float l9_245=0.0;
float l9_246=1.0;
bool l9_247=l9_242;
float l9_248=l9_243;
float l9_249=fast::clamp(l9_244,l9_245,l9_246);
float l9_250=step(abs(l9_244-l9_249),9.9999997e-06);
l9_248*=(l9_250+((1.0-float(l9_247))*(1.0-l9_250)));
l9_244=l9_249;
l9_240=l9_244;
l9_243=l9_248;
}
param_28.y=l9_240;
l9_194=l9_243;
float2 l9_251=param_28;
int l9_252=param_26;
int l9_253=param_27;
float l9_254=param_36;
float2 l9_255=l9_251;
int l9_256=l9_252;
int l9_257=l9_253;
float3 l9_258=float3(0.0);
if (l9_256==0)
{
l9_258=float3(l9_255,0.0);
}
else
{
if (l9_256==1)
{
l9_258=float3(l9_255.x,(l9_255.y*0.5)+(0.5-(float(l9_257)*0.5)),0.0);
}
else
{
l9_258=float3(l9_255,float(l9_257));
}
}
float3 l9_259=l9_258;
float3 l9_260=l9_259;
float2 l9_261=l9_260.xy;
float l9_262=l9_254;
float4 l9_263=renderTarget2.sample(renderTarget2SmpSC,l9_261,level(l9_262));
float4 l9_264=l9_263;
float4 l9_265=l9_264;
if (param_34)
{
l9_265=mix(param_35,l9_265,float4(l9_194));
}
float4 l9_266=l9_265;
float4 renderTarget2Sample=l9_266;
Scalar8=renderTarget2Sample.x;
Scalar9=renderTarget2Sample.y;
Scalar10=renderTarget2Sample.z;
Scalar11=renderTarget2Sample.w;
int l9_267=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_268=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_268=0;
}
else
{
l9_268=gl_InstanceIndex%2;
}
int l9_269=l9_268;
l9_267=1-l9_269;
}
else
{
int l9_270=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_270=0;
}
else
{
l9_270=gl_InstanceIndex%2;
}
int l9_271=l9_270;
l9_267=l9_271;
}
int l9_272=l9_267;
int param_37=renderTarget3Layout_tmp;
int param_38=l9_272;
float2 param_39=uv;
bool param_40=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_41=UserUniforms.renderTarget3Transform;
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_43=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_44=UserUniforms.renderTarget3UvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_46=UserUniforms.renderTarget3BorderColor;
float param_47=0.0;
bool l9_273=param_45&&(!param_43);
float l9_274=1.0;
float l9_275=param_39.x;
int l9_276=param_42.x;
if (l9_276==1)
{
l9_275=fract(l9_275);
}
else
{
if (l9_276==2)
{
float l9_277=fract(l9_275);
float l9_278=l9_275-l9_277;
float l9_279=step(0.25,fract(l9_278*0.5));
l9_275=mix(l9_277,1.0-l9_277,fast::clamp(l9_279,0.0,1.0));
}
}
param_39.x=l9_275;
float l9_280=param_39.y;
int l9_281=param_42.y;
if (l9_281==1)
{
l9_280=fract(l9_280);
}
else
{
if (l9_281==2)
{
float l9_282=fract(l9_280);
float l9_283=l9_280-l9_282;
float l9_284=step(0.25,fract(l9_283*0.5));
l9_280=mix(l9_282,1.0-l9_282,fast::clamp(l9_284,0.0,1.0));
}
}
param_39.y=l9_280;
if (param_43)
{
bool l9_285=param_45;
bool l9_286;
if (l9_285)
{
l9_286=param_42.x==3;
}
else
{
l9_286=l9_285;
}
float l9_287=param_39.x;
float l9_288=param_44.x;
float l9_289=param_44.z;
bool l9_290=l9_286;
float l9_291=l9_274;
float l9_292=fast::clamp(l9_287,l9_288,l9_289);
float l9_293=step(abs(l9_287-l9_292),9.9999997e-06);
l9_291*=(l9_293+((1.0-float(l9_290))*(1.0-l9_293)));
l9_287=l9_292;
param_39.x=l9_287;
l9_274=l9_291;
bool l9_294=param_45;
bool l9_295;
if (l9_294)
{
l9_295=param_42.y==3;
}
else
{
l9_295=l9_294;
}
float l9_296=param_39.y;
float l9_297=param_44.y;
float l9_298=param_44.w;
bool l9_299=l9_295;
float l9_300=l9_274;
float l9_301=fast::clamp(l9_296,l9_297,l9_298);
float l9_302=step(abs(l9_296-l9_301),9.9999997e-06);
l9_300*=(l9_302+((1.0-float(l9_299))*(1.0-l9_302)));
l9_296=l9_301;
param_39.y=l9_296;
l9_274=l9_300;
}
float2 l9_303=param_39;
bool l9_304=param_40;
float3x3 l9_305=param_41;
if (l9_304)
{
l9_303=float2((l9_305*float3(l9_303,1.0)).xy);
}
float2 l9_306=l9_303;
float2 l9_307=l9_306;
float2 l9_308=l9_307;
param_39=l9_308;
float l9_309=param_39.x;
int l9_310=param_42.x;
bool l9_311=l9_273;
float l9_312=l9_274;
if ((l9_310==0)||(l9_310==3))
{
float l9_313=l9_309;
float l9_314=0.0;
float l9_315=1.0;
bool l9_316=l9_311;
float l9_317=l9_312;
float l9_318=fast::clamp(l9_313,l9_314,l9_315);
float l9_319=step(abs(l9_313-l9_318),9.9999997e-06);
l9_317*=(l9_319+((1.0-float(l9_316))*(1.0-l9_319)));
l9_313=l9_318;
l9_309=l9_313;
l9_312=l9_317;
}
param_39.x=l9_309;
l9_274=l9_312;
float l9_320=param_39.y;
int l9_321=param_42.y;
bool l9_322=l9_273;
float l9_323=l9_274;
if ((l9_321==0)||(l9_321==3))
{
float l9_324=l9_320;
float l9_325=0.0;
float l9_326=1.0;
bool l9_327=l9_322;
float l9_328=l9_323;
float l9_329=fast::clamp(l9_324,l9_325,l9_326);
float l9_330=step(abs(l9_324-l9_329),9.9999997e-06);
l9_328*=(l9_330+((1.0-float(l9_327))*(1.0-l9_330)));
l9_324=l9_329;
l9_320=l9_324;
l9_323=l9_328;
}
param_39.y=l9_320;
l9_274=l9_323;
float2 l9_331=param_39;
int l9_332=param_37;
int l9_333=param_38;
float l9_334=param_47;
float2 l9_335=l9_331;
int l9_336=l9_332;
int l9_337=l9_333;
float3 l9_338=float3(0.0);
if (l9_336==0)
{
l9_338=float3(l9_335,0.0);
}
else
{
if (l9_336==1)
{
l9_338=float3(l9_335.x,(l9_335.y*0.5)+(0.5-(float(l9_337)*0.5)),0.0);
}
else
{
l9_338=float3(l9_335,float(l9_337));
}
}
float3 l9_339=l9_338;
float3 l9_340=l9_339;
float2 l9_341=l9_340.xy;
float l9_342=l9_334;
float4 l9_343=renderTarget3.sample(renderTarget3SmpSC,l9_341,level(l9_342));
float4 l9_344=l9_343;
float4 l9_345=l9_344;
if (param_45)
{
l9_345=mix(param_46,l9_345,float4(l9_274));
}
float4 l9_346=l9_345;
float4 renderTarget3Sample=l9_346;
Scalar12=renderTarget3Sample.x;
Scalar13=renderTarget3Sample.y;
Scalar14=renderTarget3Sample.z;
Scalar15=renderTarget3Sample.w;
float4 param_48=float4(Scalar0,Scalar1,Scalar2,Scalar3);
float param_49=-1000.0;
float param_50=1000.0;
float4 l9_347=param_48;
float l9_348=param_49;
float l9_349=param_50;
float l9_350=0.99998999;
float4 l9_351=l9_347;
#if (1)
{
l9_351=floor((l9_351*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_352=dot(l9_351,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_353=l9_352;
float l9_354=0.0;
float l9_355=l9_350;
float l9_356=l9_348;
float l9_357=l9_349;
float l9_358=l9_356+(((l9_353-l9_354)*(l9_357-l9_356))/(l9_355-l9_354));
float l9_359=l9_358;
float l9_360=l9_359;
gParticle.Position.x=l9_360;
float4 param_51=float4(Scalar4,Scalar5,Scalar6,Scalar7);
float param_52=-1000.0;
float param_53=1000.0;
float4 l9_361=param_51;
float l9_362=param_52;
float l9_363=param_53;
float l9_364=0.99998999;
float4 l9_365=l9_361;
#if (1)
{
l9_365=floor((l9_365*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_366=dot(l9_365,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_367=l9_366;
float l9_368=0.0;
float l9_369=l9_364;
float l9_370=l9_362;
float l9_371=l9_363;
float l9_372=l9_370+(((l9_367-l9_368)*(l9_371-l9_370))/(l9_369-l9_368));
float l9_373=l9_372;
float l9_374=l9_373;
gParticle.Position.y=l9_374;
float4 param_54=float4(Scalar8,Scalar9,Scalar10,Scalar11);
float param_55=-1000.0;
float param_56=1000.0;
float4 l9_375=param_54;
float l9_376=param_55;
float l9_377=param_56;
float l9_378=0.99998999;
float4 l9_379=l9_375;
#if (1)
{
l9_379=floor((l9_379*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_380=dot(l9_379,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_381=l9_380;
float l9_382=0.0;
float l9_383=l9_378;
float l9_384=l9_376;
float l9_385=l9_377;
float l9_386=l9_384+(((l9_381-l9_382)*(l9_385-l9_384))/(l9_383-l9_382));
float l9_387=l9_386;
float l9_388=l9_387;
gParticle.Position.z=l9_388;
float4 param_57=float4(Scalar12,Scalar13,Scalar14,Scalar15);
float param_58=-1000.0;
float param_59=1000.0;
float4 l9_389=param_57;
float l9_390=param_58;
float l9_391=param_59;
float l9_392=0.99998999;
float4 l9_393=l9_389;
#if (1)
{
l9_393=floor((l9_393*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_394=dot(l9_393,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_395=l9_394;
float l9_396=0.0;
float l9_397=l9_392;
float l9_398=l9_390;
float l9_399=l9_391;
float l9_400=l9_398+(((l9_395-l9_396)*(l9_399-l9_398))/(l9_397-l9_396));
float l9_401=l9_400;
float l9_402=l9_401;
gParticle.Velocity.x=l9_402;
uv=Coord+(Offset*1.0);
int l9_403=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_404=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_404=0;
}
else
{
l9_404=gl_InstanceIndex%2;
}
int l9_405=l9_404;
l9_403=1-l9_405;
}
else
{
int l9_406=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_406=0;
}
else
{
l9_406=gl_InstanceIndex%2;
}
int l9_407=l9_406;
l9_403=l9_407;
}
int l9_408=l9_403;
int param_60=renderTarget0Layout_tmp;
int param_61=l9_408;
float2 param_62=uv;
bool param_63=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_64=UserUniforms.renderTarget0Transform;
int2 param_65=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_66=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_67=UserUniforms.renderTarget0UvMinMax;
bool param_68=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_69=UserUniforms.renderTarget0BorderColor;
float param_70=0.0;
bool l9_409=param_68&&(!param_66);
float l9_410=1.0;
float l9_411=param_62.x;
int l9_412=param_65.x;
if (l9_412==1)
{
l9_411=fract(l9_411);
}
else
{
if (l9_412==2)
{
float l9_413=fract(l9_411);
float l9_414=l9_411-l9_413;
float l9_415=step(0.25,fract(l9_414*0.5));
l9_411=mix(l9_413,1.0-l9_413,fast::clamp(l9_415,0.0,1.0));
}
}
param_62.x=l9_411;
float l9_416=param_62.y;
int l9_417=param_65.y;
if (l9_417==1)
{
l9_416=fract(l9_416);
}
else
{
if (l9_417==2)
{
float l9_418=fract(l9_416);
float l9_419=l9_416-l9_418;
float l9_420=step(0.25,fract(l9_419*0.5));
l9_416=mix(l9_418,1.0-l9_418,fast::clamp(l9_420,0.0,1.0));
}
}
param_62.y=l9_416;
if (param_66)
{
bool l9_421=param_68;
bool l9_422;
if (l9_421)
{
l9_422=param_65.x==3;
}
else
{
l9_422=l9_421;
}
float l9_423=param_62.x;
float l9_424=param_67.x;
float l9_425=param_67.z;
bool l9_426=l9_422;
float l9_427=l9_410;
float l9_428=fast::clamp(l9_423,l9_424,l9_425);
float l9_429=step(abs(l9_423-l9_428),9.9999997e-06);
l9_427*=(l9_429+((1.0-float(l9_426))*(1.0-l9_429)));
l9_423=l9_428;
param_62.x=l9_423;
l9_410=l9_427;
bool l9_430=param_68;
bool l9_431;
if (l9_430)
{
l9_431=param_65.y==3;
}
else
{
l9_431=l9_430;
}
float l9_432=param_62.y;
float l9_433=param_67.y;
float l9_434=param_67.w;
bool l9_435=l9_431;
float l9_436=l9_410;
float l9_437=fast::clamp(l9_432,l9_433,l9_434);
float l9_438=step(abs(l9_432-l9_437),9.9999997e-06);
l9_436*=(l9_438+((1.0-float(l9_435))*(1.0-l9_438)));
l9_432=l9_437;
param_62.y=l9_432;
l9_410=l9_436;
}
float2 l9_439=param_62;
bool l9_440=param_63;
float3x3 l9_441=param_64;
if (l9_440)
{
l9_439=float2((l9_441*float3(l9_439,1.0)).xy);
}
float2 l9_442=l9_439;
float2 l9_443=l9_442;
float2 l9_444=l9_443;
param_62=l9_444;
float l9_445=param_62.x;
int l9_446=param_65.x;
bool l9_447=l9_409;
float l9_448=l9_410;
if ((l9_446==0)||(l9_446==3))
{
float l9_449=l9_445;
float l9_450=0.0;
float l9_451=1.0;
bool l9_452=l9_447;
float l9_453=l9_448;
float l9_454=fast::clamp(l9_449,l9_450,l9_451);
float l9_455=step(abs(l9_449-l9_454),9.9999997e-06);
l9_453*=(l9_455+((1.0-float(l9_452))*(1.0-l9_455)));
l9_449=l9_454;
l9_445=l9_449;
l9_448=l9_453;
}
param_62.x=l9_445;
l9_410=l9_448;
float l9_456=param_62.y;
int l9_457=param_65.y;
bool l9_458=l9_409;
float l9_459=l9_410;
if ((l9_457==0)||(l9_457==3))
{
float l9_460=l9_456;
float l9_461=0.0;
float l9_462=1.0;
bool l9_463=l9_458;
float l9_464=l9_459;
float l9_465=fast::clamp(l9_460,l9_461,l9_462);
float l9_466=step(abs(l9_460-l9_465),9.9999997e-06);
l9_464*=(l9_466+((1.0-float(l9_463))*(1.0-l9_466)));
l9_460=l9_465;
l9_456=l9_460;
l9_459=l9_464;
}
param_62.y=l9_456;
l9_410=l9_459;
float2 l9_467=param_62;
int l9_468=param_60;
int l9_469=param_61;
float l9_470=param_70;
float2 l9_471=l9_467;
int l9_472=l9_468;
int l9_473=l9_469;
float3 l9_474=float3(0.0);
if (l9_472==0)
{
l9_474=float3(l9_471,0.0);
}
else
{
if (l9_472==1)
{
l9_474=float3(l9_471.x,(l9_471.y*0.5)+(0.5-(float(l9_473)*0.5)),0.0);
}
else
{
l9_474=float3(l9_471,float(l9_473));
}
}
float3 l9_475=l9_474;
float3 l9_476=l9_475;
float2 l9_477=l9_476.xy;
float l9_478=l9_470;
float4 l9_479=renderTarget0.sample(renderTarget0SmpSC,l9_477,level(l9_478));
float4 l9_480=l9_479;
float4 l9_481=l9_480;
if (param_68)
{
l9_481=mix(param_69,l9_481,float4(l9_410));
}
float4 l9_482=l9_481;
float4 renderTarget0Sample_1=l9_482;
Scalar0=renderTarget0Sample_1.x;
Scalar1=renderTarget0Sample_1.y;
Scalar2=renderTarget0Sample_1.z;
Scalar3=renderTarget0Sample_1.w;
int l9_483=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_484=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_484=0;
}
else
{
l9_484=gl_InstanceIndex%2;
}
int l9_485=l9_484;
l9_483=1-l9_485;
}
else
{
int l9_486=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_486=0;
}
else
{
l9_486=gl_InstanceIndex%2;
}
int l9_487=l9_486;
l9_483=l9_487;
}
int l9_488=l9_483;
int param_71=renderTarget1Layout_tmp;
int param_72=l9_488;
float2 param_73=uv;
bool param_74=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_75=UserUniforms.renderTarget1Transform;
int2 param_76=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_77=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_78=UserUniforms.renderTarget1UvMinMax;
bool param_79=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_80=UserUniforms.renderTarget1BorderColor;
float param_81=0.0;
bool l9_489=param_79&&(!param_77);
float l9_490=1.0;
float l9_491=param_73.x;
int l9_492=param_76.x;
if (l9_492==1)
{
l9_491=fract(l9_491);
}
else
{
if (l9_492==2)
{
float l9_493=fract(l9_491);
float l9_494=l9_491-l9_493;
float l9_495=step(0.25,fract(l9_494*0.5));
l9_491=mix(l9_493,1.0-l9_493,fast::clamp(l9_495,0.0,1.0));
}
}
param_73.x=l9_491;
float l9_496=param_73.y;
int l9_497=param_76.y;
if (l9_497==1)
{
l9_496=fract(l9_496);
}
else
{
if (l9_497==2)
{
float l9_498=fract(l9_496);
float l9_499=l9_496-l9_498;
float l9_500=step(0.25,fract(l9_499*0.5));
l9_496=mix(l9_498,1.0-l9_498,fast::clamp(l9_500,0.0,1.0));
}
}
param_73.y=l9_496;
if (param_77)
{
bool l9_501=param_79;
bool l9_502;
if (l9_501)
{
l9_502=param_76.x==3;
}
else
{
l9_502=l9_501;
}
float l9_503=param_73.x;
float l9_504=param_78.x;
float l9_505=param_78.z;
bool l9_506=l9_502;
float l9_507=l9_490;
float l9_508=fast::clamp(l9_503,l9_504,l9_505);
float l9_509=step(abs(l9_503-l9_508),9.9999997e-06);
l9_507*=(l9_509+((1.0-float(l9_506))*(1.0-l9_509)));
l9_503=l9_508;
param_73.x=l9_503;
l9_490=l9_507;
bool l9_510=param_79;
bool l9_511;
if (l9_510)
{
l9_511=param_76.y==3;
}
else
{
l9_511=l9_510;
}
float l9_512=param_73.y;
float l9_513=param_78.y;
float l9_514=param_78.w;
bool l9_515=l9_511;
float l9_516=l9_490;
float l9_517=fast::clamp(l9_512,l9_513,l9_514);
float l9_518=step(abs(l9_512-l9_517),9.9999997e-06);
l9_516*=(l9_518+((1.0-float(l9_515))*(1.0-l9_518)));
l9_512=l9_517;
param_73.y=l9_512;
l9_490=l9_516;
}
float2 l9_519=param_73;
bool l9_520=param_74;
float3x3 l9_521=param_75;
if (l9_520)
{
l9_519=float2((l9_521*float3(l9_519,1.0)).xy);
}
float2 l9_522=l9_519;
float2 l9_523=l9_522;
float2 l9_524=l9_523;
param_73=l9_524;
float l9_525=param_73.x;
int l9_526=param_76.x;
bool l9_527=l9_489;
float l9_528=l9_490;
if ((l9_526==0)||(l9_526==3))
{
float l9_529=l9_525;
float l9_530=0.0;
float l9_531=1.0;
bool l9_532=l9_527;
float l9_533=l9_528;
float l9_534=fast::clamp(l9_529,l9_530,l9_531);
float l9_535=step(abs(l9_529-l9_534),9.9999997e-06);
l9_533*=(l9_535+((1.0-float(l9_532))*(1.0-l9_535)));
l9_529=l9_534;
l9_525=l9_529;
l9_528=l9_533;
}
param_73.x=l9_525;
l9_490=l9_528;
float l9_536=param_73.y;
int l9_537=param_76.y;
bool l9_538=l9_489;
float l9_539=l9_490;
if ((l9_537==0)||(l9_537==3))
{
float l9_540=l9_536;
float l9_541=0.0;
float l9_542=1.0;
bool l9_543=l9_538;
float l9_544=l9_539;
float l9_545=fast::clamp(l9_540,l9_541,l9_542);
float l9_546=step(abs(l9_540-l9_545),9.9999997e-06);
l9_544*=(l9_546+((1.0-float(l9_543))*(1.0-l9_546)));
l9_540=l9_545;
l9_536=l9_540;
l9_539=l9_544;
}
param_73.y=l9_536;
l9_490=l9_539;
float2 l9_547=param_73;
int l9_548=param_71;
int l9_549=param_72;
float l9_550=param_81;
float2 l9_551=l9_547;
int l9_552=l9_548;
int l9_553=l9_549;
float3 l9_554=float3(0.0);
if (l9_552==0)
{
l9_554=float3(l9_551,0.0);
}
else
{
if (l9_552==1)
{
l9_554=float3(l9_551.x,(l9_551.y*0.5)+(0.5-(float(l9_553)*0.5)),0.0);
}
else
{
l9_554=float3(l9_551,float(l9_553));
}
}
float3 l9_555=l9_554;
float3 l9_556=l9_555;
float2 l9_557=l9_556.xy;
float l9_558=l9_550;
float4 l9_559=renderTarget1.sample(renderTarget1SmpSC,l9_557,level(l9_558));
float4 l9_560=l9_559;
float4 l9_561=l9_560;
if (param_79)
{
l9_561=mix(param_80,l9_561,float4(l9_490));
}
float4 l9_562=l9_561;
float4 renderTarget1Sample_1=l9_562;
Scalar4=renderTarget1Sample_1.x;
Scalar5=renderTarget1Sample_1.y;
Scalar6=renderTarget1Sample_1.z;
Scalar7=renderTarget1Sample_1.w;
int l9_563=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_564=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_564=0;
}
else
{
l9_564=gl_InstanceIndex%2;
}
int l9_565=l9_564;
l9_563=1-l9_565;
}
else
{
int l9_566=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_566=0;
}
else
{
l9_566=gl_InstanceIndex%2;
}
int l9_567=l9_566;
l9_563=l9_567;
}
int l9_568=l9_563;
int param_82=renderTarget2Layout_tmp;
int param_83=l9_568;
float2 param_84=uv;
bool param_85=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_86=UserUniforms.renderTarget2Transform;
int2 param_87=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_88=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_89=UserUniforms.renderTarget2UvMinMax;
bool param_90=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_91=UserUniforms.renderTarget2BorderColor;
float param_92=0.0;
bool l9_569=param_90&&(!param_88);
float l9_570=1.0;
float l9_571=param_84.x;
int l9_572=param_87.x;
if (l9_572==1)
{
l9_571=fract(l9_571);
}
else
{
if (l9_572==2)
{
float l9_573=fract(l9_571);
float l9_574=l9_571-l9_573;
float l9_575=step(0.25,fract(l9_574*0.5));
l9_571=mix(l9_573,1.0-l9_573,fast::clamp(l9_575,0.0,1.0));
}
}
param_84.x=l9_571;
float l9_576=param_84.y;
int l9_577=param_87.y;
if (l9_577==1)
{
l9_576=fract(l9_576);
}
else
{
if (l9_577==2)
{
float l9_578=fract(l9_576);
float l9_579=l9_576-l9_578;
float l9_580=step(0.25,fract(l9_579*0.5));
l9_576=mix(l9_578,1.0-l9_578,fast::clamp(l9_580,0.0,1.0));
}
}
param_84.y=l9_576;
if (param_88)
{
bool l9_581=param_90;
bool l9_582;
if (l9_581)
{
l9_582=param_87.x==3;
}
else
{
l9_582=l9_581;
}
float l9_583=param_84.x;
float l9_584=param_89.x;
float l9_585=param_89.z;
bool l9_586=l9_582;
float l9_587=l9_570;
float l9_588=fast::clamp(l9_583,l9_584,l9_585);
float l9_589=step(abs(l9_583-l9_588),9.9999997e-06);
l9_587*=(l9_589+((1.0-float(l9_586))*(1.0-l9_589)));
l9_583=l9_588;
param_84.x=l9_583;
l9_570=l9_587;
bool l9_590=param_90;
bool l9_591;
if (l9_590)
{
l9_591=param_87.y==3;
}
else
{
l9_591=l9_590;
}
float l9_592=param_84.y;
float l9_593=param_89.y;
float l9_594=param_89.w;
bool l9_595=l9_591;
float l9_596=l9_570;
float l9_597=fast::clamp(l9_592,l9_593,l9_594);
float l9_598=step(abs(l9_592-l9_597),9.9999997e-06);
l9_596*=(l9_598+((1.0-float(l9_595))*(1.0-l9_598)));
l9_592=l9_597;
param_84.y=l9_592;
l9_570=l9_596;
}
float2 l9_599=param_84;
bool l9_600=param_85;
float3x3 l9_601=param_86;
if (l9_600)
{
l9_599=float2((l9_601*float3(l9_599,1.0)).xy);
}
float2 l9_602=l9_599;
float2 l9_603=l9_602;
float2 l9_604=l9_603;
param_84=l9_604;
float l9_605=param_84.x;
int l9_606=param_87.x;
bool l9_607=l9_569;
float l9_608=l9_570;
if ((l9_606==0)||(l9_606==3))
{
float l9_609=l9_605;
float l9_610=0.0;
float l9_611=1.0;
bool l9_612=l9_607;
float l9_613=l9_608;
float l9_614=fast::clamp(l9_609,l9_610,l9_611);
float l9_615=step(abs(l9_609-l9_614),9.9999997e-06);
l9_613*=(l9_615+((1.0-float(l9_612))*(1.0-l9_615)));
l9_609=l9_614;
l9_605=l9_609;
l9_608=l9_613;
}
param_84.x=l9_605;
l9_570=l9_608;
float l9_616=param_84.y;
int l9_617=param_87.y;
bool l9_618=l9_569;
float l9_619=l9_570;
if ((l9_617==0)||(l9_617==3))
{
float l9_620=l9_616;
float l9_621=0.0;
float l9_622=1.0;
bool l9_623=l9_618;
float l9_624=l9_619;
float l9_625=fast::clamp(l9_620,l9_621,l9_622);
float l9_626=step(abs(l9_620-l9_625),9.9999997e-06);
l9_624*=(l9_626+((1.0-float(l9_623))*(1.0-l9_626)));
l9_620=l9_625;
l9_616=l9_620;
l9_619=l9_624;
}
param_84.y=l9_616;
l9_570=l9_619;
float2 l9_627=param_84;
int l9_628=param_82;
int l9_629=param_83;
float l9_630=param_92;
float2 l9_631=l9_627;
int l9_632=l9_628;
int l9_633=l9_629;
float3 l9_634=float3(0.0);
if (l9_632==0)
{
l9_634=float3(l9_631,0.0);
}
else
{
if (l9_632==1)
{
l9_634=float3(l9_631.x,(l9_631.y*0.5)+(0.5-(float(l9_633)*0.5)),0.0);
}
else
{
l9_634=float3(l9_631,float(l9_633));
}
}
float3 l9_635=l9_634;
float3 l9_636=l9_635;
float2 l9_637=l9_636.xy;
float l9_638=l9_630;
float4 l9_639=renderTarget2.sample(renderTarget2SmpSC,l9_637,level(l9_638));
float4 l9_640=l9_639;
float4 l9_641=l9_640;
if (param_90)
{
l9_641=mix(param_91,l9_641,float4(l9_570));
}
float4 l9_642=l9_641;
float4 renderTarget2Sample_1=l9_642;
Scalar8=renderTarget2Sample_1.x;
Scalar9=renderTarget2Sample_1.y;
Scalar10=renderTarget2Sample_1.z;
Scalar11=renderTarget2Sample_1.w;
int l9_643=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_644=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_644=0;
}
else
{
l9_644=gl_InstanceIndex%2;
}
int l9_645=l9_644;
l9_643=1-l9_645;
}
else
{
int l9_646=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_646=0;
}
else
{
l9_646=gl_InstanceIndex%2;
}
int l9_647=l9_646;
l9_643=l9_647;
}
int l9_648=l9_643;
int param_93=renderTarget3Layout_tmp;
int param_94=l9_648;
float2 param_95=uv;
bool param_96=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_97=UserUniforms.renderTarget3Transform;
int2 param_98=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_99=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_100=UserUniforms.renderTarget3UvMinMax;
bool param_101=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_102=UserUniforms.renderTarget3BorderColor;
float param_103=0.0;
bool l9_649=param_101&&(!param_99);
float l9_650=1.0;
float l9_651=param_95.x;
int l9_652=param_98.x;
if (l9_652==1)
{
l9_651=fract(l9_651);
}
else
{
if (l9_652==2)
{
float l9_653=fract(l9_651);
float l9_654=l9_651-l9_653;
float l9_655=step(0.25,fract(l9_654*0.5));
l9_651=mix(l9_653,1.0-l9_653,fast::clamp(l9_655,0.0,1.0));
}
}
param_95.x=l9_651;
float l9_656=param_95.y;
int l9_657=param_98.y;
if (l9_657==1)
{
l9_656=fract(l9_656);
}
else
{
if (l9_657==2)
{
float l9_658=fract(l9_656);
float l9_659=l9_656-l9_658;
float l9_660=step(0.25,fract(l9_659*0.5));
l9_656=mix(l9_658,1.0-l9_658,fast::clamp(l9_660,0.0,1.0));
}
}
param_95.y=l9_656;
if (param_99)
{
bool l9_661=param_101;
bool l9_662;
if (l9_661)
{
l9_662=param_98.x==3;
}
else
{
l9_662=l9_661;
}
float l9_663=param_95.x;
float l9_664=param_100.x;
float l9_665=param_100.z;
bool l9_666=l9_662;
float l9_667=l9_650;
float l9_668=fast::clamp(l9_663,l9_664,l9_665);
float l9_669=step(abs(l9_663-l9_668),9.9999997e-06);
l9_667*=(l9_669+((1.0-float(l9_666))*(1.0-l9_669)));
l9_663=l9_668;
param_95.x=l9_663;
l9_650=l9_667;
bool l9_670=param_101;
bool l9_671;
if (l9_670)
{
l9_671=param_98.y==3;
}
else
{
l9_671=l9_670;
}
float l9_672=param_95.y;
float l9_673=param_100.y;
float l9_674=param_100.w;
bool l9_675=l9_671;
float l9_676=l9_650;
float l9_677=fast::clamp(l9_672,l9_673,l9_674);
float l9_678=step(abs(l9_672-l9_677),9.9999997e-06);
l9_676*=(l9_678+((1.0-float(l9_675))*(1.0-l9_678)));
l9_672=l9_677;
param_95.y=l9_672;
l9_650=l9_676;
}
float2 l9_679=param_95;
bool l9_680=param_96;
float3x3 l9_681=param_97;
if (l9_680)
{
l9_679=float2((l9_681*float3(l9_679,1.0)).xy);
}
float2 l9_682=l9_679;
float2 l9_683=l9_682;
float2 l9_684=l9_683;
param_95=l9_684;
float l9_685=param_95.x;
int l9_686=param_98.x;
bool l9_687=l9_649;
float l9_688=l9_650;
if ((l9_686==0)||(l9_686==3))
{
float l9_689=l9_685;
float l9_690=0.0;
float l9_691=1.0;
bool l9_692=l9_687;
float l9_693=l9_688;
float l9_694=fast::clamp(l9_689,l9_690,l9_691);
float l9_695=step(abs(l9_689-l9_694),9.9999997e-06);
l9_693*=(l9_695+((1.0-float(l9_692))*(1.0-l9_695)));
l9_689=l9_694;
l9_685=l9_689;
l9_688=l9_693;
}
param_95.x=l9_685;
l9_650=l9_688;
float l9_696=param_95.y;
int l9_697=param_98.y;
bool l9_698=l9_649;
float l9_699=l9_650;
if ((l9_697==0)||(l9_697==3))
{
float l9_700=l9_696;
float l9_701=0.0;
float l9_702=1.0;
bool l9_703=l9_698;
float l9_704=l9_699;
float l9_705=fast::clamp(l9_700,l9_701,l9_702);
float l9_706=step(abs(l9_700-l9_705),9.9999997e-06);
l9_704*=(l9_706+((1.0-float(l9_703))*(1.0-l9_706)));
l9_700=l9_705;
l9_696=l9_700;
l9_699=l9_704;
}
param_95.y=l9_696;
l9_650=l9_699;
float2 l9_707=param_95;
int l9_708=param_93;
int l9_709=param_94;
float l9_710=param_103;
float2 l9_711=l9_707;
int l9_712=l9_708;
int l9_713=l9_709;
float3 l9_714=float3(0.0);
if (l9_712==0)
{
l9_714=float3(l9_711,0.0);
}
else
{
if (l9_712==1)
{
l9_714=float3(l9_711.x,(l9_711.y*0.5)+(0.5-(float(l9_713)*0.5)),0.0);
}
else
{
l9_714=float3(l9_711,float(l9_713));
}
}
float3 l9_715=l9_714;
float3 l9_716=l9_715;
float2 l9_717=l9_716.xy;
float l9_718=l9_710;
float4 l9_719=renderTarget3.sample(renderTarget3SmpSC,l9_717,level(l9_718));
float4 l9_720=l9_719;
float4 l9_721=l9_720;
if (param_101)
{
l9_721=mix(param_102,l9_721,float4(l9_650));
}
float4 l9_722=l9_721;
float4 renderTarget3Sample_1=l9_722;
Scalar12=renderTarget3Sample_1.x;
Scalar13=renderTarget3Sample_1.y;
Scalar14=renderTarget3Sample_1.z;
Scalar15=renderTarget3Sample_1.w;
float4 param_104=float4(Scalar0,Scalar1,Scalar2,Scalar3);
float param_105=-1000.0;
float param_106=1000.0;
float4 l9_723=param_104;
float l9_724=param_105;
float l9_725=param_106;
float l9_726=0.99998999;
float4 l9_727=l9_723;
#if (1)
{
l9_727=floor((l9_727*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_728=dot(l9_727,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_729=l9_728;
float l9_730=0.0;
float l9_731=l9_726;
float l9_732=l9_724;
float l9_733=l9_725;
float l9_734=l9_732+(((l9_729-l9_730)*(l9_733-l9_732))/(l9_731-l9_730));
float l9_735=l9_734;
float l9_736=l9_735;
gParticle.Velocity.y=l9_736;
float4 param_107=float4(Scalar4,Scalar5,Scalar6,Scalar7);
float param_108=-1000.0;
float param_109=1000.0;
float4 l9_737=param_107;
float l9_738=param_108;
float l9_739=param_109;
float l9_740=0.99998999;
float4 l9_741=l9_737;
#if (1)
{
l9_741=floor((l9_741*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_742=dot(l9_741,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_743=l9_742;
float l9_744=0.0;
float l9_745=l9_740;
float l9_746=l9_738;
float l9_747=l9_739;
float l9_748=l9_746+(((l9_743-l9_744)*(l9_747-l9_746))/(l9_745-l9_744));
float l9_749=l9_748;
float l9_750=l9_749;
gParticle.Velocity.z=l9_750;
float4 param_110=float4(Scalar8,Scalar9,Scalar10,Scalar11);
float param_111=0.0;
float param_112=0.2;
float4 l9_751=param_110;
float l9_752=param_111;
float l9_753=param_112;
float l9_754=0.99998999;
float4 l9_755=l9_751;
#if (1)
{
l9_755=floor((l9_755*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_756=dot(l9_755,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_757=l9_756;
float l9_758=0.0;
float l9_759=l9_754;
float l9_760=l9_752;
float l9_761=l9_753;
float l9_762=l9_760+(((l9_757-l9_758)*(l9_761-l9_760))/(l9_759-l9_758));
float l9_763=l9_762;
float l9_764=l9_763;
gParticle.Life=l9_764;
float4 param_113=float4(Scalar12,Scalar13,Scalar14,Scalar15);
float param_114=0.0;
float param_115=0.2;
float4 l9_765=param_113;
float l9_766=param_114;
float l9_767=param_115;
float l9_768=0.99998999;
float4 l9_769=l9_765;
#if (1)
{
l9_769=floor((l9_769*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_770=dot(l9_769,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_771=l9_770;
float l9_772=0.0;
float l9_773=l9_768;
float l9_774=l9_766;
float l9_775=l9_767;
float l9_776=l9_774+(((l9_771-l9_772)*(l9_775-l9_774))/(l9_773-l9_772));
float l9_777=l9_776;
float l9_778=l9_777;
gParticle.Age=l9_778;
uv=Coord+(Offset*2.0);
int l9_779=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_780=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_780=0;
}
else
{
l9_780=gl_InstanceIndex%2;
}
int l9_781=l9_780;
l9_779=1-l9_781;
}
else
{
int l9_782=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_782=0;
}
else
{
l9_782=gl_InstanceIndex%2;
}
int l9_783=l9_782;
l9_779=l9_783;
}
int l9_784=l9_779;
int param_116=renderTarget0Layout_tmp;
int param_117=l9_784;
float2 param_118=uv;
bool param_119=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_120=UserUniforms.renderTarget0Transform;
int2 param_121=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_122=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_123=UserUniforms.renderTarget0UvMinMax;
bool param_124=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_125=UserUniforms.renderTarget0BorderColor;
float param_126=0.0;
bool l9_785=param_124&&(!param_122);
float l9_786=1.0;
float l9_787=param_118.x;
int l9_788=param_121.x;
if (l9_788==1)
{
l9_787=fract(l9_787);
}
else
{
if (l9_788==2)
{
float l9_789=fract(l9_787);
float l9_790=l9_787-l9_789;
float l9_791=step(0.25,fract(l9_790*0.5));
l9_787=mix(l9_789,1.0-l9_789,fast::clamp(l9_791,0.0,1.0));
}
}
param_118.x=l9_787;
float l9_792=param_118.y;
int l9_793=param_121.y;
if (l9_793==1)
{
l9_792=fract(l9_792);
}
else
{
if (l9_793==2)
{
float l9_794=fract(l9_792);
float l9_795=l9_792-l9_794;
float l9_796=step(0.25,fract(l9_795*0.5));
l9_792=mix(l9_794,1.0-l9_794,fast::clamp(l9_796,0.0,1.0));
}
}
param_118.y=l9_792;
if (param_122)
{
bool l9_797=param_124;
bool l9_798;
if (l9_797)
{
l9_798=param_121.x==3;
}
else
{
l9_798=l9_797;
}
float l9_799=param_118.x;
float l9_800=param_123.x;
float l9_801=param_123.z;
bool l9_802=l9_798;
float l9_803=l9_786;
float l9_804=fast::clamp(l9_799,l9_800,l9_801);
float l9_805=step(abs(l9_799-l9_804),9.9999997e-06);
l9_803*=(l9_805+((1.0-float(l9_802))*(1.0-l9_805)));
l9_799=l9_804;
param_118.x=l9_799;
l9_786=l9_803;
bool l9_806=param_124;
bool l9_807;
if (l9_806)
{
l9_807=param_121.y==3;
}
else
{
l9_807=l9_806;
}
float l9_808=param_118.y;
float l9_809=param_123.y;
float l9_810=param_123.w;
bool l9_811=l9_807;
float l9_812=l9_786;
float l9_813=fast::clamp(l9_808,l9_809,l9_810);
float l9_814=step(abs(l9_808-l9_813),9.9999997e-06);
l9_812*=(l9_814+((1.0-float(l9_811))*(1.0-l9_814)));
l9_808=l9_813;
param_118.y=l9_808;
l9_786=l9_812;
}
float2 l9_815=param_118;
bool l9_816=param_119;
float3x3 l9_817=param_120;
if (l9_816)
{
l9_815=float2((l9_817*float3(l9_815,1.0)).xy);
}
float2 l9_818=l9_815;
float2 l9_819=l9_818;
float2 l9_820=l9_819;
param_118=l9_820;
float l9_821=param_118.x;
int l9_822=param_121.x;
bool l9_823=l9_785;
float l9_824=l9_786;
if ((l9_822==0)||(l9_822==3))
{
float l9_825=l9_821;
float l9_826=0.0;
float l9_827=1.0;
bool l9_828=l9_823;
float l9_829=l9_824;
float l9_830=fast::clamp(l9_825,l9_826,l9_827);
float l9_831=step(abs(l9_825-l9_830),9.9999997e-06);
l9_829*=(l9_831+((1.0-float(l9_828))*(1.0-l9_831)));
l9_825=l9_830;
l9_821=l9_825;
l9_824=l9_829;
}
param_118.x=l9_821;
l9_786=l9_824;
float l9_832=param_118.y;
int l9_833=param_121.y;
bool l9_834=l9_785;
float l9_835=l9_786;
if ((l9_833==0)||(l9_833==3))
{
float l9_836=l9_832;
float l9_837=0.0;
float l9_838=1.0;
bool l9_839=l9_834;
float l9_840=l9_835;
float l9_841=fast::clamp(l9_836,l9_837,l9_838);
float l9_842=step(abs(l9_836-l9_841),9.9999997e-06);
l9_840*=(l9_842+((1.0-float(l9_839))*(1.0-l9_842)));
l9_836=l9_841;
l9_832=l9_836;
l9_835=l9_840;
}
param_118.y=l9_832;
l9_786=l9_835;
float2 l9_843=param_118;
int l9_844=param_116;
int l9_845=param_117;
float l9_846=param_126;
float2 l9_847=l9_843;
int l9_848=l9_844;
int l9_849=l9_845;
float3 l9_850=float3(0.0);
if (l9_848==0)
{
l9_850=float3(l9_847,0.0);
}
else
{
if (l9_848==1)
{
l9_850=float3(l9_847.x,(l9_847.y*0.5)+(0.5-(float(l9_849)*0.5)),0.0);
}
else
{
l9_850=float3(l9_847,float(l9_849));
}
}
float3 l9_851=l9_850;
float3 l9_852=l9_851;
float2 l9_853=l9_852.xy;
float l9_854=l9_846;
float4 l9_855=renderTarget0.sample(renderTarget0SmpSC,l9_853,level(l9_854));
float4 l9_856=l9_855;
float4 l9_857=l9_856;
if (param_124)
{
l9_857=mix(param_125,l9_857,float4(l9_786));
}
float4 l9_858=l9_857;
float4 renderTarget0Sample_2=l9_858;
Scalar0=renderTarget0Sample_2.x;
Scalar1=renderTarget0Sample_2.y;
Scalar2=renderTarget0Sample_2.z;
Scalar3=renderTarget0Sample_2.w;
int l9_859=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_860=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_860=0;
}
else
{
l9_860=gl_InstanceIndex%2;
}
int l9_861=l9_860;
l9_859=1-l9_861;
}
else
{
int l9_862=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_862=0;
}
else
{
l9_862=gl_InstanceIndex%2;
}
int l9_863=l9_862;
l9_859=l9_863;
}
int l9_864=l9_859;
int param_127=renderTarget1Layout_tmp;
int param_128=l9_864;
float2 param_129=uv;
bool param_130=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_131=UserUniforms.renderTarget1Transform;
int2 param_132=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_133=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_134=UserUniforms.renderTarget1UvMinMax;
bool param_135=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_136=UserUniforms.renderTarget1BorderColor;
float param_137=0.0;
bool l9_865=param_135&&(!param_133);
float l9_866=1.0;
float l9_867=param_129.x;
int l9_868=param_132.x;
if (l9_868==1)
{
l9_867=fract(l9_867);
}
else
{
if (l9_868==2)
{
float l9_869=fract(l9_867);
float l9_870=l9_867-l9_869;
float l9_871=step(0.25,fract(l9_870*0.5));
l9_867=mix(l9_869,1.0-l9_869,fast::clamp(l9_871,0.0,1.0));
}
}
param_129.x=l9_867;
float l9_872=param_129.y;
int l9_873=param_132.y;
if (l9_873==1)
{
l9_872=fract(l9_872);
}
else
{
if (l9_873==2)
{
float l9_874=fract(l9_872);
float l9_875=l9_872-l9_874;
float l9_876=step(0.25,fract(l9_875*0.5));
l9_872=mix(l9_874,1.0-l9_874,fast::clamp(l9_876,0.0,1.0));
}
}
param_129.y=l9_872;
if (param_133)
{
bool l9_877=param_135;
bool l9_878;
if (l9_877)
{
l9_878=param_132.x==3;
}
else
{
l9_878=l9_877;
}
float l9_879=param_129.x;
float l9_880=param_134.x;
float l9_881=param_134.z;
bool l9_882=l9_878;
float l9_883=l9_866;
float l9_884=fast::clamp(l9_879,l9_880,l9_881);
float l9_885=step(abs(l9_879-l9_884),9.9999997e-06);
l9_883*=(l9_885+((1.0-float(l9_882))*(1.0-l9_885)));
l9_879=l9_884;
param_129.x=l9_879;
l9_866=l9_883;
bool l9_886=param_135;
bool l9_887;
if (l9_886)
{
l9_887=param_132.y==3;
}
else
{
l9_887=l9_886;
}
float l9_888=param_129.y;
float l9_889=param_134.y;
float l9_890=param_134.w;
bool l9_891=l9_887;
float l9_892=l9_866;
float l9_893=fast::clamp(l9_888,l9_889,l9_890);
float l9_894=step(abs(l9_888-l9_893),9.9999997e-06);
l9_892*=(l9_894+((1.0-float(l9_891))*(1.0-l9_894)));
l9_888=l9_893;
param_129.y=l9_888;
l9_866=l9_892;
}
float2 l9_895=param_129;
bool l9_896=param_130;
float3x3 l9_897=param_131;
if (l9_896)
{
l9_895=float2((l9_897*float3(l9_895,1.0)).xy);
}
float2 l9_898=l9_895;
float2 l9_899=l9_898;
float2 l9_900=l9_899;
param_129=l9_900;
float l9_901=param_129.x;
int l9_902=param_132.x;
bool l9_903=l9_865;
float l9_904=l9_866;
if ((l9_902==0)||(l9_902==3))
{
float l9_905=l9_901;
float l9_906=0.0;
float l9_907=1.0;
bool l9_908=l9_903;
float l9_909=l9_904;
float l9_910=fast::clamp(l9_905,l9_906,l9_907);
float l9_911=step(abs(l9_905-l9_910),9.9999997e-06);
l9_909*=(l9_911+((1.0-float(l9_908))*(1.0-l9_911)));
l9_905=l9_910;
l9_901=l9_905;
l9_904=l9_909;
}
param_129.x=l9_901;
l9_866=l9_904;
float l9_912=param_129.y;
int l9_913=param_132.y;
bool l9_914=l9_865;
float l9_915=l9_866;
if ((l9_913==0)||(l9_913==3))
{
float l9_916=l9_912;
float l9_917=0.0;
float l9_918=1.0;
bool l9_919=l9_914;
float l9_920=l9_915;
float l9_921=fast::clamp(l9_916,l9_917,l9_918);
float l9_922=step(abs(l9_916-l9_921),9.9999997e-06);
l9_920*=(l9_922+((1.0-float(l9_919))*(1.0-l9_922)));
l9_916=l9_921;
l9_912=l9_916;
l9_915=l9_920;
}
param_129.y=l9_912;
l9_866=l9_915;
float2 l9_923=param_129;
int l9_924=param_127;
int l9_925=param_128;
float l9_926=param_137;
float2 l9_927=l9_923;
int l9_928=l9_924;
int l9_929=l9_925;
float3 l9_930=float3(0.0);
if (l9_928==0)
{
l9_930=float3(l9_927,0.0);
}
else
{
if (l9_928==1)
{
l9_930=float3(l9_927.x,(l9_927.y*0.5)+(0.5-(float(l9_929)*0.5)),0.0);
}
else
{
l9_930=float3(l9_927,float(l9_929));
}
}
float3 l9_931=l9_930;
float3 l9_932=l9_931;
float2 l9_933=l9_932.xy;
float l9_934=l9_926;
float4 l9_935=renderTarget1.sample(renderTarget1SmpSC,l9_933,level(l9_934));
float4 l9_936=l9_935;
float4 l9_937=l9_936;
if (param_135)
{
l9_937=mix(param_136,l9_937,float4(l9_866));
}
float4 l9_938=l9_937;
float4 renderTarget1Sample_2=l9_938;
Scalar4=renderTarget1Sample_2.x;
Scalar5=renderTarget1Sample_2.y;
Scalar6=renderTarget1Sample_2.z;
Scalar7=renderTarget1Sample_2.w;
int l9_939=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_940=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_940=0;
}
else
{
l9_940=gl_InstanceIndex%2;
}
int l9_941=l9_940;
l9_939=1-l9_941;
}
else
{
int l9_942=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_942=0;
}
else
{
l9_942=gl_InstanceIndex%2;
}
int l9_943=l9_942;
l9_939=l9_943;
}
int l9_944=l9_939;
int param_138=renderTarget2Layout_tmp;
int param_139=l9_944;
float2 param_140=uv;
bool param_141=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_142=UserUniforms.renderTarget2Transform;
int2 param_143=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_144=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_145=UserUniforms.renderTarget2UvMinMax;
bool param_146=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_147=UserUniforms.renderTarget2BorderColor;
float param_148=0.0;
bool l9_945=param_146&&(!param_144);
float l9_946=1.0;
float l9_947=param_140.x;
int l9_948=param_143.x;
if (l9_948==1)
{
l9_947=fract(l9_947);
}
else
{
if (l9_948==2)
{
float l9_949=fract(l9_947);
float l9_950=l9_947-l9_949;
float l9_951=step(0.25,fract(l9_950*0.5));
l9_947=mix(l9_949,1.0-l9_949,fast::clamp(l9_951,0.0,1.0));
}
}
param_140.x=l9_947;
float l9_952=param_140.y;
int l9_953=param_143.y;
if (l9_953==1)
{
l9_952=fract(l9_952);
}
else
{
if (l9_953==2)
{
float l9_954=fract(l9_952);
float l9_955=l9_952-l9_954;
float l9_956=step(0.25,fract(l9_955*0.5));
l9_952=mix(l9_954,1.0-l9_954,fast::clamp(l9_956,0.0,1.0));
}
}
param_140.y=l9_952;
if (param_144)
{
bool l9_957=param_146;
bool l9_958;
if (l9_957)
{
l9_958=param_143.x==3;
}
else
{
l9_958=l9_957;
}
float l9_959=param_140.x;
float l9_960=param_145.x;
float l9_961=param_145.z;
bool l9_962=l9_958;
float l9_963=l9_946;
float l9_964=fast::clamp(l9_959,l9_960,l9_961);
float l9_965=step(abs(l9_959-l9_964),9.9999997e-06);
l9_963*=(l9_965+((1.0-float(l9_962))*(1.0-l9_965)));
l9_959=l9_964;
param_140.x=l9_959;
l9_946=l9_963;
bool l9_966=param_146;
bool l9_967;
if (l9_966)
{
l9_967=param_143.y==3;
}
else
{
l9_967=l9_966;
}
float l9_968=param_140.y;
float l9_969=param_145.y;
float l9_970=param_145.w;
bool l9_971=l9_967;
float l9_972=l9_946;
float l9_973=fast::clamp(l9_968,l9_969,l9_970);
float l9_974=step(abs(l9_968-l9_973),9.9999997e-06);
l9_972*=(l9_974+((1.0-float(l9_971))*(1.0-l9_974)));
l9_968=l9_973;
param_140.y=l9_968;
l9_946=l9_972;
}
float2 l9_975=param_140;
bool l9_976=param_141;
float3x3 l9_977=param_142;
if (l9_976)
{
l9_975=float2((l9_977*float3(l9_975,1.0)).xy);
}
float2 l9_978=l9_975;
float2 l9_979=l9_978;
float2 l9_980=l9_979;
param_140=l9_980;
float l9_981=param_140.x;
int l9_982=param_143.x;
bool l9_983=l9_945;
float l9_984=l9_946;
if ((l9_982==0)||(l9_982==3))
{
float l9_985=l9_981;
float l9_986=0.0;
float l9_987=1.0;
bool l9_988=l9_983;
float l9_989=l9_984;
float l9_990=fast::clamp(l9_985,l9_986,l9_987);
float l9_991=step(abs(l9_985-l9_990),9.9999997e-06);
l9_989*=(l9_991+((1.0-float(l9_988))*(1.0-l9_991)));
l9_985=l9_990;
l9_981=l9_985;
l9_984=l9_989;
}
param_140.x=l9_981;
l9_946=l9_984;
float l9_992=param_140.y;
int l9_993=param_143.y;
bool l9_994=l9_945;
float l9_995=l9_946;
if ((l9_993==0)||(l9_993==3))
{
float l9_996=l9_992;
float l9_997=0.0;
float l9_998=1.0;
bool l9_999=l9_994;
float l9_1000=l9_995;
float l9_1001=fast::clamp(l9_996,l9_997,l9_998);
float l9_1002=step(abs(l9_996-l9_1001),9.9999997e-06);
l9_1000*=(l9_1002+((1.0-float(l9_999))*(1.0-l9_1002)));
l9_996=l9_1001;
l9_992=l9_996;
l9_995=l9_1000;
}
param_140.y=l9_992;
l9_946=l9_995;
float2 l9_1003=param_140;
int l9_1004=param_138;
int l9_1005=param_139;
float l9_1006=param_148;
float2 l9_1007=l9_1003;
int l9_1008=l9_1004;
int l9_1009=l9_1005;
float3 l9_1010=float3(0.0);
if (l9_1008==0)
{
l9_1010=float3(l9_1007,0.0);
}
else
{
if (l9_1008==1)
{
l9_1010=float3(l9_1007.x,(l9_1007.y*0.5)+(0.5-(float(l9_1009)*0.5)),0.0);
}
else
{
l9_1010=float3(l9_1007,float(l9_1009));
}
}
float3 l9_1011=l9_1010;
float3 l9_1012=l9_1011;
float2 l9_1013=l9_1012.xy;
float l9_1014=l9_1006;
float4 l9_1015=renderTarget2.sample(renderTarget2SmpSC,l9_1013,level(l9_1014));
float4 l9_1016=l9_1015;
float4 l9_1017=l9_1016;
if (param_146)
{
l9_1017=mix(param_147,l9_1017,float4(l9_946));
}
float4 l9_1018=l9_1017;
float4 renderTarget2Sample_2=l9_1018;
Scalar8=renderTarget2Sample_2.x;
Scalar9=renderTarget2Sample_2.y;
Scalar10=renderTarget2Sample_2.z;
Scalar11=renderTarget2Sample_2.w;
int l9_1019=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_1020=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1020=0;
}
else
{
l9_1020=gl_InstanceIndex%2;
}
int l9_1021=l9_1020;
l9_1019=1-l9_1021;
}
else
{
int l9_1022=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1022=0;
}
else
{
l9_1022=gl_InstanceIndex%2;
}
int l9_1023=l9_1022;
l9_1019=l9_1023;
}
int l9_1024=l9_1019;
int param_149=renderTarget3Layout_tmp;
int param_150=l9_1024;
float2 param_151=uv;
bool param_152=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_153=UserUniforms.renderTarget3Transform;
int2 param_154=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_155=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_156=UserUniforms.renderTarget3UvMinMax;
bool param_157=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_158=UserUniforms.renderTarget3BorderColor;
float param_159=0.0;
bool l9_1025=param_157&&(!param_155);
float l9_1026=1.0;
float l9_1027=param_151.x;
int l9_1028=param_154.x;
if (l9_1028==1)
{
l9_1027=fract(l9_1027);
}
else
{
if (l9_1028==2)
{
float l9_1029=fract(l9_1027);
float l9_1030=l9_1027-l9_1029;
float l9_1031=step(0.25,fract(l9_1030*0.5));
l9_1027=mix(l9_1029,1.0-l9_1029,fast::clamp(l9_1031,0.0,1.0));
}
}
param_151.x=l9_1027;
float l9_1032=param_151.y;
int l9_1033=param_154.y;
if (l9_1033==1)
{
l9_1032=fract(l9_1032);
}
else
{
if (l9_1033==2)
{
float l9_1034=fract(l9_1032);
float l9_1035=l9_1032-l9_1034;
float l9_1036=step(0.25,fract(l9_1035*0.5));
l9_1032=mix(l9_1034,1.0-l9_1034,fast::clamp(l9_1036,0.0,1.0));
}
}
param_151.y=l9_1032;
if (param_155)
{
bool l9_1037=param_157;
bool l9_1038;
if (l9_1037)
{
l9_1038=param_154.x==3;
}
else
{
l9_1038=l9_1037;
}
float l9_1039=param_151.x;
float l9_1040=param_156.x;
float l9_1041=param_156.z;
bool l9_1042=l9_1038;
float l9_1043=l9_1026;
float l9_1044=fast::clamp(l9_1039,l9_1040,l9_1041);
float l9_1045=step(abs(l9_1039-l9_1044),9.9999997e-06);
l9_1043*=(l9_1045+((1.0-float(l9_1042))*(1.0-l9_1045)));
l9_1039=l9_1044;
param_151.x=l9_1039;
l9_1026=l9_1043;
bool l9_1046=param_157;
bool l9_1047;
if (l9_1046)
{
l9_1047=param_154.y==3;
}
else
{
l9_1047=l9_1046;
}
float l9_1048=param_151.y;
float l9_1049=param_156.y;
float l9_1050=param_156.w;
bool l9_1051=l9_1047;
float l9_1052=l9_1026;
float l9_1053=fast::clamp(l9_1048,l9_1049,l9_1050);
float l9_1054=step(abs(l9_1048-l9_1053),9.9999997e-06);
l9_1052*=(l9_1054+((1.0-float(l9_1051))*(1.0-l9_1054)));
l9_1048=l9_1053;
param_151.y=l9_1048;
l9_1026=l9_1052;
}
float2 l9_1055=param_151;
bool l9_1056=param_152;
float3x3 l9_1057=param_153;
if (l9_1056)
{
l9_1055=float2((l9_1057*float3(l9_1055,1.0)).xy);
}
float2 l9_1058=l9_1055;
float2 l9_1059=l9_1058;
float2 l9_1060=l9_1059;
param_151=l9_1060;
float l9_1061=param_151.x;
int l9_1062=param_154.x;
bool l9_1063=l9_1025;
float l9_1064=l9_1026;
if ((l9_1062==0)||(l9_1062==3))
{
float l9_1065=l9_1061;
float l9_1066=0.0;
float l9_1067=1.0;
bool l9_1068=l9_1063;
float l9_1069=l9_1064;
float l9_1070=fast::clamp(l9_1065,l9_1066,l9_1067);
float l9_1071=step(abs(l9_1065-l9_1070),9.9999997e-06);
l9_1069*=(l9_1071+((1.0-float(l9_1068))*(1.0-l9_1071)));
l9_1065=l9_1070;
l9_1061=l9_1065;
l9_1064=l9_1069;
}
param_151.x=l9_1061;
l9_1026=l9_1064;
float l9_1072=param_151.y;
int l9_1073=param_154.y;
bool l9_1074=l9_1025;
float l9_1075=l9_1026;
if ((l9_1073==0)||(l9_1073==3))
{
float l9_1076=l9_1072;
float l9_1077=0.0;
float l9_1078=1.0;
bool l9_1079=l9_1074;
float l9_1080=l9_1075;
float l9_1081=fast::clamp(l9_1076,l9_1077,l9_1078);
float l9_1082=step(abs(l9_1076-l9_1081),9.9999997e-06);
l9_1080*=(l9_1082+((1.0-float(l9_1079))*(1.0-l9_1082)));
l9_1076=l9_1081;
l9_1072=l9_1076;
l9_1075=l9_1080;
}
param_151.y=l9_1072;
l9_1026=l9_1075;
float2 l9_1083=param_151;
int l9_1084=param_149;
int l9_1085=param_150;
float l9_1086=param_159;
float2 l9_1087=l9_1083;
int l9_1088=l9_1084;
int l9_1089=l9_1085;
float3 l9_1090=float3(0.0);
if (l9_1088==0)
{
l9_1090=float3(l9_1087,0.0);
}
else
{
if (l9_1088==1)
{
l9_1090=float3(l9_1087.x,(l9_1087.y*0.5)+(0.5-(float(l9_1089)*0.5)),0.0);
}
else
{
l9_1090=float3(l9_1087,float(l9_1089));
}
}
float3 l9_1091=l9_1090;
float3 l9_1092=l9_1091;
float2 l9_1093=l9_1092.xy;
float l9_1094=l9_1086;
float4 l9_1095=renderTarget3.sample(renderTarget3SmpSC,l9_1093,level(l9_1094));
float4 l9_1096=l9_1095;
float4 l9_1097=l9_1096;
if (param_157)
{
l9_1097=mix(param_158,l9_1097,float4(l9_1026));
}
float4 l9_1098=l9_1097;
float4 renderTarget3Sample_2=l9_1098;
Scalar12=renderTarget3Sample_2.x;
Scalar13=renderTarget3Sample_2.y;
Scalar14=renderTarget3Sample_2.z;
Scalar15=renderTarget3Sample_2.w;
float2 param_160=float2(Scalar0,Scalar1);
float param_161=0.0;
float param_162=100.0;
float2 l9_1099=param_160;
float l9_1100=param_161;
float l9_1101=param_162;
float l9_1102=0.99998999;
float2 l9_1103=l9_1099;
#if (1)
{
l9_1103=floor((l9_1103*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1104=dot(l9_1103,float2(1.0,0.0039215689));
float l9_1105=l9_1104;
float l9_1106=0.0;
float l9_1107=l9_1102;
float l9_1108=l9_1100;
float l9_1109=l9_1101;
float l9_1110=l9_1108+(((l9_1105-l9_1106)*(l9_1109-l9_1108))/(l9_1107-l9_1106));
float l9_1111=l9_1110;
float l9_1112=l9_1111;
gParticle.Size=l9_1112;
float2 param_163=float2(Scalar2,Scalar3);
float param_164=-1.0;
float param_165=1.0;
float2 l9_1113=param_163;
float l9_1114=param_164;
float l9_1115=param_165;
float l9_1116=0.99998999;
float2 l9_1117=l9_1113;
#if (1)
{
l9_1117=floor((l9_1117*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1118=dot(l9_1117,float2(1.0,0.0039215689));
float l9_1119=l9_1118;
float l9_1120=0.0;
float l9_1121=l9_1116;
float l9_1122=l9_1114;
float l9_1123=l9_1115;
float l9_1124=l9_1122+(((l9_1119-l9_1120)*(l9_1123-l9_1122))/(l9_1121-l9_1120));
float l9_1125=l9_1124;
float l9_1126=l9_1125;
gParticle.Quaternion.x=l9_1126;
float2 param_166=float2(Scalar4,Scalar5);
float param_167=-1.0;
float param_168=1.0;
float2 l9_1127=param_166;
float l9_1128=param_167;
float l9_1129=param_168;
float l9_1130=0.99998999;
float2 l9_1131=l9_1127;
#if (1)
{
l9_1131=floor((l9_1131*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1132=dot(l9_1131,float2(1.0,0.0039215689));
float l9_1133=l9_1132;
float l9_1134=0.0;
float l9_1135=l9_1130;
float l9_1136=l9_1128;
float l9_1137=l9_1129;
float l9_1138=l9_1136+(((l9_1133-l9_1134)*(l9_1137-l9_1136))/(l9_1135-l9_1134));
float l9_1139=l9_1138;
float l9_1140=l9_1139;
gParticle.Quaternion.y=l9_1140;
float2 param_169=float2(Scalar6,Scalar7);
float param_170=-1.0;
float param_171=1.0;
float2 l9_1141=param_169;
float l9_1142=param_170;
float l9_1143=param_171;
float l9_1144=0.99998999;
float2 l9_1145=l9_1141;
#if (1)
{
l9_1145=floor((l9_1145*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1146=dot(l9_1145,float2(1.0,0.0039215689));
float l9_1147=l9_1146;
float l9_1148=0.0;
float l9_1149=l9_1144;
float l9_1150=l9_1142;
float l9_1151=l9_1143;
float l9_1152=l9_1150+(((l9_1147-l9_1148)*(l9_1151-l9_1150))/(l9_1149-l9_1148));
float l9_1153=l9_1152;
float l9_1154=l9_1153;
gParticle.Quaternion.z=l9_1154;
float2 param_172=float2(Scalar8,Scalar9);
float param_173=-1.0;
float param_174=1.0;
float2 l9_1155=param_172;
float l9_1156=param_173;
float l9_1157=param_174;
float l9_1158=0.99998999;
float2 l9_1159=l9_1155;
#if (1)
{
l9_1159=floor((l9_1159*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1160=dot(l9_1159,float2(1.0,0.0039215689));
float l9_1161=l9_1160;
float l9_1162=0.0;
float l9_1163=l9_1158;
float l9_1164=l9_1156;
float l9_1165=l9_1157;
float l9_1166=l9_1164+(((l9_1161-l9_1162)*(l9_1165-l9_1164))/(l9_1163-l9_1162));
float l9_1167=l9_1166;
float l9_1168=l9_1167;
gParticle.Quaternion.w=l9_1168;
float2 param_175=float2(Scalar10,Scalar11);
float param_176=0.0;
float param_177=100.0;
float2 l9_1169=param_175;
float l9_1170=param_176;
float l9_1171=param_177;
float l9_1172=0.99998999;
float2 l9_1173=l9_1169;
#if (1)
{
l9_1173=floor((l9_1173*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_1174=dot(l9_1173,float2(1.0,0.0039215689));
float l9_1175=l9_1174;
float l9_1176=0.0;
float l9_1177=l9_1172;
float l9_1178=l9_1170;
float l9_1179=l9_1171;
float l9_1180=l9_1178+(((l9_1175-l9_1176)*(l9_1179-l9_1178))/(l9_1177-l9_1176));
float l9_1181=l9_1180;
float l9_1182=l9_1181;
gParticle.Mass=l9_1182;
float param_178=Scalar12;
float param_179=0.0;
float param_180=1.00001;
float l9_1183=param_178;
float l9_1184=param_179;
float l9_1185=param_180;
float l9_1186=1.0;
float l9_1187=l9_1183;
#if (1)
{
l9_1187=floor((l9_1187*255.0)+0.5)/255.0;
}
#endif
float l9_1188=l9_1187;
float l9_1189=l9_1188;
float l9_1190=0.0;
float l9_1191=l9_1186;
float l9_1192=l9_1184;
float l9_1193=l9_1185;
float l9_1194=l9_1192+(((l9_1189-l9_1190)*(l9_1193-l9_1192))/(l9_1191-l9_1190));
float l9_1195=l9_1194;
float l9_1196=l9_1195;
gParticle.Color.x=l9_1196;
float param_181=Scalar13;
float param_182=0.0;
float param_183=1.00001;
float l9_1197=param_181;
float l9_1198=param_182;
float l9_1199=param_183;
float l9_1200=1.0;
float l9_1201=l9_1197;
#if (1)
{
l9_1201=floor((l9_1201*255.0)+0.5)/255.0;
}
#endif
float l9_1202=l9_1201;
float l9_1203=l9_1202;
float l9_1204=0.0;
float l9_1205=l9_1200;
float l9_1206=l9_1198;
float l9_1207=l9_1199;
float l9_1208=l9_1206+(((l9_1203-l9_1204)*(l9_1207-l9_1206))/(l9_1205-l9_1204));
float l9_1209=l9_1208;
float l9_1210=l9_1209;
gParticle.Color.y=l9_1210;
float param_184=Scalar14;
float param_185=0.0;
float param_186=1.00001;
float l9_1211=param_184;
float l9_1212=param_185;
float l9_1213=param_186;
float l9_1214=1.0;
float l9_1215=l9_1211;
#if (1)
{
l9_1215=floor((l9_1215*255.0)+0.5)/255.0;
}
#endif
float l9_1216=l9_1215;
float l9_1217=l9_1216;
float l9_1218=0.0;
float l9_1219=l9_1214;
float l9_1220=l9_1212;
float l9_1221=l9_1213;
float l9_1222=l9_1220+(((l9_1217-l9_1218)*(l9_1221-l9_1220))/(l9_1219-l9_1218));
float l9_1223=l9_1222;
float l9_1224=l9_1223;
gParticle.Color.z=l9_1224;
float param_187=Scalar15;
float param_188=0.0;
float param_189=1.00001;
float l9_1225=param_187;
float l9_1226=param_188;
float l9_1227=param_189;
float l9_1228=1.0;
float l9_1229=l9_1225;
#if (1)
{
l9_1229=floor((l9_1229*255.0)+0.5)/255.0;
}
#endif
float l9_1230=l9_1229;
float l9_1231=l9_1230;
float l9_1232=0.0;
float l9_1233=l9_1228;
float l9_1234=l9_1226;
float l9_1235=l9_1227;
float l9_1236=l9_1234+(((l9_1231-l9_1232)*(l9_1235-l9_1234))/(l9_1233-l9_1232));
float l9_1237=l9_1236;
float l9_1238=l9_1237;
gParticle.Color.w=l9_1238;
uv=Coord+(Offset*3.0);
int l9_1239=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_1240=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1240=0;
}
else
{
l9_1240=gl_InstanceIndex%2;
}
int l9_1241=l9_1240;
l9_1239=1-l9_1241;
}
else
{
int l9_1242=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1242=0;
}
else
{
l9_1242=gl_InstanceIndex%2;
}
int l9_1243=l9_1242;
l9_1239=l9_1243;
}
int l9_1244=l9_1239;
int param_190=renderTarget0Layout_tmp;
int param_191=l9_1244;
float2 param_192=uv;
bool param_193=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_194=UserUniforms.renderTarget0Transform;
int2 param_195=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_196=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_197=UserUniforms.renderTarget0UvMinMax;
bool param_198=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_199=UserUniforms.renderTarget0BorderColor;
float param_200=0.0;
bool l9_1245=param_198&&(!param_196);
float l9_1246=1.0;
float l9_1247=param_192.x;
int l9_1248=param_195.x;
if (l9_1248==1)
{
l9_1247=fract(l9_1247);
}
else
{
if (l9_1248==2)
{
float l9_1249=fract(l9_1247);
float l9_1250=l9_1247-l9_1249;
float l9_1251=step(0.25,fract(l9_1250*0.5));
l9_1247=mix(l9_1249,1.0-l9_1249,fast::clamp(l9_1251,0.0,1.0));
}
}
param_192.x=l9_1247;
float l9_1252=param_192.y;
int l9_1253=param_195.y;
if (l9_1253==1)
{
l9_1252=fract(l9_1252);
}
else
{
if (l9_1253==2)
{
float l9_1254=fract(l9_1252);
float l9_1255=l9_1252-l9_1254;
float l9_1256=step(0.25,fract(l9_1255*0.5));
l9_1252=mix(l9_1254,1.0-l9_1254,fast::clamp(l9_1256,0.0,1.0));
}
}
param_192.y=l9_1252;
if (param_196)
{
bool l9_1257=param_198;
bool l9_1258;
if (l9_1257)
{
l9_1258=param_195.x==3;
}
else
{
l9_1258=l9_1257;
}
float l9_1259=param_192.x;
float l9_1260=param_197.x;
float l9_1261=param_197.z;
bool l9_1262=l9_1258;
float l9_1263=l9_1246;
float l9_1264=fast::clamp(l9_1259,l9_1260,l9_1261);
float l9_1265=step(abs(l9_1259-l9_1264),9.9999997e-06);
l9_1263*=(l9_1265+((1.0-float(l9_1262))*(1.0-l9_1265)));
l9_1259=l9_1264;
param_192.x=l9_1259;
l9_1246=l9_1263;
bool l9_1266=param_198;
bool l9_1267;
if (l9_1266)
{
l9_1267=param_195.y==3;
}
else
{
l9_1267=l9_1266;
}
float l9_1268=param_192.y;
float l9_1269=param_197.y;
float l9_1270=param_197.w;
bool l9_1271=l9_1267;
float l9_1272=l9_1246;
float l9_1273=fast::clamp(l9_1268,l9_1269,l9_1270);
float l9_1274=step(abs(l9_1268-l9_1273),9.9999997e-06);
l9_1272*=(l9_1274+((1.0-float(l9_1271))*(1.0-l9_1274)));
l9_1268=l9_1273;
param_192.y=l9_1268;
l9_1246=l9_1272;
}
float2 l9_1275=param_192;
bool l9_1276=param_193;
float3x3 l9_1277=param_194;
if (l9_1276)
{
l9_1275=float2((l9_1277*float3(l9_1275,1.0)).xy);
}
float2 l9_1278=l9_1275;
float2 l9_1279=l9_1278;
float2 l9_1280=l9_1279;
param_192=l9_1280;
float l9_1281=param_192.x;
int l9_1282=param_195.x;
bool l9_1283=l9_1245;
float l9_1284=l9_1246;
if ((l9_1282==0)||(l9_1282==3))
{
float l9_1285=l9_1281;
float l9_1286=0.0;
float l9_1287=1.0;
bool l9_1288=l9_1283;
float l9_1289=l9_1284;
float l9_1290=fast::clamp(l9_1285,l9_1286,l9_1287);
float l9_1291=step(abs(l9_1285-l9_1290),9.9999997e-06);
l9_1289*=(l9_1291+((1.0-float(l9_1288))*(1.0-l9_1291)));
l9_1285=l9_1290;
l9_1281=l9_1285;
l9_1284=l9_1289;
}
param_192.x=l9_1281;
l9_1246=l9_1284;
float l9_1292=param_192.y;
int l9_1293=param_195.y;
bool l9_1294=l9_1245;
float l9_1295=l9_1246;
if ((l9_1293==0)||(l9_1293==3))
{
float l9_1296=l9_1292;
float l9_1297=0.0;
float l9_1298=1.0;
bool l9_1299=l9_1294;
float l9_1300=l9_1295;
float l9_1301=fast::clamp(l9_1296,l9_1297,l9_1298);
float l9_1302=step(abs(l9_1296-l9_1301),9.9999997e-06);
l9_1300*=(l9_1302+((1.0-float(l9_1299))*(1.0-l9_1302)));
l9_1296=l9_1301;
l9_1292=l9_1296;
l9_1295=l9_1300;
}
param_192.y=l9_1292;
l9_1246=l9_1295;
float2 l9_1303=param_192;
int l9_1304=param_190;
int l9_1305=param_191;
float l9_1306=param_200;
float2 l9_1307=l9_1303;
int l9_1308=l9_1304;
int l9_1309=l9_1305;
float3 l9_1310=float3(0.0);
if (l9_1308==0)
{
l9_1310=float3(l9_1307,0.0);
}
else
{
if (l9_1308==1)
{
l9_1310=float3(l9_1307.x,(l9_1307.y*0.5)+(0.5-(float(l9_1309)*0.5)),0.0);
}
else
{
l9_1310=float3(l9_1307,float(l9_1309));
}
}
float3 l9_1311=l9_1310;
float3 l9_1312=l9_1311;
float2 l9_1313=l9_1312.xy;
float l9_1314=l9_1306;
float4 l9_1315=renderTarget0.sample(renderTarget0SmpSC,l9_1313,level(l9_1314));
float4 l9_1316=l9_1315;
float4 l9_1317=l9_1316;
if (param_198)
{
l9_1317=mix(param_199,l9_1317,float4(l9_1246));
}
float4 l9_1318=l9_1317;
float4 renderTarget0Sample_3=l9_1318;
Scalar0=renderTarget0Sample_3.x;
Scalar1=renderTarget0Sample_3.y;
Scalar2=renderTarget0Sample_3.z;
Scalar3=renderTarget0Sample_3.w;
int l9_1319=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_1320=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1320=0;
}
else
{
l9_1320=gl_InstanceIndex%2;
}
int l9_1321=l9_1320;
l9_1319=1-l9_1321;
}
else
{
int l9_1322=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1322=0;
}
else
{
l9_1322=gl_InstanceIndex%2;
}
int l9_1323=l9_1322;
l9_1319=l9_1323;
}
int l9_1324=l9_1319;
int param_201=renderTarget1Layout_tmp;
int param_202=l9_1324;
float2 param_203=uv;
bool param_204=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_205=UserUniforms.renderTarget1Transform;
int2 param_206=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_207=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_208=UserUniforms.renderTarget1UvMinMax;
bool param_209=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_210=UserUniforms.renderTarget1BorderColor;
float param_211=0.0;
bool l9_1325=param_209&&(!param_207);
float l9_1326=1.0;
float l9_1327=param_203.x;
int l9_1328=param_206.x;
if (l9_1328==1)
{
l9_1327=fract(l9_1327);
}
else
{
if (l9_1328==2)
{
float l9_1329=fract(l9_1327);
float l9_1330=l9_1327-l9_1329;
float l9_1331=step(0.25,fract(l9_1330*0.5));
l9_1327=mix(l9_1329,1.0-l9_1329,fast::clamp(l9_1331,0.0,1.0));
}
}
param_203.x=l9_1327;
float l9_1332=param_203.y;
int l9_1333=param_206.y;
if (l9_1333==1)
{
l9_1332=fract(l9_1332);
}
else
{
if (l9_1333==2)
{
float l9_1334=fract(l9_1332);
float l9_1335=l9_1332-l9_1334;
float l9_1336=step(0.25,fract(l9_1335*0.5));
l9_1332=mix(l9_1334,1.0-l9_1334,fast::clamp(l9_1336,0.0,1.0));
}
}
param_203.y=l9_1332;
if (param_207)
{
bool l9_1337=param_209;
bool l9_1338;
if (l9_1337)
{
l9_1338=param_206.x==3;
}
else
{
l9_1338=l9_1337;
}
float l9_1339=param_203.x;
float l9_1340=param_208.x;
float l9_1341=param_208.z;
bool l9_1342=l9_1338;
float l9_1343=l9_1326;
float l9_1344=fast::clamp(l9_1339,l9_1340,l9_1341);
float l9_1345=step(abs(l9_1339-l9_1344),9.9999997e-06);
l9_1343*=(l9_1345+((1.0-float(l9_1342))*(1.0-l9_1345)));
l9_1339=l9_1344;
param_203.x=l9_1339;
l9_1326=l9_1343;
bool l9_1346=param_209;
bool l9_1347;
if (l9_1346)
{
l9_1347=param_206.y==3;
}
else
{
l9_1347=l9_1346;
}
float l9_1348=param_203.y;
float l9_1349=param_208.y;
float l9_1350=param_208.w;
bool l9_1351=l9_1347;
float l9_1352=l9_1326;
float l9_1353=fast::clamp(l9_1348,l9_1349,l9_1350);
float l9_1354=step(abs(l9_1348-l9_1353),9.9999997e-06);
l9_1352*=(l9_1354+((1.0-float(l9_1351))*(1.0-l9_1354)));
l9_1348=l9_1353;
param_203.y=l9_1348;
l9_1326=l9_1352;
}
float2 l9_1355=param_203;
bool l9_1356=param_204;
float3x3 l9_1357=param_205;
if (l9_1356)
{
l9_1355=float2((l9_1357*float3(l9_1355,1.0)).xy);
}
float2 l9_1358=l9_1355;
float2 l9_1359=l9_1358;
float2 l9_1360=l9_1359;
param_203=l9_1360;
float l9_1361=param_203.x;
int l9_1362=param_206.x;
bool l9_1363=l9_1325;
float l9_1364=l9_1326;
if ((l9_1362==0)||(l9_1362==3))
{
float l9_1365=l9_1361;
float l9_1366=0.0;
float l9_1367=1.0;
bool l9_1368=l9_1363;
float l9_1369=l9_1364;
float l9_1370=fast::clamp(l9_1365,l9_1366,l9_1367);
float l9_1371=step(abs(l9_1365-l9_1370),9.9999997e-06);
l9_1369*=(l9_1371+((1.0-float(l9_1368))*(1.0-l9_1371)));
l9_1365=l9_1370;
l9_1361=l9_1365;
l9_1364=l9_1369;
}
param_203.x=l9_1361;
l9_1326=l9_1364;
float l9_1372=param_203.y;
int l9_1373=param_206.y;
bool l9_1374=l9_1325;
float l9_1375=l9_1326;
if ((l9_1373==0)||(l9_1373==3))
{
float l9_1376=l9_1372;
float l9_1377=0.0;
float l9_1378=1.0;
bool l9_1379=l9_1374;
float l9_1380=l9_1375;
float l9_1381=fast::clamp(l9_1376,l9_1377,l9_1378);
float l9_1382=step(abs(l9_1376-l9_1381),9.9999997e-06);
l9_1380*=(l9_1382+((1.0-float(l9_1379))*(1.0-l9_1382)));
l9_1376=l9_1381;
l9_1372=l9_1376;
l9_1375=l9_1380;
}
param_203.y=l9_1372;
l9_1326=l9_1375;
float2 l9_1383=param_203;
int l9_1384=param_201;
int l9_1385=param_202;
float l9_1386=param_211;
float2 l9_1387=l9_1383;
int l9_1388=l9_1384;
int l9_1389=l9_1385;
float3 l9_1390=float3(0.0);
if (l9_1388==0)
{
l9_1390=float3(l9_1387,0.0);
}
else
{
if (l9_1388==1)
{
l9_1390=float3(l9_1387.x,(l9_1387.y*0.5)+(0.5-(float(l9_1389)*0.5)),0.0);
}
else
{
l9_1390=float3(l9_1387,float(l9_1389));
}
}
float3 l9_1391=l9_1390;
float3 l9_1392=l9_1391;
float2 l9_1393=l9_1392.xy;
float l9_1394=l9_1386;
float4 l9_1395=renderTarget1.sample(renderTarget1SmpSC,l9_1393,level(l9_1394));
float4 l9_1396=l9_1395;
float4 l9_1397=l9_1396;
if (param_209)
{
l9_1397=mix(param_210,l9_1397,float4(l9_1326));
}
float4 l9_1398=l9_1397;
float4 renderTarget1Sample_3=l9_1398;
Scalar4=renderTarget1Sample_3.x;
Scalar5=renderTarget1Sample_3.y;
Scalar6=renderTarget1Sample_3.z;
Scalar7=renderTarget1Sample_3.w;
int l9_1399=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_1400=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1400=0;
}
else
{
l9_1400=gl_InstanceIndex%2;
}
int l9_1401=l9_1400;
l9_1399=1-l9_1401;
}
else
{
int l9_1402=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1402=0;
}
else
{
l9_1402=gl_InstanceIndex%2;
}
int l9_1403=l9_1402;
l9_1399=l9_1403;
}
int l9_1404=l9_1399;
int param_212=renderTarget2Layout_tmp;
int param_213=l9_1404;
float2 param_214=uv;
bool param_215=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_216=UserUniforms.renderTarget2Transform;
int2 param_217=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_218=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_219=UserUniforms.renderTarget2UvMinMax;
bool param_220=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_221=UserUniforms.renderTarget2BorderColor;
float param_222=0.0;
bool l9_1405=param_220&&(!param_218);
float l9_1406=1.0;
float l9_1407=param_214.x;
int l9_1408=param_217.x;
if (l9_1408==1)
{
l9_1407=fract(l9_1407);
}
else
{
if (l9_1408==2)
{
float l9_1409=fract(l9_1407);
float l9_1410=l9_1407-l9_1409;
float l9_1411=step(0.25,fract(l9_1410*0.5));
l9_1407=mix(l9_1409,1.0-l9_1409,fast::clamp(l9_1411,0.0,1.0));
}
}
param_214.x=l9_1407;
float l9_1412=param_214.y;
int l9_1413=param_217.y;
if (l9_1413==1)
{
l9_1412=fract(l9_1412);
}
else
{
if (l9_1413==2)
{
float l9_1414=fract(l9_1412);
float l9_1415=l9_1412-l9_1414;
float l9_1416=step(0.25,fract(l9_1415*0.5));
l9_1412=mix(l9_1414,1.0-l9_1414,fast::clamp(l9_1416,0.0,1.0));
}
}
param_214.y=l9_1412;
if (param_218)
{
bool l9_1417=param_220;
bool l9_1418;
if (l9_1417)
{
l9_1418=param_217.x==3;
}
else
{
l9_1418=l9_1417;
}
float l9_1419=param_214.x;
float l9_1420=param_219.x;
float l9_1421=param_219.z;
bool l9_1422=l9_1418;
float l9_1423=l9_1406;
float l9_1424=fast::clamp(l9_1419,l9_1420,l9_1421);
float l9_1425=step(abs(l9_1419-l9_1424),9.9999997e-06);
l9_1423*=(l9_1425+((1.0-float(l9_1422))*(1.0-l9_1425)));
l9_1419=l9_1424;
param_214.x=l9_1419;
l9_1406=l9_1423;
bool l9_1426=param_220;
bool l9_1427;
if (l9_1426)
{
l9_1427=param_217.y==3;
}
else
{
l9_1427=l9_1426;
}
float l9_1428=param_214.y;
float l9_1429=param_219.y;
float l9_1430=param_219.w;
bool l9_1431=l9_1427;
float l9_1432=l9_1406;
float l9_1433=fast::clamp(l9_1428,l9_1429,l9_1430);
float l9_1434=step(abs(l9_1428-l9_1433),9.9999997e-06);
l9_1432*=(l9_1434+((1.0-float(l9_1431))*(1.0-l9_1434)));
l9_1428=l9_1433;
param_214.y=l9_1428;
l9_1406=l9_1432;
}
float2 l9_1435=param_214;
bool l9_1436=param_215;
float3x3 l9_1437=param_216;
if (l9_1436)
{
l9_1435=float2((l9_1437*float3(l9_1435,1.0)).xy);
}
float2 l9_1438=l9_1435;
float2 l9_1439=l9_1438;
float2 l9_1440=l9_1439;
param_214=l9_1440;
float l9_1441=param_214.x;
int l9_1442=param_217.x;
bool l9_1443=l9_1405;
float l9_1444=l9_1406;
if ((l9_1442==0)||(l9_1442==3))
{
float l9_1445=l9_1441;
float l9_1446=0.0;
float l9_1447=1.0;
bool l9_1448=l9_1443;
float l9_1449=l9_1444;
float l9_1450=fast::clamp(l9_1445,l9_1446,l9_1447);
float l9_1451=step(abs(l9_1445-l9_1450),9.9999997e-06);
l9_1449*=(l9_1451+((1.0-float(l9_1448))*(1.0-l9_1451)));
l9_1445=l9_1450;
l9_1441=l9_1445;
l9_1444=l9_1449;
}
param_214.x=l9_1441;
l9_1406=l9_1444;
float l9_1452=param_214.y;
int l9_1453=param_217.y;
bool l9_1454=l9_1405;
float l9_1455=l9_1406;
if ((l9_1453==0)||(l9_1453==3))
{
float l9_1456=l9_1452;
float l9_1457=0.0;
float l9_1458=1.0;
bool l9_1459=l9_1454;
float l9_1460=l9_1455;
float l9_1461=fast::clamp(l9_1456,l9_1457,l9_1458);
float l9_1462=step(abs(l9_1456-l9_1461),9.9999997e-06);
l9_1460*=(l9_1462+((1.0-float(l9_1459))*(1.0-l9_1462)));
l9_1456=l9_1461;
l9_1452=l9_1456;
l9_1455=l9_1460;
}
param_214.y=l9_1452;
l9_1406=l9_1455;
float2 l9_1463=param_214;
int l9_1464=param_212;
int l9_1465=param_213;
float l9_1466=param_222;
float2 l9_1467=l9_1463;
int l9_1468=l9_1464;
int l9_1469=l9_1465;
float3 l9_1470=float3(0.0);
if (l9_1468==0)
{
l9_1470=float3(l9_1467,0.0);
}
else
{
if (l9_1468==1)
{
l9_1470=float3(l9_1467.x,(l9_1467.y*0.5)+(0.5-(float(l9_1469)*0.5)),0.0);
}
else
{
l9_1470=float3(l9_1467,float(l9_1469));
}
}
float3 l9_1471=l9_1470;
float3 l9_1472=l9_1471;
float2 l9_1473=l9_1472.xy;
float l9_1474=l9_1466;
float4 l9_1475=renderTarget2.sample(renderTarget2SmpSC,l9_1473,level(l9_1474));
float4 l9_1476=l9_1475;
float4 l9_1477=l9_1476;
if (param_220)
{
l9_1477=mix(param_221,l9_1477,float4(l9_1406));
}
float4 l9_1478=l9_1477;
float4 renderTarget2Sample_3=l9_1478;
Scalar8=renderTarget2Sample_3.x;
Scalar9=renderTarget2Sample_3.y;
Scalar10=renderTarget2Sample_3.z;
Scalar11=renderTarget2Sample_3.w;
int l9_1479=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_1480=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1480=0;
}
else
{
l9_1480=gl_InstanceIndex%2;
}
int l9_1481=l9_1480;
l9_1479=1-l9_1481;
}
else
{
int l9_1482=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1482=0;
}
else
{
l9_1482=gl_InstanceIndex%2;
}
int l9_1483=l9_1482;
l9_1479=l9_1483;
}
int l9_1484=l9_1479;
int param_223=renderTarget3Layout_tmp;
int param_224=l9_1484;
float2 param_225=uv;
bool param_226=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_227=UserUniforms.renderTarget3Transform;
int2 param_228=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_229=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_230=UserUniforms.renderTarget3UvMinMax;
bool param_231=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_232=UserUniforms.renderTarget3BorderColor;
float param_233=0.0;
bool l9_1485=param_231&&(!param_229);
float l9_1486=1.0;
float l9_1487=param_225.x;
int l9_1488=param_228.x;
if (l9_1488==1)
{
l9_1487=fract(l9_1487);
}
else
{
if (l9_1488==2)
{
float l9_1489=fract(l9_1487);
float l9_1490=l9_1487-l9_1489;
float l9_1491=step(0.25,fract(l9_1490*0.5));
l9_1487=mix(l9_1489,1.0-l9_1489,fast::clamp(l9_1491,0.0,1.0));
}
}
param_225.x=l9_1487;
float l9_1492=param_225.y;
int l9_1493=param_228.y;
if (l9_1493==1)
{
l9_1492=fract(l9_1492);
}
else
{
if (l9_1493==2)
{
float l9_1494=fract(l9_1492);
float l9_1495=l9_1492-l9_1494;
float l9_1496=step(0.25,fract(l9_1495*0.5));
l9_1492=mix(l9_1494,1.0-l9_1494,fast::clamp(l9_1496,0.0,1.0));
}
}
param_225.y=l9_1492;
if (param_229)
{
bool l9_1497=param_231;
bool l9_1498;
if (l9_1497)
{
l9_1498=param_228.x==3;
}
else
{
l9_1498=l9_1497;
}
float l9_1499=param_225.x;
float l9_1500=param_230.x;
float l9_1501=param_230.z;
bool l9_1502=l9_1498;
float l9_1503=l9_1486;
float l9_1504=fast::clamp(l9_1499,l9_1500,l9_1501);
float l9_1505=step(abs(l9_1499-l9_1504),9.9999997e-06);
l9_1503*=(l9_1505+((1.0-float(l9_1502))*(1.0-l9_1505)));
l9_1499=l9_1504;
param_225.x=l9_1499;
l9_1486=l9_1503;
bool l9_1506=param_231;
bool l9_1507;
if (l9_1506)
{
l9_1507=param_228.y==3;
}
else
{
l9_1507=l9_1506;
}
float l9_1508=param_225.y;
float l9_1509=param_230.y;
float l9_1510=param_230.w;
bool l9_1511=l9_1507;
float l9_1512=l9_1486;
float l9_1513=fast::clamp(l9_1508,l9_1509,l9_1510);
float l9_1514=step(abs(l9_1508-l9_1513),9.9999997e-06);
l9_1512*=(l9_1514+((1.0-float(l9_1511))*(1.0-l9_1514)));
l9_1508=l9_1513;
param_225.y=l9_1508;
l9_1486=l9_1512;
}
float2 l9_1515=param_225;
bool l9_1516=param_226;
float3x3 l9_1517=param_227;
if (l9_1516)
{
l9_1515=float2((l9_1517*float3(l9_1515,1.0)).xy);
}
float2 l9_1518=l9_1515;
float2 l9_1519=l9_1518;
float2 l9_1520=l9_1519;
param_225=l9_1520;
float l9_1521=param_225.x;
int l9_1522=param_228.x;
bool l9_1523=l9_1485;
float l9_1524=l9_1486;
if ((l9_1522==0)||(l9_1522==3))
{
float l9_1525=l9_1521;
float l9_1526=0.0;
float l9_1527=1.0;
bool l9_1528=l9_1523;
float l9_1529=l9_1524;
float l9_1530=fast::clamp(l9_1525,l9_1526,l9_1527);
float l9_1531=step(abs(l9_1525-l9_1530),9.9999997e-06);
l9_1529*=(l9_1531+((1.0-float(l9_1528))*(1.0-l9_1531)));
l9_1525=l9_1530;
l9_1521=l9_1525;
l9_1524=l9_1529;
}
param_225.x=l9_1521;
l9_1486=l9_1524;
float l9_1532=param_225.y;
int l9_1533=param_228.y;
bool l9_1534=l9_1485;
float l9_1535=l9_1486;
if ((l9_1533==0)||(l9_1533==3))
{
float l9_1536=l9_1532;
float l9_1537=0.0;
float l9_1538=1.0;
bool l9_1539=l9_1534;
float l9_1540=l9_1535;
float l9_1541=fast::clamp(l9_1536,l9_1537,l9_1538);
float l9_1542=step(abs(l9_1536-l9_1541),9.9999997e-06);
l9_1540*=(l9_1542+((1.0-float(l9_1539))*(1.0-l9_1542)));
l9_1536=l9_1541;
l9_1532=l9_1536;
l9_1535=l9_1540;
}
param_225.y=l9_1532;
l9_1486=l9_1535;
float2 l9_1543=param_225;
int l9_1544=param_223;
int l9_1545=param_224;
float l9_1546=param_233;
float2 l9_1547=l9_1543;
int l9_1548=l9_1544;
int l9_1549=l9_1545;
float3 l9_1550=float3(0.0);
if (l9_1548==0)
{
l9_1550=float3(l9_1547,0.0);
}
else
{
if (l9_1548==1)
{
l9_1550=float3(l9_1547.x,(l9_1547.y*0.5)+(0.5-(float(l9_1549)*0.5)),0.0);
}
else
{
l9_1550=float3(l9_1547,float(l9_1549));
}
}
float3 l9_1551=l9_1550;
float3 l9_1552=l9_1551;
float2 l9_1553=l9_1552.xy;
float l9_1554=l9_1546;
float4 l9_1555=renderTarget3.sample(renderTarget3SmpSC,l9_1553,level(l9_1554));
float4 l9_1556=l9_1555;
float4 l9_1557=l9_1556;
if (param_231)
{
l9_1557=mix(param_232,l9_1557,float4(l9_1486));
}
float4 l9_1558=l9_1557;
float4 renderTarget3Sample_3=l9_1558;
Scalar12=renderTarget3Sample_3.x;
Scalar13=renderTarget3Sample_3.y;
Scalar14=renderTarget3Sample_3.z;
Scalar15=renderTarget3Sample_3.w;
float param_234=Scalar0;
float param_235=0.0;
float param_236=255.0;
float l9_1559=param_234;
float l9_1560=param_235;
float l9_1561=param_236;
float l9_1562=1.0;
float l9_1563=l9_1559;
#if (1)
{
l9_1563=floor((l9_1563*255.0)+0.5)/255.0;
}
#endif
float l9_1564=l9_1563;
float l9_1565=l9_1564;
float l9_1566=0.0;
float l9_1567=l9_1562;
float l9_1568=l9_1560;
float l9_1569=l9_1561;
float l9_1570=l9_1568+(((l9_1565-l9_1566)*(l9_1569-l9_1568))/(l9_1567-l9_1566));
float l9_1571=l9_1570;
float l9_1572=l9_1571;
gParticle.collisionCount_N119=l9_1572;
float4 param_237=gParticle.Quaternion;
param_237=normalize(param_237.yzwx);
float l9_1573=param_237.x*param_237.x;
float l9_1574=param_237.y*param_237.y;
float l9_1575=param_237.z*param_237.z;
float l9_1576=param_237.x*param_237.z;
float l9_1577=param_237.x*param_237.y;
float l9_1578=param_237.y*param_237.z;
float l9_1579=param_237.w*param_237.x;
float l9_1580=param_237.w*param_237.y;
float l9_1581=param_237.w*param_237.z;
float3x3 l9_1582=float3x3(float3(1.0-(2.0*(l9_1574+l9_1575)),2.0*(l9_1577+l9_1581),2.0*(l9_1576-l9_1580)),float3(2.0*(l9_1577-l9_1581),1.0-(2.0*(l9_1573+l9_1575)),2.0*(l9_1578+l9_1579)),float3(2.0*(l9_1576+l9_1580),2.0*(l9_1578-l9_1579),1.0-(2.0*(l9_1573+l9_1574))));
gParticle.Matrix=l9_1582;
gParticle.Velocity=floor((gParticle.Velocity*2000.0)+float3(0.5))*0.00050000002;
gParticle.Position=floor((gParticle.Position*2000.0)+float3(0.5))*0.00050000002;
gParticle.Color=floor((gParticle.Color*2000.0)+float4(0.5))*0.00050000002;
gParticle.Size=floor((gParticle.Size*2000.0)+0.5)*0.00050000002;
gParticle.Mass=floor((gParticle.Mass*2000.0)+0.5)*0.00050000002;
gParticle.Life=floor((gParticle.Life*2000.0)+0.5)*0.00050000002;
return true;
}
float snoise(thread const float2& v)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 i=floor(v+float2(dot(v,float2(0.36602542))));
float2 x0=(v-i)+float2(dot(i,float2(0.21132487)));
float2 i1=float2(0.0);
bool2 l9_0=bool2(x0.x>x0.y);
i1=float2(l9_0.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_0.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float2 x1=(x0+float2(0.21132487))-i1;
float2 x2=x0+float2(-0.57735026);
float2 param=i;
float2 l9_1=param-(floor(param*0.0034602077)*289.0);
i=l9_1;
float3 param_1=float3(i.y)+float3(0.0,i1.y,1.0);
float3 l9_2=((param_1*34.0)+float3(1.0))*param_1;
float3 l9_3=l9_2-(floor(l9_2*0.0034602077)*289.0);
float3 l9_4=l9_3;
float3 param_2=(l9_4+float3(i.x))+float3(0.0,i1.x,1.0);
float3 l9_5=((param_2*34.0)+float3(1.0))*param_2;
float3 l9_6=l9_5-(floor(l9_5*0.0034602077)*289.0);
float3 l9_7=l9_6;
float3 p=l9_7;
float3 m=fast::max(float3(0.5)-float3(dot(x0,x0),dot(x1,x1),dot(x2,x2)),float3(0.0));
m*=m;
m*=m;
float3 x=(fract(p*float3(0.024390243))*2.0)-float3(1.0);
float3 h=abs(x)-float3(0.5);
float3 ox=floor(x+float3(0.5));
float3 a0=x-ox;
m*=(float3(1.7928429)-(((a0*a0)+(h*h))*0.85373473));
float3 g=float3(0.0);
g.x=(a0.x*x0.x)+(h.x*x0.y);
float2 l9_8=(a0.yz*float2(x1.x,x2.x))+(h.yz*float2(x1.y,x2.y));
g=float3(g.x,l9_8.x,l9_8.y);
return 130.0*dot(m,g);
}
else
{
return 0.0;
}
}
float4 matrixToQuaternion(thread const float3x3& m)
{
float fourXSquaredMinus1=(m[0].x-m[1].y)-m[2].z;
float fourYSquaredMinus1=(m[1].y-m[0].x)-m[2].z;
float fourZSquaredMinus1=(m[2].z-m[0].x)-m[1].y;
float fourWSquaredMinus1=(m[0].x+m[1].y)+m[2].z;
int biggestIndex=0;
float fourBiggestSquaredMinus1=fourWSquaredMinus1;
if (fourXSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourXSquaredMinus1;
biggestIndex=1;
}
if (fourYSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourYSquaredMinus1;
biggestIndex=2;
}
if (fourZSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourZSquaredMinus1;
biggestIndex=3;
}
float biggestVal=sqrt(fourBiggestSquaredMinus1+1.0)*0.5;
float mult=0.25/biggestVal;
if (biggestIndex==0)
{
return float4(biggestVal,(m[1].z-m[2].y)*mult,(m[2].x-m[0].z)*mult,(m[0].y-m[1].x)*mult);
}
else
{
if (biggestIndex==1)
{
return float4((m[1].z-m[2].y)*mult,biggestVal,(m[0].y+m[1].x)*mult,(m[2].x+m[0].z)*mult);
}
else
{
if (biggestIndex==2)
{
return float4((m[2].x-m[0].z)*mult,(m[0].y+m[1].x)*mult,biggestVal,(m[1].z+m[2].y)*mult);
}
else
{
if (biggestIndex==3)
{
return float4((m[0].y-m[1].x)*mult,(m[2].x+m[0].z)*mult,(m[1].z+m[2].y)*mult,biggestVal);
}
else
{
return float4(1.0,0.0,0.0,0.0);
}
}
}
}
}
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
int N118_OnCollision=0;
float3 N118_PlanePos=float3(0.0);
float3 N118_PlaneNormal=float3(0.0);
float N118_Bounciness=0.0;
float N118_Friction=0.0;
float N118_PlaneOffset=0.0;
float N118_CollisionCount=0.0;
float N118_VelocityThreshold=0.0;
float N118_SetCollisionCount=0.0;
float3 N118_SetForce=float3(0.0);
float3 N118_SetVelocity=float3(0.0);
float3 N118_SetPosition=float3(0.0);
float N118_KillParticle=0.0;
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.normal=in.normal;
l9_0.tangent=in.tangent.xyz;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t v=l9_1;
int l9_2=gl_InstanceIndex;
int InstanceID=l9_2;
int param=InstanceID;
ssParticle gParticle;
bool l9_3=ssDecodeParticle(param,gl_InstanceIndex,(*sc_set2.UserUniforms),sc_set2.renderTarget0,sc_set2.renderTarget0SmpSC,sc_set2.renderTarget1,sc_set2.renderTarget1SmpSC,sc_set2.renderTarget2,sc_set2.renderTarget2SmpSC,sc_set2.renderTarget3,sc_set2.renderTarget3SmpSC,gParticle);
float l9_4;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_4=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_4=(*sc_set2.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_4;
float l9_5;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_5=(*sc_set2.UserUniforms).overrideTimeDelta;
}
else
{
l9_5=fast::max((*sc_set2.UserUniforms).sc_Time.y,0.0);
}
Globals.gTimeDelta=l9_5;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
float Warmup=0.0;
float Delay=0.0;
gParticle.Age=mod((Globals.gTimeElapsedShifted-gParticle.SpawnOffset)+Warmup,0.2);
float l9_6=Globals.gTimeElapsed;
float l9_7=gParticle.SpawnOffset;
float l9_8=Delay;
float l9_9=Warmup;
bool l9_10=(l9_6-l9_7)<(l9_8-l9_9);
bool l9_11;
if (!l9_10)
{
l9_11=gParticle.Age>0.2;
}
else
{
l9_11=l9_10;
}
bool Dead=l9_11 ? true : false;
bool l9_12=Dead;
bool l9_13=!l9_12;
bool l9_14;
if (l9_13)
{
l9_14=gParticle.Life<=9.9999997e-05;
}
else
{
l9_14=l9_13;
}
bool l9_15;
if (!l9_14)
{
l9_15=mod(((Globals.gTimeElapsed-gParticle.SpawnOffset)-Delay)+Warmup,0.2)<=Globals.gTimeDelta;
}
else
{
l9_15=l9_14;
}
if (l9_15)
{
ssGlobals param_1=Globals;
ssParticle l9_16=gParticle;
float l9_17;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_17=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_17=(*sc_set2.UserUniforms).sc_Time.x;
}
float l9_18=l9_17;
l9_16.Seed=(l9_16.Ratio1D*0.97637898)+0.151235;
l9_16.Seed+=(floor(((((l9_18-l9_16.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_16.Seed=fract(abs(l9_16.Seed));
int2 l9_19=int2(l9_16.Index1D%400,l9_16.Index1D/400);
l9_16.Seed2000=(float2(l9_19)+float2(1.0))/float2(399.0);
gParticle=l9_16;
float l9_20=floor(sqrt(40.0*float((*sc_set2.UserUniforms).vfxNumCopies+1)));
int l9_21=int(l9_20);
int l9_22=gParticle.Index1D;
int l9_23=l9_21;
int l9_24=l9_22-((l9_22/l9_23)*l9_23);
gParticle.Position=(float3(((float(l9_24)/l9_20)*2.0)-1.0,((float(gParticle.Index1D/l9_21)/l9_20)*2.0)-1.0,0.0)*20.0)+float3(1.0,1.0,0.0);
gParticle.Velocity=float3(0.0);
gParticle.Color=float4(1.0);
gParticle.Age=0.0;
gParticle.Life=0.2;
gParticle.Size=1.0;
gParticle.Mass=1.0;
gParticle.Matrix=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
gParticle.Quaternion=float4(0.0,0.0,0.0,1.0);
float3 l9_25=float3(0.0);
l9_25=(*sc_set2.UserUniforms).Port_Import_N216;
float l9_26=0.0;
float l9_27=0.0;
float l9_28=0.0;
float l9_29=0.0;
ssGlobals l9_30=param_1;
float l9_31=0.0;
l9_31=0.0;
float l9_32=0.0;
l9_32=float(l9_31==(*sc_set2.UserUniforms).Port_Input1_N149);
l9_27=l9_32;
float l9_33;
if ((l9_27*1.0)!=0.0)
{
float3 l9_34=float3(0.0);
float3 l9_35=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_36=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_37=l9_30;
int l9_38=3;
bool l9_39=true;
bool l9_40=true;
bool l9_41=true;
float l9_42=150.0;
ssParticle l9_43=gParticle;
float l9_44=0.0;
float l9_45=l9_37.gTimeElapsed;
float4 l9_46=float4(0.0);
float4 l9_47=float4(0.0);
if (l9_39)
{
l9_47.x=floor(fract(l9_45)*1000.0);
}
if (l9_41)
{
l9_47.y=float(l9_43.Index1D^((l9_43.Index1D*15299)+l9_43.Index1D));
}
if (l9_40)
{
l9_47.z=l9_42;
}
l9_47.w=l9_44*1000.0;
int l9_48=int(l9_47.x);
int l9_49=int(l9_47.y);
int l9_50=int(l9_47.z);
int l9_51=int(l9_47.w);
int l9_52=(((l9_48*15299)^(l9_49*30133))^(l9_50*17539))^(l9_51*12113);
int l9_53=l9_52;
if (l9_38==1)
{
int l9_54=l9_53;
int l9_55=l9_54;
int l9_56=((l9_55*((l9_55*1471343)+101146501))+1559861749)&2147483647;
int l9_57=l9_56;
float l9_58=float(l9_57)*4.6566129e-10;
float l9_59=l9_58;
l9_46.x=l9_59;
}
else
{
if (l9_38==2)
{
int l9_60=l9_53;
int l9_61=l9_60;
int l9_62=((l9_61*((l9_61*1471343)+101146501))+1559861749)&2147483647;
int l9_63=l9_62;
int l9_64=l9_60*1399;
int l9_65=((l9_64*((l9_64*1471343)+101146501))+1559861749)&2147483647;
int l9_66=l9_65;
int l9_67=l9_63;
float l9_68=float(l9_67)*4.6566129e-10;
int l9_69=l9_66;
float l9_70=float(l9_69)*4.6566129e-10;
float2 l9_71=float2(l9_68,l9_70);
l9_46=float4(l9_71.x,l9_71.y,l9_46.z,l9_46.w);
}
else
{
if (l9_38==3)
{
int l9_72=l9_53;
int l9_73=l9_72;
int l9_74=((l9_73*((l9_73*1471343)+101146501))+1559861749)&2147483647;
int l9_75=l9_74;
int l9_76=l9_72*1399;
int l9_77=((l9_76*((l9_76*1471343)+101146501))+1559861749)&2147483647;
int l9_78=l9_77;
int l9_79=l9_72*7177;
int l9_80=((l9_79*((l9_79*1471343)+101146501))+1559861749)&2147483647;
int l9_81=l9_80;
int l9_82=l9_75;
float l9_83=float(l9_82)*4.6566129e-10;
int l9_84=l9_78;
float l9_85=float(l9_84)*4.6566129e-10;
int l9_86=l9_81;
float l9_87=float(l9_86)*4.6566129e-10;
float3 l9_88=float3(l9_83,l9_85,l9_87);
l9_46=float4(l9_88.x,l9_88.y,l9_88.z,l9_46.w);
}
else
{
int l9_89=l9_53;
int l9_90=l9_89;
int l9_91=((l9_90*((l9_90*1471343)+101146501))+1559861749)&2147483647;
int l9_92=l9_91;
int l9_93=l9_89*1399;
int l9_94=((l9_93*((l9_93*1471343)+101146501))+1559861749)&2147483647;
int l9_95=l9_94;
int l9_96=l9_89*7177;
int l9_97=((l9_96*((l9_96*1471343)+101146501))+1559861749)&2147483647;
int l9_98=l9_97;
int l9_99=l9_89*18919;
int l9_100=((l9_99*((l9_99*1471343)+101146501))+1559861749)&2147483647;
int l9_101=l9_100;
int l9_102=l9_92;
float l9_103=float(l9_102)*4.6566129e-10;
int l9_104=l9_95;
float l9_105=float(l9_104)*4.6566129e-10;
int l9_106=l9_98;
float l9_107=float(l9_106)*4.6566129e-10;
int l9_108=l9_101;
float l9_109=float(l9_108)*4.6566129e-10;
float4 l9_110=float4(l9_103,l9_105,l9_107,l9_109);
l9_46=l9_110;
}
}
}
float4 l9_111=l9_46;
float4 l9_112=l9_111;
float3 l9_113=mix(l9_35,l9_36,l9_112.xyz);
l9_34=l9_113;
float l9_114=0.0;
l9_114=length(l9_34);
float3 l9_115=float3(0.0);
l9_115=l9_34/(float3(l9_114)+float3(1.234e-06));
float l9_116=0.0;
l9_116=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_117=0.0;
l9_117=1.0-l9_116;
float l9_118=0.0;
float l9_119;
if (l9_117<=0.0)
{
l9_119=0.0;
}
else
{
l9_119=pow(l9_117,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_118=l9_119;
float3 l9_120=float3(0.0);
float3 l9_121=float3(l9_118);
float3 l9_122=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_123=l9_30;
int l9_124=3;
bool l9_125=true;
bool l9_126=true;
bool l9_127=true;
float l9_128=154.0;
ssParticle l9_129=gParticle;
float l9_130=0.0;
float l9_131=l9_123.gTimeElapsed;
float4 l9_132=float4(0.0);
float4 l9_133=float4(0.0);
if (l9_125)
{
l9_133.x=floor(fract(l9_131)*1000.0);
}
if (l9_127)
{
l9_133.y=float(l9_129.Index1D^((l9_129.Index1D*15299)+l9_129.Index1D));
}
if (l9_126)
{
l9_133.z=l9_128;
}
l9_133.w=l9_130*1000.0;
int l9_134=int(l9_133.x);
int l9_135=int(l9_133.y);
int l9_136=int(l9_133.z);
int l9_137=int(l9_133.w);
int l9_138=(((l9_134*15299)^(l9_135*30133))^(l9_136*17539))^(l9_137*12113);
int l9_139=l9_138;
if (l9_124==1)
{
int l9_140=l9_139;
int l9_141=l9_140;
int l9_142=((l9_141*((l9_141*1471343)+101146501))+1559861749)&2147483647;
int l9_143=l9_142;
float l9_144=float(l9_143)*4.6566129e-10;
float l9_145=l9_144;
l9_132.x=l9_145;
}
else
{
if (l9_124==2)
{
int l9_146=l9_139;
int l9_147=l9_146;
int l9_148=((l9_147*((l9_147*1471343)+101146501))+1559861749)&2147483647;
int l9_149=l9_148;
int l9_150=l9_146*1399;
int l9_151=((l9_150*((l9_150*1471343)+101146501))+1559861749)&2147483647;
int l9_152=l9_151;
int l9_153=l9_149;
float l9_154=float(l9_153)*4.6566129e-10;
int l9_155=l9_152;
float l9_156=float(l9_155)*4.6566129e-10;
float2 l9_157=float2(l9_154,l9_156);
l9_132=float4(l9_157.x,l9_157.y,l9_132.z,l9_132.w);
}
else
{
if (l9_124==3)
{
int l9_158=l9_139;
int l9_159=l9_158;
int l9_160=((l9_159*((l9_159*1471343)+101146501))+1559861749)&2147483647;
int l9_161=l9_160;
int l9_162=l9_158*1399;
int l9_163=((l9_162*((l9_162*1471343)+101146501))+1559861749)&2147483647;
int l9_164=l9_163;
int l9_165=l9_158*7177;
int l9_166=((l9_165*((l9_165*1471343)+101146501))+1559861749)&2147483647;
int l9_167=l9_166;
int l9_168=l9_161;
float l9_169=float(l9_168)*4.6566129e-10;
int l9_170=l9_164;
float l9_171=float(l9_170)*4.6566129e-10;
int l9_172=l9_167;
float l9_173=float(l9_172)*4.6566129e-10;
float3 l9_174=float3(l9_169,l9_171,l9_173);
l9_132=float4(l9_174.x,l9_174.y,l9_174.z,l9_132.w);
}
else
{
int l9_175=l9_139;
int l9_176=l9_175;
int l9_177=((l9_176*((l9_176*1471343)+101146501))+1559861749)&2147483647;
int l9_178=l9_177;
int l9_179=l9_175*1399;
int l9_180=((l9_179*((l9_179*1471343)+101146501))+1559861749)&2147483647;
int l9_181=l9_180;
int l9_182=l9_175*7177;
int l9_183=((l9_182*((l9_182*1471343)+101146501))+1559861749)&2147483647;
int l9_184=l9_183;
int l9_185=l9_175*18919;
int l9_186=((l9_185*((l9_185*1471343)+101146501))+1559861749)&2147483647;
int l9_187=l9_186;
int l9_188=l9_178;
float l9_189=float(l9_188)*4.6566129e-10;
int l9_190=l9_181;
float l9_191=float(l9_190)*4.6566129e-10;
int l9_192=l9_184;
float l9_193=float(l9_192)*4.6566129e-10;
int l9_194=l9_187;
float l9_195=float(l9_194)*4.6566129e-10;
float4 l9_196=float4(l9_189,l9_191,l9_193,l9_195);
l9_132=l9_196;
}
}
}
float4 l9_197=l9_132;
float4 l9_198=l9_197;
float3 l9_199=mix(l9_121,l9_122,l9_198.xyz);
l9_120=l9_199;
float3 l9_200=float3(0.0);
float l9_201;
if (l9_120.x<=0.0)
{
l9_201=0.0;
}
else
{
l9_201=sqrt(l9_120.x);
}
float l9_202=l9_201;
float l9_203;
if (l9_120.y<=0.0)
{
l9_203=0.0;
}
else
{
l9_203=sqrt(l9_120.y);
}
float l9_204=l9_203;
float l9_205;
if (l9_120.z<=0.0)
{
l9_205=0.0;
}
else
{
l9_205=sqrt(l9_120.z);
}
l9_200=float3(l9_202,l9_204,l9_205);
float3 l9_206=float3(0.0);
float l9_207;
if (l9_200.x<=0.0)
{
l9_207=0.0;
}
else
{
l9_207=sqrt(l9_200.x);
}
float l9_208=l9_207;
float l9_209;
if (l9_200.y<=0.0)
{
l9_209=0.0;
}
else
{
l9_209=sqrt(l9_200.y);
}
float l9_210=l9_209;
float l9_211;
if (l9_200.z<=0.0)
{
l9_211=0.0;
}
else
{
l9_211=sqrt(l9_200.z);
}
l9_206=float3(l9_208,l9_210,l9_211);
float l9_212=0.0;
l9_212=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_213=float3(0.0);
l9_213=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_214=float3(0.0);
l9_214=((l9_115*l9_206)*float3(l9_212))*l9_213;
float l9_215=0.0;
float3 l9_216=l9_214;
float l9_217=l9_216.x;
l9_215=l9_217;
float l9_218=0.0;
l9_218=abs(l9_215);
l9_28=l9_218;
l9_33=l9_28;
}
else
{
float3 l9_219=float3(0.0);
float3 l9_220=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_221=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_222=l9_30;
int l9_223=3;
bool l9_224=true;
bool l9_225=true;
bool l9_226=true;
float l9_227=150.0;
ssParticle l9_228=gParticle;
float l9_229=0.0;
float l9_230=l9_222.gTimeElapsed;
float4 l9_231=float4(0.0);
float4 l9_232=float4(0.0);
if (l9_224)
{
l9_232.x=floor(fract(l9_230)*1000.0);
}
if (l9_226)
{
l9_232.y=float(l9_228.Index1D^((l9_228.Index1D*15299)+l9_228.Index1D));
}
if (l9_225)
{
l9_232.z=l9_227;
}
l9_232.w=l9_229*1000.0;
int l9_233=int(l9_232.x);
int l9_234=int(l9_232.y);
int l9_235=int(l9_232.z);
int l9_236=int(l9_232.w);
int l9_237=(((l9_233*15299)^(l9_234*30133))^(l9_235*17539))^(l9_236*12113);
int l9_238=l9_237;
if (l9_223==1)
{
int l9_239=l9_238;
int l9_240=l9_239;
int l9_241=((l9_240*((l9_240*1471343)+101146501))+1559861749)&2147483647;
int l9_242=l9_241;
float l9_243=float(l9_242)*4.6566129e-10;
float l9_244=l9_243;
l9_231.x=l9_244;
}
else
{
if (l9_223==2)
{
int l9_245=l9_238;
int l9_246=l9_245;
int l9_247=((l9_246*((l9_246*1471343)+101146501))+1559861749)&2147483647;
int l9_248=l9_247;
int l9_249=l9_245*1399;
int l9_250=((l9_249*((l9_249*1471343)+101146501))+1559861749)&2147483647;
int l9_251=l9_250;
int l9_252=l9_248;
float l9_253=float(l9_252)*4.6566129e-10;
int l9_254=l9_251;
float l9_255=float(l9_254)*4.6566129e-10;
float2 l9_256=float2(l9_253,l9_255);
l9_231=float4(l9_256.x,l9_256.y,l9_231.z,l9_231.w);
}
else
{
if (l9_223==3)
{
int l9_257=l9_238;
int l9_258=l9_257;
int l9_259=((l9_258*((l9_258*1471343)+101146501))+1559861749)&2147483647;
int l9_260=l9_259;
int l9_261=l9_257*1399;
int l9_262=((l9_261*((l9_261*1471343)+101146501))+1559861749)&2147483647;
int l9_263=l9_262;
int l9_264=l9_257*7177;
int l9_265=((l9_264*((l9_264*1471343)+101146501))+1559861749)&2147483647;
int l9_266=l9_265;
int l9_267=l9_260;
float l9_268=float(l9_267)*4.6566129e-10;
int l9_269=l9_263;
float l9_270=float(l9_269)*4.6566129e-10;
int l9_271=l9_266;
float l9_272=float(l9_271)*4.6566129e-10;
float3 l9_273=float3(l9_268,l9_270,l9_272);
l9_231=float4(l9_273.x,l9_273.y,l9_273.z,l9_231.w);
}
else
{
int l9_274=l9_238;
int l9_275=l9_274;
int l9_276=((l9_275*((l9_275*1471343)+101146501))+1559861749)&2147483647;
int l9_277=l9_276;
int l9_278=l9_274*1399;
int l9_279=((l9_278*((l9_278*1471343)+101146501))+1559861749)&2147483647;
int l9_280=l9_279;
int l9_281=l9_274*7177;
int l9_282=((l9_281*((l9_281*1471343)+101146501))+1559861749)&2147483647;
int l9_283=l9_282;
int l9_284=l9_274*18919;
int l9_285=((l9_284*((l9_284*1471343)+101146501))+1559861749)&2147483647;
int l9_286=l9_285;
int l9_287=l9_277;
float l9_288=float(l9_287)*4.6566129e-10;
int l9_289=l9_280;
float l9_290=float(l9_289)*4.6566129e-10;
int l9_291=l9_283;
float l9_292=float(l9_291)*4.6566129e-10;
int l9_293=l9_286;
float l9_294=float(l9_293)*4.6566129e-10;
float4 l9_295=float4(l9_288,l9_290,l9_292,l9_294);
l9_231=l9_295;
}
}
}
float4 l9_296=l9_231;
float4 l9_297=l9_296;
float3 l9_298=mix(l9_220,l9_221,l9_297.xyz);
l9_219=l9_298;
float l9_299=0.0;
l9_299=length(l9_219);
float3 l9_300=float3(0.0);
l9_300=l9_219/(float3(l9_299)+float3(1.234e-06));
float l9_301=0.0;
l9_301=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_302=0.0;
l9_302=1.0-l9_301;
float l9_303=0.0;
float l9_304;
if (l9_302<=0.0)
{
l9_304=0.0;
}
else
{
l9_304=pow(l9_302,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_303=l9_304;
float3 l9_305=float3(0.0);
float3 l9_306=float3(l9_303);
float3 l9_307=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_308=l9_30;
int l9_309=3;
bool l9_310=true;
bool l9_311=true;
bool l9_312=true;
float l9_313=154.0;
ssParticle l9_314=gParticle;
float l9_315=0.0;
float l9_316=l9_308.gTimeElapsed;
float4 l9_317=float4(0.0);
float4 l9_318=float4(0.0);
if (l9_310)
{
l9_318.x=floor(fract(l9_316)*1000.0);
}
if (l9_312)
{
l9_318.y=float(l9_314.Index1D^((l9_314.Index1D*15299)+l9_314.Index1D));
}
if (l9_311)
{
l9_318.z=l9_313;
}
l9_318.w=l9_315*1000.0;
int l9_319=int(l9_318.x);
int l9_320=int(l9_318.y);
int l9_321=int(l9_318.z);
int l9_322=int(l9_318.w);
int l9_323=(((l9_319*15299)^(l9_320*30133))^(l9_321*17539))^(l9_322*12113);
int l9_324=l9_323;
if (l9_309==1)
{
int l9_325=l9_324;
int l9_326=l9_325;
int l9_327=((l9_326*((l9_326*1471343)+101146501))+1559861749)&2147483647;
int l9_328=l9_327;
float l9_329=float(l9_328)*4.6566129e-10;
float l9_330=l9_329;
l9_317.x=l9_330;
}
else
{
if (l9_309==2)
{
int l9_331=l9_324;
int l9_332=l9_331;
int l9_333=((l9_332*((l9_332*1471343)+101146501))+1559861749)&2147483647;
int l9_334=l9_333;
int l9_335=l9_331*1399;
int l9_336=((l9_335*((l9_335*1471343)+101146501))+1559861749)&2147483647;
int l9_337=l9_336;
int l9_338=l9_334;
float l9_339=float(l9_338)*4.6566129e-10;
int l9_340=l9_337;
float l9_341=float(l9_340)*4.6566129e-10;
float2 l9_342=float2(l9_339,l9_341);
l9_317=float4(l9_342.x,l9_342.y,l9_317.z,l9_317.w);
}
else
{
if (l9_309==3)
{
int l9_343=l9_324;
int l9_344=l9_343;
int l9_345=((l9_344*((l9_344*1471343)+101146501))+1559861749)&2147483647;
int l9_346=l9_345;
int l9_347=l9_343*1399;
int l9_348=((l9_347*((l9_347*1471343)+101146501))+1559861749)&2147483647;
int l9_349=l9_348;
int l9_350=l9_343*7177;
int l9_351=((l9_350*((l9_350*1471343)+101146501))+1559861749)&2147483647;
int l9_352=l9_351;
int l9_353=l9_346;
float l9_354=float(l9_353)*4.6566129e-10;
int l9_355=l9_349;
float l9_356=float(l9_355)*4.6566129e-10;
int l9_357=l9_352;
float l9_358=float(l9_357)*4.6566129e-10;
float3 l9_359=float3(l9_354,l9_356,l9_358);
l9_317=float4(l9_359.x,l9_359.y,l9_359.z,l9_317.w);
}
else
{
int l9_360=l9_324;
int l9_361=l9_360;
int l9_362=((l9_361*((l9_361*1471343)+101146501))+1559861749)&2147483647;
int l9_363=l9_362;
int l9_364=l9_360*1399;
int l9_365=((l9_364*((l9_364*1471343)+101146501))+1559861749)&2147483647;
int l9_366=l9_365;
int l9_367=l9_360*7177;
int l9_368=((l9_367*((l9_367*1471343)+101146501))+1559861749)&2147483647;
int l9_369=l9_368;
int l9_370=l9_360*18919;
int l9_371=((l9_370*((l9_370*1471343)+101146501))+1559861749)&2147483647;
int l9_372=l9_371;
int l9_373=l9_363;
float l9_374=float(l9_373)*4.6566129e-10;
int l9_375=l9_366;
float l9_376=float(l9_375)*4.6566129e-10;
int l9_377=l9_369;
float l9_378=float(l9_377)*4.6566129e-10;
int l9_379=l9_372;
float l9_380=float(l9_379)*4.6566129e-10;
float4 l9_381=float4(l9_374,l9_376,l9_378,l9_380);
l9_317=l9_381;
}
}
}
float4 l9_382=l9_317;
float4 l9_383=l9_382;
float3 l9_384=mix(l9_306,l9_307,l9_383.xyz);
l9_305=l9_384;
float3 l9_385=float3(0.0);
float l9_386;
if (l9_305.x<=0.0)
{
l9_386=0.0;
}
else
{
l9_386=sqrt(l9_305.x);
}
float l9_387=l9_386;
float l9_388;
if (l9_305.y<=0.0)
{
l9_388=0.0;
}
else
{
l9_388=sqrt(l9_305.y);
}
float l9_389=l9_388;
float l9_390;
if (l9_305.z<=0.0)
{
l9_390=0.0;
}
else
{
l9_390=sqrt(l9_305.z);
}
l9_385=float3(l9_387,l9_389,l9_390);
float3 l9_391=float3(0.0);
float l9_392;
if (l9_385.x<=0.0)
{
l9_392=0.0;
}
else
{
l9_392=sqrt(l9_385.x);
}
float l9_393=l9_392;
float l9_394;
if (l9_385.y<=0.0)
{
l9_394=0.0;
}
else
{
l9_394=sqrt(l9_385.y);
}
float l9_395=l9_394;
float l9_396;
if (l9_385.z<=0.0)
{
l9_396=0.0;
}
else
{
l9_396=sqrt(l9_385.z);
}
l9_391=float3(l9_393,l9_395,l9_396);
float l9_397=0.0;
l9_397=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_398=float3(0.0);
l9_398=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_399=float3(0.0);
l9_399=((l9_300*l9_391)*float3(l9_397))*l9_398;
float l9_400=0.0;
float3 l9_401=l9_399;
float l9_402=l9_401.x;
l9_400=l9_402;
l9_29=l9_400;
l9_33=l9_29;
}
l9_26=l9_33;
float l9_403=0.0;
float l9_404=0.0;
float l9_405=0.0;
float l9_406=0.0;
ssGlobals l9_407=param_1;
float l9_408=0.0;
l9_408=0.0;
float l9_409=0.0;
l9_409=float(l9_408==(*sc_set2.UserUniforms).Port_Input1_N162);
l9_404=l9_409;
float l9_410;
if ((l9_404*1.0)!=0.0)
{
float3 l9_411=float3(0.0);
float3 l9_412=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_413=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_414=l9_407;
int l9_415=3;
bool l9_416=true;
bool l9_417=true;
bool l9_418=true;
float l9_419=150.0;
ssParticle l9_420=gParticle;
float l9_421=0.0;
float l9_422=l9_414.gTimeElapsed;
float4 l9_423=float4(0.0);
float4 l9_424=float4(0.0);
if (l9_416)
{
l9_424.x=floor(fract(l9_422)*1000.0);
}
if (l9_418)
{
l9_424.y=float(l9_420.Index1D^((l9_420.Index1D*15299)+l9_420.Index1D));
}
if (l9_417)
{
l9_424.z=l9_419;
}
l9_424.w=l9_421*1000.0;
int l9_425=int(l9_424.x);
int l9_426=int(l9_424.y);
int l9_427=int(l9_424.z);
int l9_428=int(l9_424.w);
int l9_429=(((l9_425*15299)^(l9_426*30133))^(l9_427*17539))^(l9_428*12113);
int l9_430=l9_429;
if (l9_415==1)
{
int l9_431=l9_430;
int l9_432=l9_431;
int l9_433=((l9_432*((l9_432*1471343)+101146501))+1559861749)&2147483647;
int l9_434=l9_433;
float l9_435=float(l9_434)*4.6566129e-10;
float l9_436=l9_435;
l9_423.x=l9_436;
}
else
{
if (l9_415==2)
{
int l9_437=l9_430;
int l9_438=l9_437;
int l9_439=((l9_438*((l9_438*1471343)+101146501))+1559861749)&2147483647;
int l9_440=l9_439;
int l9_441=l9_437*1399;
int l9_442=((l9_441*((l9_441*1471343)+101146501))+1559861749)&2147483647;
int l9_443=l9_442;
int l9_444=l9_440;
float l9_445=float(l9_444)*4.6566129e-10;
int l9_446=l9_443;
float l9_447=float(l9_446)*4.6566129e-10;
float2 l9_448=float2(l9_445,l9_447);
l9_423=float4(l9_448.x,l9_448.y,l9_423.z,l9_423.w);
}
else
{
if (l9_415==3)
{
int l9_449=l9_430;
int l9_450=l9_449;
int l9_451=((l9_450*((l9_450*1471343)+101146501))+1559861749)&2147483647;
int l9_452=l9_451;
int l9_453=l9_449*1399;
int l9_454=((l9_453*((l9_453*1471343)+101146501))+1559861749)&2147483647;
int l9_455=l9_454;
int l9_456=l9_449*7177;
int l9_457=((l9_456*((l9_456*1471343)+101146501))+1559861749)&2147483647;
int l9_458=l9_457;
int l9_459=l9_452;
float l9_460=float(l9_459)*4.6566129e-10;
int l9_461=l9_455;
float l9_462=float(l9_461)*4.6566129e-10;
int l9_463=l9_458;
float l9_464=float(l9_463)*4.6566129e-10;
float3 l9_465=float3(l9_460,l9_462,l9_464);
l9_423=float4(l9_465.x,l9_465.y,l9_465.z,l9_423.w);
}
else
{
int l9_466=l9_430;
int l9_467=l9_466;
int l9_468=((l9_467*((l9_467*1471343)+101146501))+1559861749)&2147483647;
int l9_469=l9_468;
int l9_470=l9_466*1399;
int l9_471=((l9_470*((l9_470*1471343)+101146501))+1559861749)&2147483647;
int l9_472=l9_471;
int l9_473=l9_466*7177;
int l9_474=((l9_473*((l9_473*1471343)+101146501))+1559861749)&2147483647;
int l9_475=l9_474;
int l9_476=l9_466*18919;
int l9_477=((l9_476*((l9_476*1471343)+101146501))+1559861749)&2147483647;
int l9_478=l9_477;
int l9_479=l9_469;
float l9_480=float(l9_479)*4.6566129e-10;
int l9_481=l9_472;
float l9_482=float(l9_481)*4.6566129e-10;
int l9_483=l9_475;
float l9_484=float(l9_483)*4.6566129e-10;
int l9_485=l9_478;
float l9_486=float(l9_485)*4.6566129e-10;
float4 l9_487=float4(l9_480,l9_482,l9_484,l9_486);
l9_423=l9_487;
}
}
}
float4 l9_488=l9_423;
float4 l9_489=l9_488;
float3 l9_490=mix(l9_412,l9_413,l9_489.xyz);
l9_411=l9_490;
float l9_491=0.0;
l9_491=length(l9_411);
float3 l9_492=float3(0.0);
l9_492=l9_411/(float3(l9_491)+float3(1.234e-06));
float l9_493=0.0;
l9_493=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_494=0.0;
l9_494=1.0-l9_493;
float l9_495=0.0;
float l9_496;
if (l9_494<=0.0)
{
l9_496=0.0;
}
else
{
l9_496=pow(l9_494,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_495=l9_496;
float3 l9_497=float3(0.0);
float3 l9_498=float3(l9_495);
float3 l9_499=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_500=l9_407;
int l9_501=3;
bool l9_502=true;
bool l9_503=true;
bool l9_504=true;
float l9_505=154.0;
ssParticle l9_506=gParticle;
float l9_507=0.0;
float l9_508=l9_500.gTimeElapsed;
float4 l9_509=float4(0.0);
float4 l9_510=float4(0.0);
if (l9_502)
{
l9_510.x=floor(fract(l9_508)*1000.0);
}
if (l9_504)
{
l9_510.y=float(l9_506.Index1D^((l9_506.Index1D*15299)+l9_506.Index1D));
}
if (l9_503)
{
l9_510.z=l9_505;
}
l9_510.w=l9_507*1000.0;
int l9_511=int(l9_510.x);
int l9_512=int(l9_510.y);
int l9_513=int(l9_510.z);
int l9_514=int(l9_510.w);
int l9_515=(((l9_511*15299)^(l9_512*30133))^(l9_513*17539))^(l9_514*12113);
int l9_516=l9_515;
if (l9_501==1)
{
int l9_517=l9_516;
int l9_518=l9_517;
int l9_519=((l9_518*((l9_518*1471343)+101146501))+1559861749)&2147483647;
int l9_520=l9_519;
float l9_521=float(l9_520)*4.6566129e-10;
float l9_522=l9_521;
l9_509.x=l9_522;
}
else
{
if (l9_501==2)
{
int l9_523=l9_516;
int l9_524=l9_523;
int l9_525=((l9_524*((l9_524*1471343)+101146501))+1559861749)&2147483647;
int l9_526=l9_525;
int l9_527=l9_523*1399;
int l9_528=((l9_527*((l9_527*1471343)+101146501))+1559861749)&2147483647;
int l9_529=l9_528;
int l9_530=l9_526;
float l9_531=float(l9_530)*4.6566129e-10;
int l9_532=l9_529;
float l9_533=float(l9_532)*4.6566129e-10;
float2 l9_534=float2(l9_531,l9_533);
l9_509=float4(l9_534.x,l9_534.y,l9_509.z,l9_509.w);
}
else
{
if (l9_501==3)
{
int l9_535=l9_516;
int l9_536=l9_535;
int l9_537=((l9_536*((l9_536*1471343)+101146501))+1559861749)&2147483647;
int l9_538=l9_537;
int l9_539=l9_535*1399;
int l9_540=((l9_539*((l9_539*1471343)+101146501))+1559861749)&2147483647;
int l9_541=l9_540;
int l9_542=l9_535*7177;
int l9_543=((l9_542*((l9_542*1471343)+101146501))+1559861749)&2147483647;
int l9_544=l9_543;
int l9_545=l9_538;
float l9_546=float(l9_545)*4.6566129e-10;
int l9_547=l9_541;
float l9_548=float(l9_547)*4.6566129e-10;
int l9_549=l9_544;
float l9_550=float(l9_549)*4.6566129e-10;
float3 l9_551=float3(l9_546,l9_548,l9_550);
l9_509=float4(l9_551.x,l9_551.y,l9_551.z,l9_509.w);
}
else
{
int l9_552=l9_516;
int l9_553=l9_552;
int l9_554=((l9_553*((l9_553*1471343)+101146501))+1559861749)&2147483647;
int l9_555=l9_554;
int l9_556=l9_552*1399;
int l9_557=((l9_556*((l9_556*1471343)+101146501))+1559861749)&2147483647;
int l9_558=l9_557;
int l9_559=l9_552*7177;
int l9_560=((l9_559*((l9_559*1471343)+101146501))+1559861749)&2147483647;
int l9_561=l9_560;
int l9_562=l9_552*18919;
int l9_563=((l9_562*((l9_562*1471343)+101146501))+1559861749)&2147483647;
int l9_564=l9_563;
int l9_565=l9_555;
float l9_566=float(l9_565)*4.6566129e-10;
int l9_567=l9_558;
float l9_568=float(l9_567)*4.6566129e-10;
int l9_569=l9_561;
float l9_570=float(l9_569)*4.6566129e-10;
int l9_571=l9_564;
float l9_572=float(l9_571)*4.6566129e-10;
float4 l9_573=float4(l9_566,l9_568,l9_570,l9_572);
l9_509=l9_573;
}
}
}
float4 l9_574=l9_509;
float4 l9_575=l9_574;
float3 l9_576=mix(l9_498,l9_499,l9_575.xyz);
l9_497=l9_576;
float3 l9_577=float3(0.0);
float l9_578;
if (l9_497.x<=0.0)
{
l9_578=0.0;
}
else
{
l9_578=sqrt(l9_497.x);
}
float l9_579=l9_578;
float l9_580;
if (l9_497.y<=0.0)
{
l9_580=0.0;
}
else
{
l9_580=sqrt(l9_497.y);
}
float l9_581=l9_580;
float l9_582;
if (l9_497.z<=0.0)
{
l9_582=0.0;
}
else
{
l9_582=sqrt(l9_497.z);
}
l9_577=float3(l9_579,l9_581,l9_582);
float3 l9_583=float3(0.0);
float l9_584;
if (l9_577.x<=0.0)
{
l9_584=0.0;
}
else
{
l9_584=sqrt(l9_577.x);
}
float l9_585=l9_584;
float l9_586;
if (l9_577.y<=0.0)
{
l9_586=0.0;
}
else
{
l9_586=sqrt(l9_577.y);
}
float l9_587=l9_586;
float l9_588;
if (l9_577.z<=0.0)
{
l9_588=0.0;
}
else
{
l9_588=sqrt(l9_577.z);
}
l9_583=float3(l9_585,l9_587,l9_588);
float l9_589=0.0;
l9_589=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_590=float3(0.0);
l9_590=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_591=float3(0.0);
l9_591=((l9_492*l9_583)*float3(l9_589))*l9_590;
float l9_592=0.0;
float3 l9_593=l9_591;
float l9_594=l9_593.y;
l9_592=l9_594;
float l9_595=0.0;
l9_595=abs(l9_592);
l9_405=l9_595;
l9_410=l9_405;
}
else
{
float3 l9_596=float3(0.0);
float3 l9_597=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_598=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_599=l9_407;
int l9_600=3;
bool l9_601=true;
bool l9_602=true;
bool l9_603=true;
float l9_604=150.0;
ssParticle l9_605=gParticle;
float l9_606=0.0;
float l9_607=l9_599.gTimeElapsed;
float4 l9_608=float4(0.0);
float4 l9_609=float4(0.0);
if (l9_601)
{
l9_609.x=floor(fract(l9_607)*1000.0);
}
if (l9_603)
{
l9_609.y=float(l9_605.Index1D^((l9_605.Index1D*15299)+l9_605.Index1D));
}
if (l9_602)
{
l9_609.z=l9_604;
}
l9_609.w=l9_606*1000.0;
int l9_610=int(l9_609.x);
int l9_611=int(l9_609.y);
int l9_612=int(l9_609.z);
int l9_613=int(l9_609.w);
int l9_614=(((l9_610*15299)^(l9_611*30133))^(l9_612*17539))^(l9_613*12113);
int l9_615=l9_614;
if (l9_600==1)
{
int l9_616=l9_615;
int l9_617=l9_616;
int l9_618=((l9_617*((l9_617*1471343)+101146501))+1559861749)&2147483647;
int l9_619=l9_618;
float l9_620=float(l9_619)*4.6566129e-10;
float l9_621=l9_620;
l9_608.x=l9_621;
}
else
{
if (l9_600==2)
{
int l9_622=l9_615;
int l9_623=l9_622;
int l9_624=((l9_623*((l9_623*1471343)+101146501))+1559861749)&2147483647;
int l9_625=l9_624;
int l9_626=l9_622*1399;
int l9_627=((l9_626*((l9_626*1471343)+101146501))+1559861749)&2147483647;
int l9_628=l9_627;
int l9_629=l9_625;
float l9_630=float(l9_629)*4.6566129e-10;
int l9_631=l9_628;
float l9_632=float(l9_631)*4.6566129e-10;
float2 l9_633=float2(l9_630,l9_632);
l9_608=float4(l9_633.x,l9_633.y,l9_608.z,l9_608.w);
}
else
{
if (l9_600==3)
{
int l9_634=l9_615;
int l9_635=l9_634;
int l9_636=((l9_635*((l9_635*1471343)+101146501))+1559861749)&2147483647;
int l9_637=l9_636;
int l9_638=l9_634*1399;
int l9_639=((l9_638*((l9_638*1471343)+101146501))+1559861749)&2147483647;
int l9_640=l9_639;
int l9_641=l9_634*7177;
int l9_642=((l9_641*((l9_641*1471343)+101146501))+1559861749)&2147483647;
int l9_643=l9_642;
int l9_644=l9_637;
float l9_645=float(l9_644)*4.6566129e-10;
int l9_646=l9_640;
float l9_647=float(l9_646)*4.6566129e-10;
int l9_648=l9_643;
float l9_649=float(l9_648)*4.6566129e-10;
float3 l9_650=float3(l9_645,l9_647,l9_649);
l9_608=float4(l9_650.x,l9_650.y,l9_650.z,l9_608.w);
}
else
{
int l9_651=l9_615;
int l9_652=l9_651;
int l9_653=((l9_652*((l9_652*1471343)+101146501))+1559861749)&2147483647;
int l9_654=l9_653;
int l9_655=l9_651*1399;
int l9_656=((l9_655*((l9_655*1471343)+101146501))+1559861749)&2147483647;
int l9_657=l9_656;
int l9_658=l9_651*7177;
int l9_659=((l9_658*((l9_658*1471343)+101146501))+1559861749)&2147483647;
int l9_660=l9_659;
int l9_661=l9_651*18919;
int l9_662=((l9_661*((l9_661*1471343)+101146501))+1559861749)&2147483647;
int l9_663=l9_662;
int l9_664=l9_654;
float l9_665=float(l9_664)*4.6566129e-10;
int l9_666=l9_657;
float l9_667=float(l9_666)*4.6566129e-10;
int l9_668=l9_660;
float l9_669=float(l9_668)*4.6566129e-10;
int l9_670=l9_663;
float l9_671=float(l9_670)*4.6566129e-10;
float4 l9_672=float4(l9_665,l9_667,l9_669,l9_671);
l9_608=l9_672;
}
}
}
float4 l9_673=l9_608;
float4 l9_674=l9_673;
float3 l9_675=mix(l9_597,l9_598,l9_674.xyz);
l9_596=l9_675;
float l9_676=0.0;
l9_676=length(l9_596);
float3 l9_677=float3(0.0);
l9_677=l9_596/(float3(l9_676)+float3(1.234e-06));
float l9_678=0.0;
l9_678=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_679=0.0;
l9_679=1.0-l9_678;
float l9_680=0.0;
float l9_681;
if (l9_679<=0.0)
{
l9_681=0.0;
}
else
{
l9_681=pow(l9_679,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_680=l9_681;
float3 l9_682=float3(0.0);
float3 l9_683=float3(l9_680);
float3 l9_684=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_685=l9_407;
int l9_686=3;
bool l9_687=true;
bool l9_688=true;
bool l9_689=true;
float l9_690=154.0;
ssParticle l9_691=gParticle;
float l9_692=0.0;
float l9_693=l9_685.gTimeElapsed;
float4 l9_694=float4(0.0);
float4 l9_695=float4(0.0);
if (l9_687)
{
l9_695.x=floor(fract(l9_693)*1000.0);
}
if (l9_689)
{
l9_695.y=float(l9_691.Index1D^((l9_691.Index1D*15299)+l9_691.Index1D));
}
if (l9_688)
{
l9_695.z=l9_690;
}
l9_695.w=l9_692*1000.0;
int l9_696=int(l9_695.x);
int l9_697=int(l9_695.y);
int l9_698=int(l9_695.z);
int l9_699=int(l9_695.w);
int l9_700=(((l9_696*15299)^(l9_697*30133))^(l9_698*17539))^(l9_699*12113);
int l9_701=l9_700;
if (l9_686==1)
{
int l9_702=l9_701;
int l9_703=l9_702;
int l9_704=((l9_703*((l9_703*1471343)+101146501))+1559861749)&2147483647;
int l9_705=l9_704;
float l9_706=float(l9_705)*4.6566129e-10;
float l9_707=l9_706;
l9_694.x=l9_707;
}
else
{
if (l9_686==2)
{
int l9_708=l9_701;
int l9_709=l9_708;
int l9_710=((l9_709*((l9_709*1471343)+101146501))+1559861749)&2147483647;
int l9_711=l9_710;
int l9_712=l9_708*1399;
int l9_713=((l9_712*((l9_712*1471343)+101146501))+1559861749)&2147483647;
int l9_714=l9_713;
int l9_715=l9_711;
float l9_716=float(l9_715)*4.6566129e-10;
int l9_717=l9_714;
float l9_718=float(l9_717)*4.6566129e-10;
float2 l9_719=float2(l9_716,l9_718);
l9_694=float4(l9_719.x,l9_719.y,l9_694.z,l9_694.w);
}
else
{
if (l9_686==3)
{
int l9_720=l9_701;
int l9_721=l9_720;
int l9_722=((l9_721*((l9_721*1471343)+101146501))+1559861749)&2147483647;
int l9_723=l9_722;
int l9_724=l9_720*1399;
int l9_725=((l9_724*((l9_724*1471343)+101146501))+1559861749)&2147483647;
int l9_726=l9_725;
int l9_727=l9_720*7177;
int l9_728=((l9_727*((l9_727*1471343)+101146501))+1559861749)&2147483647;
int l9_729=l9_728;
int l9_730=l9_723;
float l9_731=float(l9_730)*4.6566129e-10;
int l9_732=l9_726;
float l9_733=float(l9_732)*4.6566129e-10;
int l9_734=l9_729;
float l9_735=float(l9_734)*4.6566129e-10;
float3 l9_736=float3(l9_731,l9_733,l9_735);
l9_694=float4(l9_736.x,l9_736.y,l9_736.z,l9_694.w);
}
else
{
int l9_737=l9_701;
int l9_738=l9_737;
int l9_739=((l9_738*((l9_738*1471343)+101146501))+1559861749)&2147483647;
int l9_740=l9_739;
int l9_741=l9_737*1399;
int l9_742=((l9_741*((l9_741*1471343)+101146501))+1559861749)&2147483647;
int l9_743=l9_742;
int l9_744=l9_737*7177;
int l9_745=((l9_744*((l9_744*1471343)+101146501))+1559861749)&2147483647;
int l9_746=l9_745;
int l9_747=l9_737*18919;
int l9_748=((l9_747*((l9_747*1471343)+101146501))+1559861749)&2147483647;
int l9_749=l9_748;
int l9_750=l9_740;
float l9_751=float(l9_750)*4.6566129e-10;
int l9_752=l9_743;
float l9_753=float(l9_752)*4.6566129e-10;
int l9_754=l9_746;
float l9_755=float(l9_754)*4.6566129e-10;
int l9_756=l9_749;
float l9_757=float(l9_756)*4.6566129e-10;
float4 l9_758=float4(l9_751,l9_753,l9_755,l9_757);
l9_694=l9_758;
}
}
}
float4 l9_759=l9_694;
float4 l9_760=l9_759;
float3 l9_761=mix(l9_683,l9_684,l9_760.xyz);
l9_682=l9_761;
float3 l9_762=float3(0.0);
float l9_763;
if (l9_682.x<=0.0)
{
l9_763=0.0;
}
else
{
l9_763=sqrt(l9_682.x);
}
float l9_764=l9_763;
float l9_765;
if (l9_682.y<=0.0)
{
l9_765=0.0;
}
else
{
l9_765=sqrt(l9_682.y);
}
float l9_766=l9_765;
float l9_767;
if (l9_682.z<=0.0)
{
l9_767=0.0;
}
else
{
l9_767=sqrt(l9_682.z);
}
l9_762=float3(l9_764,l9_766,l9_767);
float3 l9_768=float3(0.0);
float l9_769;
if (l9_762.x<=0.0)
{
l9_769=0.0;
}
else
{
l9_769=sqrt(l9_762.x);
}
float l9_770=l9_769;
float l9_771;
if (l9_762.y<=0.0)
{
l9_771=0.0;
}
else
{
l9_771=sqrt(l9_762.y);
}
float l9_772=l9_771;
float l9_773;
if (l9_762.z<=0.0)
{
l9_773=0.0;
}
else
{
l9_773=sqrt(l9_762.z);
}
l9_768=float3(l9_770,l9_772,l9_773);
float l9_774=0.0;
l9_774=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_775=float3(0.0);
l9_775=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_776=float3(0.0);
l9_776=((l9_677*l9_768)*float3(l9_774))*l9_775;
float l9_777=0.0;
float3 l9_778=l9_776;
float l9_779=l9_778.y;
l9_777=l9_779;
l9_406=l9_777;
l9_410=l9_406;
}
l9_403=l9_410;
float l9_780=0.0;
float l9_781=0.0;
float l9_782=0.0;
float l9_783=0.0;
ssGlobals l9_784=param_1;
float l9_785=0.0;
l9_785=0.0;
float l9_786=0.0;
l9_786=float(l9_785==(*sc_set2.UserUniforms).Port_Input1_N165);
l9_781=l9_786;
float l9_787;
if ((l9_781*1.0)!=0.0)
{
float3 l9_788=float3(0.0);
float3 l9_789=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_790=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_791=l9_784;
int l9_792=3;
bool l9_793=true;
bool l9_794=true;
bool l9_795=true;
float l9_796=150.0;
ssParticle l9_797=gParticle;
float l9_798=0.0;
float l9_799=l9_791.gTimeElapsed;
float4 l9_800=float4(0.0);
float4 l9_801=float4(0.0);
if (l9_793)
{
l9_801.x=floor(fract(l9_799)*1000.0);
}
if (l9_795)
{
l9_801.y=float(l9_797.Index1D^((l9_797.Index1D*15299)+l9_797.Index1D));
}
if (l9_794)
{
l9_801.z=l9_796;
}
l9_801.w=l9_798*1000.0;
int l9_802=int(l9_801.x);
int l9_803=int(l9_801.y);
int l9_804=int(l9_801.z);
int l9_805=int(l9_801.w);
int l9_806=(((l9_802*15299)^(l9_803*30133))^(l9_804*17539))^(l9_805*12113);
int l9_807=l9_806;
if (l9_792==1)
{
int l9_808=l9_807;
int l9_809=l9_808;
int l9_810=((l9_809*((l9_809*1471343)+101146501))+1559861749)&2147483647;
int l9_811=l9_810;
float l9_812=float(l9_811)*4.6566129e-10;
float l9_813=l9_812;
l9_800.x=l9_813;
}
else
{
if (l9_792==2)
{
int l9_814=l9_807;
int l9_815=l9_814;
int l9_816=((l9_815*((l9_815*1471343)+101146501))+1559861749)&2147483647;
int l9_817=l9_816;
int l9_818=l9_814*1399;
int l9_819=((l9_818*((l9_818*1471343)+101146501))+1559861749)&2147483647;
int l9_820=l9_819;
int l9_821=l9_817;
float l9_822=float(l9_821)*4.6566129e-10;
int l9_823=l9_820;
float l9_824=float(l9_823)*4.6566129e-10;
float2 l9_825=float2(l9_822,l9_824);
l9_800=float4(l9_825.x,l9_825.y,l9_800.z,l9_800.w);
}
else
{
if (l9_792==3)
{
int l9_826=l9_807;
int l9_827=l9_826;
int l9_828=((l9_827*((l9_827*1471343)+101146501))+1559861749)&2147483647;
int l9_829=l9_828;
int l9_830=l9_826*1399;
int l9_831=((l9_830*((l9_830*1471343)+101146501))+1559861749)&2147483647;
int l9_832=l9_831;
int l9_833=l9_826*7177;
int l9_834=((l9_833*((l9_833*1471343)+101146501))+1559861749)&2147483647;
int l9_835=l9_834;
int l9_836=l9_829;
float l9_837=float(l9_836)*4.6566129e-10;
int l9_838=l9_832;
float l9_839=float(l9_838)*4.6566129e-10;
int l9_840=l9_835;
float l9_841=float(l9_840)*4.6566129e-10;
float3 l9_842=float3(l9_837,l9_839,l9_841);
l9_800=float4(l9_842.x,l9_842.y,l9_842.z,l9_800.w);
}
else
{
int l9_843=l9_807;
int l9_844=l9_843;
int l9_845=((l9_844*((l9_844*1471343)+101146501))+1559861749)&2147483647;
int l9_846=l9_845;
int l9_847=l9_843*1399;
int l9_848=((l9_847*((l9_847*1471343)+101146501))+1559861749)&2147483647;
int l9_849=l9_848;
int l9_850=l9_843*7177;
int l9_851=((l9_850*((l9_850*1471343)+101146501))+1559861749)&2147483647;
int l9_852=l9_851;
int l9_853=l9_843*18919;
int l9_854=((l9_853*((l9_853*1471343)+101146501))+1559861749)&2147483647;
int l9_855=l9_854;
int l9_856=l9_846;
float l9_857=float(l9_856)*4.6566129e-10;
int l9_858=l9_849;
float l9_859=float(l9_858)*4.6566129e-10;
int l9_860=l9_852;
float l9_861=float(l9_860)*4.6566129e-10;
int l9_862=l9_855;
float l9_863=float(l9_862)*4.6566129e-10;
float4 l9_864=float4(l9_857,l9_859,l9_861,l9_863);
l9_800=l9_864;
}
}
}
float4 l9_865=l9_800;
float4 l9_866=l9_865;
float3 l9_867=mix(l9_789,l9_790,l9_866.xyz);
l9_788=l9_867;
float l9_868=0.0;
l9_868=length(l9_788);
float3 l9_869=float3(0.0);
l9_869=l9_788/(float3(l9_868)+float3(1.234e-06));
float l9_870=0.0;
l9_870=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_871=0.0;
l9_871=1.0-l9_870;
float l9_872=0.0;
float l9_873;
if (l9_871<=0.0)
{
l9_873=0.0;
}
else
{
l9_873=pow(l9_871,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_872=l9_873;
float3 l9_874=float3(0.0);
float3 l9_875=float3(l9_872);
float3 l9_876=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_877=l9_784;
int l9_878=3;
bool l9_879=true;
bool l9_880=true;
bool l9_881=true;
float l9_882=154.0;
ssParticle l9_883=gParticle;
float l9_884=0.0;
float l9_885=l9_877.gTimeElapsed;
float4 l9_886=float4(0.0);
float4 l9_887=float4(0.0);
if (l9_879)
{
l9_887.x=floor(fract(l9_885)*1000.0);
}
if (l9_881)
{
l9_887.y=float(l9_883.Index1D^((l9_883.Index1D*15299)+l9_883.Index1D));
}
if (l9_880)
{
l9_887.z=l9_882;
}
l9_887.w=l9_884*1000.0;
int l9_888=int(l9_887.x);
int l9_889=int(l9_887.y);
int l9_890=int(l9_887.z);
int l9_891=int(l9_887.w);
int l9_892=(((l9_888*15299)^(l9_889*30133))^(l9_890*17539))^(l9_891*12113);
int l9_893=l9_892;
if (l9_878==1)
{
int l9_894=l9_893;
int l9_895=l9_894;
int l9_896=((l9_895*((l9_895*1471343)+101146501))+1559861749)&2147483647;
int l9_897=l9_896;
float l9_898=float(l9_897)*4.6566129e-10;
float l9_899=l9_898;
l9_886.x=l9_899;
}
else
{
if (l9_878==2)
{
int l9_900=l9_893;
int l9_901=l9_900;
int l9_902=((l9_901*((l9_901*1471343)+101146501))+1559861749)&2147483647;
int l9_903=l9_902;
int l9_904=l9_900*1399;
int l9_905=((l9_904*((l9_904*1471343)+101146501))+1559861749)&2147483647;
int l9_906=l9_905;
int l9_907=l9_903;
float l9_908=float(l9_907)*4.6566129e-10;
int l9_909=l9_906;
float l9_910=float(l9_909)*4.6566129e-10;
float2 l9_911=float2(l9_908,l9_910);
l9_886=float4(l9_911.x,l9_911.y,l9_886.z,l9_886.w);
}
else
{
if (l9_878==3)
{
int l9_912=l9_893;
int l9_913=l9_912;
int l9_914=((l9_913*((l9_913*1471343)+101146501))+1559861749)&2147483647;
int l9_915=l9_914;
int l9_916=l9_912*1399;
int l9_917=((l9_916*((l9_916*1471343)+101146501))+1559861749)&2147483647;
int l9_918=l9_917;
int l9_919=l9_912*7177;
int l9_920=((l9_919*((l9_919*1471343)+101146501))+1559861749)&2147483647;
int l9_921=l9_920;
int l9_922=l9_915;
float l9_923=float(l9_922)*4.6566129e-10;
int l9_924=l9_918;
float l9_925=float(l9_924)*4.6566129e-10;
int l9_926=l9_921;
float l9_927=float(l9_926)*4.6566129e-10;
float3 l9_928=float3(l9_923,l9_925,l9_927);
l9_886=float4(l9_928.x,l9_928.y,l9_928.z,l9_886.w);
}
else
{
int l9_929=l9_893;
int l9_930=l9_929;
int l9_931=((l9_930*((l9_930*1471343)+101146501))+1559861749)&2147483647;
int l9_932=l9_931;
int l9_933=l9_929*1399;
int l9_934=((l9_933*((l9_933*1471343)+101146501))+1559861749)&2147483647;
int l9_935=l9_934;
int l9_936=l9_929*7177;
int l9_937=((l9_936*((l9_936*1471343)+101146501))+1559861749)&2147483647;
int l9_938=l9_937;
int l9_939=l9_929*18919;
int l9_940=((l9_939*((l9_939*1471343)+101146501))+1559861749)&2147483647;
int l9_941=l9_940;
int l9_942=l9_932;
float l9_943=float(l9_942)*4.6566129e-10;
int l9_944=l9_935;
float l9_945=float(l9_944)*4.6566129e-10;
int l9_946=l9_938;
float l9_947=float(l9_946)*4.6566129e-10;
int l9_948=l9_941;
float l9_949=float(l9_948)*4.6566129e-10;
float4 l9_950=float4(l9_943,l9_945,l9_947,l9_949);
l9_886=l9_950;
}
}
}
float4 l9_951=l9_886;
float4 l9_952=l9_951;
float3 l9_953=mix(l9_875,l9_876,l9_952.xyz);
l9_874=l9_953;
float3 l9_954=float3(0.0);
float l9_955;
if (l9_874.x<=0.0)
{
l9_955=0.0;
}
else
{
l9_955=sqrt(l9_874.x);
}
float l9_956=l9_955;
float l9_957;
if (l9_874.y<=0.0)
{
l9_957=0.0;
}
else
{
l9_957=sqrt(l9_874.y);
}
float l9_958=l9_957;
float l9_959;
if (l9_874.z<=0.0)
{
l9_959=0.0;
}
else
{
l9_959=sqrt(l9_874.z);
}
l9_954=float3(l9_956,l9_958,l9_959);
float3 l9_960=float3(0.0);
float l9_961;
if (l9_954.x<=0.0)
{
l9_961=0.0;
}
else
{
l9_961=sqrt(l9_954.x);
}
float l9_962=l9_961;
float l9_963;
if (l9_954.y<=0.0)
{
l9_963=0.0;
}
else
{
l9_963=sqrt(l9_954.y);
}
float l9_964=l9_963;
float l9_965;
if (l9_954.z<=0.0)
{
l9_965=0.0;
}
else
{
l9_965=sqrt(l9_954.z);
}
l9_960=float3(l9_962,l9_964,l9_965);
float l9_966=0.0;
l9_966=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_967=float3(0.0);
l9_967=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_968=float3(0.0);
l9_968=((l9_869*l9_960)*float3(l9_966))*l9_967;
float l9_969=0.0;
float3 l9_970=l9_968;
float l9_971=l9_970.z;
l9_969=l9_971;
float l9_972=0.0;
l9_972=abs(l9_969);
l9_782=l9_972;
l9_787=l9_782;
}
else
{
float3 l9_973=float3(0.0);
float3 l9_974=(*sc_set2.UserUniforms).Port_Min_N150;
float3 l9_975=(*sc_set2.UserUniforms).Port_Max_N150;
ssGlobals l9_976=l9_784;
int l9_977=3;
bool l9_978=true;
bool l9_979=true;
bool l9_980=true;
float l9_981=150.0;
ssParticle l9_982=gParticle;
float l9_983=0.0;
float l9_984=l9_976.gTimeElapsed;
float4 l9_985=float4(0.0);
float4 l9_986=float4(0.0);
if (l9_978)
{
l9_986.x=floor(fract(l9_984)*1000.0);
}
if (l9_980)
{
l9_986.y=float(l9_982.Index1D^((l9_982.Index1D*15299)+l9_982.Index1D));
}
if (l9_979)
{
l9_986.z=l9_981;
}
l9_986.w=l9_983*1000.0;
int l9_987=int(l9_986.x);
int l9_988=int(l9_986.y);
int l9_989=int(l9_986.z);
int l9_990=int(l9_986.w);
int l9_991=(((l9_987*15299)^(l9_988*30133))^(l9_989*17539))^(l9_990*12113);
int l9_992=l9_991;
if (l9_977==1)
{
int l9_993=l9_992;
int l9_994=l9_993;
int l9_995=((l9_994*((l9_994*1471343)+101146501))+1559861749)&2147483647;
int l9_996=l9_995;
float l9_997=float(l9_996)*4.6566129e-10;
float l9_998=l9_997;
l9_985.x=l9_998;
}
else
{
if (l9_977==2)
{
int l9_999=l9_992;
int l9_1000=l9_999;
int l9_1001=((l9_1000*((l9_1000*1471343)+101146501))+1559861749)&2147483647;
int l9_1002=l9_1001;
int l9_1003=l9_999*1399;
int l9_1004=((l9_1003*((l9_1003*1471343)+101146501))+1559861749)&2147483647;
int l9_1005=l9_1004;
int l9_1006=l9_1002;
float l9_1007=float(l9_1006)*4.6566129e-10;
int l9_1008=l9_1005;
float l9_1009=float(l9_1008)*4.6566129e-10;
float2 l9_1010=float2(l9_1007,l9_1009);
l9_985=float4(l9_1010.x,l9_1010.y,l9_985.z,l9_985.w);
}
else
{
if (l9_977==3)
{
int l9_1011=l9_992;
int l9_1012=l9_1011;
int l9_1013=((l9_1012*((l9_1012*1471343)+101146501))+1559861749)&2147483647;
int l9_1014=l9_1013;
int l9_1015=l9_1011*1399;
int l9_1016=((l9_1015*((l9_1015*1471343)+101146501))+1559861749)&2147483647;
int l9_1017=l9_1016;
int l9_1018=l9_1011*7177;
int l9_1019=((l9_1018*((l9_1018*1471343)+101146501))+1559861749)&2147483647;
int l9_1020=l9_1019;
int l9_1021=l9_1014;
float l9_1022=float(l9_1021)*4.6566129e-10;
int l9_1023=l9_1017;
float l9_1024=float(l9_1023)*4.6566129e-10;
int l9_1025=l9_1020;
float l9_1026=float(l9_1025)*4.6566129e-10;
float3 l9_1027=float3(l9_1022,l9_1024,l9_1026);
l9_985=float4(l9_1027.x,l9_1027.y,l9_1027.z,l9_985.w);
}
else
{
int l9_1028=l9_992;
int l9_1029=l9_1028;
int l9_1030=((l9_1029*((l9_1029*1471343)+101146501))+1559861749)&2147483647;
int l9_1031=l9_1030;
int l9_1032=l9_1028*1399;
int l9_1033=((l9_1032*((l9_1032*1471343)+101146501))+1559861749)&2147483647;
int l9_1034=l9_1033;
int l9_1035=l9_1028*7177;
int l9_1036=((l9_1035*((l9_1035*1471343)+101146501))+1559861749)&2147483647;
int l9_1037=l9_1036;
int l9_1038=l9_1028*18919;
int l9_1039=((l9_1038*((l9_1038*1471343)+101146501))+1559861749)&2147483647;
int l9_1040=l9_1039;
int l9_1041=l9_1031;
float l9_1042=float(l9_1041)*4.6566129e-10;
int l9_1043=l9_1034;
float l9_1044=float(l9_1043)*4.6566129e-10;
int l9_1045=l9_1037;
float l9_1046=float(l9_1045)*4.6566129e-10;
int l9_1047=l9_1040;
float l9_1048=float(l9_1047)*4.6566129e-10;
float4 l9_1049=float4(l9_1042,l9_1044,l9_1046,l9_1048);
l9_985=l9_1049;
}
}
}
float4 l9_1050=l9_985;
float4 l9_1051=l9_1050;
float3 l9_1052=mix(l9_974,l9_975,l9_1051.xyz);
l9_973=l9_1052;
float l9_1053=0.0;
l9_1053=length(l9_973);
float3 l9_1054=float3(0.0);
l9_1054=l9_973/(float3(l9_1053)+float3(1.234e-06));
float l9_1055=0.0;
l9_1055=fast::clamp((*sc_set2.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_1056=0.0;
l9_1056=1.0-l9_1055;
float l9_1057=0.0;
float l9_1058;
if (l9_1056<=0.0)
{
l9_1058=0.0;
}
else
{
l9_1058=pow(l9_1056,(*sc_set2.UserUniforms).Port_Input1_N153);
}
l9_1057=l9_1058;
float3 l9_1059=float3(0.0);
float3 l9_1060=float3(l9_1057);
float3 l9_1061=(*sc_set2.UserUniforms).Port_Max_N154;
ssGlobals l9_1062=l9_784;
int l9_1063=3;
bool l9_1064=true;
bool l9_1065=true;
bool l9_1066=true;
float l9_1067=154.0;
ssParticle l9_1068=gParticle;
float l9_1069=0.0;
float l9_1070=l9_1062.gTimeElapsed;
float4 l9_1071=float4(0.0);
float4 l9_1072=float4(0.0);
if (l9_1064)
{
l9_1072.x=floor(fract(l9_1070)*1000.0);
}
if (l9_1066)
{
l9_1072.y=float(l9_1068.Index1D^((l9_1068.Index1D*15299)+l9_1068.Index1D));
}
if (l9_1065)
{
l9_1072.z=l9_1067;
}
l9_1072.w=l9_1069*1000.0;
int l9_1073=int(l9_1072.x);
int l9_1074=int(l9_1072.y);
int l9_1075=int(l9_1072.z);
int l9_1076=int(l9_1072.w);
int l9_1077=(((l9_1073*15299)^(l9_1074*30133))^(l9_1075*17539))^(l9_1076*12113);
int l9_1078=l9_1077;
if (l9_1063==1)
{
int l9_1079=l9_1078;
int l9_1080=l9_1079;
int l9_1081=((l9_1080*((l9_1080*1471343)+101146501))+1559861749)&2147483647;
int l9_1082=l9_1081;
float l9_1083=float(l9_1082)*4.6566129e-10;
float l9_1084=l9_1083;
l9_1071.x=l9_1084;
}
else
{
if (l9_1063==2)
{
int l9_1085=l9_1078;
int l9_1086=l9_1085;
int l9_1087=((l9_1086*((l9_1086*1471343)+101146501))+1559861749)&2147483647;
int l9_1088=l9_1087;
int l9_1089=l9_1085*1399;
int l9_1090=((l9_1089*((l9_1089*1471343)+101146501))+1559861749)&2147483647;
int l9_1091=l9_1090;
int l9_1092=l9_1088;
float l9_1093=float(l9_1092)*4.6566129e-10;
int l9_1094=l9_1091;
float l9_1095=float(l9_1094)*4.6566129e-10;
float2 l9_1096=float2(l9_1093,l9_1095);
l9_1071=float4(l9_1096.x,l9_1096.y,l9_1071.z,l9_1071.w);
}
else
{
if (l9_1063==3)
{
int l9_1097=l9_1078;
int l9_1098=l9_1097;
int l9_1099=((l9_1098*((l9_1098*1471343)+101146501))+1559861749)&2147483647;
int l9_1100=l9_1099;
int l9_1101=l9_1097*1399;
int l9_1102=((l9_1101*((l9_1101*1471343)+101146501))+1559861749)&2147483647;
int l9_1103=l9_1102;
int l9_1104=l9_1097*7177;
int l9_1105=((l9_1104*((l9_1104*1471343)+101146501))+1559861749)&2147483647;
int l9_1106=l9_1105;
int l9_1107=l9_1100;
float l9_1108=float(l9_1107)*4.6566129e-10;
int l9_1109=l9_1103;
float l9_1110=float(l9_1109)*4.6566129e-10;
int l9_1111=l9_1106;
float l9_1112=float(l9_1111)*4.6566129e-10;
float3 l9_1113=float3(l9_1108,l9_1110,l9_1112);
l9_1071=float4(l9_1113.x,l9_1113.y,l9_1113.z,l9_1071.w);
}
else
{
int l9_1114=l9_1078;
int l9_1115=l9_1114;
int l9_1116=((l9_1115*((l9_1115*1471343)+101146501))+1559861749)&2147483647;
int l9_1117=l9_1116;
int l9_1118=l9_1114*1399;
int l9_1119=((l9_1118*((l9_1118*1471343)+101146501))+1559861749)&2147483647;
int l9_1120=l9_1119;
int l9_1121=l9_1114*7177;
int l9_1122=((l9_1121*((l9_1121*1471343)+101146501))+1559861749)&2147483647;
int l9_1123=l9_1122;
int l9_1124=l9_1114*18919;
int l9_1125=((l9_1124*((l9_1124*1471343)+101146501))+1559861749)&2147483647;
int l9_1126=l9_1125;
int l9_1127=l9_1117;
float l9_1128=float(l9_1127)*4.6566129e-10;
int l9_1129=l9_1120;
float l9_1130=float(l9_1129)*4.6566129e-10;
int l9_1131=l9_1123;
float l9_1132=float(l9_1131)*4.6566129e-10;
int l9_1133=l9_1126;
float l9_1134=float(l9_1133)*4.6566129e-10;
float4 l9_1135=float4(l9_1128,l9_1130,l9_1132,l9_1134);
l9_1071=l9_1135;
}
}
}
float4 l9_1136=l9_1071;
float4 l9_1137=l9_1136;
float3 l9_1138=mix(l9_1060,l9_1061,l9_1137.xyz);
l9_1059=l9_1138;
float3 l9_1139=float3(0.0);
float l9_1140;
if (l9_1059.x<=0.0)
{
l9_1140=0.0;
}
else
{
l9_1140=sqrt(l9_1059.x);
}
float l9_1141=l9_1140;
float l9_1142;
if (l9_1059.y<=0.0)
{
l9_1142=0.0;
}
else
{
l9_1142=sqrt(l9_1059.y);
}
float l9_1143=l9_1142;
float l9_1144;
if (l9_1059.z<=0.0)
{
l9_1144=0.0;
}
else
{
l9_1144=sqrt(l9_1059.z);
}
l9_1139=float3(l9_1141,l9_1143,l9_1144);
float3 l9_1145=float3(0.0);
float l9_1146;
if (l9_1139.x<=0.0)
{
l9_1146=0.0;
}
else
{
l9_1146=sqrt(l9_1139.x);
}
float l9_1147=l9_1146;
float l9_1148;
if (l9_1139.y<=0.0)
{
l9_1148=0.0;
}
else
{
l9_1148=sqrt(l9_1139.y);
}
float l9_1149=l9_1148;
float l9_1150;
if (l9_1139.z<=0.0)
{
l9_1150=0.0;
}
else
{
l9_1150=sqrt(l9_1139.z);
}
l9_1145=float3(l9_1147,l9_1149,l9_1150);
float l9_1151=0.0;
l9_1151=(*sc_set2.UserUniforms).Port_Import_N157;
float3 l9_1152=float3(0.0);
l9_1152=(*sc_set2.UserUniforms).Port_Import_N158;
float3 l9_1153=float3(0.0);
l9_1153=((l9_1054*l9_1145)*float3(l9_1151))*l9_1152;
float l9_1154=0.0;
float3 l9_1155=l9_1153;
float l9_1156=l9_1155.z;
l9_1154=l9_1156;
l9_783=l9_1154;
l9_787=l9_783;
}
l9_780=l9_787;
float3 l9_1157=float3(0.0);
l9_1157.x=l9_26;
l9_1157.y=l9_403;
l9_1157.z=l9_780;
float3 l9_1158=float3(0.0);
l9_1158=l9_25+l9_1157;
gParticle.Position=l9_1158;
float l9_1159=0.0;
float l9_1160=1.0;
float l9_1161=1.0;
float l9_1162=0.0;
ssGlobals l9_1163=param_1;
float l9_1164=0.0;
l9_1164=1.0;
l9_1160=l9_1164;
float l9_1165;
if ((l9_1160*1.0)!=0.0)
{
float l9_1166=0.0;
l9_1166=(*sc_set2.UserUniforms).Port_Import_N042;
float l9_1167=0.0;
l9_1167=(*sc_set2.UserUniforms).Port_Import_N043;
float l9_1168=0.0;
float l9_1169=l9_1166;
float l9_1170=l9_1167;
ssGlobals l9_1171=l9_1163;
int l9_1172=1;
bool l9_1173=false;
bool l9_1174=true;
bool l9_1175=true;
float l9_1176=44.0;
ssParticle l9_1177=gParticle;
float l9_1178=0.0;
float l9_1179=l9_1171.gTimeElapsed;
float4 l9_1180=float4(0.0);
float4 l9_1181=float4(0.0);
if (l9_1173)
{
l9_1181.x=floor(fract(l9_1179)*1000.0);
}
if (l9_1175)
{
l9_1181.y=float(l9_1177.Index1D^((l9_1177.Index1D*15299)+l9_1177.Index1D));
}
if (l9_1174)
{
l9_1181.z=l9_1176;
}
l9_1181.w=l9_1178*1000.0;
int l9_1182=int(l9_1181.x);
int l9_1183=int(l9_1181.y);
int l9_1184=int(l9_1181.z);
int l9_1185=int(l9_1181.w);
int l9_1186=(((l9_1182*15299)^(l9_1183*30133))^(l9_1184*17539))^(l9_1185*12113);
int l9_1187=l9_1186;
if (l9_1172==1)
{
int l9_1188=l9_1187;
int l9_1189=l9_1188;
int l9_1190=((l9_1189*((l9_1189*1471343)+101146501))+1559861749)&2147483647;
int l9_1191=l9_1190;
float l9_1192=float(l9_1191)*4.6566129e-10;
float l9_1193=l9_1192;
l9_1180.x=l9_1193;
}
else
{
if (l9_1172==2)
{
int l9_1194=l9_1187;
int l9_1195=l9_1194;
int l9_1196=((l9_1195*((l9_1195*1471343)+101146501))+1559861749)&2147483647;
int l9_1197=l9_1196;
int l9_1198=l9_1194*1399;
int l9_1199=((l9_1198*((l9_1198*1471343)+101146501))+1559861749)&2147483647;
int l9_1200=l9_1199;
int l9_1201=l9_1197;
float l9_1202=float(l9_1201)*4.6566129e-10;
int l9_1203=l9_1200;
float l9_1204=float(l9_1203)*4.6566129e-10;
float2 l9_1205=float2(l9_1202,l9_1204);
l9_1180=float4(l9_1205.x,l9_1205.y,l9_1180.z,l9_1180.w);
}
else
{
if (l9_1172==3)
{
int l9_1206=l9_1187;
int l9_1207=l9_1206;
int l9_1208=((l9_1207*((l9_1207*1471343)+101146501))+1559861749)&2147483647;
int l9_1209=l9_1208;
int l9_1210=l9_1206*1399;
int l9_1211=((l9_1210*((l9_1210*1471343)+101146501))+1559861749)&2147483647;
int l9_1212=l9_1211;
int l9_1213=l9_1206*7177;
int l9_1214=((l9_1213*((l9_1213*1471343)+101146501))+1559861749)&2147483647;
int l9_1215=l9_1214;
int l9_1216=l9_1209;
float l9_1217=float(l9_1216)*4.6566129e-10;
int l9_1218=l9_1212;
float l9_1219=float(l9_1218)*4.6566129e-10;
int l9_1220=l9_1215;
float l9_1221=float(l9_1220)*4.6566129e-10;
float3 l9_1222=float3(l9_1217,l9_1219,l9_1221);
l9_1180=float4(l9_1222.x,l9_1222.y,l9_1222.z,l9_1180.w);
}
else
{
int l9_1223=l9_1187;
int l9_1224=l9_1223;
int l9_1225=((l9_1224*((l9_1224*1471343)+101146501))+1559861749)&2147483647;
int l9_1226=l9_1225;
int l9_1227=l9_1223*1399;
int l9_1228=((l9_1227*((l9_1227*1471343)+101146501))+1559861749)&2147483647;
int l9_1229=l9_1228;
int l9_1230=l9_1223*7177;
int l9_1231=((l9_1230*((l9_1230*1471343)+101146501))+1559861749)&2147483647;
int l9_1232=l9_1231;
int l9_1233=l9_1223*18919;
int l9_1234=((l9_1233*((l9_1233*1471343)+101146501))+1559861749)&2147483647;
int l9_1235=l9_1234;
int l9_1236=l9_1226;
float l9_1237=float(l9_1236)*4.6566129e-10;
int l9_1238=l9_1229;
float l9_1239=float(l9_1238)*4.6566129e-10;
int l9_1240=l9_1232;
float l9_1241=float(l9_1240)*4.6566129e-10;
int l9_1242=l9_1235;
float l9_1243=float(l9_1242)*4.6566129e-10;
float4 l9_1244=float4(l9_1237,l9_1239,l9_1241,l9_1243);
l9_1180=l9_1244;
}
}
}
float4 l9_1245=l9_1180;
float4 l9_1246=l9_1245;
float l9_1247=mix(l9_1169,l9_1170,l9_1246.x);
l9_1168=l9_1247;
float3 l9_1248=float3(0.0);
l9_1248=(*sc_set2.UserUniforms).vfxLocalAabbMax;
float3 l9_1249=float3(0.0);
l9_1249=(*sc_set2.UserUniforms).vfxLocalAabbMin;
float3 l9_1250=float3(0.0);
l9_1250=l9_1248-l9_1249;
float l9_1251=0.0;
l9_1251=length(l9_1250);
float l9_1252=0.0;
l9_1252=l9_1168/(l9_1251+1.234e-06);
l9_1161=l9_1252;
l9_1165=l9_1161;
}
else
{
float l9_1253=0.0;
l9_1253=(*sc_set2.UserUniforms).Port_Import_N042;
float l9_1254=0.0;
l9_1254=(*sc_set2.UserUniforms).Port_Import_N043;
float l9_1255=0.0;
float l9_1256=l9_1253;
float l9_1257=l9_1254;
ssGlobals l9_1258=l9_1163;
int l9_1259=1;
bool l9_1260=false;
bool l9_1261=true;
bool l9_1262=true;
float l9_1263=44.0;
ssParticle l9_1264=gParticle;
float l9_1265=0.0;
float l9_1266=l9_1258.gTimeElapsed;
float4 l9_1267=float4(0.0);
float4 l9_1268=float4(0.0);
if (l9_1260)
{
l9_1268.x=floor(fract(l9_1266)*1000.0);
}
if (l9_1262)
{
l9_1268.y=float(l9_1264.Index1D^((l9_1264.Index1D*15299)+l9_1264.Index1D));
}
if (l9_1261)
{
l9_1268.z=l9_1263;
}
l9_1268.w=l9_1265*1000.0;
int l9_1269=int(l9_1268.x);
int l9_1270=int(l9_1268.y);
int l9_1271=int(l9_1268.z);
int l9_1272=int(l9_1268.w);
int l9_1273=(((l9_1269*15299)^(l9_1270*30133))^(l9_1271*17539))^(l9_1272*12113);
int l9_1274=l9_1273;
if (l9_1259==1)
{
int l9_1275=l9_1274;
int l9_1276=l9_1275;
int l9_1277=((l9_1276*((l9_1276*1471343)+101146501))+1559861749)&2147483647;
int l9_1278=l9_1277;
float l9_1279=float(l9_1278)*4.6566129e-10;
float l9_1280=l9_1279;
l9_1267.x=l9_1280;
}
else
{
if (l9_1259==2)
{
int l9_1281=l9_1274;
int l9_1282=l9_1281;
int l9_1283=((l9_1282*((l9_1282*1471343)+101146501))+1559861749)&2147483647;
int l9_1284=l9_1283;
int l9_1285=l9_1281*1399;
int l9_1286=((l9_1285*((l9_1285*1471343)+101146501))+1559861749)&2147483647;
int l9_1287=l9_1286;
int l9_1288=l9_1284;
float l9_1289=float(l9_1288)*4.6566129e-10;
int l9_1290=l9_1287;
float l9_1291=float(l9_1290)*4.6566129e-10;
float2 l9_1292=float2(l9_1289,l9_1291);
l9_1267=float4(l9_1292.x,l9_1292.y,l9_1267.z,l9_1267.w);
}
else
{
if (l9_1259==3)
{
int l9_1293=l9_1274;
int l9_1294=l9_1293;
int l9_1295=((l9_1294*((l9_1294*1471343)+101146501))+1559861749)&2147483647;
int l9_1296=l9_1295;
int l9_1297=l9_1293*1399;
int l9_1298=((l9_1297*((l9_1297*1471343)+101146501))+1559861749)&2147483647;
int l9_1299=l9_1298;
int l9_1300=l9_1293*7177;
int l9_1301=((l9_1300*((l9_1300*1471343)+101146501))+1559861749)&2147483647;
int l9_1302=l9_1301;
int l9_1303=l9_1296;
float l9_1304=float(l9_1303)*4.6566129e-10;
int l9_1305=l9_1299;
float l9_1306=float(l9_1305)*4.6566129e-10;
int l9_1307=l9_1302;
float l9_1308=float(l9_1307)*4.6566129e-10;
float3 l9_1309=float3(l9_1304,l9_1306,l9_1308);
l9_1267=float4(l9_1309.x,l9_1309.y,l9_1309.z,l9_1267.w);
}
else
{
int l9_1310=l9_1274;
int l9_1311=l9_1310;
int l9_1312=((l9_1311*((l9_1311*1471343)+101146501))+1559861749)&2147483647;
int l9_1313=l9_1312;
int l9_1314=l9_1310*1399;
int l9_1315=((l9_1314*((l9_1314*1471343)+101146501))+1559861749)&2147483647;
int l9_1316=l9_1315;
int l9_1317=l9_1310*7177;
int l9_1318=((l9_1317*((l9_1317*1471343)+101146501))+1559861749)&2147483647;
int l9_1319=l9_1318;
int l9_1320=l9_1310*18919;
int l9_1321=((l9_1320*((l9_1320*1471343)+101146501))+1559861749)&2147483647;
int l9_1322=l9_1321;
int l9_1323=l9_1313;
float l9_1324=float(l9_1323)*4.6566129e-10;
int l9_1325=l9_1316;
float l9_1326=float(l9_1325)*4.6566129e-10;
int l9_1327=l9_1319;
float l9_1328=float(l9_1327)*4.6566129e-10;
int l9_1329=l9_1322;
float l9_1330=float(l9_1329)*4.6566129e-10;
float4 l9_1331=float4(l9_1324,l9_1326,l9_1328,l9_1330);
l9_1267=l9_1331;
}
}
}
float4 l9_1332=l9_1267;
float4 l9_1333=l9_1332;
float l9_1334=mix(l9_1256,l9_1257,l9_1333.x);
l9_1255=l9_1334;
l9_1162=l9_1255;
l9_1165=l9_1162;
}
l9_1159=l9_1165;
gParticle.Size=l9_1159;
float l9_1335=0.0;
l9_1335=(*sc_set2.UserUniforms).Port_Import_N023;
float l9_1336=0.0;
l9_1336=(*sc_set2.UserUniforms).Port_Import_N024;
float l9_1337=0.0;
float l9_1338=l9_1335;
float l9_1339=l9_1336;
ssGlobals l9_1340=param_1;
int l9_1341=1;
bool l9_1342=false;
bool l9_1343=true;
bool l9_1344=true;
float l9_1345=26.0;
ssParticle l9_1346=gParticle;
float l9_1347=0.0;
float l9_1348=l9_1340.gTimeElapsed;
float4 l9_1349=float4(0.0);
float4 l9_1350=float4(0.0);
if (l9_1342)
{
l9_1350.x=floor(fract(l9_1348)*1000.0);
}
if (l9_1344)
{
l9_1350.y=float(l9_1346.Index1D^((l9_1346.Index1D*15299)+l9_1346.Index1D));
}
if (l9_1343)
{
l9_1350.z=l9_1345;
}
l9_1350.w=l9_1347*1000.0;
int l9_1351=int(l9_1350.x);
int l9_1352=int(l9_1350.y);
int l9_1353=int(l9_1350.z);
int l9_1354=int(l9_1350.w);
int l9_1355=(((l9_1351*15299)^(l9_1352*30133))^(l9_1353*17539))^(l9_1354*12113);
int l9_1356=l9_1355;
if (l9_1341==1)
{
int l9_1357=l9_1356;
int l9_1358=l9_1357;
int l9_1359=((l9_1358*((l9_1358*1471343)+101146501))+1559861749)&2147483647;
int l9_1360=l9_1359;
float l9_1361=float(l9_1360)*4.6566129e-10;
float l9_1362=l9_1361;
l9_1349.x=l9_1362;
}
else
{
if (l9_1341==2)
{
int l9_1363=l9_1356;
int l9_1364=l9_1363;
int l9_1365=((l9_1364*((l9_1364*1471343)+101146501))+1559861749)&2147483647;
int l9_1366=l9_1365;
int l9_1367=l9_1363*1399;
int l9_1368=((l9_1367*((l9_1367*1471343)+101146501))+1559861749)&2147483647;
int l9_1369=l9_1368;
int l9_1370=l9_1366;
float l9_1371=float(l9_1370)*4.6566129e-10;
int l9_1372=l9_1369;
float l9_1373=float(l9_1372)*4.6566129e-10;
float2 l9_1374=float2(l9_1371,l9_1373);
l9_1349=float4(l9_1374.x,l9_1374.y,l9_1349.z,l9_1349.w);
}
else
{
if (l9_1341==3)
{
int l9_1375=l9_1356;
int l9_1376=l9_1375;
int l9_1377=((l9_1376*((l9_1376*1471343)+101146501))+1559861749)&2147483647;
int l9_1378=l9_1377;
int l9_1379=l9_1375*1399;
int l9_1380=((l9_1379*((l9_1379*1471343)+101146501))+1559861749)&2147483647;
int l9_1381=l9_1380;
int l9_1382=l9_1375*7177;
int l9_1383=((l9_1382*((l9_1382*1471343)+101146501))+1559861749)&2147483647;
int l9_1384=l9_1383;
int l9_1385=l9_1378;
float l9_1386=float(l9_1385)*4.6566129e-10;
int l9_1387=l9_1381;
float l9_1388=float(l9_1387)*4.6566129e-10;
int l9_1389=l9_1384;
float l9_1390=float(l9_1389)*4.6566129e-10;
float3 l9_1391=float3(l9_1386,l9_1388,l9_1390);
l9_1349=float4(l9_1391.x,l9_1391.y,l9_1391.z,l9_1349.w);
}
else
{
int l9_1392=l9_1356;
int l9_1393=l9_1392;
int l9_1394=((l9_1393*((l9_1393*1471343)+101146501))+1559861749)&2147483647;
int l9_1395=l9_1394;
int l9_1396=l9_1392*1399;
int l9_1397=((l9_1396*((l9_1396*1471343)+101146501))+1559861749)&2147483647;
int l9_1398=l9_1397;
int l9_1399=l9_1392*7177;
int l9_1400=((l9_1399*((l9_1399*1471343)+101146501))+1559861749)&2147483647;
int l9_1401=l9_1400;
int l9_1402=l9_1392*18919;
int l9_1403=((l9_1402*((l9_1402*1471343)+101146501))+1559861749)&2147483647;
int l9_1404=l9_1403;
int l9_1405=l9_1395;
float l9_1406=float(l9_1405)*4.6566129e-10;
int l9_1407=l9_1398;
float l9_1408=float(l9_1407)*4.6566129e-10;
int l9_1409=l9_1401;
float l9_1410=float(l9_1409)*4.6566129e-10;
int l9_1411=l9_1404;
float l9_1412=float(l9_1411)*4.6566129e-10;
float4 l9_1413=float4(l9_1406,l9_1408,l9_1410,l9_1412);
l9_1349=l9_1413;
}
}
}
float4 l9_1414=l9_1349;
float4 l9_1415=l9_1414;
float l9_1416=mix(l9_1338,l9_1339,l9_1415.x);
l9_1337=l9_1416;
float l9_1417=l9_1337;
gParticle.Mass=l9_1417;
gParticle.Mass=fast::max(9.9999997e-06,gParticle.Mass);
float l9_1418=0.0;
l9_1418=(*sc_set2.UserUniforms).Port_Import_N053;
float3 l9_1419=float3(0.0);
l9_1419=(*sc_set2.UserUniforms).Port_Import_N054;
float3 l9_1420=float3(0.0);
l9_1420=gParticle.Position;
float3 l9_1421=float3(0.0);
l9_1421=l9_1419-l9_1420;
float3 l9_1422=float3(0.0);
float3 l9_1423=l9_1421;
float l9_1424=dot(l9_1423,l9_1423);
float l9_1425;
if (l9_1424>0.0)
{
l9_1425=1.0/sqrt(l9_1424);
}
else
{
l9_1425=0.0;
}
float l9_1426=l9_1425;
float3 l9_1427=l9_1423*l9_1426;
l9_1422=l9_1427;
float3 l9_1428=float3(0.0);
l9_1428=float3(l9_1418)*l9_1422;
gParticle.Force+=l9_1428;
float3 l9_1429=float3(0.0);
l9_1429=(*sc_set2.UserUniforms).Port_Import_N187;
float3 l9_1430=float3(0.0);
float3 l9_1431=l9_1429;
float l9_1432=dot(l9_1431,l9_1431);
float l9_1433;
if (l9_1432>0.0)
{
l9_1433=1.0/sqrt(l9_1432);
}
else
{
l9_1433=0.0;
}
float l9_1434=l9_1433;
float3 l9_1435=l9_1431*l9_1434;
l9_1430=l9_1435;
float l9_1436=0.0;
float l9_1437=(*sc_set2.UserUniforms).particles_speed;
l9_1436=l9_1437;
float l9_1438=0.0;
l9_1438=l9_1436;
float3 l9_1439=float3(0.0);
l9_1439=l9_1430*float3(l9_1438);
gParticle.Force+=l9_1439;
float l9_1440=0.0;
l9_1440=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float l9_1441=0.0;
float l9_1442=(*sc_set2.UserUniforms).particlesReduce;
l9_1441=l9_1442;
float l9_1443=0.0;
l9_1443=1.0-l9_1441;
float l9_1444=0.0;
l9_1444=float(l9_1440>l9_1443);
float l9_1445=l9_1444;
if ((l9_1445*1.0)!=0.0)
{
gParticle.Dead=true;
}
gParticle.Velocity+=((gParticle.Force/float3(gParticle.Mass))*0.033330001);
gParticle.Force=float3(0.0);
int l9_1446=gl_InstanceIndex;
gParticle.Position=((*sc_set2.UserUniforms).vfxModelMatrix[l9_1446/40]*float4(gParticle.Position,1.0)).xyz;
int l9_1447=gl_InstanceIndex;
int l9_1448=l9_1447/40;
gParticle.Velocity=float3x3((*sc_set2.UserUniforms).vfxModelMatrix[l9_1448][0].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1448][1].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1448][2].xyz)*gParticle.Velocity;
int l9_1449=gl_InstanceIndex;
int l9_1450=l9_1449/40;
gParticle.Force=float3x3((*sc_set2.UserUniforms).vfxModelMatrix[l9_1450][0].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1450][1].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1450][2].xyz)*gParticle.Force;
int l9_1451=gl_InstanceIndex;
int l9_1452=l9_1451/40;
gParticle.Matrix=float3x3((*sc_set2.UserUniforms).vfxModelMatrix[l9_1452][0].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1452][1].xyz,(*sc_set2.UserUniforms).vfxModelMatrix[l9_1452][2].xyz)*gParticle.Matrix;
int l9_1453=gl_InstanceIndex;
int l9_1454=gl_InstanceIndex;
int l9_1455=gl_InstanceIndex;
gParticle.Size=fast::max(length((*sc_set2.UserUniforms).vfxModelMatrix[l9_1453/40][0].xyz),fast::max(length((*sc_set2.UserUniforms).vfxModelMatrix[l9_1454/40][1].xyz),length((*sc_set2.UserUniforms).vfxModelMatrix[l9_1455/40][2].xyz)))*gParticle.Size;
gParticle.Spawned=true;
}
if (gParticle.Dead)
{
float4 param_2=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1456=param_2;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1457=dot(l9_1456,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1458=l9_1457;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1458;
}
}
float4 l9_1459=float4(param_2.x,-param_2.y,(param_2.z*0.5)+(param_2.w*0.5),param_2.w);
out.gl_Position=l9_1459;
return out;
}
float3 Value_N142=float3(0.0);
Value_N142=(*sc_set2.UserUniforms).Port_Import_N142;
float3 Value_N6=float3(0.0);
Value_N6=(*sc_set2.UserUniforms).Port_Import_N006;
float Value_N30=0.0;
Value_N30=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float3 Output_N31=float3(0.0);
Output_N31=mix(Value_N142,Value_N6,float3(Value_N30));
float4 Value_N32=float4(0.0);
Value_N32=gParticle.Color;
float Output_N33=0.0;
Output_N33=Value_N32.w;
float4 Value_N182=float4(0.0);
Value_N182=float4(Output_N31.x,Output_N31.y,Output_N31.z,Value_N182.w);
Value_N182.w=Output_N33;
gParticle.Color=Value_N182;
float Output_N12=0.0;
float param_3=(*sc_set2.UserUniforms).Tweak_N12;
Output_N12=param_3;
float Output_N14=0.0;
Output_N14=Output_N12/((*sc_set2.UserUniforms).Port_Input1_N014+1.234e-06);
float3 Value_N13=float3(0.0);
Value_N13.x=Output_N12;
Value_N13.y=Output_N14;
Value_N13.z=Output_N12;
float3 Value_N206=float3(0.0);
Value_N206=Value_N13;
float3 Value_N207=float3(0.0);
Value_N207=gParticle.Position;
float3 Value_N208=float3(0.0);
Value_N208=(*sc_set2.UserUniforms).Port_Import_N208;
float3 Value_N318=float3(0.0);
Value_N318=(*sc_set2.UserUniforms).Port_Import_N318;
float Time_N319=0.0;
Time_N319=Globals.gTimeElapsedShifted*(*sc_set2.UserUniforms).Port_Multiplier_N319;
float3 Output_N320=float3(0.0);
Output_N320=Value_N318*float3(Time_N319);
float3 Output_N321=float3(0.0);
Output_N321=(Value_N207+Value_N208)+Output_N320;
float3 Value_N322=float3(0.0);
Value_N322=(*sc_set2.UserUniforms).Port_Import_N322;
float3 Output_N323=float3(0.0);
Output_N323=float3(1.0)/Value_N322;
float3 Output_N324=float3(0.0);
Output_N324=Output_N321*Output_N323;
float2 Output_N325=float2(0.0);
Output_N325=float2(Output_N324.x,Output_N324.y);
float2 Output_N326=float2(0.0);
Output_N326=Output_N325+(*sc_set2.UserUniforms).Port_Input1_N326;
float Noise_N327=0.0;
float2 param_4=Output_N326;
float2 param_5=(*sc_set2.UserUniforms).Port_Scale_N327;
param_4.x=floor(param_4.x*10000.0)*9.9999997e-05;
param_4.y=floor(param_4.y*10000.0)*9.9999997e-05;
param_4*=(param_5*0.5);
float2 l9_1461=param_4;
float param_6=(snoise(l9_1461)*0.5)+0.5;
param_6=floor(param_6*10000.0)*9.9999997e-05;
Noise_N327=param_6;
float2 Output_N328=float2(0.0);
Output_N328=float2(Output_N324.y,Output_N324.z);
float2 Output_N329=float2(0.0);
Output_N329=Output_N328+(*sc_set2.UserUniforms).Port_Input1_N329;
float Noise_N330=0.0;
float2 param_7=Output_N329;
float2 param_8=(*sc_set2.UserUniforms).Port_Scale_N330;
param_7.x=floor(param_7.x*10000.0)*9.9999997e-05;
param_7.y=floor(param_7.y*10000.0)*9.9999997e-05;
param_7*=(param_8*0.5);
float2 l9_1462=param_7;
float param_9=(snoise(l9_1462)*0.5)+0.5;
param_9=floor(param_9*10000.0)*9.9999997e-05;
Noise_N330=param_9;
float2 Output_N331=float2(0.0);
Output_N331=float2(Output_N324.z,Output_N324.x);
float2 Output_N332=float2(0.0);
Output_N332=Output_N331+(*sc_set2.UserUniforms).Port_Input1_N332;
float Noise_N333=0.0;
float2 param_10=Output_N332;
float2 param_11=(*sc_set2.UserUniforms).Port_Scale_N333;
param_10.x=floor(param_10.x*10000.0)*9.9999997e-05;
param_10.y=floor(param_10.y*10000.0)*9.9999997e-05;
param_10*=(param_11*0.5);
float2 l9_1463=param_10;
float param_12=(snoise(l9_1463)*0.5)+0.5;
param_12=floor(param_12*10000.0)*9.9999997e-05;
Noise_N333=param_12;
float3 Value_N334=float3(0.0);
Value_N334.x=Noise_N327;
Value_N334.y=Noise_N330;
Value_N334.z=Noise_N333;
float3 Output_N335=float3(0.0);
Output_N335=Value_N334*(*sc_set2.UserUniforms).Port_Input1_N335;
float3 Output_N336=float3(0.0);
Output_N336=Output_N335-float3(1.0);
float3 Output_N337=float3(0.0);
Output_N337=Value_N206*Output_N336;
gParticle.Force+=Output_N337;
float Value_N126=0.0;
Value_N126=(*sc_set2.UserUniforms).Port_Import_N126;
float Value_N127=0.0;
Value_N127=(*sc_set2.UserUniforms).Port_Import_N127;
float Value_N128=0.0;
Value_N128=(*sc_set2.UserUniforms).Port_Import_N128;
float3 Value_N129=float3(0.0);
Value_N129=gParticle.Velocity;
float3 Output_N264=float3(0.0);
Output_N264=-Value_N129;
float Output_N265=0.0;
Output_N265=length(Value_N129);
float3 Output_N130=float3(0.0);
Output_N130=Output_N264*float3(Output_N265);
float3 Output_N137=float3(0.0);
Output_N137=(((float3(Value_N126)*float3(Value_N127))*float3(Value_N128))*Output_N130)*float3((*sc_set2.UserUniforms).Port_Input4_N137);
float3 Value_N138=float3(0.0);
Value_N138=gParticle.Velocity;
float Value_N139=0.0;
Value_N139=gParticle.Mass;
float3 Output_N140=float3(0.0);
Output_N140=Value_N138*float3(Value_N139);
float3 Output_N141=float3(0.0);
Output_N141=abs(Output_N140);
float Time_N272=0.0;
Time_N272=Globals.gTimeDelta*(*sc_set2.UserUniforms).Port_Multiplier_N272;
float3 Output_N273=float3(0.0);
Output_N273=Output_N141/(float3(Time_N272)+float3(1.234e-06));
float3 Output_N274=float3(0.0);
Output_N274=-Output_N273;
float3 Output_N275=float3(0.0);
Output_N275=fast::clamp(Output_N137,Output_N274,Output_N273);
gParticle.Force+=Output_N275;
float Value_N111=0.0;
Value_N111=0.0;
float3 Value_N112=float3(0.0);
Value_N112=(*sc_set2.UserUniforms).Port_Import_N112;
float3 Value_N213=float3(0.0);
Value_N213.x=(*sc_set2.UserUniforms).Port_Value1_N213;
Value_N213.y=(*sc_set2.UserUniforms).Port_Value2_N213;
Value_N213.z=(*sc_set2.UserUniforms).Port_Value3_N213;
float3 Output_N212=float3(0.0);
Output_N212=Value_N112+Value_N213;
float3 Value_N113=float3(0.0);
Value_N113=(*sc_set2.UserUniforms).Port_Import_N113;
float Value_N114=0.0;
Value_N114=fast::clamp((*sc_set2.UserUniforms).Port_Import_N114,0.0,1.0);
float Value_N115=0.0;
Value_N115=fast::clamp((*sc_set2.UserUniforms).Port_Import_N115,0.0,1.0);
float Value_N116=0.0;
Value_N116=(*sc_set2.UserUniforms).Port_Import_N116;
float SetCollisionCount_N118=0.0;
float3 SetForce_N118=float3(0.0);
float3 SetVelocity_N118=float3(0.0);
float3 SetPosition_N118=float3(0.0);
float KillParticle_N118=0.0;
float param_13=Value_N111;
float3 param_14=Output_N212;
float3 param_15=Value_N113;
float param_16=Value_N114;
float param_17=Value_N115;
float param_18=Value_N116;
float param_19=(*sc_set2.UserUniforms).Port_CollisionCount_N118;
float param_20=(*sc_set2.UserUniforms).Port_VelocityThreshold_N118;
ssGlobals param_26=Globals;
ssGlobals tempGlobals=param_26;
float param_21=0.0;
float3 param_22=float3(0.0);
float3 param_23=float3(0.0);
float3 param_24=float3(0.0);
float param_25=0.0;
N118_OnCollision=int(param_13);
N118_PlanePos=param_14;
N118_PlaneNormal=param_15;
N118_Bounciness=param_16;
N118_Friction=param_17;
N118_PlaneOffset=param_18;
N118_CollisionCount=param_19;
N118_VelocityThreshold=param_20;
N118_CollisionPlane l9_1464;
N118_CollisionPlane l9_1465=l9_1464;
l9_1465.isColliding=false;
float3 l9_1466=gParticle.Velocity;
l9_1465.velocity=l9_1466;
float3 l9_1467=gParticle.Force;
l9_1465.force=l9_1467;
float3 l9_1468=gParticle.Position;
l9_1465.position=l9_1468;
float3 l9_1469=gParticle.Velocity;
float3 l9_1470=gParticle.Force;
float l9_1471=gParticle.Mass;
float l9_1472=tempGlobals.gTimeDelta;
float3 l9_1473=l9_1469+((l9_1470/float3(fast::max(9.9999997e-06,l9_1471)))*float3(l9_1472));
float l9_1474=tempGlobals.gTimeDelta;
float3 l9_1475=gParticle.Position;
float3 l9_1476=(l9_1473*float3(l9_1474))+l9_1475;
float3 l9_1477=l9_1476;
float3 l9_1478=normalize(N118_PlaneNormal);
float l9_1479=dot(l9_1478,l9_1477-N118_PlanePos)-N118_PlaneOffset;
if (l9_1479<0.0)
{
l9_1465.isColliding=true;
float3 l9_1480=l9_1478;
float l9_1481=N118_Bounciness;
float l9_1482=N118_Friction;
float3 l9_1483=gParticle.Velocity;
float3 l9_1484=l9_1480*dot(l9_1480,l9_1483);
float3 l9_1485=gParticle.Velocity;
float3 l9_1486=l9_1485-l9_1484;
l9_1486*=(1.0-l9_1482);
l9_1484*=l9_1481;
float3 l9_1487=l9_1486-l9_1484;
l9_1465.velocity=l9_1487;
l9_1465.force*=float(length(l9_1465.velocity)>N118_VelocityThreshold);
float3 l9_1488=gParticle.Position;
float l9_1489=dot(l9_1478,l9_1488-N118_PlanePos)-N118_PlaneOffset;
l9_1465.position+=(l9_1478*(-l9_1489));
}
N118_CollisionPlane l9_1490=l9_1465;
l9_1464=l9_1490;
N118_KillParticle=0.0;
N118_SetCollisionCount=floor(N118_CollisionCount);
if (l9_1464.isColliding)
{
N118_SetCollisionCount+=1.0;
}
N118_SetPosition=l9_1464.position;
N118_SetForce=l9_1464.force;
N118_SetVelocity=l9_1464.velocity;
if ((N118_OnCollision==1)&&(N118_SetCollisionCount>0.0))
{
N118_SetForce=float3(0.0);
N118_SetVelocity=float3(0.0);
}
if ((N118_OnCollision==2)&&(N118_SetCollisionCount>0.0))
{
N118_KillParticle=1.0;
}
param_21=N118_SetCollisionCount;
param_22=N118_SetForce;
param_23=N118_SetVelocity;
param_24=N118_SetPosition;
param_25=N118_KillParticle;
SetCollisionCount_N118=param_21;
SetForce_N118=param_22;
SetVelocity_N118=param_23;
SetPosition_N118=param_24;
KillParticle_N118=param_25;
float param_27=SetCollisionCount_N118;
float param_28=(*sc_set2.UserUniforms).Port_DefaultFloat_N119;
if (gParticle.Spawned)
{
gParticle.collisionCount_N119=param_28;
}
else
{
gParticle.collisionCount_N119=param_27;
}
gParticle.Force=SetForce_N118;
gParticle.Velocity=SetVelocity_N118;
gParticle.Position=SetPosition_N118;
float param_29=KillParticle_N118;
if ((param_29*1.0)!=0.0)
{
gParticle.Dead=true;
}
float Value_N105=0.0;
Value_N105=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float Output_N106=0.0;
Output_N106=1.0-Value_N105;
float Output_N171=0.0;
Output_N171=Output_N106*(*sc_set2.UserUniforms).Port_Input1_N171;
float Output_N108=0.0;
Output_N108=sin(Output_N171);
float Output_N109=0.0;
Output_N109=fast::clamp(Output_N108+0.001,(*sc_set2.UserUniforms).Port_Input1_N109+0.001,(*sc_set2.UserUniforms).Port_Input2_N109+0.001)-0.001;
float Output_N29=0.0;
float param_30=(*sc_set2.UserUniforms).particle_scale;
Output_N29=param_30;
float Output_N172=0.0;
Output_N172=Output_N109*Output_N29;
gParticle.Size=Output_N172;
float Value_N8=0.0;
Value_N8=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float Output_N7=0.0;
float param_31=(*sc_set2.UserUniforms).particlesReduce;
Output_N7=param_31;
float Output_N10=0.0;
Output_N10=1.0-Output_N7;
float Output_N9=0.0;
Output_N9=float(Value_N8>Output_N10);
float param_32=Output_N9;
if ((param_32*1.0)!=0.0)
{
gParticle.Dead=true;
}
float3x3 param_33=gParticle.Matrix;
gParticle.Quaternion=matrixToQuaternion(param_33);
if (gParticle.Dead)
{
float4 param_34=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1491=param_34;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1492=dot(l9_1491,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1493=l9_1492;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1493;
}
}
float4 l9_1494=float4(param_34.x,-param_34.y,(param_34.z*0.5)+(param_34.w*0.5),param_34.w);
out.gl_Position=l9_1494;
return out;
}
float DeltaTime=fast::clamp(Globals.gTimeDelta,9.9999997e-05,0.5);
float Drift=0.0049999999;
float l9_1495;
if (abs(gParticle.Force.x)<Drift)
{
l9_1495=0.0;
}
else
{
l9_1495=gParticle.Force.x;
}
gParticle.Force.x=l9_1495;
float l9_1496;
if (abs(gParticle.Force.y)<Drift)
{
l9_1496=0.0;
}
else
{
l9_1496=gParticle.Force.y;
}
gParticle.Force.y=l9_1496;
float l9_1497;
if (abs(gParticle.Force.z)<Drift)
{
l9_1497=0.0;
}
else
{
l9_1497=gParticle.Force.z;
}
gParticle.Force.z=l9_1497;
gParticle.Mass=fast::max(Drift,gParticle.Mass);
gParticle.Velocity+=((gParticle.Force/float3(gParticle.Mass))*DeltaTime);
float l9_1498;
if (abs(gParticle.Velocity.x)<Drift)
{
l9_1498=0.0;
}
else
{
l9_1498=gParticle.Velocity.x;
}
gParticle.Velocity.x=l9_1498;
float l9_1499;
if (abs(gParticle.Velocity.y)<Drift)
{
l9_1499=0.0;
}
else
{
l9_1499=gParticle.Velocity.y;
}
gParticle.Velocity.y=l9_1499;
float l9_1500;
if (abs(gParticle.Velocity.z)<Drift)
{
l9_1500=0.0;
}
else
{
l9_1500=gParticle.Velocity.z;
}
gParticle.Velocity.z=l9_1500;
gParticle.Position+=(gParticle.Velocity*DeltaTime);
float2 QuadSize=float2(4.0,1.0)/float2(2048.0,(*sc_set2.UserUniforms).ssTARGET_SIZE_FLOAT.y);
float2 Offset=float2(0.0);
int l9_1501=gl_InstanceIndex;
int offsetID=(*sc_set2.UserUniforms).vfxOffsetInstances+l9_1501;
int particleRow=512;
Offset.x=float(offsetID%particleRow);
Offset.y=float(offsetID/particleRow);
Offset*=QuadSize;
float2 Vertex=float2(0.0);
float l9_1502;
if (v.texture0.x<0.5)
{
l9_1502=0.0;
}
else
{
l9_1502=QuadSize.x;
}
Vertex.x=l9_1502;
float l9_1503;
if (v.texture0.y<0.5)
{
l9_1503=0.0;
}
else
{
l9_1503=QuadSize.y;
}
Vertex.y=l9_1503;
Vertex+=Offset;
float4 param_35=float4((Vertex*2.0)-float2(1.0),1.0,1.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1504=param_35;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1505=dot(l9_1504,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1506=l9_1505;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1506;
}
}
float4 l9_1507=float4(param_35.x,-param_35.y,(param_35.z*0.5)+(param_35.w*0.5),param_35.w);
out.gl_Position=l9_1507;
int l9_1508=gl_InstanceIndex;
out.Interp_Particle_Index=l9_1508;
out.Interp_Particle_Coord=v.texture0;
out.Interp_Particle_Force=gParticle.Force;
out.Interp_Particle_Position=gParticle.Position;
out.Interp_Particle_Velocity=gParticle.Velocity;
out.Interp_Particle_Life=gParticle.Life;
out.Interp_Particle_Age=gParticle.Age;
out.Interp_Particle_Size=gParticle.Size;
out.Interp_Particle_Color=gParticle.Color;
out.Interp_Particle_Quaternion=gParticle.Quaternion;
out.Interp_Particle_collisionCount_N119=gParticle.collisionCount_N119;
out.Interp_Particle_Mass=gParticle.Mass;
if (gParticle.Dead)
{
float4 param_36=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1509=param_36;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1510=dot(l9_1509,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1511=l9_1510;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1511;
}
}
float4 l9_1512=float4(param_36.x,-param_36.y,(param_36.z*0.5)+(param_36.w*0.5),param_36.w);
out.gl_Position=l9_1512;
return out;
}
bool l9_1513=(*sc_set2.UserUniforms).overrideTimeEnabled==1;
bool l9_1514;
if (l9_1513)
{
l9_1514=(*sc_set2.UserUniforms).overrideTimeDelta==0.0;
}
else
{
l9_1514=l9_1513;
}
if (l9_1514)
{
int l9_1515=gl_InstanceIndex;
float4 l9_1516;
if (l9_1515==0)
{
l9_1516=float4((v.texture0*2.0)-float2(1.0),1.0,1.0);
}
else
{
l9_1516=float4(0.0);
}
float4 param_37=l9_1516;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1517=param_37;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1518=dot(l9_1517,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1519=l9_1518;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1519;
}
}
float4 l9_1520=float4(param_37.x,-param_37.y,(param_37.z*0.5)+(param_37.w*0.5),param_37.w);
out.gl_Position=l9_1520;
out.varPackedTex=float4(v.texture0.x,v.texture0.y,out.varPackedTex.z,out.varPackedTex.w);
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct ssParticle
{
float3 Position;
float3 Velocity;
float4 Color;
float Size;
float Age;
float Life;
float Mass;
float3x3 Matrix;
bool Dead;
float4 Quaternion;
float collisionCount_N119;
float SpawnOffset;
float Seed;
float2 Seed2000;
float TimeShift;
int Index1D;
int Index1DPerCopy;
float Coord1D;
float Ratio1D;
float Ratio1DPerCopy;
int2 Index2D;
float2 Coord2D;
float2 Ratio2D;
float3 Force;
bool Spawned;
float CopyId;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int vfxNumCopies;
int vfxBatchEnable[32];
float4x4 vfxModelMatrix[32];
float4 renderTarget0Size;
float4 renderTarget0Dims;
float4 renderTarget0View;
float3x3 renderTarget0Transform;
float4 renderTarget0UvMinMax;
float4 renderTarget0BorderColor;
float4 renderTarget1Size;
float4 renderTarget1Dims;
float4 renderTarget1View;
float3x3 renderTarget1Transform;
float4 renderTarget1UvMinMax;
float4 renderTarget1BorderColor;
float4 renderTarget2Size;
float4 renderTarget2Dims;
float4 renderTarget2View;
float3x3 renderTarget2Transform;
float4 renderTarget2UvMinMax;
float4 renderTarget2BorderColor;
float4 renderTarget3Size;
float4 renderTarget3Dims;
float4 renderTarget3View;
float3x3 renderTarget3Transform;
float4 renderTarget3UvMinMax;
float4 renderTarget3BorderColor;
float3 vfxLocalAabbMin;
float3 vfxLocalAabbMax;
float vfxCameraAspect;
float vfxCameraNear;
float vfxCameraFar;
float3 vfxCameraUp;
float3 vfxCameraForward;
float3 vfxCameraRight;
float4x4 vfxProjectionMatrix;
float4x4 vfxProjectionMatrixInverse;
float4x4 vfxViewMatrix;
float4x4 vfxViewMatrixInverse;
float4x4 vfxViewProjectionMatrix;
float4x4 vfxViewProjectionMatrixInverse;
int vfxFrame;
int vfxOffsetInstances;
int vfxOffsetInstancesPrev;
float2 ssTARGET_SIZE_INT;
float2 ssTARGET_SIZE_FLOAT;
float ssTARGET_WIDTH;
int ssTARGET_WIDTH_INT;
float particles_speed;
float particlesReduce;
float Tweak_N12;
float particle_scale;
float3 Port_Import_N216;
float Port_Input1_N149;
float3 Port_Min_N150;
float3 Port_Max_N150;
float Port_Import_N151;
float Port_Input1_N153;
float3 Port_Max_N154;
float Port_Import_N157;
float3 Port_Import_N158;
float Port_Input1_N162;
float Port_Input1_N165;
float Port_Import_N042;
float Port_Import_N043;
float Port_Import_N023;
float Port_Import_N024;
float Port_Import_N053;
float3 Port_Import_N054;
float3 Port_Import_N187;
float Port_Import_N189;
float3 Port_Import_N142;
float3 Port_Import_N006;
float Port_Input1_N014;
float3 Port_Import_N206;
float3 Port_Import_N208;
float3 Port_Import_N318;
float Port_Multiplier_N319;
float3 Port_Import_N322;
float2 Port_Input1_N326;
float2 Port_Scale_N327;
float2 Port_Input1_N329;
float2 Port_Scale_N330;
float2 Port_Input1_N332;
float2 Port_Scale_N333;
float3 Port_Input1_N335;
float Port_Import_N126;
float Port_Import_N127;
float Port_Import_N128;
float Port_Input4_N137;
float Port_Multiplier_N272;
float3 Port_Import_N112;
float Port_Value1_N213;
float Port_Value2_N213;
float Port_Value3_N213;
float3 Port_Import_N113;
float Port_Import_N114;
float Port_Import_N115;
float Port_Import_N116;
float Port_CollisionCount_N118;
float Port_VelocityThreshold_N118;
float Port_DefaultFloat_N119;
float Port_Input1_N171;
float Port_Input1_N109;
float Port_Input2_N109;
float Port_Input1_N184;
float4 Port_Value0_N176;
float Port_Position1_N176;
float4 Port_Value1_N176;
float Port_Position2_N176;
float4 Port_Value2_N176;
float Port_Position3_N176;
float4 Port_Value3_N176;
float4 Port_Value4_N176;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct sc_Set2
{
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> renderTarget0 [[id(2)]];
texture2d<float> renderTarget1 [[id(3)]];
texture2d<float> renderTarget2 [[id(4)]];
texture2d<float> renderTarget3 [[id(5)]];
sampler renderTarget0SmpSC [[id(21)]];
sampler renderTarget1SmpSC [[id(22)]];
sampler renderTarget2SmpSC [[id(23)]];
sampler renderTarget3SmpSC [[id(24)]];
constant userUniformsObj* UserUniforms [[id(32)]];
};
struct main_frag_out
{
float4 FragColor0 [[color(0)]];
float4 FragColor1 [[color(1)]];
float4 FragColor2 [[color(2)]];
float4 FragColor3 [[color(3)]];
};
struct main_frag_in
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
int Interp_Particle_Index [[user(locn11)]];
float3 Interp_Particle_Force [[user(locn12)]];
float2 Interp_Particle_Coord [[user(locn13)]];
float3 Interp_Particle_Position [[user(locn14)]];
float3 Interp_Particle_Velocity [[user(locn15)]];
float Interp_Particle_Life [[user(locn16)]];
float Interp_Particle_Age [[user(locn17)]];
float Interp_Particle_Size [[user(locn18)]];
float4 Interp_Particle_Color [[user(locn19)]];
float4 Interp_Particle_Quaternion [[user(locn20)]];
float Interp_Particle_collisionCount_N119 [[user(locn21)]];
float Interp_Particle_Mass [[user(locn22)]];
};
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]])
{
main_frag_out out={};
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
int l9_0=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_1=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1=0;
}
else
{
l9_1=in.varStereoViewID;
}
int l9_2=l9_1;
l9_0=1-l9_2;
}
else
{
int l9_3=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3=0;
}
else
{
l9_3=in.varStereoViewID;
}
int l9_4=l9_3;
l9_0=l9_4;
}
int l9_5=l9_0;
int param=renderTarget0Layout_tmp;
int param_1=l9_5;
float2 param_2=float2(0.5);
bool param_3=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_4=(*sc_set2.UserUniforms).renderTarget0Transform;
int2 param_5=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_6=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_7=(*sc_set2.UserUniforms).renderTarget0UvMinMax;
bool param_8=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_9=(*sc_set2.UserUniforms).renderTarget0BorderColor;
float param_10=0.0;
bool l9_6=param_8&&(!param_6);
float l9_7=1.0;
float l9_8=param_2.x;
int l9_9=param_5.x;
if (l9_9==1)
{
l9_8=fract(l9_8);
}
else
{
if (l9_9==2)
{
float l9_10=fract(l9_8);
float l9_11=l9_8-l9_10;
float l9_12=step(0.25,fract(l9_11*0.5));
l9_8=mix(l9_10,1.0-l9_10,fast::clamp(l9_12,0.0,1.0));
}
}
param_2.x=l9_8;
float l9_13=param_2.y;
int l9_14=param_5.y;
if (l9_14==1)
{
l9_13=fract(l9_13);
}
else
{
if (l9_14==2)
{
float l9_15=fract(l9_13);
float l9_16=l9_13-l9_15;
float l9_17=step(0.25,fract(l9_16*0.5));
l9_13=mix(l9_15,1.0-l9_15,fast::clamp(l9_17,0.0,1.0));
}
}
param_2.y=l9_13;
if (param_6)
{
bool l9_18=param_8;
bool l9_19;
if (l9_18)
{
l9_19=param_5.x==3;
}
else
{
l9_19=l9_18;
}
float l9_20=param_2.x;
float l9_21=param_7.x;
float l9_22=param_7.z;
bool l9_23=l9_19;
float l9_24=l9_7;
float l9_25=fast::clamp(l9_20,l9_21,l9_22);
float l9_26=step(abs(l9_20-l9_25),9.9999997e-06);
l9_24*=(l9_26+((1.0-float(l9_23))*(1.0-l9_26)));
l9_20=l9_25;
param_2.x=l9_20;
l9_7=l9_24;
bool l9_27=param_8;
bool l9_28;
if (l9_27)
{
l9_28=param_5.y==3;
}
else
{
l9_28=l9_27;
}
float l9_29=param_2.y;
float l9_30=param_7.y;
float l9_31=param_7.w;
bool l9_32=l9_28;
float l9_33=l9_7;
float l9_34=fast::clamp(l9_29,l9_30,l9_31);
float l9_35=step(abs(l9_29-l9_34),9.9999997e-06);
l9_33*=(l9_35+((1.0-float(l9_32))*(1.0-l9_35)));
l9_29=l9_34;
param_2.y=l9_29;
l9_7=l9_33;
}
float2 l9_36=param_2;
bool l9_37=param_3;
float3x3 l9_38=param_4;
if (l9_37)
{
l9_36=float2((l9_38*float3(l9_36,1.0)).xy);
}
float2 l9_39=l9_36;
float2 l9_40=l9_39;
float2 l9_41=l9_40;
param_2=l9_41;
float l9_42=param_2.x;
int l9_43=param_5.x;
bool l9_44=l9_6;
float l9_45=l9_7;
if ((l9_43==0)||(l9_43==3))
{
float l9_46=l9_42;
float l9_47=0.0;
float l9_48=1.0;
bool l9_49=l9_44;
float l9_50=l9_45;
float l9_51=fast::clamp(l9_46,l9_47,l9_48);
float l9_52=step(abs(l9_46-l9_51),9.9999997e-06);
l9_50*=(l9_52+((1.0-float(l9_49))*(1.0-l9_52)));
l9_46=l9_51;
l9_42=l9_46;
l9_45=l9_50;
}
param_2.x=l9_42;
l9_7=l9_45;
float l9_53=param_2.y;
int l9_54=param_5.y;
bool l9_55=l9_6;
float l9_56=l9_7;
if ((l9_54==0)||(l9_54==3))
{
float l9_57=l9_53;
float l9_58=0.0;
float l9_59=1.0;
bool l9_60=l9_55;
float l9_61=l9_56;
float l9_62=fast::clamp(l9_57,l9_58,l9_59);
float l9_63=step(abs(l9_57-l9_62),9.9999997e-06);
l9_61*=(l9_63+((1.0-float(l9_60))*(1.0-l9_63)));
l9_57=l9_62;
l9_53=l9_57;
l9_56=l9_61;
}
param_2.y=l9_53;
l9_7=l9_56;
float2 l9_64=param_2;
int l9_65=param;
int l9_66=param_1;
float l9_67=param_10;
float2 l9_68=l9_64;
int l9_69=l9_65;
int l9_70=l9_66;
float3 l9_71=float3(0.0);
if (l9_69==0)
{
l9_71=float3(l9_68,0.0);
}
else
{
if (l9_69==1)
{
l9_71=float3(l9_68.x,(l9_68.y*0.5)+(0.5-(float(l9_70)*0.5)),0.0);
}
else
{
l9_71=float3(l9_68,float(l9_70));
}
}
float3 l9_72=l9_71;
float3 l9_73=l9_72;
float2 l9_74=l9_73.xy;
float l9_75=l9_67;
float4 l9_76=sc_set2.renderTarget0.sample(sc_set2.renderTarget0SmpSC,l9_74,level(l9_75));
float4 l9_77=l9_76;
float4 l9_78=l9_77;
if (param_8)
{
l9_78=mix(param_9,l9_78,float4(l9_7));
}
float4 l9_79=l9_78;
float4 renderTarget0Sample=l9_79;
int l9_80=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_81=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_81=0;
}
else
{
l9_81=in.varStereoViewID;
}
int l9_82=l9_81;
l9_80=1-l9_82;
}
else
{
int l9_83=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_83=0;
}
else
{
l9_83=in.varStereoViewID;
}
int l9_84=l9_83;
l9_80=l9_84;
}
int l9_85=l9_80;
int param_11=renderTarget1Layout_tmp;
int param_12=l9_85;
float2 param_13=float2(0.5);
bool param_14=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_15=(*sc_set2.UserUniforms).renderTarget1Transform;
int2 param_16=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_17=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_18=(*sc_set2.UserUniforms).renderTarget1UvMinMax;
bool param_19=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_20=(*sc_set2.UserUniforms).renderTarget1BorderColor;
float param_21=0.0;
bool l9_86=param_19&&(!param_17);
float l9_87=1.0;
float l9_88=param_13.x;
int l9_89=param_16.x;
if (l9_89==1)
{
l9_88=fract(l9_88);
}
else
{
if (l9_89==2)
{
float l9_90=fract(l9_88);
float l9_91=l9_88-l9_90;
float l9_92=step(0.25,fract(l9_91*0.5));
l9_88=mix(l9_90,1.0-l9_90,fast::clamp(l9_92,0.0,1.0));
}
}
param_13.x=l9_88;
float l9_93=param_13.y;
int l9_94=param_16.y;
if (l9_94==1)
{
l9_93=fract(l9_93);
}
else
{
if (l9_94==2)
{
float l9_95=fract(l9_93);
float l9_96=l9_93-l9_95;
float l9_97=step(0.25,fract(l9_96*0.5));
l9_93=mix(l9_95,1.0-l9_95,fast::clamp(l9_97,0.0,1.0));
}
}
param_13.y=l9_93;
if (param_17)
{
bool l9_98=param_19;
bool l9_99;
if (l9_98)
{
l9_99=param_16.x==3;
}
else
{
l9_99=l9_98;
}
float l9_100=param_13.x;
float l9_101=param_18.x;
float l9_102=param_18.z;
bool l9_103=l9_99;
float l9_104=l9_87;
float l9_105=fast::clamp(l9_100,l9_101,l9_102);
float l9_106=step(abs(l9_100-l9_105),9.9999997e-06);
l9_104*=(l9_106+((1.0-float(l9_103))*(1.0-l9_106)));
l9_100=l9_105;
param_13.x=l9_100;
l9_87=l9_104;
bool l9_107=param_19;
bool l9_108;
if (l9_107)
{
l9_108=param_16.y==3;
}
else
{
l9_108=l9_107;
}
float l9_109=param_13.y;
float l9_110=param_18.y;
float l9_111=param_18.w;
bool l9_112=l9_108;
float l9_113=l9_87;
float l9_114=fast::clamp(l9_109,l9_110,l9_111);
float l9_115=step(abs(l9_109-l9_114),9.9999997e-06);
l9_113*=(l9_115+((1.0-float(l9_112))*(1.0-l9_115)));
l9_109=l9_114;
param_13.y=l9_109;
l9_87=l9_113;
}
float2 l9_116=param_13;
bool l9_117=param_14;
float3x3 l9_118=param_15;
if (l9_117)
{
l9_116=float2((l9_118*float3(l9_116,1.0)).xy);
}
float2 l9_119=l9_116;
float2 l9_120=l9_119;
float2 l9_121=l9_120;
param_13=l9_121;
float l9_122=param_13.x;
int l9_123=param_16.x;
bool l9_124=l9_86;
float l9_125=l9_87;
if ((l9_123==0)||(l9_123==3))
{
float l9_126=l9_122;
float l9_127=0.0;
float l9_128=1.0;
bool l9_129=l9_124;
float l9_130=l9_125;
float l9_131=fast::clamp(l9_126,l9_127,l9_128);
float l9_132=step(abs(l9_126-l9_131),9.9999997e-06);
l9_130*=(l9_132+((1.0-float(l9_129))*(1.0-l9_132)));
l9_126=l9_131;
l9_122=l9_126;
l9_125=l9_130;
}
param_13.x=l9_122;
l9_87=l9_125;
float l9_133=param_13.y;
int l9_134=param_16.y;
bool l9_135=l9_86;
float l9_136=l9_87;
if ((l9_134==0)||(l9_134==3))
{
float l9_137=l9_133;
float l9_138=0.0;
float l9_139=1.0;
bool l9_140=l9_135;
float l9_141=l9_136;
float l9_142=fast::clamp(l9_137,l9_138,l9_139);
float l9_143=step(abs(l9_137-l9_142),9.9999997e-06);
l9_141*=(l9_143+((1.0-float(l9_140))*(1.0-l9_143)));
l9_137=l9_142;
l9_133=l9_137;
l9_136=l9_141;
}
param_13.y=l9_133;
l9_87=l9_136;
float2 l9_144=param_13;
int l9_145=param_11;
int l9_146=param_12;
float l9_147=param_21;
float2 l9_148=l9_144;
int l9_149=l9_145;
int l9_150=l9_146;
float3 l9_151=float3(0.0);
if (l9_149==0)
{
l9_151=float3(l9_148,0.0);
}
else
{
if (l9_149==1)
{
l9_151=float3(l9_148.x,(l9_148.y*0.5)+(0.5-(float(l9_150)*0.5)),0.0);
}
else
{
l9_151=float3(l9_148,float(l9_150));
}
}
float3 l9_152=l9_151;
float3 l9_153=l9_152;
float2 l9_154=l9_153.xy;
float l9_155=l9_147;
float4 l9_156=sc_set2.renderTarget1.sample(sc_set2.renderTarget1SmpSC,l9_154,level(l9_155));
float4 l9_157=l9_156;
float4 l9_158=l9_157;
if (param_19)
{
l9_158=mix(param_20,l9_158,float4(l9_87));
}
float4 l9_159=l9_158;
float4 renderTarget1Sample=l9_159;
int l9_160=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_161=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_161=0;
}
else
{
l9_161=in.varStereoViewID;
}
int l9_162=l9_161;
l9_160=1-l9_162;
}
else
{
int l9_163=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_163=0;
}
else
{
l9_163=in.varStereoViewID;
}
int l9_164=l9_163;
l9_160=l9_164;
}
int l9_165=l9_160;
int param_22=renderTarget2Layout_tmp;
int param_23=l9_165;
float2 param_24=float2(0.5);
bool param_25=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_26=(*sc_set2.UserUniforms).renderTarget2Transform;
int2 param_27=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_28=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_29=(*sc_set2.UserUniforms).renderTarget2UvMinMax;
bool param_30=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_31=(*sc_set2.UserUniforms).renderTarget2BorderColor;
float param_32=0.0;
bool l9_166=param_30&&(!param_28);
float l9_167=1.0;
float l9_168=param_24.x;
int l9_169=param_27.x;
if (l9_169==1)
{
l9_168=fract(l9_168);
}
else
{
if (l9_169==2)
{
float l9_170=fract(l9_168);
float l9_171=l9_168-l9_170;
float l9_172=step(0.25,fract(l9_171*0.5));
l9_168=mix(l9_170,1.0-l9_170,fast::clamp(l9_172,0.0,1.0));
}
}
param_24.x=l9_168;
float l9_173=param_24.y;
int l9_174=param_27.y;
if (l9_174==1)
{
l9_173=fract(l9_173);
}
else
{
if (l9_174==2)
{
float l9_175=fract(l9_173);
float l9_176=l9_173-l9_175;
float l9_177=step(0.25,fract(l9_176*0.5));
l9_173=mix(l9_175,1.0-l9_175,fast::clamp(l9_177,0.0,1.0));
}
}
param_24.y=l9_173;
if (param_28)
{
bool l9_178=param_30;
bool l9_179;
if (l9_178)
{
l9_179=param_27.x==3;
}
else
{
l9_179=l9_178;
}
float l9_180=param_24.x;
float l9_181=param_29.x;
float l9_182=param_29.z;
bool l9_183=l9_179;
float l9_184=l9_167;
float l9_185=fast::clamp(l9_180,l9_181,l9_182);
float l9_186=step(abs(l9_180-l9_185),9.9999997e-06);
l9_184*=(l9_186+((1.0-float(l9_183))*(1.0-l9_186)));
l9_180=l9_185;
param_24.x=l9_180;
l9_167=l9_184;
bool l9_187=param_30;
bool l9_188;
if (l9_187)
{
l9_188=param_27.y==3;
}
else
{
l9_188=l9_187;
}
float l9_189=param_24.y;
float l9_190=param_29.y;
float l9_191=param_29.w;
bool l9_192=l9_188;
float l9_193=l9_167;
float l9_194=fast::clamp(l9_189,l9_190,l9_191);
float l9_195=step(abs(l9_189-l9_194),9.9999997e-06);
l9_193*=(l9_195+((1.0-float(l9_192))*(1.0-l9_195)));
l9_189=l9_194;
param_24.y=l9_189;
l9_167=l9_193;
}
float2 l9_196=param_24;
bool l9_197=param_25;
float3x3 l9_198=param_26;
if (l9_197)
{
l9_196=float2((l9_198*float3(l9_196,1.0)).xy);
}
float2 l9_199=l9_196;
float2 l9_200=l9_199;
float2 l9_201=l9_200;
param_24=l9_201;
float l9_202=param_24.x;
int l9_203=param_27.x;
bool l9_204=l9_166;
float l9_205=l9_167;
if ((l9_203==0)||(l9_203==3))
{
float l9_206=l9_202;
float l9_207=0.0;
float l9_208=1.0;
bool l9_209=l9_204;
float l9_210=l9_205;
float l9_211=fast::clamp(l9_206,l9_207,l9_208);
float l9_212=step(abs(l9_206-l9_211),9.9999997e-06);
l9_210*=(l9_212+((1.0-float(l9_209))*(1.0-l9_212)));
l9_206=l9_211;
l9_202=l9_206;
l9_205=l9_210;
}
param_24.x=l9_202;
l9_167=l9_205;
float l9_213=param_24.y;
int l9_214=param_27.y;
bool l9_215=l9_166;
float l9_216=l9_167;
if ((l9_214==0)||(l9_214==3))
{
float l9_217=l9_213;
float l9_218=0.0;
float l9_219=1.0;
bool l9_220=l9_215;
float l9_221=l9_216;
float l9_222=fast::clamp(l9_217,l9_218,l9_219);
float l9_223=step(abs(l9_217-l9_222),9.9999997e-06);
l9_221*=(l9_223+((1.0-float(l9_220))*(1.0-l9_223)));
l9_217=l9_222;
l9_213=l9_217;
l9_216=l9_221;
}
param_24.y=l9_213;
l9_167=l9_216;
float2 l9_224=param_24;
int l9_225=param_22;
int l9_226=param_23;
float l9_227=param_32;
float2 l9_228=l9_224;
int l9_229=l9_225;
int l9_230=l9_226;
float3 l9_231=float3(0.0);
if (l9_229==0)
{
l9_231=float3(l9_228,0.0);
}
else
{
if (l9_229==1)
{
l9_231=float3(l9_228.x,(l9_228.y*0.5)+(0.5-(float(l9_230)*0.5)),0.0);
}
else
{
l9_231=float3(l9_228,float(l9_230));
}
}
float3 l9_232=l9_231;
float3 l9_233=l9_232;
float2 l9_234=l9_233.xy;
float l9_235=l9_227;
float4 l9_236=sc_set2.renderTarget2.sample(sc_set2.renderTarget2SmpSC,l9_234,level(l9_235));
float4 l9_237=l9_236;
float4 l9_238=l9_237;
if (param_30)
{
l9_238=mix(param_31,l9_238,float4(l9_167));
}
float4 l9_239=l9_238;
float4 renderTarget2Sample=l9_239;
int l9_240=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_241=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_241=0;
}
else
{
l9_241=in.varStereoViewID;
}
int l9_242=l9_241;
l9_240=1-l9_242;
}
else
{
int l9_243=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_243=0;
}
else
{
l9_243=in.varStereoViewID;
}
int l9_244=l9_243;
l9_240=l9_244;
}
int l9_245=l9_240;
int param_33=renderTarget3Layout_tmp;
int param_34=l9_245;
float2 param_35=float2(0.5);
bool param_36=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_37=(*sc_set2.UserUniforms).renderTarget3Transform;
int2 param_38=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_39=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_40=(*sc_set2.UserUniforms).renderTarget3UvMinMax;
bool param_41=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_42=(*sc_set2.UserUniforms).renderTarget3BorderColor;
float param_43=0.0;
bool l9_246=param_41&&(!param_39);
float l9_247=1.0;
float l9_248=param_35.x;
int l9_249=param_38.x;
if (l9_249==1)
{
l9_248=fract(l9_248);
}
else
{
if (l9_249==2)
{
float l9_250=fract(l9_248);
float l9_251=l9_248-l9_250;
float l9_252=step(0.25,fract(l9_251*0.5));
l9_248=mix(l9_250,1.0-l9_250,fast::clamp(l9_252,0.0,1.0));
}
}
param_35.x=l9_248;
float l9_253=param_35.y;
int l9_254=param_38.y;
if (l9_254==1)
{
l9_253=fract(l9_253);
}
else
{
if (l9_254==2)
{
float l9_255=fract(l9_253);
float l9_256=l9_253-l9_255;
float l9_257=step(0.25,fract(l9_256*0.5));
l9_253=mix(l9_255,1.0-l9_255,fast::clamp(l9_257,0.0,1.0));
}
}
param_35.y=l9_253;
if (param_39)
{
bool l9_258=param_41;
bool l9_259;
if (l9_258)
{
l9_259=param_38.x==3;
}
else
{
l9_259=l9_258;
}
float l9_260=param_35.x;
float l9_261=param_40.x;
float l9_262=param_40.z;
bool l9_263=l9_259;
float l9_264=l9_247;
float l9_265=fast::clamp(l9_260,l9_261,l9_262);
float l9_266=step(abs(l9_260-l9_265),9.9999997e-06);
l9_264*=(l9_266+((1.0-float(l9_263))*(1.0-l9_266)));
l9_260=l9_265;
param_35.x=l9_260;
l9_247=l9_264;
bool l9_267=param_41;
bool l9_268;
if (l9_267)
{
l9_268=param_38.y==3;
}
else
{
l9_268=l9_267;
}
float l9_269=param_35.y;
float l9_270=param_40.y;
float l9_271=param_40.w;
bool l9_272=l9_268;
float l9_273=l9_247;
float l9_274=fast::clamp(l9_269,l9_270,l9_271);
float l9_275=step(abs(l9_269-l9_274),9.9999997e-06);
l9_273*=(l9_275+((1.0-float(l9_272))*(1.0-l9_275)));
l9_269=l9_274;
param_35.y=l9_269;
l9_247=l9_273;
}
float2 l9_276=param_35;
bool l9_277=param_36;
float3x3 l9_278=param_37;
if (l9_277)
{
l9_276=float2((l9_278*float3(l9_276,1.0)).xy);
}
float2 l9_279=l9_276;
float2 l9_280=l9_279;
float2 l9_281=l9_280;
param_35=l9_281;
float l9_282=param_35.x;
int l9_283=param_38.x;
bool l9_284=l9_246;
float l9_285=l9_247;
if ((l9_283==0)||(l9_283==3))
{
float l9_286=l9_282;
float l9_287=0.0;
float l9_288=1.0;
bool l9_289=l9_284;
float l9_290=l9_285;
float l9_291=fast::clamp(l9_286,l9_287,l9_288);
float l9_292=step(abs(l9_286-l9_291),9.9999997e-06);
l9_290*=(l9_292+((1.0-float(l9_289))*(1.0-l9_292)));
l9_286=l9_291;
l9_282=l9_286;
l9_285=l9_290;
}
param_35.x=l9_282;
l9_247=l9_285;
float l9_293=param_35.y;
int l9_294=param_38.y;
bool l9_295=l9_246;
float l9_296=l9_247;
if ((l9_294==0)||(l9_294==3))
{
float l9_297=l9_293;
float l9_298=0.0;
float l9_299=1.0;
bool l9_300=l9_295;
float l9_301=l9_296;
float l9_302=fast::clamp(l9_297,l9_298,l9_299);
float l9_303=step(abs(l9_297-l9_302),9.9999997e-06);
l9_301*=(l9_303+((1.0-float(l9_300))*(1.0-l9_303)));
l9_297=l9_302;
l9_293=l9_297;
l9_296=l9_301;
}
param_35.y=l9_293;
l9_247=l9_296;
float2 l9_304=param_35;
int l9_305=param_33;
int l9_306=param_34;
float l9_307=param_43;
float2 l9_308=l9_304;
int l9_309=l9_305;
int l9_310=l9_306;
float3 l9_311=float3(0.0);
if (l9_309==0)
{
l9_311=float3(l9_308,0.0);
}
else
{
if (l9_309==1)
{
l9_311=float3(l9_308.x,(l9_308.y*0.5)+(0.5-(float(l9_310)*0.5)),0.0);
}
else
{
l9_311=float3(l9_308,float(l9_310));
}
}
float3 l9_312=l9_311;
float3 l9_313=l9_312;
float2 l9_314=l9_313.xy;
float l9_315=l9_307;
float4 l9_316=sc_set2.renderTarget3.sample(sc_set2.renderTarget3SmpSC,l9_314,level(l9_315));
float4 l9_317=l9_316;
float4 l9_318=l9_317;
if (param_41)
{
l9_318=mix(param_42,l9_318,float4(l9_247));
}
float4 l9_319=l9_318;
float4 renderTarget3Sample=l9_319;
float4 Data0=float4(0.0);
float4 Data1=float4(0.0);
float4 Data2=float4(0.0);
float4 Data3=float4(0.0);
bool l9_320=(*sc_set2.UserUniforms).overrideTimeEnabled==1;
bool l9_321;
if (l9_320)
{
l9_321=(*sc_set2.UserUniforms).overrideTimeDelta==0.0;
}
else
{
l9_321=l9_320;
}
if (l9_321)
{
int l9_322=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_323=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_323=0;
}
else
{
l9_323=in.varStereoViewID;
}
int l9_324=l9_323;
l9_322=1-l9_324;
}
else
{
int l9_325=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_325=0;
}
else
{
l9_325=in.varStereoViewID;
}
int l9_326=l9_325;
l9_322=l9_326;
}
int l9_327=l9_322;
int param_44=renderTarget0Layout_tmp;
int param_45=l9_327;
float2 param_46=in.varPackedTex.xy;
bool param_47=(int(SC_USE_UV_TRANSFORM_renderTarget0_tmp)!=0);
float3x3 param_48=(*sc_set2.UserUniforms).renderTarget0Transform;
int2 param_49=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp);
bool param_50=(int(SC_USE_UV_MIN_MAX_renderTarget0_tmp)!=0);
float4 param_51=(*sc_set2.UserUniforms).renderTarget0UvMinMax;
bool param_52=(int(SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp)!=0);
float4 param_53=(*sc_set2.UserUniforms).renderTarget0BorderColor;
float param_54=0.0;
bool l9_328=param_52&&(!param_50);
float l9_329=1.0;
float l9_330=param_46.x;
int l9_331=param_49.x;
if (l9_331==1)
{
l9_330=fract(l9_330);
}
else
{
if (l9_331==2)
{
float l9_332=fract(l9_330);
float l9_333=l9_330-l9_332;
float l9_334=step(0.25,fract(l9_333*0.5));
l9_330=mix(l9_332,1.0-l9_332,fast::clamp(l9_334,0.0,1.0));
}
}
param_46.x=l9_330;
float l9_335=param_46.y;
int l9_336=param_49.y;
if (l9_336==1)
{
l9_335=fract(l9_335);
}
else
{
if (l9_336==2)
{
float l9_337=fract(l9_335);
float l9_338=l9_335-l9_337;
float l9_339=step(0.25,fract(l9_338*0.5));
l9_335=mix(l9_337,1.0-l9_337,fast::clamp(l9_339,0.0,1.0));
}
}
param_46.y=l9_335;
if (param_50)
{
bool l9_340=param_52;
bool l9_341;
if (l9_340)
{
l9_341=param_49.x==3;
}
else
{
l9_341=l9_340;
}
float l9_342=param_46.x;
float l9_343=param_51.x;
float l9_344=param_51.z;
bool l9_345=l9_341;
float l9_346=l9_329;
float l9_347=fast::clamp(l9_342,l9_343,l9_344);
float l9_348=step(abs(l9_342-l9_347),9.9999997e-06);
l9_346*=(l9_348+((1.0-float(l9_345))*(1.0-l9_348)));
l9_342=l9_347;
param_46.x=l9_342;
l9_329=l9_346;
bool l9_349=param_52;
bool l9_350;
if (l9_349)
{
l9_350=param_49.y==3;
}
else
{
l9_350=l9_349;
}
float l9_351=param_46.y;
float l9_352=param_51.y;
float l9_353=param_51.w;
bool l9_354=l9_350;
float l9_355=l9_329;
float l9_356=fast::clamp(l9_351,l9_352,l9_353);
float l9_357=step(abs(l9_351-l9_356),9.9999997e-06);
l9_355*=(l9_357+((1.0-float(l9_354))*(1.0-l9_357)));
l9_351=l9_356;
param_46.y=l9_351;
l9_329=l9_355;
}
float2 l9_358=param_46;
bool l9_359=param_47;
float3x3 l9_360=param_48;
if (l9_359)
{
l9_358=float2((l9_360*float3(l9_358,1.0)).xy);
}
float2 l9_361=l9_358;
float2 l9_362=l9_361;
float2 l9_363=l9_362;
param_46=l9_363;
float l9_364=param_46.x;
int l9_365=param_49.x;
bool l9_366=l9_328;
float l9_367=l9_329;
if ((l9_365==0)||(l9_365==3))
{
float l9_368=l9_364;
float l9_369=0.0;
float l9_370=1.0;
bool l9_371=l9_366;
float l9_372=l9_367;
float l9_373=fast::clamp(l9_368,l9_369,l9_370);
float l9_374=step(abs(l9_368-l9_373),9.9999997e-06);
l9_372*=(l9_374+((1.0-float(l9_371))*(1.0-l9_374)));
l9_368=l9_373;
l9_364=l9_368;
l9_367=l9_372;
}
param_46.x=l9_364;
l9_329=l9_367;
float l9_375=param_46.y;
int l9_376=param_49.y;
bool l9_377=l9_328;
float l9_378=l9_329;
if ((l9_376==0)||(l9_376==3))
{
float l9_379=l9_375;
float l9_380=0.0;
float l9_381=1.0;
bool l9_382=l9_377;
float l9_383=l9_378;
float l9_384=fast::clamp(l9_379,l9_380,l9_381);
float l9_385=step(abs(l9_379-l9_384),9.9999997e-06);
l9_383*=(l9_385+((1.0-float(l9_382))*(1.0-l9_385)));
l9_379=l9_384;
l9_375=l9_379;
l9_378=l9_383;
}
param_46.y=l9_375;
l9_329=l9_378;
float2 l9_386=param_46;
int l9_387=param_44;
int l9_388=param_45;
float l9_389=param_54;
float2 l9_390=l9_386;
int l9_391=l9_387;
int l9_392=l9_388;
float3 l9_393=float3(0.0);
if (l9_391==0)
{
l9_393=float3(l9_390,0.0);
}
else
{
if (l9_391==1)
{
l9_393=float3(l9_390.x,(l9_390.y*0.5)+(0.5-(float(l9_392)*0.5)),0.0);
}
else
{
l9_393=float3(l9_390,float(l9_392));
}
}
float3 l9_394=l9_393;
float3 l9_395=l9_394;
float2 l9_396=l9_395.xy;
float l9_397=l9_389;
float4 l9_398=sc_set2.renderTarget0.sample(sc_set2.renderTarget0SmpSC,l9_396,level(l9_397));
float4 l9_399=l9_398;
float4 l9_400=l9_399;
if (param_52)
{
l9_400=mix(param_53,l9_400,float4(l9_329));
}
float4 l9_401=l9_400;
renderTarget0Sample=l9_401;
int l9_402=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_403=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_403=0;
}
else
{
l9_403=in.varStereoViewID;
}
int l9_404=l9_403;
l9_402=1-l9_404;
}
else
{
int l9_405=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_405=0;
}
else
{
l9_405=in.varStereoViewID;
}
int l9_406=l9_405;
l9_402=l9_406;
}
int l9_407=l9_402;
int param_55=renderTarget1Layout_tmp;
int param_56=l9_407;
float2 param_57=in.varPackedTex.xy;
bool param_58=(int(SC_USE_UV_TRANSFORM_renderTarget1_tmp)!=0);
float3x3 param_59=(*sc_set2.UserUniforms).renderTarget1Transform;
int2 param_60=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp);
bool param_61=(int(SC_USE_UV_MIN_MAX_renderTarget1_tmp)!=0);
float4 param_62=(*sc_set2.UserUniforms).renderTarget1UvMinMax;
bool param_63=(int(SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp)!=0);
float4 param_64=(*sc_set2.UserUniforms).renderTarget1BorderColor;
float param_65=0.0;
bool l9_408=param_63&&(!param_61);
float l9_409=1.0;
float l9_410=param_57.x;
int l9_411=param_60.x;
if (l9_411==1)
{
l9_410=fract(l9_410);
}
else
{
if (l9_411==2)
{
float l9_412=fract(l9_410);
float l9_413=l9_410-l9_412;
float l9_414=step(0.25,fract(l9_413*0.5));
l9_410=mix(l9_412,1.0-l9_412,fast::clamp(l9_414,0.0,1.0));
}
}
param_57.x=l9_410;
float l9_415=param_57.y;
int l9_416=param_60.y;
if (l9_416==1)
{
l9_415=fract(l9_415);
}
else
{
if (l9_416==2)
{
float l9_417=fract(l9_415);
float l9_418=l9_415-l9_417;
float l9_419=step(0.25,fract(l9_418*0.5));
l9_415=mix(l9_417,1.0-l9_417,fast::clamp(l9_419,0.0,1.0));
}
}
param_57.y=l9_415;
if (param_61)
{
bool l9_420=param_63;
bool l9_421;
if (l9_420)
{
l9_421=param_60.x==3;
}
else
{
l9_421=l9_420;
}
float l9_422=param_57.x;
float l9_423=param_62.x;
float l9_424=param_62.z;
bool l9_425=l9_421;
float l9_426=l9_409;
float l9_427=fast::clamp(l9_422,l9_423,l9_424);
float l9_428=step(abs(l9_422-l9_427),9.9999997e-06);
l9_426*=(l9_428+((1.0-float(l9_425))*(1.0-l9_428)));
l9_422=l9_427;
param_57.x=l9_422;
l9_409=l9_426;
bool l9_429=param_63;
bool l9_430;
if (l9_429)
{
l9_430=param_60.y==3;
}
else
{
l9_430=l9_429;
}
float l9_431=param_57.y;
float l9_432=param_62.y;
float l9_433=param_62.w;
bool l9_434=l9_430;
float l9_435=l9_409;
float l9_436=fast::clamp(l9_431,l9_432,l9_433);
float l9_437=step(abs(l9_431-l9_436),9.9999997e-06);
l9_435*=(l9_437+((1.0-float(l9_434))*(1.0-l9_437)));
l9_431=l9_436;
param_57.y=l9_431;
l9_409=l9_435;
}
float2 l9_438=param_57;
bool l9_439=param_58;
float3x3 l9_440=param_59;
if (l9_439)
{
l9_438=float2((l9_440*float3(l9_438,1.0)).xy);
}
float2 l9_441=l9_438;
float2 l9_442=l9_441;
float2 l9_443=l9_442;
param_57=l9_443;
float l9_444=param_57.x;
int l9_445=param_60.x;
bool l9_446=l9_408;
float l9_447=l9_409;
if ((l9_445==0)||(l9_445==3))
{
float l9_448=l9_444;
float l9_449=0.0;
float l9_450=1.0;
bool l9_451=l9_446;
float l9_452=l9_447;
float l9_453=fast::clamp(l9_448,l9_449,l9_450);
float l9_454=step(abs(l9_448-l9_453),9.9999997e-06);
l9_452*=(l9_454+((1.0-float(l9_451))*(1.0-l9_454)));
l9_448=l9_453;
l9_444=l9_448;
l9_447=l9_452;
}
param_57.x=l9_444;
l9_409=l9_447;
float l9_455=param_57.y;
int l9_456=param_60.y;
bool l9_457=l9_408;
float l9_458=l9_409;
if ((l9_456==0)||(l9_456==3))
{
float l9_459=l9_455;
float l9_460=0.0;
float l9_461=1.0;
bool l9_462=l9_457;
float l9_463=l9_458;
float l9_464=fast::clamp(l9_459,l9_460,l9_461);
float l9_465=step(abs(l9_459-l9_464),9.9999997e-06);
l9_463*=(l9_465+((1.0-float(l9_462))*(1.0-l9_465)));
l9_459=l9_464;
l9_455=l9_459;
l9_458=l9_463;
}
param_57.y=l9_455;
l9_409=l9_458;
float2 l9_466=param_57;
int l9_467=param_55;
int l9_468=param_56;
float l9_469=param_65;
float2 l9_470=l9_466;
int l9_471=l9_467;
int l9_472=l9_468;
float3 l9_473=float3(0.0);
if (l9_471==0)
{
l9_473=float3(l9_470,0.0);
}
else
{
if (l9_471==1)
{
l9_473=float3(l9_470.x,(l9_470.y*0.5)+(0.5-(float(l9_472)*0.5)),0.0);
}
else
{
l9_473=float3(l9_470,float(l9_472));
}
}
float3 l9_474=l9_473;
float3 l9_475=l9_474;
float2 l9_476=l9_475.xy;
float l9_477=l9_469;
float4 l9_478=sc_set2.renderTarget1.sample(sc_set2.renderTarget1SmpSC,l9_476,level(l9_477));
float4 l9_479=l9_478;
float4 l9_480=l9_479;
if (param_63)
{
l9_480=mix(param_64,l9_480,float4(l9_409));
}
float4 l9_481=l9_480;
renderTarget1Sample=l9_481;
int l9_482=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_483=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_483=0;
}
else
{
l9_483=in.varStereoViewID;
}
int l9_484=l9_483;
l9_482=1-l9_484;
}
else
{
int l9_485=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_485=0;
}
else
{
l9_485=in.varStereoViewID;
}
int l9_486=l9_485;
l9_482=l9_486;
}
int l9_487=l9_482;
int param_66=renderTarget2Layout_tmp;
int param_67=l9_487;
float2 param_68=in.varPackedTex.xy;
bool param_69=(int(SC_USE_UV_TRANSFORM_renderTarget2_tmp)!=0);
float3x3 param_70=(*sc_set2.UserUniforms).renderTarget2Transform;
int2 param_71=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp);
bool param_72=(int(SC_USE_UV_MIN_MAX_renderTarget2_tmp)!=0);
float4 param_73=(*sc_set2.UserUniforms).renderTarget2UvMinMax;
bool param_74=(int(SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp)!=0);
float4 param_75=(*sc_set2.UserUniforms).renderTarget2BorderColor;
float param_76=0.0;
bool l9_488=param_74&&(!param_72);
float l9_489=1.0;
float l9_490=param_68.x;
int l9_491=param_71.x;
if (l9_491==1)
{
l9_490=fract(l9_490);
}
else
{
if (l9_491==2)
{
float l9_492=fract(l9_490);
float l9_493=l9_490-l9_492;
float l9_494=step(0.25,fract(l9_493*0.5));
l9_490=mix(l9_492,1.0-l9_492,fast::clamp(l9_494,0.0,1.0));
}
}
param_68.x=l9_490;
float l9_495=param_68.y;
int l9_496=param_71.y;
if (l9_496==1)
{
l9_495=fract(l9_495);
}
else
{
if (l9_496==2)
{
float l9_497=fract(l9_495);
float l9_498=l9_495-l9_497;
float l9_499=step(0.25,fract(l9_498*0.5));
l9_495=mix(l9_497,1.0-l9_497,fast::clamp(l9_499,0.0,1.0));
}
}
param_68.y=l9_495;
if (param_72)
{
bool l9_500=param_74;
bool l9_501;
if (l9_500)
{
l9_501=param_71.x==3;
}
else
{
l9_501=l9_500;
}
float l9_502=param_68.x;
float l9_503=param_73.x;
float l9_504=param_73.z;
bool l9_505=l9_501;
float l9_506=l9_489;
float l9_507=fast::clamp(l9_502,l9_503,l9_504);
float l9_508=step(abs(l9_502-l9_507),9.9999997e-06);
l9_506*=(l9_508+((1.0-float(l9_505))*(1.0-l9_508)));
l9_502=l9_507;
param_68.x=l9_502;
l9_489=l9_506;
bool l9_509=param_74;
bool l9_510;
if (l9_509)
{
l9_510=param_71.y==3;
}
else
{
l9_510=l9_509;
}
float l9_511=param_68.y;
float l9_512=param_73.y;
float l9_513=param_73.w;
bool l9_514=l9_510;
float l9_515=l9_489;
float l9_516=fast::clamp(l9_511,l9_512,l9_513);
float l9_517=step(abs(l9_511-l9_516),9.9999997e-06);
l9_515*=(l9_517+((1.0-float(l9_514))*(1.0-l9_517)));
l9_511=l9_516;
param_68.y=l9_511;
l9_489=l9_515;
}
float2 l9_518=param_68;
bool l9_519=param_69;
float3x3 l9_520=param_70;
if (l9_519)
{
l9_518=float2((l9_520*float3(l9_518,1.0)).xy);
}
float2 l9_521=l9_518;
float2 l9_522=l9_521;
float2 l9_523=l9_522;
param_68=l9_523;
float l9_524=param_68.x;
int l9_525=param_71.x;
bool l9_526=l9_488;
float l9_527=l9_489;
if ((l9_525==0)||(l9_525==3))
{
float l9_528=l9_524;
float l9_529=0.0;
float l9_530=1.0;
bool l9_531=l9_526;
float l9_532=l9_527;
float l9_533=fast::clamp(l9_528,l9_529,l9_530);
float l9_534=step(abs(l9_528-l9_533),9.9999997e-06);
l9_532*=(l9_534+((1.0-float(l9_531))*(1.0-l9_534)));
l9_528=l9_533;
l9_524=l9_528;
l9_527=l9_532;
}
param_68.x=l9_524;
l9_489=l9_527;
float l9_535=param_68.y;
int l9_536=param_71.y;
bool l9_537=l9_488;
float l9_538=l9_489;
if ((l9_536==0)||(l9_536==3))
{
float l9_539=l9_535;
float l9_540=0.0;
float l9_541=1.0;
bool l9_542=l9_537;
float l9_543=l9_538;
float l9_544=fast::clamp(l9_539,l9_540,l9_541);
float l9_545=step(abs(l9_539-l9_544),9.9999997e-06);
l9_543*=(l9_545+((1.0-float(l9_542))*(1.0-l9_545)));
l9_539=l9_544;
l9_535=l9_539;
l9_538=l9_543;
}
param_68.y=l9_535;
l9_489=l9_538;
float2 l9_546=param_68;
int l9_547=param_66;
int l9_548=param_67;
float l9_549=param_76;
float2 l9_550=l9_546;
int l9_551=l9_547;
int l9_552=l9_548;
float3 l9_553=float3(0.0);
if (l9_551==0)
{
l9_553=float3(l9_550,0.0);
}
else
{
if (l9_551==1)
{
l9_553=float3(l9_550.x,(l9_550.y*0.5)+(0.5-(float(l9_552)*0.5)),0.0);
}
else
{
l9_553=float3(l9_550,float(l9_552));
}
}
float3 l9_554=l9_553;
float3 l9_555=l9_554;
float2 l9_556=l9_555.xy;
float l9_557=l9_549;
float4 l9_558=sc_set2.renderTarget2.sample(sc_set2.renderTarget2SmpSC,l9_556,level(l9_557));
float4 l9_559=l9_558;
float4 l9_560=l9_559;
if (param_74)
{
l9_560=mix(param_75,l9_560,float4(l9_489));
}
float4 l9_561=l9_560;
renderTarget2Sample=l9_561;
int l9_562=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_563=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_563=0;
}
else
{
l9_563=in.varStereoViewID;
}
int l9_564=l9_563;
l9_562=1-l9_564;
}
else
{
int l9_565=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_565=0;
}
else
{
l9_565=in.varStereoViewID;
}
int l9_566=l9_565;
l9_562=l9_566;
}
int l9_567=l9_562;
int param_77=renderTarget3Layout_tmp;
int param_78=l9_567;
float2 param_79=in.varPackedTex.xy;
bool param_80=(int(SC_USE_UV_TRANSFORM_renderTarget3_tmp)!=0);
float3x3 param_81=(*sc_set2.UserUniforms).renderTarget3Transform;
int2 param_82=int2(SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp,SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp);
bool param_83=(int(SC_USE_UV_MIN_MAX_renderTarget3_tmp)!=0);
float4 param_84=(*sc_set2.UserUniforms).renderTarget3UvMinMax;
bool param_85=(int(SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp)!=0);
float4 param_86=(*sc_set2.UserUniforms).renderTarget3BorderColor;
float param_87=0.0;
bool l9_568=param_85&&(!param_83);
float l9_569=1.0;
float l9_570=param_79.x;
int l9_571=param_82.x;
if (l9_571==1)
{
l9_570=fract(l9_570);
}
else
{
if (l9_571==2)
{
float l9_572=fract(l9_570);
float l9_573=l9_570-l9_572;
float l9_574=step(0.25,fract(l9_573*0.5));
l9_570=mix(l9_572,1.0-l9_572,fast::clamp(l9_574,0.0,1.0));
}
}
param_79.x=l9_570;
float l9_575=param_79.y;
int l9_576=param_82.y;
if (l9_576==1)
{
l9_575=fract(l9_575);
}
else
{
if (l9_576==2)
{
float l9_577=fract(l9_575);
float l9_578=l9_575-l9_577;
float l9_579=step(0.25,fract(l9_578*0.5));
l9_575=mix(l9_577,1.0-l9_577,fast::clamp(l9_579,0.0,1.0));
}
}
param_79.y=l9_575;
if (param_83)
{
bool l9_580=param_85;
bool l9_581;
if (l9_580)
{
l9_581=param_82.x==3;
}
else
{
l9_581=l9_580;
}
float l9_582=param_79.x;
float l9_583=param_84.x;
float l9_584=param_84.z;
bool l9_585=l9_581;
float l9_586=l9_569;
float l9_587=fast::clamp(l9_582,l9_583,l9_584);
float l9_588=step(abs(l9_582-l9_587),9.9999997e-06);
l9_586*=(l9_588+((1.0-float(l9_585))*(1.0-l9_588)));
l9_582=l9_587;
param_79.x=l9_582;
l9_569=l9_586;
bool l9_589=param_85;
bool l9_590;
if (l9_589)
{
l9_590=param_82.y==3;
}
else
{
l9_590=l9_589;
}
float l9_591=param_79.y;
float l9_592=param_84.y;
float l9_593=param_84.w;
bool l9_594=l9_590;
float l9_595=l9_569;
float l9_596=fast::clamp(l9_591,l9_592,l9_593);
float l9_597=step(abs(l9_591-l9_596),9.9999997e-06);
l9_595*=(l9_597+((1.0-float(l9_594))*(1.0-l9_597)));
l9_591=l9_596;
param_79.y=l9_591;
l9_569=l9_595;
}
float2 l9_598=param_79;
bool l9_599=param_80;
float3x3 l9_600=param_81;
if (l9_599)
{
l9_598=float2((l9_600*float3(l9_598,1.0)).xy);
}
float2 l9_601=l9_598;
float2 l9_602=l9_601;
float2 l9_603=l9_602;
param_79=l9_603;
float l9_604=param_79.x;
int l9_605=param_82.x;
bool l9_606=l9_568;
float l9_607=l9_569;
if ((l9_605==0)||(l9_605==3))
{
float l9_608=l9_604;
float l9_609=0.0;
float l9_610=1.0;
bool l9_611=l9_606;
float l9_612=l9_607;
float l9_613=fast::clamp(l9_608,l9_609,l9_610);
float l9_614=step(abs(l9_608-l9_613),9.9999997e-06);
l9_612*=(l9_614+((1.0-float(l9_611))*(1.0-l9_614)));
l9_608=l9_613;
l9_604=l9_608;
l9_607=l9_612;
}
param_79.x=l9_604;
l9_569=l9_607;
float l9_615=param_79.y;
int l9_616=param_82.y;
bool l9_617=l9_568;
float l9_618=l9_569;
if ((l9_616==0)||(l9_616==3))
{
float l9_619=l9_615;
float l9_620=0.0;
float l9_621=1.0;
bool l9_622=l9_617;
float l9_623=l9_618;
float l9_624=fast::clamp(l9_619,l9_620,l9_621);
float l9_625=step(abs(l9_619-l9_624),9.9999997e-06);
l9_623*=(l9_625+((1.0-float(l9_622))*(1.0-l9_625)));
l9_619=l9_624;
l9_615=l9_619;
l9_618=l9_623;
}
param_79.y=l9_615;
l9_569=l9_618;
float2 l9_626=param_79;
int l9_627=param_77;
int l9_628=param_78;
float l9_629=param_87;
float2 l9_630=l9_626;
int l9_631=l9_627;
int l9_632=l9_628;
float3 l9_633=float3(0.0);
if (l9_631==0)
{
l9_633=float3(l9_630,0.0);
}
else
{
if (l9_631==1)
{
l9_633=float3(l9_630.x,(l9_630.y*0.5)+(0.5-(float(l9_632)*0.5)),0.0);
}
else
{
l9_633=float3(l9_630,float(l9_632));
}
}
float3 l9_634=l9_633;
float3 l9_635=l9_634;
float2 l9_636=l9_635.xy;
float l9_637=l9_629;
float4 l9_638=sc_set2.renderTarget3.sample(sc_set2.renderTarget3SmpSC,l9_636,level(l9_637));
float4 l9_639=l9_638;
float4 l9_640=l9_639;
if (param_85)
{
l9_640=mix(param_86,l9_640,float4(l9_569));
}
float4 l9_641=l9_640;
renderTarget3Sample=l9_641;
Data0=renderTarget0Sample;
Data1=renderTarget1Sample;
Data2=renderTarget2Sample;
Data3=renderTarget3Sample;
}
else
{
ssParticle gParticle;
gParticle.Position=in.Interp_Particle_Position;
gParticle.Velocity=in.Interp_Particle_Velocity;
gParticle.Life=in.Interp_Particle_Life;
gParticle.Age=in.Interp_Particle_Age;
gParticle.Size=in.Interp_Particle_Size;
gParticle.Color=in.Interp_Particle_Color;
gParticle.Quaternion=in.Interp_Particle_Quaternion;
gParticle.collisionCount_N119=in.Interp_Particle_collisionCount_N119;
gParticle.Mass=in.Interp_Particle_Mass;
float2 param_88=in.Interp_Particle_Coord;
int l9_642=int(floor(param_88.x*4.0));
float4 l9_643=float4(0.0);
float l9_644=0.0;
float l9_645=0.0;
float l9_646=0.0;
float l9_647=0.0;
float l9_648=0.0;
float l9_649=0.0;
float l9_650=0.0;
float l9_651=0.0;
float l9_652=0.0;
float l9_653=0.0;
float l9_654=0.0;
float l9_655=0.0;
float l9_656=0.0;
float l9_657=0.0;
float l9_658=0.0;
float l9_659=0.0;
if (l9_642==0)
{
float l9_660=gParticle.Position.x;
float l9_661=-1000.0;
float l9_662=1000.0;
float l9_663=l9_660;
float l9_664=l9_661;
float l9_665=l9_662;
float l9_666=0.99998999;
float l9_667=fast::clamp(l9_663,l9_664,l9_665);
float l9_668=l9_664;
float l9_669=l9_665;
float l9_670=0.0;
float l9_671=l9_666;
float l9_672=l9_670+(((l9_667-l9_668)*(l9_671-l9_670))/(l9_669-l9_668));
float l9_673=l9_672;
float4 l9_674=float4(1.0,255.0,65025.0,16581375.0)*l9_673;
l9_674=fract(l9_674);
l9_674-=(l9_674.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_675=l9_674;
float4 l9_676=l9_675;
float4 l9_677=l9_676;
l9_643=l9_677;
l9_644=l9_643.x;
l9_645=l9_643.y;
l9_646=l9_643.z;
l9_647=l9_643.w;
float l9_678=gParticle.Position.y;
float l9_679=-1000.0;
float l9_680=1000.0;
float l9_681=l9_678;
float l9_682=l9_679;
float l9_683=l9_680;
float l9_684=0.99998999;
float l9_685=fast::clamp(l9_681,l9_682,l9_683);
float l9_686=l9_682;
float l9_687=l9_683;
float l9_688=0.0;
float l9_689=l9_684;
float l9_690=l9_688+(((l9_685-l9_686)*(l9_689-l9_688))/(l9_687-l9_686));
float l9_691=l9_690;
float4 l9_692=float4(1.0,255.0,65025.0,16581375.0)*l9_691;
l9_692=fract(l9_692);
l9_692-=(l9_692.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_693=l9_692;
float4 l9_694=l9_693;
float4 l9_695=l9_694;
l9_643=l9_695;
l9_648=l9_643.x;
l9_649=l9_643.y;
l9_650=l9_643.z;
l9_651=l9_643.w;
float l9_696=gParticle.Position.z;
float l9_697=-1000.0;
float l9_698=1000.0;
float l9_699=l9_696;
float l9_700=l9_697;
float l9_701=l9_698;
float l9_702=0.99998999;
float l9_703=fast::clamp(l9_699,l9_700,l9_701);
float l9_704=l9_700;
float l9_705=l9_701;
float l9_706=0.0;
float l9_707=l9_702;
float l9_708=l9_706+(((l9_703-l9_704)*(l9_707-l9_706))/(l9_705-l9_704));
float l9_709=l9_708;
float4 l9_710=float4(1.0,255.0,65025.0,16581375.0)*l9_709;
l9_710=fract(l9_710);
l9_710-=(l9_710.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_711=l9_710;
float4 l9_712=l9_711;
float4 l9_713=l9_712;
l9_643=l9_713;
l9_652=l9_643.x;
l9_653=l9_643.y;
l9_654=l9_643.z;
l9_655=l9_643.w;
float l9_714=gParticle.Velocity.x;
float l9_715=-1000.0;
float l9_716=1000.0;
float l9_717=l9_714;
float l9_718=l9_715;
float l9_719=l9_716;
float l9_720=0.99998999;
float l9_721=fast::clamp(l9_717,l9_718,l9_719);
float l9_722=l9_718;
float l9_723=l9_719;
float l9_724=0.0;
float l9_725=l9_720;
float l9_726=l9_724+(((l9_721-l9_722)*(l9_725-l9_724))/(l9_723-l9_722));
float l9_727=l9_726;
float4 l9_728=float4(1.0,255.0,65025.0,16581375.0)*l9_727;
l9_728=fract(l9_728);
l9_728-=(l9_728.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_729=l9_728;
float4 l9_730=l9_729;
float4 l9_731=l9_730;
l9_643=l9_731;
l9_656=l9_643.x;
l9_657=l9_643.y;
l9_658=l9_643.z;
l9_659=l9_643.w;
}
else
{
if (l9_642==1)
{
float l9_732=gParticle.Velocity.y;
float l9_733=-1000.0;
float l9_734=1000.0;
float l9_735=l9_732;
float l9_736=l9_733;
float l9_737=l9_734;
float l9_738=0.99998999;
float l9_739=fast::clamp(l9_735,l9_736,l9_737);
float l9_740=l9_736;
float l9_741=l9_737;
float l9_742=0.0;
float l9_743=l9_738;
float l9_744=l9_742+(((l9_739-l9_740)*(l9_743-l9_742))/(l9_741-l9_740));
float l9_745=l9_744;
float4 l9_746=float4(1.0,255.0,65025.0,16581375.0)*l9_745;
l9_746=fract(l9_746);
l9_746-=(l9_746.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_747=l9_746;
float4 l9_748=l9_747;
float4 l9_749=l9_748;
l9_643=l9_749;
l9_644=l9_643.x;
l9_645=l9_643.y;
l9_646=l9_643.z;
l9_647=l9_643.w;
float l9_750=gParticle.Velocity.z;
float l9_751=-1000.0;
float l9_752=1000.0;
float l9_753=l9_750;
float l9_754=l9_751;
float l9_755=l9_752;
float l9_756=0.99998999;
float l9_757=fast::clamp(l9_753,l9_754,l9_755);
float l9_758=l9_754;
float l9_759=l9_755;
float l9_760=0.0;
float l9_761=l9_756;
float l9_762=l9_760+(((l9_757-l9_758)*(l9_761-l9_760))/(l9_759-l9_758));
float l9_763=l9_762;
float4 l9_764=float4(1.0,255.0,65025.0,16581375.0)*l9_763;
l9_764=fract(l9_764);
l9_764-=(l9_764.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_765=l9_764;
float4 l9_766=l9_765;
float4 l9_767=l9_766;
l9_643=l9_767;
l9_648=l9_643.x;
l9_649=l9_643.y;
l9_650=l9_643.z;
l9_651=l9_643.w;
float l9_768=gParticle.Life;
float l9_769=0.0;
float l9_770=0.2;
float l9_771=l9_768;
float l9_772=l9_769;
float l9_773=l9_770;
float l9_774=0.99998999;
float l9_775=fast::clamp(l9_771,l9_772,l9_773);
float l9_776=l9_772;
float l9_777=l9_773;
float l9_778=0.0;
float l9_779=l9_774;
float l9_780=l9_778+(((l9_775-l9_776)*(l9_779-l9_778))/(l9_777-l9_776));
float l9_781=l9_780;
float4 l9_782=float4(1.0,255.0,65025.0,16581375.0)*l9_781;
l9_782=fract(l9_782);
l9_782-=(l9_782.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_783=l9_782;
float4 l9_784=l9_783;
float4 l9_785=l9_784;
l9_643=l9_785;
l9_652=l9_643.x;
l9_653=l9_643.y;
l9_654=l9_643.z;
l9_655=l9_643.w;
float l9_786=gParticle.Age;
float l9_787=0.0;
float l9_788=0.2;
float l9_789=l9_786;
float l9_790=l9_787;
float l9_791=l9_788;
float l9_792=0.99998999;
float l9_793=fast::clamp(l9_789,l9_790,l9_791);
float l9_794=l9_790;
float l9_795=l9_791;
float l9_796=0.0;
float l9_797=l9_792;
float l9_798=l9_796+(((l9_793-l9_794)*(l9_797-l9_796))/(l9_795-l9_794));
float l9_799=l9_798;
float4 l9_800=float4(1.0,255.0,65025.0,16581375.0)*l9_799;
l9_800=fract(l9_800);
l9_800-=(l9_800.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_801=l9_800;
float4 l9_802=l9_801;
float4 l9_803=l9_802;
l9_643=l9_803;
l9_656=l9_643.x;
l9_657=l9_643.y;
l9_658=l9_643.z;
l9_659=l9_643.w;
}
else
{
if (l9_642==2)
{
float l9_804=gParticle.Size;
float l9_805=0.0;
float l9_806=100.0;
float l9_807=l9_804;
float l9_808=l9_805;
float l9_809=l9_806;
float l9_810=0.99998999;
float l9_811=fast::clamp(l9_807,l9_808,l9_809);
float l9_812=l9_808;
float l9_813=l9_809;
float l9_814=0.0;
float l9_815=l9_810;
float l9_816=l9_814+(((l9_811-l9_812)*(l9_815-l9_814))/(l9_813-l9_812));
float l9_817=l9_816;
float4 l9_818=float4(1.0,255.0,65025.0,16581375.0)*l9_817;
l9_818=fract(l9_818);
l9_818-=(l9_818.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_819=l9_818.xy;
float2 l9_820=l9_819;
float2 l9_821=l9_820;
l9_643=float4(l9_821.x,l9_821.y,l9_643.z,l9_643.w);
l9_644=l9_643.x;
l9_645=l9_643.y;
float l9_822=gParticle.Quaternion.x;
float l9_823=-1.0;
float l9_824=1.0;
float l9_825=l9_822;
float l9_826=l9_823;
float l9_827=l9_824;
float l9_828=0.99998999;
float l9_829=fast::clamp(l9_825,l9_826,l9_827);
float l9_830=l9_826;
float l9_831=l9_827;
float l9_832=0.0;
float l9_833=l9_828;
float l9_834=l9_832+(((l9_829-l9_830)*(l9_833-l9_832))/(l9_831-l9_830));
float l9_835=l9_834;
float4 l9_836=float4(1.0,255.0,65025.0,16581375.0)*l9_835;
l9_836=fract(l9_836);
l9_836-=(l9_836.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_837=l9_836.xy;
float2 l9_838=l9_837;
float2 l9_839=l9_838;
l9_643=float4(l9_839.x,l9_839.y,l9_643.z,l9_643.w);
l9_646=l9_643.x;
l9_647=l9_643.y;
float l9_840=gParticle.Quaternion.y;
float l9_841=-1.0;
float l9_842=1.0;
float l9_843=l9_840;
float l9_844=l9_841;
float l9_845=l9_842;
float l9_846=0.99998999;
float l9_847=fast::clamp(l9_843,l9_844,l9_845);
float l9_848=l9_844;
float l9_849=l9_845;
float l9_850=0.0;
float l9_851=l9_846;
float l9_852=l9_850+(((l9_847-l9_848)*(l9_851-l9_850))/(l9_849-l9_848));
float l9_853=l9_852;
float4 l9_854=float4(1.0,255.0,65025.0,16581375.0)*l9_853;
l9_854=fract(l9_854);
l9_854-=(l9_854.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_855=l9_854.xy;
float2 l9_856=l9_855;
float2 l9_857=l9_856;
l9_643=float4(l9_857.x,l9_857.y,l9_643.z,l9_643.w);
l9_648=l9_643.x;
l9_649=l9_643.y;
float l9_858=gParticle.Quaternion.z;
float l9_859=-1.0;
float l9_860=1.0;
float l9_861=l9_858;
float l9_862=l9_859;
float l9_863=l9_860;
float l9_864=0.99998999;
float l9_865=fast::clamp(l9_861,l9_862,l9_863);
float l9_866=l9_862;
float l9_867=l9_863;
float l9_868=0.0;
float l9_869=l9_864;
float l9_870=l9_868+(((l9_865-l9_866)*(l9_869-l9_868))/(l9_867-l9_866));
float l9_871=l9_870;
float4 l9_872=float4(1.0,255.0,65025.0,16581375.0)*l9_871;
l9_872=fract(l9_872);
l9_872-=(l9_872.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_873=l9_872.xy;
float2 l9_874=l9_873;
float2 l9_875=l9_874;
l9_643=float4(l9_875.x,l9_875.y,l9_643.z,l9_643.w);
l9_650=l9_643.x;
l9_651=l9_643.y;
float l9_876=gParticle.Quaternion.w;
float l9_877=-1.0;
float l9_878=1.0;
float l9_879=l9_876;
float l9_880=l9_877;
float l9_881=l9_878;
float l9_882=0.99998999;
float l9_883=fast::clamp(l9_879,l9_880,l9_881);
float l9_884=l9_880;
float l9_885=l9_881;
float l9_886=0.0;
float l9_887=l9_882;
float l9_888=l9_886+(((l9_883-l9_884)*(l9_887-l9_886))/(l9_885-l9_884));
float l9_889=l9_888;
float4 l9_890=float4(1.0,255.0,65025.0,16581375.0)*l9_889;
l9_890=fract(l9_890);
l9_890-=(l9_890.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_891=l9_890.xy;
float2 l9_892=l9_891;
float2 l9_893=l9_892;
l9_643=float4(l9_893.x,l9_893.y,l9_643.z,l9_643.w);
l9_652=l9_643.x;
l9_653=l9_643.y;
float l9_894=gParticle.Mass;
float l9_895=0.0;
float l9_896=100.0;
float l9_897=l9_894;
float l9_898=l9_895;
float l9_899=l9_896;
float l9_900=0.99998999;
float l9_901=fast::clamp(l9_897,l9_898,l9_899);
float l9_902=l9_898;
float l9_903=l9_899;
float l9_904=0.0;
float l9_905=l9_900;
float l9_906=l9_904+(((l9_901-l9_902)*(l9_905-l9_904))/(l9_903-l9_902));
float l9_907=l9_906;
float4 l9_908=float4(1.0,255.0,65025.0,16581375.0)*l9_907;
l9_908=fract(l9_908);
l9_908-=(l9_908.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_909=l9_908.xy;
float2 l9_910=l9_909;
float2 l9_911=l9_910;
l9_643=float4(l9_911.x,l9_911.y,l9_643.z,l9_643.w);
l9_654=l9_643.x;
l9_655=l9_643.y;
float l9_912=gParticle.Color.x;
float l9_913=0.0;
float l9_914=1.00001;
float l9_915=fast::clamp(l9_912,l9_913,l9_914);
float l9_916=l9_913;
float l9_917=l9_914;
float l9_918=0.0;
float l9_919=1.0;
float l9_920=l9_918+(((l9_915-l9_916)*(l9_919-l9_918))/(l9_917-l9_916));
float l9_921=l9_920;
l9_643.x=l9_921;
l9_656=l9_643.x;
float l9_922=gParticle.Color.y;
float l9_923=0.0;
float l9_924=1.00001;
float l9_925=fast::clamp(l9_922,l9_923,l9_924);
float l9_926=l9_923;
float l9_927=l9_924;
float l9_928=0.0;
float l9_929=1.0;
float l9_930=l9_928+(((l9_925-l9_926)*(l9_929-l9_928))/(l9_927-l9_926));
float l9_931=l9_930;
l9_643.x=l9_931;
l9_657=l9_643.x;
float l9_932=gParticle.Color.z;
float l9_933=0.0;
float l9_934=1.00001;
float l9_935=fast::clamp(l9_932,l9_933,l9_934);
float l9_936=l9_933;
float l9_937=l9_934;
float l9_938=0.0;
float l9_939=1.0;
float l9_940=l9_938+(((l9_935-l9_936)*(l9_939-l9_938))/(l9_937-l9_936));
float l9_941=l9_940;
l9_643.x=l9_941;
l9_658=l9_643.x;
float l9_942=gParticle.Color.w;
float l9_943=0.0;
float l9_944=1.00001;
float l9_945=fast::clamp(l9_942,l9_943,l9_944);
float l9_946=l9_943;
float l9_947=l9_944;
float l9_948=0.0;
float l9_949=1.0;
float l9_950=l9_948+(((l9_945-l9_946)*(l9_949-l9_948))/(l9_947-l9_946));
float l9_951=l9_950;
l9_643.x=l9_951;
l9_659=l9_643.x;
}
else
{
if (l9_642==3)
{
float l9_952=gParticle.collisionCount_N119;
float l9_953=0.0;
float l9_954=255.0;
float l9_955=fast::clamp(l9_952,l9_953,l9_954);
float l9_956=l9_953;
float l9_957=l9_954;
float l9_958=0.0;
float l9_959=1.0;
float l9_960=l9_958+(((l9_955-l9_956)*(l9_959-l9_958))/(l9_957-l9_956));
float l9_961=l9_960;
l9_643.x=l9_961;
l9_644=l9_643.x;
}
}
}
}
float4 param_89=float4(l9_644,l9_645,l9_646,l9_647);
float4 param_90=float4(l9_648,l9_649,l9_650,l9_651);
float4 param_91=float4(l9_652,l9_653,l9_654,l9_655);
float4 param_92=float4(l9_656,l9_657,l9_658,l9_659);
Data0=param_89;
Data1=param_90;
Data2=param_91;
Data3=param_92;
if (dot(((Data0+Data1)+Data2)+Data3,float4(0.23454))==0.34231836)
{
Data0+=float4(1e-06);
}
}
float4 param_93=Data0;
out.FragColor0=param_93;
float4 param_94=Data1;
out.FragColor1=param_94;
float4 param_95=Data2;
out.FragColor2=param_95;
float4 param_96=Data3;
out.FragColor3=param_96;
return out;
}
} // FRAGMENT SHADER
