#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define SC_USE_USER_DEFINED_VS_MAIN
//efine SC_DISABLE_FRUSTUM_CULLING
#define SC_ALLOW_16_TEXTURES
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
//sampler sampler renderTarget0SmpSC 2:11
//sampler sampler renderTarget1SmpSC 2:12
//sampler sampler renderTarget2SmpSC 2:13
//sampler sampler renderTarget3SmpSC 2:14
//texture texture2D renderTarget0 2:1:2:11
//texture texture2D renderTarget1 2:2:2:12
//texture texture2D renderTarget2 2:3:2:13
//texture texture2D renderTarget3 2:4:2:14
//ubo float sc_BonesUBO 2:0:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:21:4336 {
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
//float4 renderTarget0Size 3808
//float4 renderTarget0Dims 3824
//float4 renderTarget0View 3840
//float3x3 renderTarget0Transform 3856
//float4 renderTarget0UvMinMax 3904
//float4 renderTarget0BorderColor 3920
//float4 renderTarget1Size 3936
//float4 renderTarget1Dims 3952
//float4 renderTarget1View 3968
//float3x3 renderTarget1Transform 3984
//float4 renderTarget1UvMinMax 4032
//float4 renderTarget1BorderColor 4048
//float4 renderTarget2Size 4064
//float4 renderTarget2Dims 4080
//float4 renderTarget2View 4096
//float3x3 renderTarget2Transform 4112
//float4 renderTarget2UvMinMax 4160
//float4 renderTarget2BorderColor 4176
//float4 renderTarget3Size 4192
//float4 renderTarget3Dims 4208
//float4 renderTarget3View 4224
//float3x3 renderTarget3Transform 4240
//float4 renderTarget3UvMinMax 4288
//float4 renderTarget3BorderColor 4304
//float2 rtScaleFactor 4320
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
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 1016
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 1017
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 1018
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 1019
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 1020
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 1021
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 1022
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 1023
//spec_const int renderTarget0Layout 1024
//spec_const int renderTarget1Layout 1025
//spec_const int renderTarget2Layout 1026
//spec_const int renderTarget3Layout 1027
//spec_const int sc_StereoRenderingMode 1028
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1029
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
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 [[function_constant(1016)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 [[function_constant(1017)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 [[function_constant(1018)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 [[function_constant(1019)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget3 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 [[function_constant(1020)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 [[function_constant(1021)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 [[function_constant(1022)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 [[function_constant(1023)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget3 : -1;
constant int renderTarget0Layout [[function_constant(1024)]];
constant int renderTarget0Layout_tmp = is_function_constant_defined(renderTarget0Layout) ? renderTarget0Layout : 0;
constant int renderTarget1Layout [[function_constant(1025)]];
constant int renderTarget1Layout_tmp = is_function_constant_defined(renderTarget1Layout) ? renderTarget1Layout : 0;
constant int renderTarget2Layout [[function_constant(1026)]];
constant int renderTarget2Layout_tmp = is_function_constant_defined(renderTarget2Layout) ? renderTarget2Layout : 0;
constant int renderTarget3Layout [[function_constant(1027)]];
constant int renderTarget3Layout_tmp = is_function_constant_defined(renderTarget3Layout) ? renderTarget3Layout : 0;
constant int sc_StereoRenderingMode [[function_constant(1028)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1029)]];
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
float2 rtScaleFactor;
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
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
sampler renderTarget0SmpSC [[id(11)]];
sampler renderTarget1SmpSC [[id(12)]];
sampler renderTarget2SmpSC [[id(13)]];
sampler renderTarget3SmpSC [[id(14)]];
constant userUniformsObj* UserUniforms [[id(21)]];
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
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.normal=in.normal;
l9_0.tangent=in.tangent.xyz;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t v=l9_1;
float4 param=float4((v.texture0*2.0)-float2(1.0),1.0,1.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_2=param;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_3=dot(l9_2,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_4=l9_3;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_4;
}
}
float4 l9_5=float4(param.x,-param.y,(param.z*0.5)+(param.w*0.5),param.w);
out.gl_Position=l9_5;
out.varPackedTex=float4(v.texture0.x,v.texture0.y,out.varPackedTex.z,out.varPackedTex.w);
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
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
float2 rtScaleFactor;
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
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
sampler renderTarget0SmpSC [[id(11)]];
sampler renderTarget1SmpSC [[id(12)]];
sampler renderTarget2SmpSC [[id(13)]];
sampler renderTarget3SmpSC [[id(14)]];
constant userUniformsObj* UserUniforms [[id(21)]];
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
float2 uv=in.varPackedTex.xy;
uv*=(*sc_set2.UserUniforms).rtScaleFactor;
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
float2 param_2=uv;
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
float2 param_13=uv;
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
float2 param_24=uv;
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
float2 param_35=uv;
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
if (dot(((renderTarget0Sample+renderTarget1Sample)+renderTarget2Sample)+renderTarget3Sample,float4(0.2542325))==0.34231836)
{
discard_fragment();
}
float4 param_44=renderTarget0Sample;
out.FragColor0=param_44;
float4 param_45=renderTarget1Sample;
out.FragColor1=param_45;
float4 param_46=renderTarget2Sample;
out.FragColor2=param_46;
float4 param_47=renderTarget3Sample;
out.FragColor3=param_47;
return out;
}
} // FRAGMENT SHADER
