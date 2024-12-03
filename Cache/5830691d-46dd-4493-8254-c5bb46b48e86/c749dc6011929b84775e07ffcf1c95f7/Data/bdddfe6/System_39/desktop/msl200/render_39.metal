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
//attribute vec4 color 18
//attribute vec3 positionNext 15
//attribute vec3 positionPrevious 16
//attribute vec4 strandProperties 17
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//sampler sampler intensityTextureSmpSC 2:20
//sampler sampler renderTarget0SmpSC 2:21
//sampler sampler renderTarget1SmpSC 2:22
//sampler sampler renderTarget2SmpSC 2:23
//sampler sampler renderTarget3SmpSC 2:24
//sampler sampler sc_ScreenTextureSmpSC 2:29
//texture texture2D intensityTexture 2:1:2:20
//texture texture2D renderTarget0 2:2:2:21
//texture texture2D renderTarget1 2:3:2:22
//texture texture2D renderTarget2 2:4:2:23
//texture texture2D renderTarget3 2:5:2:24
//texture texture2D sc_ScreenTexture 2:17:2:29
//ubo float sc_BonesUBO 2:0:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:32:7504 {
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
//float4 Port_Value1_N132 7200
//float4 Port_Value2_N132 7216
//float Port_AlphaTestThreshold_N039 7232
//float3 Port_Normal_N002 7248
//float Port_Exponent_N002 7264
//float Port_Intensity_N002 7268
//float Port_Input1_N063 7272
//float Port_Input1_N017 7276
//float Port_RangeMinA_N018 7280
//float Port_RangeMaxA_N018 7284
//float Port_RangeMinB_N018 7288
//float Port_RangeMaxB_N018 7292
//float Port_Input1_N065 7296
//float Port_Input2_N065 7300
//float4 Port_Input1_N066 7312
//float4 Port_Value0_N068 7328
//float Port_Position1_N068 7344
//float4 Port_Value1_N068 7360
//float Port_Position2_N068 7376
//float4 Port_Value2_N068 7392
//float4 Port_Value3_N068 7408
//float Port_Input1_N067 7424
//float4 Port_Value0_N178 7440
//float Port_Position1_N178 7456
//float4 Port_Value1_N178 7472
//float4 Port_Value2_N178 7488
//}
//spec_const bool BLEND_MODE_AVERAGE 1000
//spec_const bool BLEND_MODE_BRIGHT 1001
//spec_const bool BLEND_MODE_COLOR_BURN 1002
//spec_const bool BLEND_MODE_COLOR_DODGE 1003
//spec_const bool BLEND_MODE_COLOR 1004
//spec_const bool BLEND_MODE_DARKEN 1005
//spec_const bool BLEND_MODE_DIFFERENCE 1006
//spec_const bool BLEND_MODE_DIVIDE 1007
//spec_const bool BLEND_MODE_DIVISION 1008
//spec_const bool BLEND_MODE_EXCLUSION 1009
//spec_const bool BLEND_MODE_FORGRAY 1010
//spec_const bool BLEND_MODE_HARD_GLOW 1011
//spec_const bool BLEND_MODE_HARD_LIGHT 1012
//spec_const bool BLEND_MODE_HARD_MIX 1013
//spec_const bool BLEND_MODE_HARD_PHOENIX 1014
//spec_const bool BLEND_MODE_HARD_REFLECT 1015
//spec_const bool BLEND_MODE_HUE 1016
//spec_const bool BLEND_MODE_INTENSE 1017
//spec_const bool BLEND_MODE_LIGHTEN 1018
//spec_const bool BLEND_MODE_LINEAR_LIGHT 1019
//spec_const bool BLEND_MODE_LUMINOSITY 1020
//spec_const bool BLEND_MODE_NEGATION 1021
//spec_const bool BLEND_MODE_NOTBRIGHT 1022
//spec_const bool BLEND_MODE_OVERLAY 1023
//spec_const bool BLEND_MODE_PIN_LIGHT 1024
//spec_const bool BLEND_MODE_REALISTIC 1025
//spec_const bool BLEND_MODE_SATURATION 1026
//spec_const bool BLEND_MODE_SOFT_LIGHT 1027
//spec_const bool BLEND_MODE_SUBTRACT 1028
//spec_const bool BLEND_MODE_VIVID_LIGHT 1029
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1030
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget0 1031
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget1 1032
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget2 1033
//spec_const bool SC_USE_CLAMP_TO_BORDER_renderTarget3 1034
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1035
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget0 1036
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget1 1037
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget2 1038
//spec_const bool SC_USE_UV_MIN_MAX_renderTarget3 1039
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1040
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget0 1041
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget1 1042
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget2 1043
//spec_const bool SC_USE_UV_TRANSFORM_renderTarget3 1044
//spec_const bool UseViewSpaceDepthVariant 1045
//spec_const bool intensityTextureHasSwappedViews 1046
//spec_const bool renderTarget0HasSwappedViews 1047
//spec_const bool renderTarget1HasSwappedViews 1048
//spec_const bool renderTarget2HasSwappedViews 1049
//spec_const bool renderTarget3HasSwappedViews 1050
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1051
//spec_const bool sc_BlendMode_Add 1052
//spec_const bool sc_BlendMode_AlphaTest 1053
//spec_const bool sc_BlendMode_AlphaToCoverage 1054
//spec_const bool sc_BlendMode_ColoredGlass 1055
//spec_const bool sc_BlendMode_Custom 1056
//spec_const bool sc_BlendMode_Max 1057
//spec_const bool sc_BlendMode_Min 1058
//spec_const bool sc_BlendMode_MultiplyOriginal 1059
//spec_const bool sc_BlendMode_Multiply 1060
//spec_const bool sc_BlendMode_Normal 1061
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1062
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1063
//spec_const bool sc_BlendMode_PremultipliedAlpha 1064
//spec_const bool sc_BlendMode_Screen 1065
//spec_const bool sc_FramebufferFetch 1066
//spec_const bool sc_OITCompositingPass 1067
//spec_const bool sc_OITDepthBoundsPass 1068
//spec_const bool sc_OITDepthGatherPass 1069
//spec_const bool sc_ProjectiveShadowsCaster 1070
//spec_const bool sc_RenderAlphaToColor 1071
//spec_const bool sc_ScreenTextureHasSwappedViews 1072
//spec_const bool sc_ShaderComplexityAnalyzer 1073
//spec_const bool sc_UseFramebufferFetchMarker 1074
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1075
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 1076
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 1077
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 1078
//spec_const int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 1079
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1080
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 1081
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 1082
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 1083
//spec_const int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 1084
//spec_const int intensityTextureLayout 1085
//spec_const int renderTarget0Layout 1086
//spec_const int renderTarget1Layout 1087
//spec_const int renderTarget2Layout 1088
//spec_const int renderTarget3Layout 1089
//spec_const int sc_DepthBufferMode 1090
//spec_const int sc_ScreenTextureLayout 1091
//spec_const int sc_StereoRenderingMode 1092
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1093
//SG_REFLECTION_END
constant bool BLEND_MODE_AVERAGE [[function_constant(1000)]];
constant bool BLEND_MODE_AVERAGE_tmp = is_function_constant_defined(BLEND_MODE_AVERAGE) ? BLEND_MODE_AVERAGE : false;
constant bool BLEND_MODE_BRIGHT [[function_constant(1001)]];
constant bool BLEND_MODE_BRIGHT_tmp = is_function_constant_defined(BLEND_MODE_BRIGHT) ? BLEND_MODE_BRIGHT : false;
constant bool BLEND_MODE_COLOR_BURN [[function_constant(1002)]];
constant bool BLEND_MODE_COLOR_BURN_tmp = is_function_constant_defined(BLEND_MODE_COLOR_BURN) ? BLEND_MODE_COLOR_BURN : false;
constant bool BLEND_MODE_COLOR_DODGE [[function_constant(1003)]];
constant bool BLEND_MODE_COLOR_DODGE_tmp = is_function_constant_defined(BLEND_MODE_COLOR_DODGE) ? BLEND_MODE_COLOR_DODGE : false;
constant bool BLEND_MODE_COLOR [[function_constant(1004)]];
constant bool BLEND_MODE_COLOR_tmp = is_function_constant_defined(BLEND_MODE_COLOR) ? BLEND_MODE_COLOR : false;
constant bool BLEND_MODE_DARKEN [[function_constant(1005)]];
constant bool BLEND_MODE_DARKEN_tmp = is_function_constant_defined(BLEND_MODE_DARKEN) ? BLEND_MODE_DARKEN : false;
constant bool BLEND_MODE_DIFFERENCE [[function_constant(1006)]];
constant bool BLEND_MODE_DIFFERENCE_tmp = is_function_constant_defined(BLEND_MODE_DIFFERENCE) ? BLEND_MODE_DIFFERENCE : false;
constant bool BLEND_MODE_DIVIDE [[function_constant(1007)]];
constant bool BLEND_MODE_DIVIDE_tmp = is_function_constant_defined(BLEND_MODE_DIVIDE) ? BLEND_MODE_DIVIDE : false;
constant bool BLEND_MODE_DIVISION [[function_constant(1008)]];
constant bool BLEND_MODE_DIVISION_tmp = is_function_constant_defined(BLEND_MODE_DIVISION) ? BLEND_MODE_DIVISION : false;
constant bool BLEND_MODE_EXCLUSION [[function_constant(1009)]];
constant bool BLEND_MODE_EXCLUSION_tmp = is_function_constant_defined(BLEND_MODE_EXCLUSION) ? BLEND_MODE_EXCLUSION : false;
constant bool BLEND_MODE_FORGRAY [[function_constant(1010)]];
constant bool BLEND_MODE_FORGRAY_tmp = is_function_constant_defined(BLEND_MODE_FORGRAY) ? BLEND_MODE_FORGRAY : false;
constant bool BLEND_MODE_HARD_GLOW [[function_constant(1011)]];
constant bool BLEND_MODE_HARD_GLOW_tmp = is_function_constant_defined(BLEND_MODE_HARD_GLOW) ? BLEND_MODE_HARD_GLOW : false;
constant bool BLEND_MODE_HARD_LIGHT [[function_constant(1012)]];
constant bool BLEND_MODE_HARD_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_HARD_LIGHT) ? BLEND_MODE_HARD_LIGHT : false;
constant bool BLEND_MODE_HARD_MIX [[function_constant(1013)]];
constant bool BLEND_MODE_HARD_MIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_MIX) ? BLEND_MODE_HARD_MIX : false;
constant bool BLEND_MODE_HARD_PHOENIX [[function_constant(1014)]];
constant bool BLEND_MODE_HARD_PHOENIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_PHOENIX) ? BLEND_MODE_HARD_PHOENIX : false;
constant bool BLEND_MODE_HARD_REFLECT [[function_constant(1015)]];
constant bool BLEND_MODE_HARD_REFLECT_tmp = is_function_constant_defined(BLEND_MODE_HARD_REFLECT) ? BLEND_MODE_HARD_REFLECT : false;
constant bool BLEND_MODE_HUE [[function_constant(1016)]];
constant bool BLEND_MODE_HUE_tmp = is_function_constant_defined(BLEND_MODE_HUE) ? BLEND_MODE_HUE : false;
constant bool BLEND_MODE_INTENSE [[function_constant(1017)]];
constant bool BLEND_MODE_INTENSE_tmp = is_function_constant_defined(BLEND_MODE_INTENSE) ? BLEND_MODE_INTENSE : false;
constant bool BLEND_MODE_LIGHTEN [[function_constant(1018)]];
constant bool BLEND_MODE_LIGHTEN_tmp = is_function_constant_defined(BLEND_MODE_LIGHTEN) ? BLEND_MODE_LIGHTEN : false;
constant bool BLEND_MODE_LINEAR_LIGHT [[function_constant(1019)]];
constant bool BLEND_MODE_LINEAR_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_LINEAR_LIGHT) ? BLEND_MODE_LINEAR_LIGHT : false;
constant bool BLEND_MODE_LUMINOSITY [[function_constant(1020)]];
constant bool BLEND_MODE_LUMINOSITY_tmp = is_function_constant_defined(BLEND_MODE_LUMINOSITY) ? BLEND_MODE_LUMINOSITY : false;
constant bool BLEND_MODE_NEGATION [[function_constant(1021)]];
constant bool BLEND_MODE_NEGATION_tmp = is_function_constant_defined(BLEND_MODE_NEGATION) ? BLEND_MODE_NEGATION : false;
constant bool BLEND_MODE_NOTBRIGHT [[function_constant(1022)]];
constant bool BLEND_MODE_NOTBRIGHT_tmp = is_function_constant_defined(BLEND_MODE_NOTBRIGHT) ? BLEND_MODE_NOTBRIGHT : false;
constant bool BLEND_MODE_OVERLAY [[function_constant(1023)]];
constant bool BLEND_MODE_OVERLAY_tmp = is_function_constant_defined(BLEND_MODE_OVERLAY) ? BLEND_MODE_OVERLAY : false;
constant bool BLEND_MODE_PIN_LIGHT [[function_constant(1024)]];
constant bool BLEND_MODE_PIN_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_PIN_LIGHT) ? BLEND_MODE_PIN_LIGHT : false;
constant bool BLEND_MODE_REALISTIC [[function_constant(1025)]];
constant bool BLEND_MODE_REALISTIC_tmp = is_function_constant_defined(BLEND_MODE_REALISTIC) ? BLEND_MODE_REALISTIC : false;
constant bool BLEND_MODE_SATURATION [[function_constant(1026)]];
constant bool BLEND_MODE_SATURATION_tmp = is_function_constant_defined(BLEND_MODE_SATURATION) ? BLEND_MODE_SATURATION : false;
constant bool BLEND_MODE_SOFT_LIGHT [[function_constant(1027)]];
constant bool BLEND_MODE_SOFT_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_SOFT_LIGHT) ? BLEND_MODE_SOFT_LIGHT : false;
constant bool BLEND_MODE_SUBTRACT [[function_constant(1028)]];
constant bool BLEND_MODE_SUBTRACT_tmp = is_function_constant_defined(BLEND_MODE_SUBTRACT) ? BLEND_MODE_SUBTRACT : false;
constant bool BLEND_MODE_VIVID_LIGHT [[function_constant(1029)]];
constant bool BLEND_MODE_VIVID_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_VIVID_LIGHT) ? BLEND_MODE_VIVID_LIGHT : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1030)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget0 [[function_constant(1031)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget0_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget0) ? SC_USE_CLAMP_TO_BORDER_renderTarget0 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget1 [[function_constant(1032)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget1_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget1) ? SC_USE_CLAMP_TO_BORDER_renderTarget1 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget2 [[function_constant(1033)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget2_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget2) ? SC_USE_CLAMP_TO_BORDER_renderTarget2 : false;
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget3 [[function_constant(1034)]];
constant bool SC_USE_CLAMP_TO_BORDER_renderTarget3_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_renderTarget3) ? SC_USE_CLAMP_TO_BORDER_renderTarget3 : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1035)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget0 [[function_constant(1036)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget0_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget0) ? SC_USE_UV_MIN_MAX_renderTarget0 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget1 [[function_constant(1037)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget1_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget1) ? SC_USE_UV_MIN_MAX_renderTarget1 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget2 [[function_constant(1038)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget2_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget2) ? SC_USE_UV_MIN_MAX_renderTarget2 : false;
constant bool SC_USE_UV_MIN_MAX_renderTarget3 [[function_constant(1039)]];
constant bool SC_USE_UV_MIN_MAX_renderTarget3_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_renderTarget3) ? SC_USE_UV_MIN_MAX_renderTarget3 : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1040)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget0 [[function_constant(1041)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget0_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget0) ? SC_USE_UV_TRANSFORM_renderTarget0 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget1 [[function_constant(1042)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget1_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget1) ? SC_USE_UV_TRANSFORM_renderTarget1 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget2 [[function_constant(1043)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget2_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget2) ? SC_USE_UV_TRANSFORM_renderTarget2 : false;
constant bool SC_USE_UV_TRANSFORM_renderTarget3 [[function_constant(1044)]];
constant bool SC_USE_UV_TRANSFORM_renderTarget3_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_renderTarget3) ? SC_USE_UV_TRANSFORM_renderTarget3 : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1045)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool intensityTextureHasSwappedViews [[function_constant(1046)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool renderTarget0HasSwappedViews [[function_constant(1047)]];
constant bool renderTarget0HasSwappedViews_tmp = is_function_constant_defined(renderTarget0HasSwappedViews) ? renderTarget0HasSwappedViews : false;
constant bool renderTarget1HasSwappedViews [[function_constant(1048)]];
constant bool renderTarget1HasSwappedViews_tmp = is_function_constant_defined(renderTarget1HasSwappedViews) ? renderTarget1HasSwappedViews : false;
constant bool renderTarget2HasSwappedViews [[function_constant(1049)]];
constant bool renderTarget2HasSwappedViews_tmp = is_function_constant_defined(renderTarget2HasSwappedViews) ? renderTarget2HasSwappedViews : false;
constant bool renderTarget3HasSwappedViews [[function_constant(1050)]];
constant bool renderTarget3HasSwappedViews_tmp = is_function_constant_defined(renderTarget3HasSwappedViews) ? renderTarget3HasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1051)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1052)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1053)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1054)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1055)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1056)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1057)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1058)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1059)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1060)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1061)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1062)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1063)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1064)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1065)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_FramebufferFetch [[function_constant(1066)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_OITCompositingPass [[function_constant(1067)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1068)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1069)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1070)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_RenderAlphaToColor [[function_constant(1071)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1072)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1073)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1074)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1075)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0 [[function_constant(1076)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1 [[function_constant(1077)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2 [[function_constant(1078)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3 [[function_constant(1079)]];
constant int SC_SOFTWARE_WRAP_MODE_U_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_U_renderTarget3 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1080)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0 [[function_constant(1081)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget0_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget0) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget0 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1 [[function_constant(1082)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget1_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget1) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget1 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2 [[function_constant(1083)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget2_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget2) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget2 : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3 [[function_constant(1084)]];
constant int SC_SOFTWARE_WRAP_MODE_V_renderTarget3_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_renderTarget3) ? SC_SOFTWARE_WRAP_MODE_V_renderTarget3 : -1;
constant int intensityTextureLayout [[function_constant(1085)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int renderTarget0Layout [[function_constant(1086)]];
constant int renderTarget0Layout_tmp = is_function_constant_defined(renderTarget0Layout) ? renderTarget0Layout : 0;
constant int renderTarget1Layout [[function_constant(1087)]];
constant int renderTarget1Layout_tmp = is_function_constant_defined(renderTarget1Layout) ? renderTarget1Layout : 0;
constant int renderTarget2Layout [[function_constant(1088)]];
constant int renderTarget2Layout_tmp = is_function_constant_defined(renderTarget2Layout) ? renderTarget2Layout : 0;
constant int renderTarget3Layout [[function_constant(1089)]];
constant int renderTarget3Layout_tmp = is_function_constant_defined(renderTarget3Layout) ? renderTarget3Layout : 0;
constant int sc_DepthBufferMode [[function_constant(1090)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_ScreenTextureLayout [[function_constant(1091)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_StereoRenderingMode [[function_constant(1092)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1093)]];
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
float4 Port_Value1_N132;
float4 Port_Value2_N132;
float Port_AlphaTestThreshold_N039;
float3 Port_Normal_N002;
float Port_Exponent_N002;
float Port_Intensity_N002;
float Port_Input1_N063;
float Port_Input1_N017;
float Port_RangeMinA_N018;
float Port_RangeMaxA_N018;
float Port_RangeMinB_N018;
float Port_RangeMaxB_N018;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Input1_N066;
float4 Port_Value0_N068;
float Port_Position1_N068;
float4 Port_Value1_N068;
float Port_Position2_N068;
float4 Port_Value2_N068;
float4 Port_Value3_N068;
float Port_Input1_N067;
float4 Port_Value0_N178;
float Port_Position1_N178;
float4 Port_Value1_N178;
float4 Port_Value2_N178;
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
texture2d<float> intensityTexture [[id(1)]];
texture2d<float> renderTarget0 [[id(2)]];
texture2d<float> renderTarget1 [[id(3)]];
texture2d<float> renderTarget2 [[id(4)]];
texture2d<float> renderTarget3 [[id(5)]];
texture2d<float> sc_ScreenTexture [[id(17)]];
sampler intensityTextureSmpSC [[id(20)]];
sampler renderTarget0SmpSC [[id(21)]];
sampler renderTarget1SmpSC [[id(22)]];
sampler renderTarget2SmpSC [[id(23)]];
sampler renderTarget3SmpSC [[id(24)]];
sampler sc_ScreenTextureSmpSC [[id(29)]];
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
float gParticlesDebug [[user(locn23)]];
float2 ParticleUV [[user(locn24)]];
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
float4 color [[attribute(18)]];
};
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
int offsetPixelId=(UserUniforms.vfxOffsetInstances+InstanceID)*4;
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
out.varColor=in.color;
int l9_2=gl_InstanceIndex;
int InstanceID=l9_2;
int l9_3=InstanceID;
bool l9_4=l9_3>=(40*((*sc_set2.UserUniforms).vfxNumCopies+1));
ssParticle gParticle;
bool l9_5;
if (!l9_4)
{
int l9_6=gl_InstanceIndex;
l9_5=((*sc_set2.UserUniforms).vfxBatchEnable[l9_6/40]!=0)==false;
}
else
{
l9_5=l9_4;
}
if (l9_5)
{
float4 param=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_7=param;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_8=dot(l9_7,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_9=l9_8;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_9;
}
}
float4 l9_10=float4(param.x,-param.y,(param.z*0.5)+(param.w*0.5),param.w);
out.gl_Position=l9_10;
return out;
}
int param_1=InstanceID;
bool l9_12=ssDecodeParticle(param_1,gl_InstanceIndex,(*sc_set2.UserUniforms),sc_set2.renderTarget0,sc_set2.renderTarget0SmpSC,sc_set2.renderTarget1,sc_set2.renderTarget1SmpSC,sc_set2.renderTarget2,sc_set2.renderTarget2SmpSC,sc_set2.renderTarget3,sc_set2.renderTarget3SmpSC,gParticle);
if (!l9_12)
{
float4 param_2=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_13=param_2;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_14=dot(l9_13,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_15=l9_14;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_15;
}
}
float4 l9_16=float4(param_2.x,-param_2.y,(param_2.z*0.5)+(param_2.w*0.5),param_2.w);
out.gl_Position=l9_16;
return out;
}
float l9_17=gParticle.Size;
bool l9_18=l9_17<9.9999997e-06;
bool l9_19;
if (!l9_18)
{
l9_19=gParticle.Age>=gParticle.Life;
}
else
{
l9_19=l9_18;
}
if (l9_19)
{
float4 param_3=float4(4334.0,4334.0,4334.0,0.0);
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_20=param_3;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_21=dot(l9_20,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_22=l9_21;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_22;
}
}
float4 l9_23=float4(param_3.x,-param_3.y,(param_3.z*0.5)+(param_3.w*0.5),param_3.w);
out.gl_Position=l9_23;
return out;
}
float4 param_4=gParticle.Quaternion;
param_4=normalize(param_4.yzwx);
float l9_24=param_4.x*param_4.x;
float l9_25=param_4.y*param_4.y;
float l9_26=param_4.z*param_4.z;
float l9_27=param_4.x*param_4.z;
float l9_28=param_4.x*param_4.y;
float l9_29=param_4.y*param_4.z;
float l9_30=param_4.w*param_4.x;
float l9_31=param_4.w*param_4.y;
float l9_32=param_4.w*param_4.z;
float3x3 l9_33=float3x3(float3(1.0-(2.0*(l9_25+l9_26)),2.0*(l9_28+l9_32),2.0*(l9_27-l9_31)),float3(2.0*(l9_28-l9_32),1.0-(2.0*(l9_24+l9_26)),2.0*(l9_29+l9_30)),float3(2.0*(l9_27+l9_31),2.0*(l9_29-l9_30),1.0-(2.0*(l9_24+l9_25))));
gParticle.Matrix=l9_33;
out.varPos=gParticle.Position+((gParticle.Matrix*v.position.xyz)*gParticle.Size);
out.varNormal=gParticle.Matrix*v.normal;
float3 l9_34=gParticle.Matrix*v.tangent;
out.varTangent=float4(l9_34.x,l9_34.y,l9_34.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
out.varPackedTex=float4(v.texture0,v.texture1);
if ((int(UseViewSpaceDepthVariant_tmp)!=0)&&(((int(sc_OITDepthGatherPass_tmp)!=0)||(int(sc_OITCompositingPass_tmp)!=0))||(int(sc_OITDepthBoundsPass_tmp)!=0)))
{
int l9_35=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_35=0;
}
else
{
l9_35=gl_InstanceIndex%2;
}
int l9_36=l9_35;
float4 ViewPosition=(*sc_set2.UserUniforms).sc_ViewMatrixArray[l9_36]*float4(out.varPos,1.0);
out.varViewSpaceDepth=-ViewPosition.z;
int l9_37=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_37=0;
}
else
{
l9_37=gl_InstanceIndex%2;
}
int l9_38=l9_37;
float4 param_5=(*sc_set2.UserUniforms).sc_ProjectionMatrixArray[l9_38]*ViewPosition;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_39=param_5;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_40=dot(l9_39,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_41=l9_40;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_41;
}
}
float4 l9_42=float4(param_5.x,-param_5.y,(param_5.z*0.5)+(param_5.w*0.5),param_5.w);
out.gl_Position=l9_42;
}
else
{
int l9_43=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_43=0;
}
else
{
l9_43=gl_InstanceIndex%2;
}
int l9_44=l9_43;
float4 clipPosition=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_44]*float4(out.varPos,1.0);
float4 param_6=clipPosition;
if (sc_DepthBufferMode_tmp==1)
{
int l9_45=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_45=0;
}
else
{
l9_45=gl_InstanceIndex%2;
}
int l9_46=l9_45;
if ((*sc_set2.UserUniforms).sc_ProjectionMatrixArray[l9_46][2].w!=0.0)
{
float l9_47=2.0/log2((*sc_set2.UserUniforms).sc_Camera.clipPlanes.y+1.0);
param_6.z=((log2(fast::max((*sc_set2.UserUniforms).sc_Camera.clipPlanes.x,1.0+param_6.w))*l9_47)-1.0)*param_6.w;
}
}
float4 l9_48=param_6;
clipPosition=l9_48;
float4 param_7=clipPosition;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_49=param_7;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_50=dot(l9_49,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_51=l9_50;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_51;
}
}
float4 l9_52=float4(param_7.x,-param_7.y,(param_7.z*0.5)+(param_7.w*0.5),param_7.w);
out.gl_Position=l9_52;
}
int l9_53=gl_InstanceIndex;
out.Interp_Particle_Index=l9_53;
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
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 VertexTangent_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexBinormal_WorldSpace;
float3 ViewDirWS;
float3 SurfacePosition_WorldSpace;
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
float4 Port_Value1_N132;
float4 Port_Value2_N132;
float Port_AlphaTestThreshold_N039;
float3 Port_Normal_N002;
float Port_Exponent_N002;
float Port_Intensity_N002;
float Port_Input1_N063;
float Port_Input1_N017;
float Port_RangeMinA_N018;
float Port_RangeMaxA_N018;
float Port_RangeMinB_N018;
float Port_RangeMaxB_N018;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Input1_N066;
float4 Port_Value0_N068;
float Port_Position1_N068;
float4 Port_Value1_N068;
float Port_Position2_N068;
float4 Port_Value2_N068;
float4 Port_Value3_N068;
float Port_Input1_N067;
float4 Port_Value0_N178;
float Port_Position1_N178;
float4 Port_Value1_N178;
float4 Port_Value2_N178;
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
texture2d<float> intensityTexture [[id(1)]];
texture2d<float> renderTarget0 [[id(2)]];
texture2d<float> renderTarget1 [[id(3)]];
texture2d<float> renderTarget2 [[id(4)]];
texture2d<float> renderTarget3 [[id(5)]];
texture2d<float> sc_ScreenTexture [[id(17)]];
sampler intensityTextureSmpSC [[id(20)]];
sampler renderTarget0SmpSC [[id(21)]];
sampler renderTarget1SmpSC [[id(22)]];
sampler renderTarget2SmpSC [[id(23)]];
sampler renderTarget3SmpSC [[id(24)]];
sampler sc_ScreenTextureSmpSC [[id(29)]];
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
float gParticlesDebug [[user(locn23)]];
float2 ParticleUV [[user(locn24)]];
float4 color [[user(locn25)]];
};
float transformSingleColor(thread const float& original,thread const float& intMap,thread const float& target)
{
if (((int(BLEND_MODE_REALISTIC_tmp)!=0)||(int(BLEND_MODE_FORGRAY_tmp)!=0))||(int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
return original/pow(1.0-target,intMap);
}
else
{
if ((int(BLEND_MODE_DIVISION_tmp)!=0))
{
return original/(1.0-target);
}
else
{
if ((int(BLEND_MODE_BRIGHT_tmp)!=0))
{
return original/pow(1.0-target,2.0-(2.0*original));
}
}
}
return 0.0;
}
float3 transformColor(thread const float& yValue,thread const float3& original,thread const float3& target,thread const float& weight,thread const float& intMap)
{
if ((int(BLEND_MODE_INTENSE_tmp)!=0))
{
float3 param=original;
float3 l9_0=param;
float4 l9_1;
if (l9_0.y<l9_0.z)
{
l9_1=float4(l9_0.zy,-1.0,0.66666669);
}
else
{
l9_1=float4(l9_0.yz,0.0,-0.33333334);
}
float4 l9_2=l9_1;
float4 l9_3;
if (l9_0.x<l9_2.x)
{
l9_3=float4(l9_2.xyw,l9_0.x);
}
else
{
l9_3=float4(l9_0.x,l9_2.yzx);
}
float4 l9_4=l9_3;
float l9_5=l9_4.x-fast::min(l9_4.w,l9_4.y);
float l9_6=abs(((l9_4.w-l9_4.y)/((6.0*l9_5)+1e-07))+l9_4.z);
float l9_7=l9_4.x;
float3 l9_8=float3(l9_6,l9_5,l9_7);
float3 l9_9=l9_8;
float l9_10=l9_9.z-(l9_9.y*0.5);
float l9_11=l9_9.y/((1.0-abs((2.0*l9_10)-1.0))+1e-07);
float3 l9_12=float3(l9_9.x,l9_11,l9_10);
float3 hslOrig=l9_12;
float3 res=float3(0.0);
res.x=target.x;
res.y=target.y;
res.z=hslOrig.z;
float3 param_1=res;
float l9_13=param_1.x;
float l9_14=abs((6.0*l9_13)-3.0)-1.0;
float l9_15=2.0-abs((6.0*l9_13)-2.0);
float l9_16=2.0-abs((6.0*l9_13)-4.0);
float3 l9_17=fast::clamp(float3(l9_14,l9_15,l9_16),float3(0.0),float3(1.0));
float3 l9_18=l9_17;
float l9_19=(1.0-abs((2.0*param_1.z)-1.0))*param_1.y;
l9_18=((l9_18-float3(0.5))*l9_19)+float3(param_1.z);
float3 l9_20=l9_18;
res=l9_20;
float3 resColor=mix(original,res,float3(weight));
return resColor;
}
else
{
float3 tmpColor=float3(0.0);
float param_2=yValue;
float param_3=intMap;
float param_4=target.x;
tmpColor.x=transformSingleColor(param_2,param_3,param_4);
float param_5=yValue;
float param_6=intMap;
float param_7=target.y;
tmpColor.y=transformSingleColor(param_5,param_6,param_7);
float param_8=yValue;
float param_9=intMap;
float param_10=target.z;
tmpColor.z=transformSingleColor(param_8,param_9,param_10);
tmpColor=fast::clamp(tmpColor,float3(0.0),float3(1.0));
float3 resColor_1=mix(original,tmpColor,float3(weight));
return resColor_1;
}
}
float3 definedBlend(thread const float3& a,thread const float3& b,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> intensityTexture,thread sampler intensityTextureSmpSC)
{
if ((int(BLEND_MODE_LIGHTEN_tmp)!=0))
{
return fast::max(a,b);
}
else
{
if ((int(BLEND_MODE_DARKEN_tmp)!=0))
{
return fast::min(a,b);
}
else
{
if ((int(BLEND_MODE_DIVIDE_tmp)!=0))
{
return b/a;
}
else
{
if ((int(BLEND_MODE_AVERAGE_tmp)!=0))
{
return (a+b)*0.5;
}
else
{
if ((int(BLEND_MODE_SUBTRACT_tmp)!=0))
{
return fast::max((a+b)-float3(1.0),float3(0.0));
}
else
{
if ((int(BLEND_MODE_DIFFERENCE_tmp)!=0))
{
return abs(a-b);
}
else
{
if ((int(BLEND_MODE_NEGATION_tmp)!=0))
{
return float3(1.0)-abs((float3(1.0)-a)-b);
}
else
{
if ((int(BLEND_MODE_EXCLUSION_tmp)!=0))
{
return (a+b)-((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_OVERLAY_tmp)!=0))
{
float l9_0;
if (a.x<0.5)
{
l9_0=(2.0*a.x)*b.x;
}
else
{
l9_0=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float l9_1=l9_0;
float l9_2;
if (a.y<0.5)
{
l9_2=(2.0*a.y)*b.y;
}
else
{
l9_2=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_3=l9_2;
float l9_4;
if (a.z<0.5)
{
l9_4=(2.0*a.z)*b.z;
}
else
{
l9_4=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return float3(l9_1,l9_3,l9_4);
}
else
{
if ((int(BLEND_MODE_SOFT_LIGHT_tmp)!=0))
{
return (((float3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_HARD_LIGHT_tmp)!=0))
{
float l9_5;
if (b.x<0.5)
{
l9_5=(2.0*b.x)*a.x;
}
else
{
l9_5=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_6=l9_5;
float l9_7;
if (b.y<0.5)
{
l9_7=(2.0*b.y)*a.y;
}
else
{
l9_7=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_8=l9_7;
float l9_9;
if (b.z<0.5)
{
l9_9=(2.0*b.z)*a.z;
}
else
{
l9_9=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return float3(l9_6,l9_8,l9_9);
}
else
{
if ((int(BLEND_MODE_COLOR_DODGE_tmp)!=0))
{
float l9_10;
if (b.x==1.0)
{
l9_10=b.x;
}
else
{
l9_10=fast::min(a.x/(1.0-b.x),1.0);
}
float l9_11=l9_10;
float l9_12;
if (b.y==1.0)
{
l9_12=b.y;
}
else
{
l9_12=fast::min(a.y/(1.0-b.y),1.0);
}
float l9_13=l9_12;
float l9_14;
if (b.z==1.0)
{
l9_14=b.z;
}
else
{
l9_14=fast::min(a.z/(1.0-b.z),1.0);
}
return float3(l9_11,l9_13,l9_14);
}
else
{
if ((int(BLEND_MODE_COLOR_BURN_tmp)!=0))
{
float l9_15;
if (b.x==0.0)
{
l9_15=b.x;
}
else
{
l9_15=fast::max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_16=l9_15;
float l9_17;
if (b.y==0.0)
{
l9_17=b.y;
}
else
{
l9_17=fast::max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_18=l9_17;
float l9_19;
if (b.z==0.0)
{
l9_19=b.z;
}
else
{
l9_19=fast::max(1.0-((1.0-a.z)/b.z),0.0);
}
return float3(l9_16,l9_18,l9_19);
}
else
{
if ((int(BLEND_MODE_LINEAR_LIGHT_tmp)!=0))
{
float l9_20;
if (b.x<0.5)
{
l9_20=fast::max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_20=fast::min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_21=l9_20;
float l9_22;
if (b.y<0.5)
{
l9_22=fast::max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_22=fast::min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_23=l9_22;
float l9_24;
if (b.z<0.5)
{
l9_24=fast::max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_24=fast::min(a.z+(2.0*(b.z-0.5)),1.0);
}
return float3(l9_21,l9_23,l9_24);
}
else
{
if ((int(BLEND_MODE_VIVID_LIGHT_tmp)!=0))
{
float l9_25;
if (b.x<0.5)
{
float l9_26;
if ((2.0*b.x)==0.0)
{
l9_26=2.0*b.x;
}
else
{
l9_26=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_25=l9_26;
}
else
{
float l9_27;
if ((2.0*(b.x-0.5))==1.0)
{
l9_27=2.0*(b.x-0.5);
}
else
{
l9_27=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_25=l9_27;
}
float l9_28=l9_25;
float l9_29;
if (b.y<0.5)
{
float l9_30;
if ((2.0*b.y)==0.0)
{
l9_30=2.0*b.y;
}
else
{
l9_30=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_29=l9_30;
}
else
{
float l9_31;
if ((2.0*(b.y-0.5))==1.0)
{
l9_31=2.0*(b.y-0.5);
}
else
{
l9_31=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_29=l9_31;
}
float l9_32=l9_29;
float l9_33;
if (b.z<0.5)
{
float l9_34;
if ((2.0*b.z)==0.0)
{
l9_34=2.0*b.z;
}
else
{
l9_34=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_33=l9_34;
}
else
{
float l9_35;
if ((2.0*(b.z-0.5))==1.0)
{
l9_35=2.0*(b.z-0.5);
}
else
{
l9_35=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_33=l9_35;
}
return float3(l9_28,l9_32,l9_33);
}
else
{
if ((int(BLEND_MODE_PIN_LIGHT_tmp)!=0))
{
float l9_36;
if (b.x<0.5)
{
l9_36=fast::min(a.x,2.0*b.x);
}
else
{
l9_36=fast::max(a.x,2.0*(b.x-0.5));
}
float l9_37=l9_36;
float l9_38;
if (b.y<0.5)
{
l9_38=fast::min(a.y,2.0*b.y);
}
else
{
l9_38=fast::max(a.y,2.0*(b.y-0.5));
}
float l9_39=l9_38;
float l9_40;
if (b.z<0.5)
{
l9_40=fast::min(a.z,2.0*b.z);
}
else
{
l9_40=fast::max(a.z,2.0*(b.z-0.5));
}
return float3(l9_37,l9_39,l9_40);
}
else
{
if ((int(BLEND_MODE_HARD_MIX_tmp)!=0))
{
float l9_41;
if (b.x<0.5)
{
float l9_42;
if ((2.0*b.x)==0.0)
{
l9_42=2.0*b.x;
}
else
{
l9_42=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_41=l9_42;
}
else
{
float l9_43;
if ((2.0*(b.x-0.5))==1.0)
{
l9_43=2.0*(b.x-0.5);
}
else
{
l9_43=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_41=l9_43;
}
float l9_44=l9_41;
float l9_45;
if (b.y<0.5)
{
float l9_46;
if ((2.0*b.y)==0.0)
{
l9_46=2.0*b.y;
}
else
{
l9_46=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_45=l9_46;
}
else
{
float l9_47;
if ((2.0*(b.y-0.5))==1.0)
{
l9_47=2.0*(b.y-0.5);
}
else
{
l9_47=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_45=l9_47;
}
float l9_48=l9_45;
float l9_49;
if (b.z<0.5)
{
float l9_50;
if ((2.0*b.z)==0.0)
{
l9_50=2.0*b.z;
}
else
{
l9_50=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_49=l9_50;
}
else
{
float l9_51;
if ((2.0*(b.z-0.5))==1.0)
{
l9_51=2.0*(b.z-0.5);
}
else
{
l9_51=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_49=l9_51;
}
return float3((l9_44<0.5) ? 0.0 : 1.0,(l9_48<0.5) ? 0.0 : 1.0,(l9_49<0.5) ? 0.0 : 1.0);
}
else
{
if ((int(BLEND_MODE_HARD_REFLECT_tmp)!=0))
{
float l9_52;
if (b.x==1.0)
{
l9_52=b.x;
}
else
{
l9_52=fast::min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_53=l9_52;
float l9_54;
if (b.y==1.0)
{
l9_54=b.y;
}
else
{
l9_54=fast::min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_55=l9_54;
float l9_56;
if (b.z==1.0)
{
l9_56=b.z;
}
else
{
l9_56=fast::min((a.z*a.z)/(1.0-b.z),1.0);
}
return float3(l9_53,l9_55,l9_56);
}
else
{
if ((int(BLEND_MODE_HARD_GLOW_tmp)!=0))
{
float l9_57;
if (a.x==1.0)
{
l9_57=a.x;
}
else
{
l9_57=fast::min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_58=l9_57;
float l9_59;
if (a.y==1.0)
{
l9_59=a.y;
}
else
{
l9_59=fast::min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_60=l9_59;
float l9_61;
if (a.z==1.0)
{
l9_61=a.z;
}
else
{
l9_61=fast::min((b.z*b.z)/(1.0-a.z),1.0);
}
return float3(l9_58,l9_60,l9_61);
}
else
{
if ((int(BLEND_MODE_HARD_PHOENIX_tmp)!=0))
{
return (fast::min(a,b)-fast::max(a,b))+float3(1.0);
}
else
{
if ((int(BLEND_MODE_HUE_tmp)!=0))
{
float3 param=a;
float3 param_1=b;
float3 l9_62=param;
float3 l9_63=l9_62;
float4 l9_64;
if (l9_63.y<l9_63.z)
{
l9_64=float4(l9_63.zy,-1.0,0.66666669);
}
else
{
l9_64=float4(l9_63.yz,0.0,-0.33333334);
}
float4 l9_65=l9_64;
float4 l9_66;
if (l9_63.x<l9_65.x)
{
l9_66=float4(l9_65.xyw,l9_63.x);
}
else
{
l9_66=float4(l9_63.x,l9_65.yzx);
}
float4 l9_67=l9_66;
float l9_68=l9_67.x-fast::min(l9_67.w,l9_67.y);
float l9_69=abs(((l9_67.w-l9_67.y)/((6.0*l9_68)+1e-07))+l9_67.z);
float l9_70=l9_67.x;
float3 l9_71=float3(l9_69,l9_68,l9_70);
float3 l9_72=l9_71;
float l9_73=l9_72.z-(l9_72.y*0.5);
float l9_74=l9_72.y/((1.0-abs((2.0*l9_73)-1.0))+1e-07);
float3 l9_75=float3(l9_72.x,l9_74,l9_73);
float3 l9_76=l9_75;
float3 l9_77=param_1;
float3 l9_78=l9_77;
float4 l9_79;
if (l9_78.y<l9_78.z)
{
l9_79=float4(l9_78.zy,-1.0,0.66666669);
}
else
{
l9_79=float4(l9_78.yz,0.0,-0.33333334);
}
float4 l9_80=l9_79;
float4 l9_81;
if (l9_78.x<l9_80.x)
{
l9_81=float4(l9_80.xyw,l9_78.x);
}
else
{
l9_81=float4(l9_78.x,l9_80.yzx);
}
float4 l9_82=l9_81;
float l9_83=l9_82.x-fast::min(l9_82.w,l9_82.y);
float l9_84=abs(((l9_82.w-l9_82.y)/((6.0*l9_83)+1e-07))+l9_82.z);
float l9_85=l9_82.x;
float3 l9_86=float3(l9_84,l9_83,l9_85);
float3 l9_87=l9_86;
float l9_88=l9_87.z-(l9_87.y*0.5);
float l9_89=l9_87.y/((1.0-abs((2.0*l9_88)-1.0))+1e-07);
float3 l9_90=float3(l9_87.x,l9_89,l9_88);
float3 l9_91=float3(l9_90.x,l9_76.y,l9_76.z);
float l9_92=l9_91.x;
float l9_93=abs((6.0*l9_92)-3.0)-1.0;
float l9_94=2.0-abs((6.0*l9_92)-2.0);
float l9_95=2.0-abs((6.0*l9_92)-4.0);
float3 l9_96=fast::clamp(float3(l9_93,l9_94,l9_95),float3(0.0),float3(1.0));
float3 l9_97=l9_96;
float l9_98=(1.0-abs((2.0*l9_91.z)-1.0))*l9_91.y;
l9_97=((l9_97-float3(0.5))*l9_98)+float3(l9_91.z);
float3 l9_99=l9_97;
float3 l9_100=l9_99;
return l9_100;
}
else
{
if ((int(BLEND_MODE_SATURATION_tmp)!=0))
{
float3 param_2=a;
float3 param_3=b;
float3 l9_101=param_2;
float3 l9_102=l9_101;
float4 l9_103;
if (l9_102.y<l9_102.z)
{
l9_103=float4(l9_102.zy,-1.0,0.66666669);
}
else
{
l9_103=float4(l9_102.yz,0.0,-0.33333334);
}
float4 l9_104=l9_103;
float4 l9_105;
if (l9_102.x<l9_104.x)
{
l9_105=float4(l9_104.xyw,l9_102.x);
}
else
{
l9_105=float4(l9_102.x,l9_104.yzx);
}
float4 l9_106=l9_105;
float l9_107=l9_106.x-fast::min(l9_106.w,l9_106.y);
float l9_108=abs(((l9_106.w-l9_106.y)/((6.0*l9_107)+1e-07))+l9_106.z);
float l9_109=l9_106.x;
float3 l9_110=float3(l9_108,l9_107,l9_109);
float3 l9_111=l9_110;
float l9_112=l9_111.z-(l9_111.y*0.5);
float l9_113=l9_111.y/((1.0-abs((2.0*l9_112)-1.0))+1e-07);
float3 l9_114=float3(l9_111.x,l9_113,l9_112);
float3 l9_115=l9_114;
float l9_116=l9_115.x;
float3 l9_117=param_3;
float3 l9_118=l9_117;
float4 l9_119;
if (l9_118.y<l9_118.z)
{
l9_119=float4(l9_118.zy,-1.0,0.66666669);
}
else
{
l9_119=float4(l9_118.yz,0.0,-0.33333334);
}
float4 l9_120=l9_119;
float4 l9_121;
if (l9_118.x<l9_120.x)
{
l9_121=float4(l9_120.xyw,l9_118.x);
}
else
{
l9_121=float4(l9_118.x,l9_120.yzx);
}
float4 l9_122=l9_121;
float l9_123=l9_122.x-fast::min(l9_122.w,l9_122.y);
float l9_124=abs(((l9_122.w-l9_122.y)/((6.0*l9_123)+1e-07))+l9_122.z);
float l9_125=l9_122.x;
float3 l9_126=float3(l9_124,l9_123,l9_125);
float3 l9_127=l9_126;
float l9_128=l9_127.z-(l9_127.y*0.5);
float l9_129=l9_127.y/((1.0-abs((2.0*l9_128)-1.0))+1e-07);
float3 l9_130=float3(l9_127.x,l9_129,l9_128);
float3 l9_131=float3(l9_116,l9_130.y,l9_115.z);
float l9_132=l9_131.x;
float l9_133=abs((6.0*l9_132)-3.0)-1.0;
float l9_134=2.0-abs((6.0*l9_132)-2.0);
float l9_135=2.0-abs((6.0*l9_132)-4.0);
float3 l9_136=fast::clamp(float3(l9_133,l9_134,l9_135),float3(0.0),float3(1.0));
float3 l9_137=l9_136;
float l9_138=(1.0-abs((2.0*l9_131.z)-1.0))*l9_131.y;
l9_137=((l9_137-float3(0.5))*l9_138)+float3(l9_131.z);
float3 l9_139=l9_137;
float3 l9_140=l9_139;
return l9_140;
}
else
{
if ((int(BLEND_MODE_COLOR_tmp)!=0))
{
float3 param_4=a;
float3 param_5=b;
float3 l9_141=param_5;
float3 l9_142=l9_141;
float4 l9_143;
if (l9_142.y<l9_142.z)
{
l9_143=float4(l9_142.zy,-1.0,0.66666669);
}
else
{
l9_143=float4(l9_142.yz,0.0,-0.33333334);
}
float4 l9_144=l9_143;
float4 l9_145;
if (l9_142.x<l9_144.x)
{
l9_145=float4(l9_144.xyw,l9_142.x);
}
else
{
l9_145=float4(l9_142.x,l9_144.yzx);
}
float4 l9_146=l9_145;
float l9_147=l9_146.x-fast::min(l9_146.w,l9_146.y);
float l9_148=abs(((l9_146.w-l9_146.y)/((6.0*l9_147)+1e-07))+l9_146.z);
float l9_149=l9_146.x;
float3 l9_150=float3(l9_148,l9_147,l9_149);
float3 l9_151=l9_150;
float l9_152=l9_151.z-(l9_151.y*0.5);
float l9_153=l9_151.y/((1.0-abs((2.0*l9_152)-1.0))+1e-07);
float3 l9_154=float3(l9_151.x,l9_153,l9_152);
float3 l9_155=l9_154;
float l9_156=l9_155.x;
float l9_157=l9_155.y;
float3 l9_158=param_4;
float3 l9_159=l9_158;
float4 l9_160;
if (l9_159.y<l9_159.z)
{
l9_160=float4(l9_159.zy,-1.0,0.66666669);
}
else
{
l9_160=float4(l9_159.yz,0.0,-0.33333334);
}
float4 l9_161=l9_160;
float4 l9_162;
if (l9_159.x<l9_161.x)
{
l9_162=float4(l9_161.xyw,l9_159.x);
}
else
{
l9_162=float4(l9_159.x,l9_161.yzx);
}
float4 l9_163=l9_162;
float l9_164=l9_163.x-fast::min(l9_163.w,l9_163.y);
float l9_165=abs(((l9_163.w-l9_163.y)/((6.0*l9_164)+1e-07))+l9_163.z);
float l9_166=l9_163.x;
float3 l9_167=float3(l9_165,l9_164,l9_166);
float3 l9_168=l9_167;
float l9_169=l9_168.z-(l9_168.y*0.5);
float l9_170=l9_168.y/((1.0-abs((2.0*l9_169)-1.0))+1e-07);
float3 l9_171=float3(l9_168.x,l9_170,l9_169);
float3 l9_172=float3(l9_156,l9_157,l9_171.z);
float l9_173=l9_172.x;
float l9_174=abs((6.0*l9_173)-3.0)-1.0;
float l9_175=2.0-abs((6.0*l9_173)-2.0);
float l9_176=2.0-abs((6.0*l9_173)-4.0);
float3 l9_177=fast::clamp(float3(l9_174,l9_175,l9_176),float3(0.0),float3(1.0));
float3 l9_178=l9_177;
float l9_179=(1.0-abs((2.0*l9_172.z)-1.0))*l9_172.y;
l9_178=((l9_178-float3(0.5))*l9_179)+float3(l9_172.z);
float3 l9_180=l9_178;
float3 l9_181=l9_180;
return l9_181;
}
else
{
if ((int(BLEND_MODE_LUMINOSITY_tmp)!=0))
{
float3 param_6=a;
float3 param_7=b;
float3 l9_182=param_6;
float3 l9_183=l9_182;
float4 l9_184;
if (l9_183.y<l9_183.z)
{
l9_184=float4(l9_183.zy,-1.0,0.66666669);
}
else
{
l9_184=float4(l9_183.yz,0.0,-0.33333334);
}
float4 l9_185=l9_184;
float4 l9_186;
if (l9_183.x<l9_185.x)
{
l9_186=float4(l9_185.xyw,l9_183.x);
}
else
{
l9_186=float4(l9_183.x,l9_185.yzx);
}
float4 l9_187=l9_186;
float l9_188=l9_187.x-fast::min(l9_187.w,l9_187.y);
float l9_189=abs(((l9_187.w-l9_187.y)/((6.0*l9_188)+1e-07))+l9_187.z);
float l9_190=l9_187.x;
float3 l9_191=float3(l9_189,l9_188,l9_190);
float3 l9_192=l9_191;
float l9_193=l9_192.z-(l9_192.y*0.5);
float l9_194=l9_192.y/((1.0-abs((2.0*l9_193)-1.0))+1e-07);
float3 l9_195=float3(l9_192.x,l9_194,l9_193);
float3 l9_196=l9_195;
float l9_197=l9_196.x;
float l9_198=l9_196.y;
float3 l9_199=param_7;
float3 l9_200=l9_199;
float4 l9_201;
if (l9_200.y<l9_200.z)
{
l9_201=float4(l9_200.zy,-1.0,0.66666669);
}
else
{
l9_201=float4(l9_200.yz,0.0,-0.33333334);
}
float4 l9_202=l9_201;
float4 l9_203;
if (l9_200.x<l9_202.x)
{
l9_203=float4(l9_202.xyw,l9_200.x);
}
else
{
l9_203=float4(l9_200.x,l9_202.yzx);
}
float4 l9_204=l9_203;
float l9_205=l9_204.x-fast::min(l9_204.w,l9_204.y);
float l9_206=abs(((l9_204.w-l9_204.y)/((6.0*l9_205)+1e-07))+l9_204.z);
float l9_207=l9_204.x;
float3 l9_208=float3(l9_206,l9_205,l9_207);
float3 l9_209=l9_208;
float l9_210=l9_209.z-(l9_209.y*0.5);
float l9_211=l9_209.y/((1.0-abs((2.0*l9_210)-1.0))+1e-07);
float3 l9_212=float3(l9_209.x,l9_211,l9_210);
float3 l9_213=float3(l9_197,l9_198,l9_212.z);
float l9_214=l9_213.x;
float l9_215=abs((6.0*l9_214)-3.0)-1.0;
float l9_216=2.0-abs((6.0*l9_214)-2.0);
float l9_217=2.0-abs((6.0*l9_214)-4.0);
float3 l9_218=fast::clamp(float3(l9_215,l9_216,l9_217),float3(0.0),float3(1.0));
float3 l9_219=l9_218;
float l9_220=(1.0-abs((2.0*l9_213.z)-1.0))*l9_213.y;
l9_219=((l9_219-float3(0.5))*l9_220)+float3(l9_213.z);
float3 l9_221=l9_219;
float3 l9_222=l9_221;
return l9_222;
}
else
{
float3 param_8=a;
float3 param_9=b;
float3 l9_223=param_8;
float l9_224=((0.29899999*l9_223.x)+(0.58700001*l9_223.y))+(0.114*l9_223.z);
float l9_225=l9_224;
float l9_226=1.0;
float l9_227=pow(l9_225,1.0/UserUniforms.correctedIntensity);
int l9_228=0;
if ((int(intensityTextureHasSwappedViews_tmp)!=0))
{
int l9_229=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_229=0;
}
else
{
l9_229=varStereoViewID;
}
int l9_230=l9_229;
l9_228=1-l9_230;
}
else
{
int l9_231=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_231=0;
}
else
{
l9_231=varStereoViewID;
}
int l9_232=l9_231;
l9_228=l9_232;
}
int l9_233=l9_228;
int l9_234=intensityTextureLayout_tmp;
int l9_235=l9_233;
float2 l9_236=float2(l9_227,0.5);
bool l9_237=(int(SC_USE_UV_TRANSFORM_intensityTexture_tmp)!=0);
float3x3 l9_238=UserUniforms.intensityTextureTransform;
int2 l9_239=int2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp);
bool l9_240=(int(SC_USE_UV_MIN_MAX_intensityTexture_tmp)!=0);
float4 l9_241=UserUniforms.intensityTextureUvMinMax;
bool l9_242=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp)!=0);
float4 l9_243=UserUniforms.intensityTextureBorderColor;
float l9_244=0.0;
bool l9_245=l9_242&&(!l9_240);
float l9_246=1.0;
float l9_247=l9_236.x;
int l9_248=l9_239.x;
if (l9_248==1)
{
l9_247=fract(l9_247);
}
else
{
if (l9_248==2)
{
float l9_249=fract(l9_247);
float l9_250=l9_247-l9_249;
float l9_251=step(0.25,fract(l9_250*0.5));
l9_247=mix(l9_249,1.0-l9_249,fast::clamp(l9_251,0.0,1.0));
}
}
l9_236.x=l9_247;
float l9_252=l9_236.y;
int l9_253=l9_239.y;
if (l9_253==1)
{
l9_252=fract(l9_252);
}
else
{
if (l9_253==2)
{
float l9_254=fract(l9_252);
float l9_255=l9_252-l9_254;
float l9_256=step(0.25,fract(l9_255*0.5));
l9_252=mix(l9_254,1.0-l9_254,fast::clamp(l9_256,0.0,1.0));
}
}
l9_236.y=l9_252;
if (l9_240)
{
bool l9_257=l9_242;
bool l9_258;
if (l9_257)
{
l9_258=l9_239.x==3;
}
else
{
l9_258=l9_257;
}
float l9_259=l9_236.x;
float l9_260=l9_241.x;
float l9_261=l9_241.z;
bool l9_262=l9_258;
float l9_263=l9_246;
float l9_264=fast::clamp(l9_259,l9_260,l9_261);
float l9_265=step(abs(l9_259-l9_264),9.9999997e-06);
l9_263*=(l9_265+((1.0-float(l9_262))*(1.0-l9_265)));
l9_259=l9_264;
l9_236.x=l9_259;
l9_246=l9_263;
bool l9_266=l9_242;
bool l9_267;
if (l9_266)
{
l9_267=l9_239.y==3;
}
else
{
l9_267=l9_266;
}
float l9_268=l9_236.y;
float l9_269=l9_241.y;
float l9_270=l9_241.w;
bool l9_271=l9_267;
float l9_272=l9_246;
float l9_273=fast::clamp(l9_268,l9_269,l9_270);
float l9_274=step(abs(l9_268-l9_273),9.9999997e-06);
l9_272*=(l9_274+((1.0-float(l9_271))*(1.0-l9_274)));
l9_268=l9_273;
l9_236.y=l9_268;
l9_246=l9_272;
}
float2 l9_275=l9_236;
bool l9_276=l9_237;
float3x3 l9_277=l9_238;
if (l9_276)
{
l9_275=float2((l9_277*float3(l9_275,1.0)).xy);
}
float2 l9_278=l9_275;
float2 l9_279=l9_278;
float2 l9_280=l9_279;
l9_236=l9_280;
float l9_281=l9_236.x;
int l9_282=l9_239.x;
bool l9_283=l9_245;
float l9_284=l9_246;
if ((l9_282==0)||(l9_282==3))
{
float l9_285=l9_281;
float l9_286=0.0;
float l9_287=1.0;
bool l9_288=l9_283;
float l9_289=l9_284;
float l9_290=fast::clamp(l9_285,l9_286,l9_287);
float l9_291=step(abs(l9_285-l9_290),9.9999997e-06);
l9_289*=(l9_291+((1.0-float(l9_288))*(1.0-l9_291)));
l9_285=l9_290;
l9_281=l9_285;
l9_284=l9_289;
}
l9_236.x=l9_281;
l9_246=l9_284;
float l9_292=l9_236.y;
int l9_293=l9_239.y;
bool l9_294=l9_245;
float l9_295=l9_246;
if ((l9_293==0)||(l9_293==3))
{
float l9_296=l9_292;
float l9_297=0.0;
float l9_298=1.0;
bool l9_299=l9_294;
float l9_300=l9_295;
float l9_301=fast::clamp(l9_296,l9_297,l9_298);
float l9_302=step(abs(l9_296-l9_301),9.9999997e-06);
l9_300*=(l9_302+((1.0-float(l9_299))*(1.0-l9_302)));
l9_296=l9_301;
l9_292=l9_296;
l9_295=l9_300;
}
l9_236.y=l9_292;
l9_246=l9_295;
float2 l9_303=l9_236;
int l9_304=l9_234;
int l9_305=l9_235;
float l9_306=l9_244;
float2 l9_307=l9_303;
int l9_308=l9_304;
int l9_309=l9_305;
float3 l9_310=float3(0.0);
if (l9_308==0)
{
l9_310=float3(l9_307,0.0);
}
else
{
if (l9_308==1)
{
l9_310=float3(l9_307.x,(l9_307.y*0.5)+(0.5-(float(l9_309)*0.5)),0.0);
}
else
{
l9_310=float3(l9_307,float(l9_309));
}
}
float3 l9_311=l9_310;
float3 l9_312=l9_311;
float2 l9_313=l9_312.xy;
float l9_314=l9_306;
float4 l9_315=intensityTexture.sample(intensityTextureSmpSC,l9_313,bias(l9_314));
float4 l9_316=l9_315;
float4 l9_317=l9_316;
if (l9_242)
{
l9_317=mix(l9_243,l9_317,float4(l9_246));
}
float4 l9_318=l9_317;
float3 l9_319=l9_318.xyz;
float3 l9_320=l9_319;
float l9_321=16.0;
float l9_322=((((l9_320.x*256.0)+l9_320.y)+(l9_320.z/256.0))/257.00391)*l9_321;
float l9_323=l9_322;
if ((int(BLEND_MODE_FORGRAY_tmp)!=0))
{
l9_323=fast::max(l9_323,1.0);
}
if ((int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
l9_323=fast::min(l9_323,1.0);
}
float l9_324=l9_225;
float3 l9_325=param_8;
float3 l9_326=param_9;
float l9_327=l9_226;
float l9_328=l9_323;
float3 l9_329=transformColor(l9_324,l9_325,l9_326,l9_327,l9_328);
return l9_329;
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_frag_out out={};
float4 Output_Color0=float4(0.0);
float3 ngsTempNormal=float3(0.0);
float4 ngsTempTangent=float4(0.0);
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
ngsTempNormal=in.varNormal;
ngsTempTangent=float4(in.varTangent.xyz.x,in.varTangent.xyz.y,in.varTangent.xyz.z,ngsTempTangent.w);
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
float l9_0;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_0=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_0=(*sc_set2.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_0;
float l9_1;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_1=(*sc_set2.UserUniforms).overrideTimeDelta;
}
else
{
l9_1=fast::max((*sc_set2.UserUniforms).sc_Time.y,0.0);
}
Globals.gTimeDelta=l9_1;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
Globals.VertexTangent_WorldSpace=normalize(ngsTempTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(ngsTempNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace);
Globals.SurfacePosition_WorldSpace=in.varPos;
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-Globals.SurfacePosition_WorldSpace);
int param=in.Interp_Particle_Index;
ssParticle param_1=gParticle;
param_1.Spawned=false;
param_1.Dead=false;
param_1.Force=float3(0.0);
param_1.Index1D=param;
param_1.Index1DPerCopy=param%40;
int l9_2=param_1.Index1D;
int2 l9_3=int2(l9_2%40,l9_2/40);
param_1.Index2D=l9_3;
int l9_4=param_1.Index1D;
float l9_5=(float(l9_4)+0.5)/40.0;
param_1.Coord1D=l9_5;
int2 l9_6=param_1.Index2D;
float2 l9_7=(float2(l9_6)+float2(0.5))/float2(40.0,1.0);
param_1.Coord2D=l9_7;
int l9_8=param_1.Index1D;
float l9_9=float(l9_8)/39.0;
param_1.Ratio1D=l9_9;
int l9_10=param_1.Index1DPerCopy;
float l9_11=float(l9_10)/39.0;
param_1.Ratio1DPerCopy=l9_11;
int2 l9_12=param_1.Index2D;
float2 l9_13=float2(l9_12)/float2(39.0,1.0);
param_1.Ratio2D=l9_13;
param_1.Seed=0.0;
param_1.CopyId=float(param_1.Index1D/40);
int l9_14=param_1.Index1D;
int l9_15=l9_14;
int l9_16=((l9_15*((l9_15*1471343)+101146501))+1559861749)&2147483647;
int l9_17=l9_16;
float l9_18=float(l9_17)*4.6566129e-10;
float l9_19=l9_18;
param_1.TimeShift=l9_19;
param_1.SpawnOffset=param_1.Ratio1D*0.2;
ssParticle l9_20=param_1;
float l9_21;
if ((*sc_set2.UserUniforms).overrideTimeEnabled==1)
{
l9_21=(*sc_set2.UserUniforms).overrideTimeElapsed;
}
else
{
l9_21=(*sc_set2.UserUniforms).sc_Time.x;
}
float l9_22=l9_21;
l9_20.Seed=(l9_20.Ratio1D*0.97637898)+0.151235;
l9_20.Seed+=(floor(((((l9_22-l9_20.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_20.Seed=fract(abs(l9_20.Seed));
int2 l9_23=int2(l9_20.Index1D%400,l9_20.Index1D/400);
l9_20.Seed2000=(float2(l9_23)+float2(1.0))/float2(399.0);
param_1=l9_20;
gParticle=param_1;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
Output_Color0=gParticle.Color;
float Rim_N2=0.0;
float3 param_2=(*sc_set2.UserUniforms).Port_Normal_N002;
float param_3=(*sc_set2.UserUniforms).Port_Exponent_N002;
float param_4=(*sc_set2.UserUniforms).Port_Intensity_N002;
ssGlobals param_6=Globals;
param_2=float3x3(float3(param_6.VertexTangent_WorldSpace),float3(param_6.VertexBinormal_WorldSpace),float3(param_6.VertexNormal_WorldSpace))*param_2;
float l9_24=abs(dot(-param_6.ViewDirWS,param_2));
float param_5=pow(1.0-l9_24,param_3);
param_5=fast::max(param_5,0.0);
param_5*=param_4;
Rim_N2=param_5;
float3 Position_N3=float3(0.0);
Position_N3=Globals.SurfacePosition_WorldSpace;
float3 Camera_Position_N4=float3(0.0);
Camera_Position_N4=(*sc_set2.UserUniforms).sc_Camera.position;
float Output_N5=0.0;
Output_N5=distance(Position_N3,Camera_Position_N4);
float Output_N17=0.0;
Output_N17=Output_N5*(*sc_set2.UserUniforms).Port_Input1_N017;
float ValueOut_N18=0.0;
float param_7=Output_N17;
float param_9=(*sc_set2.UserUniforms).Port_RangeMinA_N018;
float param_10=(*sc_set2.UserUniforms).Port_RangeMaxA_N018;
float param_11=(*sc_set2.UserUniforms).Port_RangeMinB_N018;
float param_12=(*sc_set2.UserUniforms).Port_RangeMaxB_N018;
float param_8=(((param_7-param_9)/(param_10-param_9))*(param_12-param_11))+param_11;
float l9_25;
if (param_12>param_11)
{
l9_25=fast::clamp(param_8,param_11,param_12);
}
else
{
l9_25=fast::clamp(param_8,param_12,param_11);
}
param_8=l9_25;
ValueOut_N18=param_8;
float Output_N63=0.0;
Output_N63=(Rim_N2*(*sc_set2.UserUniforms).Port_Input1_N063)+ValueOut_N18;
float Output_N64=0.0;
Output_N64=1.0-Output_N63;
float Output_N65=0.0;
Output_N65=fast::clamp(Output_N64+0.001,(*sc_set2.UserUniforms).Port_Input1_N065+0.001,(*sc_set2.UserUniforms).Port_Input2_N065+0.001)-0.001;
float Value_N201=0.0;
Value_N201=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float4 Output_N66=float4(0.0);
Output_N66=mix(float4(Output_N65),(*sc_set2.UserUniforms).Port_Input1_N066,float4(Value_N201));
float4 Value_N68=float4(0.0);
float param_13=Value_N201;
float4 param_14=(*sc_set2.UserUniforms).Port_Value0_N068;
float param_15=(*sc_set2.UserUniforms).Port_Position1_N068;
float4 param_16=(*sc_set2.UserUniforms).Port_Value1_N068;
float param_17=(*sc_set2.UserUniforms).Port_Position2_N068;
float4 param_18=(*sc_set2.UserUniforms).Port_Value2_N068;
float4 param_19=(*sc_set2.UserUniforms).Port_Value3_N068;
param_13=fast::clamp(param_13,0.0,1.0);
float4 param_20;
if (param_13<param_15)
{
param_20=mix(param_14,param_16,float4(fast::clamp(param_13/param_15,0.0,1.0)));
}
else
{
if (param_13<param_17)
{
param_20=mix(param_16,param_18,float4(fast::clamp((param_13-param_15)/(param_17-param_15),0.0,1.0)));
}
else
{
param_20=mix(param_18,param_19,float4(fast::clamp((param_13-param_17)/(1.0-param_17),0.0,1.0)));
}
}
Value_N68=param_20;
float4 Output_N79=float4(0.0);
Output_N79=Output_N66*Value_N68;
float Output_N67=0.0;
float l9_26;
if (Value_N201<=0.0)
{
l9_26=0.0;
}
else
{
l9_26=pow(Value_N201,(*sc_set2.UserUniforms).Port_Input1_N067);
}
Output_N67=l9_26;
float4 Value_N178=float4(0.0);
float param_21=Output_N67;
float4 param_22=(*sc_set2.UserUniforms).Port_Value0_N178;
float param_23=(*sc_set2.UserUniforms).Port_Position1_N178;
float4 param_24=(*sc_set2.UserUniforms).Port_Value1_N178;
float4 param_25=(*sc_set2.UserUniforms).Port_Value2_N178;
param_21=fast::clamp(param_21,0.0,1.0);
float4 param_26;
if (param_21<param_23)
{
param_26=mix(param_22,param_24,float4(fast::clamp(param_21/param_23,0.0,1.0)));
}
else
{
param_26=mix(param_24,param_25,float4(fast::clamp((param_21-param_23)/(1.0-param_23),0.0,1.0)));
}
Value_N178=param_26;
float4 Value_N98=float4(0.0);
Value_N98=float4(Output_N79.xyz.x,Output_N79.xyz.y,Output_N79.xyz.z,Value_N98.w);
Value_N98.w=Value_N178.x;
float4 param_27=Value_N98;
Output_Color0=param_27;
float4 param_28=Output_Color0;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_27=param_28;
float4 l9_28=l9_27;
float l9_29=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_29=l9_28.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_29=fast::clamp(l9_28.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_29=fast::clamp(dot(l9_28.xyz,float3(l9_28.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_29=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_29=(1.0-dot(l9_28.xyz,float3(0.33333001)))*l9_28.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_29=(1.0-fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0))*l9_28.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_29=fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0)*l9_28.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_29=fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_29=fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0)*l9_28.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_29=dot(l9_28.xyz,float3(0.33333001))*l9_28.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_29=1.0-fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_29=fast::clamp(dot(l9_28.xyz,float3(1.0)),0.0,1.0);
}
}
}
}
}
}
}
}
}
}
}
}
float l9_30=l9_29;
float l9_31=l9_30;
float l9_32=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_31;
float3 l9_33=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_27.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_34=float4(l9_33.x,l9_33.y,l9_33.z,l9_32);
param_28=l9_34;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_28=float4(param_28.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_35=param_28;
float4 l9_36=float4(0.0);
float4 l9_37=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_38=out.FragColor0;
float4 l9_39=l9_38;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_39.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_40=l9_39;
l9_37=l9_40;
}
else
{
float4 l9_41=gl_FragCoord;
float2 l9_42=(l9_41.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_43=l9_42;
float2 l9_44=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_45=1;
int l9_46=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_46=0;
}
else
{
l9_46=in.varStereoViewID;
}
int l9_47=l9_46;
int l9_48=l9_47;
float3 l9_49=float3(l9_43,0.0);
int l9_50=l9_45;
int l9_51=l9_48;
if (l9_50==1)
{
l9_49.y=((2.0*l9_49.y)+float(l9_51))-1.0;
}
float2 l9_52=l9_49.xy;
l9_44=l9_52;
}
else
{
l9_44=l9_43;
}
float2 l9_53=l9_44;
float2 l9_54=l9_53;
float2 l9_55=l9_54;
int l9_56=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_57=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_57=0;
}
else
{
l9_57=in.varStereoViewID;
}
int l9_58=l9_57;
l9_56=1-l9_58;
}
else
{
int l9_59=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_59=0;
}
else
{
l9_59=in.varStereoViewID;
}
int l9_60=l9_59;
l9_56=l9_60;
}
int l9_61=l9_56;
float2 l9_62=l9_55;
int l9_63=l9_61;
float2 l9_64=l9_62;
int l9_65=l9_63;
float l9_66=0.0;
float4 l9_67=float4(0.0);
float2 l9_68=l9_64;
int l9_69=sc_ScreenTextureLayout_tmp;
int l9_70=l9_65;
float l9_71=l9_66;
float2 l9_72=l9_68;
int l9_73=l9_69;
int l9_74=l9_70;
float3 l9_75=float3(0.0);
if (l9_73==0)
{
l9_75=float3(l9_72,0.0);
}
else
{
if (l9_73==1)
{
l9_75=float3(l9_72.x,(l9_72.y*0.5)+(0.5-(float(l9_74)*0.5)),0.0);
}
else
{
l9_75=float3(l9_72,float(l9_74));
}
}
float3 l9_76=l9_75;
float3 l9_77=l9_76;
float2 l9_78=l9_77.xy;
float l9_79=l9_71;
float4 l9_80=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_78,bias(l9_79));
float4 l9_81=l9_80;
l9_67=l9_81;
float4 l9_82=l9_67;
float4 l9_83=l9_82;
float4 l9_84=l9_83;
l9_37=l9_84;
}
float4 l9_85=l9_37;
float4 l9_86=l9_85;
float3 l9_87=l9_86.xyz;
float3 l9_88=l9_87;
float3 l9_89=l9_35.xyz;
float3 l9_90=definedBlend(l9_88,l9_89,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_36=float4(l9_90.x,l9_90.y,l9_90.z,l9_36.w);
float3 l9_91=mix(l9_87,l9_36.xyz,float3(l9_35.w));
l9_36=float4(l9_91.x,l9_91.y,l9_91.z,l9_36.w);
l9_36.w=1.0;
float4 l9_92=l9_36;
param_28=l9_92;
}
else
{
float4 l9_93=param_28;
float4 l9_94=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_94=float4(mix(float3(1.0),l9_93.xyz,float3(l9_93.w)),l9_93.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_95=l9_93.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_95=fast::clamp(l9_95,0.0,1.0);
}
l9_94=float4(l9_93.xyz*l9_95,l9_95);
}
else
{
l9_94=l9_93;
}
}
float4 l9_96=l9_94;
param_28=l9_96;
}
}
}
float4 l9_97=param_28;
Output_Color0=l9_97;
float4 l9_98=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_98=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_98=float4(0.0);
}
float4 l9_99=l9_98;
float4 Cost=l9_99;
if (Cost.w>0.0)
{
Output_Color0=Cost;
}
float4 param_29=Output_Color0;
out.FragColor0=param_29;
float4 param_30=Output_Color0;
float4 l9_100=param_30;
out.FragColor0=l9_100;
return out;
}
} // FRAGMENT SHADER
