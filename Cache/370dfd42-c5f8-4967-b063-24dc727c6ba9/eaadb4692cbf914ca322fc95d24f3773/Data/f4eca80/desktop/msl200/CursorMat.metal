#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_BACKEND_SHADER_FLAGS_END__
#endif
#ifdef useTexture
#undef useTexture
#endif
#ifdef isTriggering
#undef isTriggering
#endif
#ifdef multipleInteractorsActive
#undef multipleInteractorsActive
#endif
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
#ifdef uv2
#undef uv2
#endif
#ifdef uv3
#undef uv3
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
//sampler sampler cursorTextureSmpSC 2:22
//sampler sampler intensityTextureSmpSC 2:23
//sampler sampler sc_ScreenTextureSmpSC 2:28
//sampler sampler z_hitIdAndBarycentricSmp 2:31
//sampler sampler z_rayDirectionsSmpSC 2:32
//texture texture2D cursorTexture 2:4:2:22
//texture texture2D intensityTexture 2:5:2:23
//texture texture2D sc_ScreenTexture 2:17:2:28
//texture utexture2D z_hitIdAndBarycentric 2:20:2:31
//texture texture2D z_rayDirections 2:21:2:32
//ubo float sc_BonesUBO 2:3:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:33:4656 {
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
//bool isProxyMode 3808
//int instance_id 3812
//int lray_triangles_last 3816
//bool noEarlyZ 3820
//bool has_animated_pn 3824
//int emitter_stride 3828
//int proxy_offset_position 3832
//int proxy_offset_normal 3836
//int proxy_offset_tangent 3840
//int proxy_offset_color 3844
//int proxy_offset_texture0 3848
//int proxy_offset_texture1 3852
//int proxy_offset_texture2 3856
//int proxy_offset_texture3 3860
//int proxy_format_position 3864
//int proxy_format_normal 3868
//int proxy_format_tangent 3872
//int proxy_format_color 3876
//int proxy_format_texture0 3880
//int proxy_format_texture1 3884
//int proxy_format_texture2 3888
//int proxy_format_texture3 3892
//float4 z_rayDirectionsSize 3904
//float4 z_rayDirectionsDims 3920
//float4 z_rayDirectionsView 3936
//float correctedIntensity 3952
//float4 intensityTextureSize 3968
//float4 intensityTextureDims 3984
//float4 intensityTextureView 4000
//float3x3 intensityTextureTransform 4016
//float4 intensityTextureUvMinMax 4064
//float4 intensityTextureBorderColor 4080
//float reflBlurWidth 4096
//float reflBlurMinRough 4100
//float reflBlurMaxRough 4104
//int overrideTimeEnabled 4108
//float overrideTimeElapsed 4112
//float overrideTimeDelta 4116
//int PreviewEnabled 4120
//int PreviewNodeID 4124
//float alphaTestThreshold 4128
//bool useTexture 4132
//float4 cursorTextureSize 4144
//float4 cursorTextureDims 4160
//float4 cursorTextureView 4176
//float3x3 cursorTextureTransform 4192
//float4 cursorTextureUvMinMax 4240
//float4 cursorTextureBorderColor 4256
//float circleSquishScale 4272
//bool isTriggering 4276
//float outlineOffset 4280
//int handType 4284
//bool multipleInteractorsActive 4288
//float maxAlpha 4292
//float outlineAlpha 4296
//float shadowGradientOffset 4300
//float shadowOpacity 4304
//float Port_RangeMinA_N013 4308
//float Port_RangeMaxA_N013 4312
//float Port_RangeMinB_N013 4316
//float Port_RangeMaxB_N013 4320
//float Port_Value_N164 4324
//float Port_RangeMinA_N161 4328
//float Port_RangeMaxA_N161 4332
//float Port_RangeMinB_N161 4336
//float Port_RangeMaxB_N161 4340
//float2 Port_Center_N019 4344
//float2 Port_Input1_N020 4352
//float Port_Input1_N027 4360
//float Port_Input1_N026 4364
//float Port_Input1_N028 4368
//float Port_Input1_N029 4372
//float2 Port_Default_N010 4376
//float Port_RangeMinA_N001 4384
//float Port_RangeMaxA_N001 4388
//float Port_RangeMinB_N001 4392
//float Port_RangeMaxB_N001 4396
//float2 Port_Scale_N002 4400
//float2 Port_Center_N002 4408
//float Port_Value1_N046 4416
//float Port_Value2_N046 4420
//float Port_Value_N042 4424
//float3 Port_Value1_N048 4432
//float3 Port_Default_N048 4448
//float Port_Input0_N083 4464
//float Port_Input1_N083 4468
//float Port_Value_N036 4472
//float Port_Value_N037 4476
//float Port_Input1_N071 4480
//float Port_Input1_N097 4484
//int Port_Value_N091 4488
//int Port_Value_N041 4492
//float Port_Input1_N084 4496
//float Port_Input1_N035 4500
//float Port_Value1_N131 4504
//float Port_Input1_N054 4508
//float Port_Value_N068 4512
//float Port_Value2_N131 4516
//float Port_Input1_N094 4520
//float Port_Input1_N112 4524
//float Port_Value3_N131 4528
//float Port_Default_N131 4532
//float3 Port_Value1_N014 4544
//float Port_Value1_N156 4560
//float Port_Value2_N156 4564
//float Port_Value3_N156 4568
//float Port_Value4_N156 4572
//float Port_Default_N156 4576
//float Port_Value1_N149 4580
//float Port_Value2_N149 4584
//float Port_Value3_N149 4588
//float Port_RangeMaxB_N151 4592
//float Port_RangeMaxB_N152 4596
//float Port_Default_N153 4600
//float Port_RangeMaxB_N154 4604
//float Port_Input1_N143 4608
//float Port_RangeMaxB_N146 4612
//float Port_Default_N155 4616
//float4 Port_Default_N088 4624
//float depthRef 4640
//}
//ssbo int layoutIndices 2:0:4 {
//uint _Triangles 0:[]:4
//}
//ssbo float layoutVerticesPN 2:2:4 {
//float _VerticesPN 0:[]:4
//}
//ssbo float layoutVertices 2:1:4 {
//float _Vertices 0:[]:4
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
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 1030
//spec_const bool SC_USE_CLAMP_TO_BORDER_cursorTexture 1031
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1032
//spec_const bool SC_USE_UV_MIN_MAX_cursorTexture 1033
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1034
//spec_const bool SC_USE_UV_TRANSFORM_cursorTexture 1035
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1036
//spec_const bool UseViewSpaceDepthVariant 1037
//spec_const bool cursorTextureHasSwappedViews 1038
//spec_const bool intensityTextureHasSwappedViews 1039
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1040
//spec_const bool sc_BlendMode_Add 1041
//spec_const bool sc_BlendMode_AlphaTest 1042
//spec_const bool sc_BlendMode_AlphaToCoverage 1043
//spec_const bool sc_BlendMode_ColoredGlass 1044
//spec_const bool sc_BlendMode_Custom 1045
//spec_const bool sc_BlendMode_Max 1046
//spec_const bool sc_BlendMode_Min 1047
//spec_const bool sc_BlendMode_MultiplyOriginal 1048
//spec_const bool sc_BlendMode_Multiply 1049
//spec_const bool sc_BlendMode_Normal 1050
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1051
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1052
//spec_const bool sc_BlendMode_PremultipliedAlpha 1053
//spec_const bool sc_BlendMode_Screen 1054
//spec_const bool sc_DepthOnly 1055
//spec_const bool sc_FramebufferFetch 1056
//spec_const bool sc_MotionVectorsPass 1057
//spec_const bool sc_OITCompositingPass 1058
//spec_const bool sc_OITDepthBoundsPass 1059
//spec_const bool sc_OITDepthGatherPass 1060
//spec_const bool sc_ProjectiveShadowsCaster 1061
//spec_const bool sc_ProjectiveShadowsReceiver 1062
//spec_const bool sc_ProxyAlphaOne 1063
//spec_const bool sc_RenderAlphaToColor 1064
//spec_const bool sc_ScreenTextureHasSwappedViews 1065
//spec_const bool sc_ShaderComplexityAnalyzer 1066
//spec_const bool sc_UseFramebufferFetchMarker 1067
//spec_const bool sc_VertexBlendingUseNormals 1068
//spec_const bool sc_VertexBlending 1069
//spec_const int SC_SOFTWARE_WRAP_MODE_U_cursorTexture 1070
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1071
//spec_const int SC_SOFTWARE_WRAP_MODE_V_cursorTexture 1072
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1073
//spec_const int cursorTextureLayout 1074
//spec_const int intensityTextureLayout 1075
//spec_const int sc_DepthBufferMode 1076
//spec_const int sc_RenderingSpace 1077
//spec_const int sc_ScreenTextureLayout 1078
//spec_const int sc_SkinBonesCount 1079
//spec_const int sc_StereoRenderingMode 1080
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1081
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
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(1030)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool SC_USE_CLAMP_TO_BORDER_cursorTexture [[function_constant(1031)]];
constant bool SC_USE_CLAMP_TO_BORDER_cursorTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_cursorTexture) ? SC_USE_CLAMP_TO_BORDER_cursorTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1032)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_cursorTexture [[function_constant(1033)]];
constant bool SC_USE_UV_MIN_MAX_cursorTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_cursorTexture) ? SC_USE_UV_MIN_MAX_cursorTexture : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1034)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_cursorTexture [[function_constant(1035)]];
constant bool SC_USE_UV_TRANSFORM_cursorTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_cursorTexture) ? SC_USE_UV_TRANSFORM_cursorTexture : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1036)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1037)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool cursorTextureHasSwappedViews [[function_constant(1038)]];
constant bool cursorTextureHasSwappedViews_tmp = is_function_constant_defined(cursorTextureHasSwappedViews) ? cursorTextureHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1039)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1040)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1041)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1042)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1043)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1044)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1045)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1046)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1047)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1048)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1049)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1050)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1051)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1052)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1053)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1054)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1055)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_FramebufferFetch [[function_constant(1056)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_MotionVectorsPass [[function_constant(1057)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1058)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1059)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1060)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1061)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1062)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_ProxyAlphaOne [[function_constant(1063)]];
constant bool sc_ProxyAlphaOne_tmp = is_function_constant_defined(sc_ProxyAlphaOne) ? sc_ProxyAlphaOne : false;
constant bool sc_RenderAlphaToColor [[function_constant(1064)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1065)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1066)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1067)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1068)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1069)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant int SC_SOFTWARE_WRAP_MODE_U_cursorTexture [[function_constant(1070)]];
constant int SC_SOFTWARE_WRAP_MODE_U_cursorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_cursorTexture) ? SC_SOFTWARE_WRAP_MODE_U_cursorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1071)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_cursorTexture [[function_constant(1072)]];
constant int SC_SOFTWARE_WRAP_MODE_V_cursorTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_cursorTexture) ? SC_SOFTWARE_WRAP_MODE_V_cursorTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1073)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int cursorTextureLayout [[function_constant(1074)]];
constant int cursorTextureLayout_tmp = is_function_constant_defined(cursorTextureLayout) ? cursorTextureLayout : 0;
constant int intensityTextureLayout [[function_constant(1075)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int sc_DepthBufferMode [[function_constant(1076)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_RenderingSpace [[function_constant(1077)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1078)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1079)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1080)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1081)]];
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
int isProxyMode;
int instance_id;
int lray_triangles_last;
int noEarlyZ;
int has_animated_pn;
int emitter_stride;
int proxy_offset_position;
int proxy_offset_normal;
int proxy_offset_tangent;
int proxy_offset_color;
int proxy_offset_texture0;
int proxy_offset_texture1;
int proxy_offset_texture2;
int proxy_offset_texture3;
int proxy_format_position;
int proxy_format_normal;
int proxy_format_tangent;
int proxy_format_color;
int proxy_format_texture0;
int proxy_format_texture1;
int proxy_format_texture2;
int proxy_format_texture3;
float4 z_rayDirectionsSize;
float4 z_rayDirectionsDims;
float4 z_rayDirectionsView;
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
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
int useTexture;
float4 cursorTextureSize;
float4 cursorTextureDims;
float4 cursorTextureView;
float3x3 cursorTextureTransform;
float4 cursorTextureUvMinMax;
float4 cursorTextureBorderColor;
float circleSquishScale;
int isTriggering;
float outlineOffset;
int handType;
int multipleInteractorsActive;
float maxAlpha;
float outlineAlpha;
float shadowGradientOffset;
float shadowOpacity;
float Port_RangeMinA_N013;
float Port_RangeMaxA_N013;
float Port_RangeMinB_N013;
float Port_RangeMaxB_N013;
float Port_Value_N164;
float Port_RangeMinA_N161;
float Port_RangeMaxA_N161;
float Port_RangeMinB_N161;
float Port_RangeMaxB_N161;
float2 Port_Center_N019;
float2 Port_Input1_N020;
float Port_Input1_N027;
float Port_Input1_N026;
float Port_Input1_N028;
float Port_Input1_N029;
float2 Port_Default_N010;
float Port_RangeMinA_N001;
float Port_RangeMaxA_N001;
float Port_RangeMinB_N001;
float Port_RangeMaxB_N001;
float2 Port_Scale_N002;
float2 Port_Center_N002;
float Port_Value1_N046;
float Port_Value2_N046;
float Port_Value_N042;
float3 Port_Value1_N048;
float3 Port_Default_N048;
float Port_Input0_N083;
float Port_Input1_N083;
float Port_Value_N036;
float Port_Value_N037;
float Port_Input1_N071;
float Port_Input1_N097;
int Port_Value_N091;
int Port_Value_N041;
float Port_Input1_N084;
float Port_Input1_N035;
float Port_Value1_N131;
float Port_Input1_N054;
float Port_Value_N068;
float Port_Value2_N131;
float Port_Input1_N094;
float Port_Input1_N112;
float Port_Value3_N131;
float Port_Default_N131;
float3 Port_Value1_N014;
float Port_Value1_N156;
float Port_Value2_N156;
float Port_Value3_N156;
float Port_Value4_N156;
float Port_Default_N156;
float Port_Value1_N149;
float Port_Value2_N149;
float Port_Value3_N149;
float Port_RangeMaxB_N151;
float Port_RangeMaxB_N152;
float Port_Default_N153;
float Port_RangeMaxB_N154;
float Port_Input1_N143;
float Port_RangeMaxB_N146;
float Port_Default_N155;
float4 Port_Default_N088;
float depthRef;
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
struct ssPreviewInfo
{
float4 Color;
bool Saved;
};
struct layoutIndices_obj
{
uint _Triangles[1];
};
struct layoutVertices_obj
{
float _Vertices[1];
};
struct layoutVerticesPN_obj
{
float _VerticesPN[1];
};
struct sc_Set2
{
const device layoutIndices_obj* layoutIndices [[id(0)]];
const device layoutVertices_obj* layoutVertices [[id(1)]];
const device layoutVerticesPN_obj* layoutVerticesPN [[id(2)]];
constant sc_Bones_obj* sc_BonesUBO [[id(3)]];
texture2d<float> cursorTexture [[id(4)]];
texture2d<float> intensityTexture [[id(5)]];
texture2d<float> sc_ScreenTexture [[id(17)]];
texture2d<uint> z_hitIdAndBarycentric [[id(20)]];
texture2d<float> z_rayDirections [[id(21)]];
sampler cursorTextureSmpSC [[id(22)]];
sampler intensityTextureSmpSC [[id(23)]];
sampler sc_ScreenTextureSmpSC [[id(28)]];
sampler z_hitIdAndBarycentricSmp [[id(31)]];
sampler z_rayDirectionsSmpSC [[id(32)]];
constant userUniformsObj* UserUniforms [[id(33)]];
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
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
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
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
bool l9_0=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_0)
{
float4 param=float4(in.position.xy,(*sc_set2.UserUniforms).depthRef+(1e-10*in.position.z),1.0+(1e-10*in.position.w));
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1=param;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_2=dot(l9_1,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_3=l9_2;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_3;
}
}
float4 l9_4=float4(param.x,-param.y,(param.z*0.5)+(param.w*0.5),param.w);
out.gl_Position=l9_4;
return out;
}
out.PreviewVertexColor=float4(0.5);
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=float4(0.5);
PreviewInfo.Saved=false;
out.PreviewVertexSaved=0.0;
sc_Vertex_t l9_6;
l9_6.position=in.position;
l9_6.normal=in.normal;
l9_6.tangent=in.tangent.xyz;
l9_6.texture0=in.texture0;
l9_6.texture1=in.texture1;
sc_Vertex_t l9_7=l9_6;
sc_Vertex_t param_1=l9_7;
sc_Vertex_t l9_8=param_1;
if ((int(sc_VertexBlending_tmp)!=0))
{
if ((int(sc_VertexBlendingUseNormals_tmp)!=0))
{
sc_Vertex_t l9_9=l9_8;
float3 l9_10=in.blendShape0Pos;
float3 l9_11=in.blendShape0Normal;
float l9_12=(*sc_set2.UserUniforms).weights0.x;
sc_Vertex_t l9_13=l9_9;
float3 l9_14=l9_10;
float l9_15=l9_12;
float3 l9_16=l9_13.position.xyz+(l9_14*l9_15);
l9_13.position=float4(l9_16.x,l9_16.y,l9_16.z,l9_13.position.w);
l9_9=l9_13;
l9_9.normal+=(l9_11*l9_12);
l9_8=l9_9;
sc_Vertex_t l9_17=l9_8;
float3 l9_18=in.blendShape1Pos;
float3 l9_19=in.blendShape1Normal;
float l9_20=(*sc_set2.UserUniforms).weights0.y;
sc_Vertex_t l9_21=l9_17;
float3 l9_22=l9_18;
float l9_23=l9_20;
float3 l9_24=l9_21.position.xyz+(l9_22*l9_23);
l9_21.position=float4(l9_24.x,l9_24.y,l9_24.z,l9_21.position.w);
l9_17=l9_21;
l9_17.normal+=(l9_19*l9_20);
l9_8=l9_17;
sc_Vertex_t l9_25=l9_8;
float3 l9_26=in.blendShape2Pos;
float3 l9_27=in.blendShape2Normal;
float l9_28=(*sc_set2.UserUniforms).weights0.z;
sc_Vertex_t l9_29=l9_25;
float3 l9_30=l9_26;
float l9_31=l9_28;
float3 l9_32=l9_29.position.xyz+(l9_30*l9_31);
l9_29.position=float4(l9_32.x,l9_32.y,l9_32.z,l9_29.position.w);
l9_25=l9_29;
l9_25.normal+=(l9_27*l9_28);
l9_8=l9_25;
}
else
{
sc_Vertex_t l9_33=l9_8;
float3 l9_34=in.blendShape0Pos;
float l9_35=(*sc_set2.UserUniforms).weights0.x;
float3 l9_36=l9_33.position.xyz+(l9_34*l9_35);
l9_33.position=float4(l9_36.x,l9_36.y,l9_36.z,l9_33.position.w);
l9_8=l9_33;
sc_Vertex_t l9_37=l9_8;
float3 l9_38=in.blendShape1Pos;
float l9_39=(*sc_set2.UserUniforms).weights0.y;
float3 l9_40=l9_37.position.xyz+(l9_38*l9_39);
l9_37.position=float4(l9_40.x,l9_40.y,l9_40.z,l9_37.position.w);
l9_8=l9_37;
sc_Vertex_t l9_41=l9_8;
float3 l9_42=in.blendShape2Pos;
float l9_43=(*sc_set2.UserUniforms).weights0.z;
float3 l9_44=l9_41.position.xyz+(l9_42*l9_43);
l9_41.position=float4(l9_44.x,l9_44.y,l9_44.z,l9_41.position.w);
l9_8=l9_41;
sc_Vertex_t l9_45=l9_8;
float3 l9_46=in.blendShape3Pos;
float l9_47=(*sc_set2.UserUniforms).weights0.w;
float3 l9_48=l9_45.position.xyz+(l9_46*l9_47);
l9_45.position=float4(l9_48.x,l9_48.y,l9_48.z,l9_45.position.w);
l9_8=l9_45;
sc_Vertex_t l9_49=l9_8;
float3 l9_50=in.blendShape4Pos;
float l9_51=(*sc_set2.UserUniforms).weights1.x;
float3 l9_52=l9_49.position.xyz+(l9_50*l9_51);
l9_49.position=float4(l9_52.x,l9_52.y,l9_52.z,l9_49.position.w);
l9_8=l9_49;
sc_Vertex_t l9_53=l9_8;
float3 l9_54=in.blendShape5Pos;
float l9_55=(*sc_set2.UserUniforms).weights1.y;
float3 l9_56=l9_53.position.xyz+(l9_54*l9_55);
l9_53.position=float4(l9_56.x,l9_56.y,l9_56.z,l9_53.position.w);
l9_8=l9_53;
}
}
param_1=l9_8;
sc_Vertex_t l9_57=param_1;
if (sc_SkinBonesCount_tmp>0)
{
float4 l9_58=float4(0.0);
if (sc_SkinBonesCount_tmp>0)
{
l9_58=float4(1.0,fract(in.boneData.yzw));
l9_58.x-=dot(l9_58.yzw,float3(1.0));
}
float4 l9_59=l9_58;
float4 l9_60=l9_59;
int l9_61=0;
int l9_62=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_62=int(in.boneData[l9_61]);
}
int l9_63=l9_62;
int l9_64=l9_63;
int l9_65=1;
int l9_66=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_66=int(in.boneData[l9_65]);
}
int l9_67=l9_66;
int l9_68=l9_67;
int l9_69=2;
int l9_70=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_70=int(in.boneData[l9_69]);
}
int l9_71=l9_70;
int l9_72=l9_71;
int l9_73=3;
int l9_74=0;
if (sc_SkinBonesCount_tmp>0)
{
l9_74=int(in.boneData[l9_73]);
}
int l9_75=l9_74;
int l9_76=l9_75;
int l9_77=l9_64;
float4 l9_78=l9_57.position;
float3 l9_79=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_80=l9_77;
float4 l9_81=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[0];
float4 l9_82=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[1];
float4 l9_83=(*sc_set2.sc_BonesUBO).sc_Bones[l9_80].boneMatrix[2];
float4 l9_84[3];
l9_84[0]=l9_81;
l9_84[1]=l9_82;
l9_84[2]=l9_83;
l9_79=float3(dot(l9_78,l9_84[0]),dot(l9_78,l9_84[1]),dot(l9_78,l9_84[2]));
}
else
{
l9_79=l9_78.xyz;
}
float3 l9_85=l9_79;
float3 l9_86=l9_85;
float l9_87=l9_60.x;
int l9_88=l9_68;
float4 l9_89=l9_57.position;
float3 l9_90=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_91=l9_88;
float4 l9_92=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[0];
float4 l9_93=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[1];
float4 l9_94=(*sc_set2.sc_BonesUBO).sc_Bones[l9_91].boneMatrix[2];
float4 l9_95[3];
l9_95[0]=l9_92;
l9_95[1]=l9_93;
l9_95[2]=l9_94;
l9_90=float3(dot(l9_89,l9_95[0]),dot(l9_89,l9_95[1]),dot(l9_89,l9_95[2]));
}
else
{
l9_90=l9_89.xyz;
}
float3 l9_96=l9_90;
float3 l9_97=l9_96;
float l9_98=l9_60.y;
int l9_99=l9_72;
float4 l9_100=l9_57.position;
float3 l9_101=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_102=l9_99;
float4 l9_103=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[0];
float4 l9_104=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[1];
float4 l9_105=(*sc_set2.sc_BonesUBO).sc_Bones[l9_102].boneMatrix[2];
float4 l9_106[3];
l9_106[0]=l9_103;
l9_106[1]=l9_104;
l9_106[2]=l9_105;
l9_101=float3(dot(l9_100,l9_106[0]),dot(l9_100,l9_106[1]),dot(l9_100,l9_106[2]));
}
else
{
l9_101=l9_100.xyz;
}
float3 l9_107=l9_101;
float3 l9_108=l9_107;
float l9_109=l9_60.z;
int l9_110=l9_76;
float4 l9_111=l9_57.position;
float3 l9_112=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_113=l9_110;
float4 l9_114=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[0];
float4 l9_115=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[1];
float4 l9_116=(*sc_set2.sc_BonesUBO).sc_Bones[l9_113].boneMatrix[2];
float4 l9_117[3];
l9_117[0]=l9_114;
l9_117[1]=l9_115;
l9_117[2]=l9_116;
l9_112=float3(dot(l9_111,l9_117[0]),dot(l9_111,l9_117[1]),dot(l9_111,l9_117[2]));
}
else
{
l9_112=l9_111.xyz;
}
float3 l9_118=l9_112;
float3 l9_119=(((l9_86*l9_87)+(l9_97*l9_98))+(l9_108*l9_109))+(l9_118*l9_60.w);
l9_57.position=float4(l9_119.x,l9_119.y,l9_119.z,l9_57.position.w);
int l9_120=l9_64;
float3x3 l9_121=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_120].normalMatrix[2].xyz));
float3x3 l9_122=l9_121;
float3x3 l9_123=l9_122;
int l9_124=l9_68;
float3x3 l9_125=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_124].normalMatrix[2].xyz));
float3x3 l9_126=l9_125;
float3x3 l9_127=l9_126;
int l9_128=l9_72;
float3x3 l9_129=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_128].normalMatrix[2].xyz));
float3x3 l9_130=l9_129;
float3x3 l9_131=l9_130;
int l9_132=l9_76;
float3x3 l9_133=float3x3(float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[0].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[1].xyz),float3((*sc_set2.sc_BonesUBO).sc_Bones[l9_132].normalMatrix[2].xyz));
float3x3 l9_134=l9_133;
float3x3 l9_135=l9_134;
l9_57.normal=((((l9_123*l9_57.normal)*l9_60.x)+((l9_127*l9_57.normal)*l9_60.y))+((l9_131*l9_57.normal)*l9_60.z))+((l9_135*l9_57.normal)*l9_60.w);
l9_57.tangent=((((l9_123*l9_57.tangent)*l9_60.x)+((l9_127*l9_57.tangent)*l9_60.y))+((l9_131*l9_57.tangent)*l9_60.z))+((l9_135*l9_57.tangent)*l9_60.w);
}
param_1=l9_57;
if (sc_RenderingSpace_tmp==3)
{
out.varPos=float3(0.0);
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==4)
{
out.varPos=float3(0.0);
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
out.varPos=param_1.position.xyz;
out.varNormal=param_1.normal;
out.varTangent=float4(param_1.tangent.x,param_1.tangent.y,param_1.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
out.varPos=((*sc_set2.UserUniforms).sc_ModelMatrix*param_1.position).xyz;
out.varNormal=(*sc_set2.UserUniforms).sc_NormalMatrix*param_1.normal;
float3 l9_136=(*sc_set2.UserUniforms).sc_NormalMatrix*param_1.tangent;
out.varTangent=float4(l9_136.x,l9_136.y,l9_136.z,out.varTangent.w);
}
}
}
}
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
param_1.texture0.x=1.0-param_1.texture0.x;
}
out.varColor=in.color;
sc_Vertex_t v=param_1;
float3 WorldPosition=out.varPos;
float3 WorldNormal=out.varNormal;
float3 WorldTangent=out.varTangent.xyz;
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
WorldPosition=out.varPos;
WorldNormal=out.varNormal;
WorldTangent=out.varTangent.xyz;
}
sc_Vertex_t param_2=v;
float3 param_3=WorldPosition;
float3 param_4=WorldNormal;
float3 param_5=WorldTangent;
float4 param_6=v.position;
out.varPos=param_3;
out.varNormal=normalize(param_4);
float3 l9_137=normalize(param_5);
out.varTangent=float4(l9_137.x,l9_137.y,l9_137.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
if ((int(UseViewSpaceDepthVariant_tmp)!=0)&&(((int(sc_OITDepthGatherPass_tmp)!=0)||(int(sc_OITCompositingPass_tmp)!=0))||(int(sc_OITDepthBoundsPass_tmp)!=0)))
{
float4 l9_138=param_2.position;
float4 l9_139=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
int l9_140=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_140=0;
}
else
{
l9_140=gl_InstanceIndex%2;
}
int l9_141=l9_140;
l9_139=(*sc_set2.UserUniforms).sc_ProjectionMatrixInverseArray[l9_141]*l9_138;
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_142=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_142=0;
}
else
{
l9_142=gl_InstanceIndex%2;
}
int l9_143=l9_142;
l9_139=(*sc_set2.UserUniforms).sc_ViewMatrixArray[l9_143]*l9_138;
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_144=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_144=0;
}
else
{
l9_144=gl_InstanceIndex%2;
}
int l9_145=l9_144;
l9_139=(*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_145]*l9_138;
}
else
{
l9_139=l9_138;
}
}
}
float4 l9_146=l9_139;
out.varViewSpaceDepth=-l9_146.z;
}
float4 l9_147=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
l9_147=param_6;
}
else
{
if (sc_RenderingSpace_tmp==4)
{
int l9_148=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_148=0;
}
else
{
l9_148=gl_InstanceIndex%2;
}
int l9_149=l9_148;
l9_147=((*sc_set2.UserUniforms).sc_ModelViewMatrixArray[l9_149]*param_2.position)*float4(1.0/(*sc_set2.UserUniforms).sc_Camera.aspect,1.0,1.0,1.0);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_150=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_150=0;
}
else
{
l9_150=gl_InstanceIndex%2;
}
int l9_151=l9_150;
l9_147=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_151]*float4(out.varPos,1.0);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_152=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_152=0;
}
else
{
l9_152=gl_InstanceIndex%2;
}
int l9_153=l9_152;
l9_147=(*sc_set2.UserUniforms).sc_ViewProjectionMatrixArray[l9_153]*float4(out.varPos,1.0);
}
}
}
}
out.varPackedTex=float4(param_2.texture0,param_2.texture1);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float4 l9_154=param_2.position;
float4 l9_155=l9_154;
if (sc_RenderingSpace_tmp==1)
{
l9_155=(*sc_set2.UserUniforms).sc_ModelMatrix*l9_154;
}
float4 l9_156=(*sc_set2.UserUniforms).sc_ProjectorMatrix*l9_155;
float2 l9_157=((l9_156.xy/float2(l9_156.w))*0.5)+float2(0.5);
out.varShadowTex=l9_157;
}
float4 l9_158=l9_147;
if (sc_DepthBufferMode_tmp==1)
{
int l9_159=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_159=0;
}
else
{
l9_159=gl_InstanceIndex%2;
}
int l9_160=l9_159;
if ((*sc_set2.UserUniforms).sc_ProjectionMatrixArray[l9_160][2].w!=0.0)
{
float l9_161=2.0/log2((*sc_set2.UserUniforms).sc_Camera.clipPlanes.y+1.0);
l9_158.z=((log2(fast::max((*sc_set2.UserUniforms).sc_Camera.clipPlanes.x,1.0+l9_158.w))*l9_161)-1.0)*l9_158.w;
}
}
float4 l9_162=l9_158;
l9_147=l9_162;
float4 l9_163=l9_147;
float4 l9_164=l9_163;
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_165=l9_164;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_166=dot(l9_165,(*sc_set2.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_167=l9_166;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_167;
}
}
float4 l9_168=float4(l9_164.x,-l9_164.y,(l9_164.z*0.5)+(l9_164.w*0.5),l9_164.w);
out.gl_Position=l9_168;
v=param_2;
if (PreviewInfo.Saved)
{
out.PreviewVertexColor=float4(PreviewInfo.Color.xyz,1.0);
out.PreviewVertexSaved=1.0;
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct RayHitPayload
{
float3 viewDirWS;
float3 positionWS;
float3 normalWS;
float4 tangentWS;
float4 color;
float2 uv0;
float2 uv1;
float2 uv2;
float2 uv3;
uint2 id;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float2 Surface_UVCoord0;
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
int isProxyMode;
int instance_id;
int lray_triangles_last;
int noEarlyZ;
int has_animated_pn;
int emitter_stride;
int proxy_offset_position;
int proxy_offset_normal;
int proxy_offset_tangent;
int proxy_offset_color;
int proxy_offset_texture0;
int proxy_offset_texture1;
int proxy_offset_texture2;
int proxy_offset_texture3;
int proxy_format_position;
int proxy_format_normal;
int proxy_format_tangent;
int proxy_format_color;
int proxy_format_texture0;
int proxy_format_texture1;
int proxy_format_texture2;
int proxy_format_texture3;
float4 z_rayDirectionsSize;
float4 z_rayDirectionsDims;
float4 z_rayDirectionsView;
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
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
int useTexture;
float4 cursorTextureSize;
float4 cursorTextureDims;
float4 cursorTextureView;
float3x3 cursorTextureTransform;
float4 cursorTextureUvMinMax;
float4 cursorTextureBorderColor;
float circleSquishScale;
int isTriggering;
float outlineOffset;
int handType;
int multipleInteractorsActive;
float maxAlpha;
float outlineAlpha;
float shadowGradientOffset;
float shadowOpacity;
float Port_RangeMinA_N013;
float Port_RangeMaxA_N013;
float Port_RangeMinB_N013;
float Port_RangeMaxB_N013;
float Port_Value_N164;
float Port_RangeMinA_N161;
float Port_RangeMaxA_N161;
float Port_RangeMinB_N161;
float Port_RangeMaxB_N161;
float2 Port_Center_N019;
float2 Port_Input1_N020;
float Port_Input1_N027;
float Port_Input1_N026;
float Port_Input1_N028;
float Port_Input1_N029;
float2 Port_Default_N010;
float Port_RangeMinA_N001;
float Port_RangeMaxA_N001;
float Port_RangeMinB_N001;
float Port_RangeMaxB_N001;
float2 Port_Scale_N002;
float2 Port_Center_N002;
float Port_Value1_N046;
float Port_Value2_N046;
float Port_Value_N042;
float3 Port_Value1_N048;
float3 Port_Default_N048;
float Port_Input0_N083;
float Port_Input1_N083;
float Port_Value_N036;
float Port_Value_N037;
float Port_Input1_N071;
float Port_Input1_N097;
int Port_Value_N091;
int Port_Value_N041;
float Port_Input1_N084;
float Port_Input1_N035;
float Port_Value1_N131;
float Port_Input1_N054;
float Port_Value_N068;
float Port_Value2_N131;
float Port_Input1_N094;
float Port_Input1_N112;
float Port_Value3_N131;
float Port_Default_N131;
float3 Port_Value1_N014;
float Port_Value1_N156;
float Port_Value2_N156;
float Port_Value3_N156;
float Port_Value4_N156;
float Port_Default_N156;
float Port_Value1_N149;
float Port_Value2_N149;
float Port_Value3_N149;
float Port_RangeMaxB_N151;
float Port_RangeMaxB_N152;
float Port_Default_N153;
float Port_RangeMaxB_N154;
float Port_Input1_N143;
float Port_RangeMaxB_N146;
float Port_Default_N155;
float4 Port_Default_N088;
float depthRef;
};
struct layoutVertices_obj
{
float _Vertices[1];
};
struct layoutVerticesPN_obj
{
float _VerticesPN[1];
};
struct layoutIndices_obj
{
uint _Triangles[1];
};
struct ssPreviewInfo
{
float4 Color;
bool Saved;
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
const device layoutIndices_obj* layoutIndices [[id(0)]];
const device layoutVertices_obj* layoutVertices [[id(1)]];
const device layoutVerticesPN_obj* layoutVerticesPN [[id(2)]];
constant sc_Bones_obj* sc_BonesUBO [[id(3)]];
texture2d<float> cursorTexture [[id(4)]];
texture2d<float> intensityTexture [[id(5)]];
texture2d<float> sc_ScreenTexture [[id(17)]];
texture2d<uint> z_hitIdAndBarycentric [[id(20)]];
texture2d<float> z_rayDirections [[id(21)]];
sampler cursorTextureSmpSC [[id(22)]];
sampler intensityTextureSmpSC [[id(23)]];
sampler sc_ScreenTextureSmpSC [[id(28)]];
sampler z_hitIdAndBarycentricSmp [[id(31)]];
sampler z_rayDirectionsSmpSC [[id(32)]];
constant userUniformsObj* UserUniforms [[id(33)]];
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
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
// Implementation of the GLSL radians() function
template<typename T>
T radians(T d)
{
return d*T(0.01745329251);
}
RayHitPayload GetHitData(thread const int2& screenPos,constant userUniformsObj& UserUniforms,thread texture2d<float> z_rayDirections,thread sampler z_rayDirectionsSmpSC,thread texture2d<uint> z_hitIdAndBarycentric,thread sampler z_hitIdAndBarycentricSmp,const device layoutVertices_obj& layoutVertices,const device layoutVerticesPN_obj& layoutVerticesPN,const device layoutIndices_obj& layoutIndices)
{
int2 param=screenPos;
uint4 l9_0=z_hitIdAndBarycentric.read(uint2(param),0);
uint4 id_and_barycentric=l9_0;
RayHitPayload rhp;
rhp.id=id_and_barycentric.xy;
if (rhp.id.x!=uint(UserUniforms.instance_id))
{
return rhp;
}
float2 brc_vw=float2(as_type<half2>(id_and_barycentric.z|(id_and_barycentric.w<<uint(16))));
float3 brc=float3((1.0-brc_vw.x)-brc_vw.y,brc_vw);
float2 param_1=z_rayDirections.read(uint2(screenPos),0).xy;
float3 l9_1=float3(param_1.x,param_1.y,(1.0-abs(param_1.x))-abs(param_1.y));
float l9_2=fast::clamp(-l9_1.z,0.0,1.0);
float l9_3;
if (l9_1.x>=0.0)
{
l9_3=-l9_2;
}
else
{
l9_3=l9_2;
}
float l9_4=l9_3;
float l9_5;
if (l9_1.y>=0.0)
{
l9_5=-l9_2;
}
else
{
l9_5=l9_2;
}
float2 l9_6=l9_1.xy+float2(l9_4,l9_5);
l9_1=float3(l9_6.x,l9_6.y,l9_1.z);
float3 l9_7=normalize(l9_1);
float3 rayDir=l9_7;
rhp.viewDirWS=-rayDir;
uint param_2=rhp.id.y;
uint l9_8=min(param_2,uint(UserUniforms.lray_triangles_last));
uint l9_9=l9_8*6u;
uint l9_10=l9_9&4294967292u;
uint4 l9_11=(uint4(uint2(layoutIndices._Triangles[l9_10/4u]),uint2(layoutIndices._Triangles[(l9_10/4u)+1u]))&uint4(65535u,4294967295u,65535u,4294967295u))>>uint4(0u,16u,0u,16u);
int3 l9_12;
if (l9_9==l9_10)
{
l9_12=int3(l9_11.xyz);
}
else
{
l9_12=int3(l9_11.yzw);
}
int3 l9_13=l9_12;
int3 i=l9_13;
if (UserUniforms.has_animated_pn!=0)
{
float3 param_3=brc;
int3 param_4=i;
int param_5=0;
int3 l9_14=(param_4*int3(6))+int3(param_5);
int l9_15=l9_14.x;
float3 l9_16=float3(layoutVerticesPN._VerticesPN[l9_15],layoutVerticesPN._VerticesPN[l9_15+1],layoutVerticesPN._VerticesPN[l9_15+2]);
int l9_17=l9_14.y;
float3 l9_18=float3(layoutVerticesPN._VerticesPN[l9_17],layoutVerticesPN._VerticesPN[l9_17+1],layoutVerticesPN._VerticesPN[l9_17+2]);
int l9_19=l9_14.z;
float3 l9_20=float3(layoutVerticesPN._VerticesPN[l9_19],layoutVerticesPN._VerticesPN[l9_19+1],layoutVerticesPN._VerticesPN[l9_19+2]);
float3 l9_21=((l9_16*param_3.x)+(l9_18*param_3.y))+(l9_20*param_3.z);
rhp.positionWS=l9_21;
}
else
{
float3 param_6=brc;
int3 param_7=i;
int3 l9_22=int3((param_7.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position,(param_7.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position,(param_7.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_position);
float3 l9_23=float3(0.0);
if (UserUniforms.proxy_format_position==5)
{
int l9_24=l9_22.x;
float3 l9_25=float3(layoutVertices._Vertices[l9_24],layoutVertices._Vertices[l9_24+1],layoutVertices._Vertices[l9_24+2]);
int l9_26=l9_22.y;
float3 l9_27=float3(layoutVertices._Vertices[l9_26],layoutVertices._Vertices[l9_26+1],layoutVertices._Vertices[l9_26+2]);
int l9_28=l9_22.z;
float3 l9_29=float3(layoutVertices._Vertices[l9_28],layoutVertices._Vertices[l9_28+1],layoutVertices._Vertices[l9_28+2]);
l9_23=((l9_25*param_6.x)+(l9_27*param_6.y))+(l9_29*param_6.z);
}
else
{
if (UserUniforms.proxy_format_position==6)
{
int l9_30=l9_22.x;
float3 l9_31=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_30]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_30+1]))).x);
int l9_32=l9_22.y;
float3 l9_33=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_32]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_32+1]))).x);
int l9_34=l9_22.z;
float3 l9_35=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_34]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_34+1]))).x);
l9_23=((l9_31*param_6.x)+(l9_33*param_6.y))+(l9_35*param_6.z);
}
else
{
l9_23=float3(1.0,0.0,0.0);
}
}
float3 l9_36=l9_23;
float3 positionOS=l9_36;
rhp.positionWS=(UserUniforms.sc_ModelMatrix*float4(positionOS,1.0)).xyz;
}
if (UserUniforms.proxy_offset_normal>0)
{
if (UserUniforms.has_animated_pn!=0)
{
float3 param_8=brc;
int3 param_9=i;
int param_10=3;
int3 l9_37=(param_9*int3(6))+int3(param_10);
int l9_38=l9_37.x;
float3 l9_39=float3(layoutVerticesPN._VerticesPN[l9_38],layoutVerticesPN._VerticesPN[l9_38+1],layoutVerticesPN._VerticesPN[l9_38+2]);
int l9_40=l9_37.y;
float3 l9_41=float3(layoutVerticesPN._VerticesPN[l9_40],layoutVerticesPN._VerticesPN[l9_40+1],layoutVerticesPN._VerticesPN[l9_40+2]);
int l9_42=l9_37.z;
float3 l9_43=float3(layoutVerticesPN._VerticesPN[l9_42],layoutVerticesPN._VerticesPN[l9_42+1],layoutVerticesPN._VerticesPN[l9_42+2]);
float3 l9_44=((l9_39*param_8.x)+(l9_41*param_8.y))+(l9_43*param_8.z);
rhp.normalWS=l9_44;
}
else
{
float3 param_11=brc;
int3 param_12=i;
int3 l9_45=int3((param_12.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal,(param_12.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal,(param_12.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_normal);
float3 l9_46=float3(0.0);
if (UserUniforms.proxy_format_normal==5)
{
int l9_47=l9_45.x;
float3 l9_48=float3(layoutVertices._Vertices[l9_47],layoutVertices._Vertices[l9_47+1],layoutVertices._Vertices[l9_47+2]);
int l9_49=l9_45.y;
float3 l9_50=float3(layoutVertices._Vertices[l9_49],layoutVertices._Vertices[l9_49+1],layoutVertices._Vertices[l9_49+2]);
int l9_51=l9_45.z;
float3 l9_52=float3(layoutVertices._Vertices[l9_51],layoutVertices._Vertices[l9_51+1],layoutVertices._Vertices[l9_51+2]);
l9_46=((l9_48*param_11.x)+(l9_50*param_11.y))+(l9_52*param_11.z);
}
else
{
if (UserUniforms.proxy_format_normal==6)
{
int l9_53=l9_45.x;
float3 l9_54=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_53]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_53+1]))).x);
int l9_55=l9_45.y;
float3 l9_56=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_55]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_55+1]))).x);
int l9_57=l9_45.z;
float3 l9_58=float3(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_57]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_57+1]))).x);
l9_46=((l9_54*param_11.x)+(l9_56*param_11.y))+(l9_58*param_11.z);
}
else
{
l9_46=float3(1.0,0.0,0.0);
}
}
float3 l9_59=l9_46;
float3 normalOS=l9_59;
rhp.normalWS=normalize(UserUniforms.sc_NormalMatrix*normalOS);
}
}
else
{
rhp.normalWS=float3(1.0,0.0,0.0);
}
bool l9_60=!(UserUniforms.has_animated_pn!=0);
bool l9_61;
if (l9_60)
{
l9_61=UserUniforms.proxy_offset_tangent>0;
}
else
{
l9_61=l9_60;
}
if (l9_61)
{
float3 param_13=brc;
int3 param_14=i;
int3 l9_62=int3((param_14.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent,(param_14.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent,(param_14.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_tangent);
float4 l9_63=float4(0.0);
if (UserUniforms.proxy_format_tangent==5)
{
int l9_64=l9_62.x;
float4 l9_65=float4(layoutVertices._Vertices[l9_64],layoutVertices._Vertices[l9_64+1],layoutVertices._Vertices[l9_64+2],layoutVertices._Vertices[l9_64+3]);
int l9_66=l9_62.y;
float4 l9_67=float4(layoutVertices._Vertices[l9_66],layoutVertices._Vertices[l9_66+1],layoutVertices._Vertices[l9_66+2],layoutVertices._Vertices[l9_66+3]);
int l9_68=l9_62.z;
float4 l9_69=float4(layoutVertices._Vertices[l9_68],layoutVertices._Vertices[l9_68+1],layoutVertices._Vertices[l9_68+2],layoutVertices._Vertices[l9_68+3]);
l9_63=((l9_65*param_13.x)+(l9_67*param_13.y))+(l9_69*param_13.z);
}
else
{
if (UserUniforms.proxy_format_tangent==6)
{
int l9_70=l9_62.x;
float4 l9_71=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_70]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_70+1]))));
int l9_72=l9_62.y;
float4 l9_73=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_72]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_72+1]))));
int l9_74=l9_62.z;
float4 l9_75=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_74]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_74+1]))));
l9_63=((l9_71*param_13.x)+(l9_73*param_13.y))+(l9_75*param_13.z);
}
else
{
if (UserUniforms.proxy_format_tangent==2)
{
int l9_76=l9_62.x;
uint l9_77=as_type<uint>(layoutVertices._Vertices[l9_76]);
uint l9_78=l9_77&255u;
uint l9_79=(l9_77>>uint(8))&255u;
uint l9_80=(l9_77>>uint(16))&255u;
uint l9_81=(l9_77>>uint(24))&255u;
float4 l9_82=float4(float(l9_78),float(l9_79),float(l9_80),float(l9_81))/float4(255.0);
int l9_83=l9_62.y;
uint l9_84=as_type<uint>(layoutVertices._Vertices[l9_83]);
uint l9_85=l9_84&255u;
uint l9_86=(l9_84>>uint(8))&255u;
uint l9_87=(l9_84>>uint(16))&255u;
uint l9_88=(l9_84>>uint(24))&255u;
float4 l9_89=float4(float(l9_85),float(l9_86),float(l9_87),float(l9_88))/float4(255.0);
int l9_90=l9_62.z;
uint l9_91=as_type<uint>(layoutVertices._Vertices[l9_90]);
uint l9_92=l9_91&255u;
uint l9_93=(l9_91>>uint(8))&255u;
uint l9_94=(l9_91>>uint(16))&255u;
uint l9_95=(l9_91>>uint(24))&255u;
float4 l9_96=float4(float(l9_92),float(l9_93),float(l9_94),float(l9_95))/float4(255.0);
l9_63=((l9_82*param_13.x)+(l9_89*param_13.y))+(l9_96*param_13.z);
}
else
{
l9_63=float4(1.0,0.0,0.0,0.0);
}
}
}
float4 l9_97=l9_63;
float4 tangentOS=l9_97;
float3 tangentWS=normalize(UserUniforms.sc_NormalMatrix*tangentOS.xyz);
rhp.tangentWS=float4(tangentWS,tangentOS.w);
}
else
{
rhp.tangentWS=float4(1.0,0.0,0.0,1.0);
}
if (UserUniforms.proxy_format_color>0)
{
float3 param_15=brc;
int3 param_16=i;
int3 l9_98=int3((param_16.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color,(param_16.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color,(param_16.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_color);
float4 l9_99=float4(0.0);
if (UserUniforms.proxy_format_color==5)
{
int l9_100=l9_98.x;
float4 l9_101=float4(layoutVertices._Vertices[l9_100],layoutVertices._Vertices[l9_100+1],layoutVertices._Vertices[l9_100+2],layoutVertices._Vertices[l9_100+3]);
int l9_102=l9_98.y;
float4 l9_103=float4(layoutVertices._Vertices[l9_102],layoutVertices._Vertices[l9_102+1],layoutVertices._Vertices[l9_102+2],layoutVertices._Vertices[l9_102+3]);
int l9_104=l9_98.z;
float4 l9_105=float4(layoutVertices._Vertices[l9_104],layoutVertices._Vertices[l9_104+1],layoutVertices._Vertices[l9_104+2],layoutVertices._Vertices[l9_104+3]);
l9_99=((l9_101*param_15.x)+(l9_103*param_15.y))+(l9_105*param_15.z);
}
else
{
if (UserUniforms.proxy_format_color==6)
{
int l9_106=l9_98.x;
float4 l9_107=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_106]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_106+1]))));
int l9_108=l9_98.y;
float4 l9_109=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_108]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_108+1]))));
int l9_110=l9_98.z;
float4 l9_111=float4(float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_110]))),float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_110+1]))));
l9_99=((l9_107*param_15.x)+(l9_109*param_15.y))+(l9_111*param_15.z);
}
else
{
if (UserUniforms.proxy_format_color==2)
{
int l9_112=l9_98.x;
uint l9_113=as_type<uint>(layoutVertices._Vertices[l9_112]);
uint l9_114=l9_113&255u;
uint l9_115=(l9_113>>uint(8))&255u;
uint l9_116=(l9_113>>uint(16))&255u;
uint l9_117=(l9_113>>uint(24))&255u;
float4 l9_118=float4(float(l9_114),float(l9_115),float(l9_116),float(l9_117))/float4(255.0);
int l9_119=l9_98.y;
uint l9_120=as_type<uint>(layoutVertices._Vertices[l9_119]);
uint l9_121=l9_120&255u;
uint l9_122=(l9_120>>uint(8))&255u;
uint l9_123=(l9_120>>uint(16))&255u;
uint l9_124=(l9_120>>uint(24))&255u;
float4 l9_125=float4(float(l9_121),float(l9_122),float(l9_123),float(l9_124))/float4(255.0);
int l9_126=l9_98.z;
uint l9_127=as_type<uint>(layoutVertices._Vertices[l9_126]);
uint l9_128=l9_127&255u;
uint l9_129=(l9_127>>uint(8))&255u;
uint l9_130=(l9_127>>uint(16))&255u;
uint l9_131=(l9_127>>uint(24))&255u;
float4 l9_132=float4(float(l9_128),float(l9_129),float(l9_130),float(l9_131))/float4(255.0);
l9_99=((l9_118*param_15.x)+(l9_125*param_15.y))+(l9_132*param_15.z);
}
else
{
l9_99=float4(1.0,0.0,0.0,0.0);
}
}
}
float4 l9_133=l9_99;
rhp.color=l9_133;
}
float2 dummy_red_black=float2(dot(brc,float3(int3(1)-(i%int3(2)))),0.0);
if (UserUniforms.proxy_format_texture0>0)
{
float3 param_17=brc;
int3 param_18=i;
int3 l9_134=int3((param_18.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0,(param_18.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0,(param_18.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture0);
float2 l9_135=float2(0.0);
if (UserUniforms.proxy_format_texture0==5)
{
int l9_136=l9_134.x;
float2 l9_137=float2(layoutVertices._Vertices[l9_136],layoutVertices._Vertices[l9_136+1]);
int l9_138=l9_134.y;
float2 l9_139=float2(layoutVertices._Vertices[l9_138],layoutVertices._Vertices[l9_138+1]);
int l9_140=l9_134.z;
float2 l9_141=float2(layoutVertices._Vertices[l9_140],layoutVertices._Vertices[l9_140+1]);
l9_135=((l9_137*param_17.x)+(l9_139*param_17.y))+(l9_141*param_17.z);
}
else
{
if (UserUniforms.proxy_format_texture0==6)
{
int l9_142=l9_134.x;
float2 l9_143=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_142])));
int l9_144=l9_134.y;
float2 l9_145=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_144])));
int l9_146=l9_134.z;
float2 l9_147=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_146])));
l9_135=((l9_143*param_17.x)+(l9_145*param_17.y))+(l9_147*param_17.z);
}
else
{
l9_135=float2(1.0,0.0);
}
}
float2 l9_148=l9_135;
rhp.uv0=l9_148;
}
else
{
rhp.uv0=dummy_red_black;
}
if (UserUniforms.proxy_format_texture1>0)
{
float3 param_19=brc;
int3 param_20=i;
int3 l9_149=int3((param_20.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1,(param_20.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1,(param_20.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture1);
float2 l9_150=float2(0.0);
if (UserUniforms.proxy_format_texture1==5)
{
int l9_151=l9_149.x;
float2 l9_152=float2(layoutVertices._Vertices[l9_151],layoutVertices._Vertices[l9_151+1]);
int l9_153=l9_149.y;
float2 l9_154=float2(layoutVertices._Vertices[l9_153],layoutVertices._Vertices[l9_153+1]);
int l9_155=l9_149.z;
float2 l9_156=float2(layoutVertices._Vertices[l9_155],layoutVertices._Vertices[l9_155+1]);
l9_150=((l9_152*param_19.x)+(l9_154*param_19.y))+(l9_156*param_19.z);
}
else
{
if (UserUniforms.proxy_format_texture1==6)
{
int l9_157=l9_149.x;
float2 l9_158=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_157])));
int l9_159=l9_149.y;
float2 l9_160=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_159])));
int l9_161=l9_149.z;
float2 l9_162=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_161])));
l9_150=((l9_158*param_19.x)+(l9_160*param_19.y))+(l9_162*param_19.z);
}
else
{
l9_150=float2(1.0,0.0);
}
}
float2 l9_163=l9_150;
rhp.uv1=l9_163;
}
else
{
rhp.uv1=dummy_red_black;
}
if (UserUniforms.proxy_format_texture2>0)
{
float3 param_21=brc;
int3 param_22=i;
int3 l9_164=int3((param_22.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2,(param_22.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2,(param_22.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture2);
float2 l9_165=float2(0.0);
if (UserUniforms.proxy_format_texture2==5)
{
int l9_166=l9_164.x;
float2 l9_167=float2(layoutVertices._Vertices[l9_166],layoutVertices._Vertices[l9_166+1]);
int l9_168=l9_164.y;
float2 l9_169=float2(layoutVertices._Vertices[l9_168],layoutVertices._Vertices[l9_168+1]);
int l9_170=l9_164.z;
float2 l9_171=float2(layoutVertices._Vertices[l9_170],layoutVertices._Vertices[l9_170+1]);
l9_165=((l9_167*param_21.x)+(l9_169*param_21.y))+(l9_171*param_21.z);
}
else
{
if (UserUniforms.proxy_format_texture2==6)
{
int l9_172=l9_164.x;
float2 l9_173=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_172])));
int l9_174=l9_164.y;
float2 l9_175=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_174])));
int l9_176=l9_164.z;
float2 l9_177=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_176])));
l9_165=((l9_173*param_21.x)+(l9_175*param_21.y))+(l9_177*param_21.z);
}
else
{
l9_165=float2(1.0,0.0);
}
}
float2 l9_178=l9_165;
rhp.uv2=l9_178;
}
else
{
rhp.uv2=dummy_red_black;
}
if (UserUniforms.proxy_format_texture3>0)
{
float3 param_23=brc;
int3 param_24=i;
int3 l9_179=int3((param_24.x*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3,(param_24.y*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3,(param_24.z*UserUniforms.emitter_stride)+UserUniforms.proxy_offset_texture3);
float2 l9_180=float2(0.0);
if (UserUniforms.proxy_format_texture3==5)
{
int l9_181=l9_179.x;
float2 l9_182=float2(layoutVertices._Vertices[l9_181],layoutVertices._Vertices[l9_181+1]);
int l9_183=l9_179.y;
float2 l9_184=float2(layoutVertices._Vertices[l9_183],layoutVertices._Vertices[l9_183+1]);
int l9_185=l9_179.z;
float2 l9_186=float2(layoutVertices._Vertices[l9_185],layoutVertices._Vertices[l9_185+1]);
l9_180=((l9_182*param_23.x)+(l9_184*param_23.y))+(l9_186*param_23.z);
}
else
{
if (UserUniforms.proxy_format_texture3==6)
{
int l9_187=l9_179.x;
float2 l9_188=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_187])));
int l9_189=l9_179.y;
float2 l9_190=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_189])));
int l9_191=l9_179.z;
float2 l9_192=float2(as_type<half2>(as_type<uint>(layoutVertices._Vertices[l9_191])));
l9_180=((l9_188*param_23.x)+(l9_190*param_23.y))+(l9_192*param_23.z);
}
else
{
l9_180=float2(1.0,0.0);
}
}
float2 l9_193=l9_180;
rhp.uv3=l9_193;
}
else
{
rhp.uv3=dummy_red_black;
}
return rhp;
}
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
float4 outputMotionVectorsIfNeeded(thread const float3& surfacePosWorldSpace,thread const float4& finalColor,thread int& varStereoViewID,constant userUniformsObj& UserUniforms)
{
if ((int(sc_MotionVectorsPass_tmp)!=0))
{
float3 param=surfacePosWorldSpace;
int l9_0=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_0=0;
}
else
{
l9_0=varStereoViewID;
}
int l9_1=l9_0;
float4 l9_2=UserUniforms.sc_ViewProjectionMatrixArray[l9_1]*float4(param,1.0);
float2 l9_3=l9_2.xy/float2(l9_2.w);
l9_2=float4(l9_3.x,l9_3.y,l9_2.z,l9_2.w);
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
float4 l9_6=((UserUniforms.sc_PrevFrameViewProjectionMatrixArray[l9_5]*UserUniforms.sc_PrevFrameModelMatrix)*UserUniforms.sc_ModelMatrixInverse)*float4(param,1.0);
float2 l9_7=l9_6.xy/float2(l9_6.w);
l9_6=float4(l9_7.x,l9_7.y,l9_6.z,l9_6.w);
float2 l9_8=(l9_2.xy-l9_6.xy)*0.5;
float2 l9_9=l9_8;
float l9_10=(l9_9.x*5.0)+0.5;
float l9_11=floor(l9_10*65535.0);
float l9_12=floor(l9_11*0.00390625);
float2 l9_13=float2(l9_12/255.0,(l9_11-(l9_12*256.0))/255.0);
float l9_14=(l9_9.y*5.0)+0.5;
float l9_15=floor(l9_14*65535.0);
float l9_16=floor(l9_15*0.00390625);
float2 l9_17=float2(l9_16/255.0,(l9_15-(l9_16*256.0))/255.0);
float4 l9_18=float4(l9_13,l9_17);
float4 l9_19=l9_18;
return l9_19;
}
else
{
return finalColor;
}
}
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_frag_out out={};
if ((int(sc_DepthOnly_tmp)!=0))
{
return out;
}
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=in.PreviewVertexColor;
PreviewInfo.Saved=((in.PreviewVertexSaved*1.0)!=0.0) ? true : false;
float4 FinalColor=float4(1.0);
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
l9_1=(*sc_set2.UserUniforms).sc_Time.y;
}
Globals.gTimeDelta=l9_1;
bool l9_2=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_2)
{
float4 l9_3=gl_FragCoord;
int2 l9_4=int2(l9_3.xy);
RayHitPayload l9_5=GetHitData(l9_4,(*sc_set2.UserUniforms),sc_set2.z_rayDirections,sc_set2.z_rayDirectionsSmpSC,sc_set2.z_hitIdAndBarycentric,sc_set2.z_hitIdAndBarycentricSmp,(*sc_set2.layoutVertices),(*sc_set2.layoutVerticesPN),(*sc_set2.layoutIndices));
RayHitPayload rhp=l9_5;
bool l9_6=(*sc_set2.UserUniforms).noEarlyZ!=0;
if (l9_6)
{
if (rhp.id.x!=uint((*sc_set2.UserUniforms).instance_id))
{
return out;
}
}
Globals.Surface_UVCoord0=rhp.uv0;
}
else
{
Globals.Surface_UVCoord0=in.varPackedTex.xy;
}
float4 Result_N33=float4(0.0);
float param=0.0;
float4 param_1=float4(0.0);
float4 param_2=float4(0.0);
ssGlobals param_4=Globals;
float l9_7=0.0;
float l9_8=float((*sc_set2.UserUniforms).useTexture!=0);
l9_7=l9_8;
param=l9_7;
float4 param_3;
if ((param*1.0)!=0.0)
{
float2 l9_9=float2(0.0);
float l9_10=0.0;
float2 l9_11=float2(0.0);
float2 l9_12=(*sc_set2.UserUniforms).Port_Default_N010;
ssGlobals l9_13=param_4;
float2 l9_14=float2(0.0);
l9_14=l9_13.Surface_UVCoord0;
float2 l9_15=float2(0.0);
l9_15=(((l9_14-float2((*sc_set2.UserUniforms).Port_RangeMinA_N013))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N013-(*sc_set2.UserUniforms).Port_RangeMinA_N013))*((*sc_set2.UserUniforms).Port_RangeMaxB_N013-(*sc_set2.UserUniforms).Port_RangeMinB_N013))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N013);
float l9_16=0.0;
float l9_17=(*sc_set2.UserUniforms).Port_Value_N164;
float l9_18=l9_17+0.001;
l9_18-=0.001;
l9_16=l9_18;
float l9_19=0.0;
float l9_20=(*sc_set2.UserUniforms).circleSquishScale;
l9_19=l9_20;
float l9_21=0.0;
float l9_22=l9_19;
float l9_23=(*sc_set2.UserUniforms).Port_RangeMinA_N161;
float l9_24=(*sc_set2.UserUniforms).Port_RangeMaxA_N161;
float l9_25=(*sc_set2.UserUniforms).Port_RangeMinB_N161;
float l9_26=(*sc_set2.UserUniforms).Port_RangeMaxB_N161;
float l9_27=(((l9_22-l9_23)/(l9_24-l9_23))*(l9_26-l9_25))+l9_25;
float l9_28;
if (l9_26>l9_25)
{
l9_28=fast::clamp(l9_27,l9_25,l9_26);
}
else
{
l9_28=fast::clamp(l9_27,l9_26,l9_25);
}
l9_27=l9_28;
l9_21=l9_27;
float l9_29=0.0;
l9_29=l9_16/(l9_21+1.234e-06);
float2 l9_30=float2(0.0);
l9_30.x=l9_29;
l9_30.y=l9_29;
float2 l9_31=float2(0.0);
l9_31=((l9_15-(*sc_set2.UserUniforms).Port_Center_N019)*l9_30)+(*sc_set2.UserUniforms).Port_Center_N019;
float2 l9_32=float2(0.0);
l9_32=l9_31+(*sc_set2.UserUniforms).Port_Input1_N020;
float l9_33=0.0;
float l9_34=0.0;
float2 l9_35=l9_32;
float l9_36=l9_35.x;
float l9_37=l9_35.y;
l9_33=l9_36;
l9_34=l9_37;
float l9_38=0.0;
l9_38=float(l9_33>=(*sc_set2.UserUniforms).Port_Input1_N027);
float l9_39=0.0;
l9_39=float(l9_33<=(*sc_set2.UserUniforms).Port_Input1_N026);
float l9_40=0.0;
float l9_41=l9_38;
bool l9_42=(l9_41*1.0)!=0.0;
bool l9_43;
if (l9_42)
{
l9_43=(l9_39*1.0)!=0.0;
}
else
{
l9_43=l9_42;
}
l9_40=float(l9_43);
float l9_44=0.0;
l9_44=float(l9_34>=(*sc_set2.UserUniforms).Port_Input1_N028);
float l9_45=0.0;
l9_45=float(l9_34<=(*sc_set2.UserUniforms).Port_Input1_N029);
float l9_46=0.0;
float l9_47=l9_44;
bool l9_48=(l9_47*1.0)!=0.0;
bool l9_49;
if (l9_48)
{
l9_49=(l9_45*1.0)!=0.0;
}
else
{
l9_49=l9_48;
}
l9_46=float(l9_49);
float l9_50=0.0;
float l9_51=l9_40;
bool l9_52=(l9_51*1.0)!=0.0;
bool l9_53;
if (l9_52)
{
l9_53=(l9_46*1.0)!=0.0;
}
else
{
l9_53=l9_52;
}
l9_50=float(l9_53);
l9_10=l9_50;
float2 l9_54;
if ((l9_10*1.0)!=0.0)
{
float2 l9_55=float2(0.0);
l9_55=l9_13.Surface_UVCoord0;
float2 l9_56=float2(0.0);
l9_56=(((l9_55-float2((*sc_set2.UserUniforms).Port_RangeMinA_N013))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N013-(*sc_set2.UserUniforms).Port_RangeMinA_N013))*((*sc_set2.UserUniforms).Port_RangeMaxB_N013-(*sc_set2.UserUniforms).Port_RangeMinB_N013))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N013);
float l9_57=0.0;
float l9_58=(*sc_set2.UserUniforms).Port_Value_N164;
float l9_59=l9_58+0.001;
l9_59-=0.001;
l9_57=l9_59;
float l9_60=0.0;
float l9_61=(*sc_set2.UserUniforms).circleSquishScale;
l9_60=l9_61;
float l9_62=0.0;
float l9_63=l9_60;
float l9_64=(*sc_set2.UserUniforms).Port_RangeMinA_N161;
float l9_65=(*sc_set2.UserUniforms).Port_RangeMaxA_N161;
float l9_66=(*sc_set2.UserUniforms).Port_RangeMinB_N161;
float l9_67=(*sc_set2.UserUniforms).Port_RangeMaxB_N161;
float l9_68=(((l9_63-l9_64)/(l9_65-l9_64))*(l9_67-l9_66))+l9_66;
float l9_69;
if (l9_67>l9_66)
{
l9_69=fast::clamp(l9_68,l9_66,l9_67);
}
else
{
l9_69=fast::clamp(l9_68,l9_67,l9_66);
}
l9_68=l9_69;
l9_62=l9_68;
float l9_70=0.0;
l9_70=l9_57/(l9_62+1.234e-06);
float2 l9_71=float2(0.0);
l9_71.x=l9_70;
l9_71.y=l9_70;
float2 l9_72=float2(0.0);
l9_72=((l9_56-(*sc_set2.UserUniforms).Port_Center_N019)*l9_71)+(*sc_set2.UserUniforms).Port_Center_N019;
float2 l9_73=float2(0.0);
l9_73=l9_72+(*sc_set2.UserUniforms).Port_Input1_N020;
l9_11=l9_73;
l9_54=l9_11;
}
else
{
l9_54=l9_12;
}
l9_9=l9_54;
float4 l9_74=float4(0.0);
int l9_75=0;
if ((int(cursorTextureHasSwappedViews_tmp)!=0))
{
int l9_76=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_76=0;
}
else
{
l9_76=in.varStereoViewID;
}
int l9_77=l9_76;
l9_75=1-l9_77;
}
else
{
int l9_78=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_78=0;
}
else
{
l9_78=in.varStereoViewID;
}
int l9_79=l9_78;
l9_75=l9_79;
}
int l9_80=l9_75;
int l9_81=cursorTextureLayout_tmp;
int l9_82=l9_80;
float2 l9_83=l9_9;
bool l9_84=(int(SC_USE_UV_TRANSFORM_cursorTexture_tmp)!=0);
float3x3 l9_85=(*sc_set2.UserUniforms).cursorTextureTransform;
int2 l9_86=int2(SC_SOFTWARE_WRAP_MODE_U_cursorTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_cursorTexture_tmp);
bool l9_87=(int(SC_USE_UV_MIN_MAX_cursorTexture_tmp)!=0);
float4 l9_88=(*sc_set2.UserUniforms).cursorTextureUvMinMax;
bool l9_89=(int(SC_USE_CLAMP_TO_BORDER_cursorTexture_tmp)!=0);
float4 l9_90=(*sc_set2.UserUniforms).cursorTextureBorderColor;
float l9_91=0.0;
bool l9_92=l9_89&&(!l9_87);
float l9_93=1.0;
float l9_94=l9_83.x;
int l9_95=l9_86.x;
if (l9_95==1)
{
l9_94=fract(l9_94);
}
else
{
if (l9_95==2)
{
float l9_96=fract(l9_94);
float l9_97=l9_94-l9_96;
float l9_98=step(0.25,fract(l9_97*0.5));
l9_94=mix(l9_96,1.0-l9_96,fast::clamp(l9_98,0.0,1.0));
}
}
l9_83.x=l9_94;
float l9_99=l9_83.y;
int l9_100=l9_86.y;
if (l9_100==1)
{
l9_99=fract(l9_99);
}
else
{
if (l9_100==2)
{
float l9_101=fract(l9_99);
float l9_102=l9_99-l9_101;
float l9_103=step(0.25,fract(l9_102*0.5));
l9_99=mix(l9_101,1.0-l9_101,fast::clamp(l9_103,0.0,1.0));
}
}
l9_83.y=l9_99;
if (l9_87)
{
bool l9_104=l9_89;
bool l9_105;
if (l9_104)
{
l9_105=l9_86.x==3;
}
else
{
l9_105=l9_104;
}
float l9_106=l9_83.x;
float l9_107=l9_88.x;
float l9_108=l9_88.z;
bool l9_109=l9_105;
float l9_110=l9_93;
float l9_111=fast::clamp(l9_106,l9_107,l9_108);
float l9_112=step(abs(l9_106-l9_111),9.9999997e-06);
l9_110*=(l9_112+((1.0-float(l9_109))*(1.0-l9_112)));
l9_106=l9_111;
l9_83.x=l9_106;
l9_93=l9_110;
bool l9_113=l9_89;
bool l9_114;
if (l9_113)
{
l9_114=l9_86.y==3;
}
else
{
l9_114=l9_113;
}
float l9_115=l9_83.y;
float l9_116=l9_88.y;
float l9_117=l9_88.w;
bool l9_118=l9_114;
float l9_119=l9_93;
float l9_120=fast::clamp(l9_115,l9_116,l9_117);
float l9_121=step(abs(l9_115-l9_120),9.9999997e-06);
l9_119*=(l9_121+((1.0-float(l9_118))*(1.0-l9_121)));
l9_115=l9_120;
l9_83.y=l9_115;
l9_93=l9_119;
}
float2 l9_122=l9_83;
bool l9_123=l9_84;
float3x3 l9_124=l9_85;
if (l9_123)
{
l9_122=float2((l9_124*float3(l9_122,1.0)).xy);
}
float2 l9_125=l9_122;
float2 l9_126=l9_125;
float2 l9_127=l9_126;
l9_83=l9_127;
float l9_128=l9_83.x;
int l9_129=l9_86.x;
bool l9_130=l9_92;
float l9_131=l9_93;
if ((l9_129==0)||(l9_129==3))
{
float l9_132=l9_128;
float l9_133=0.0;
float l9_134=1.0;
bool l9_135=l9_130;
float l9_136=l9_131;
float l9_137=fast::clamp(l9_132,l9_133,l9_134);
float l9_138=step(abs(l9_132-l9_137),9.9999997e-06);
l9_136*=(l9_138+((1.0-float(l9_135))*(1.0-l9_138)));
l9_132=l9_137;
l9_128=l9_132;
l9_131=l9_136;
}
l9_83.x=l9_128;
l9_93=l9_131;
float l9_139=l9_83.y;
int l9_140=l9_86.y;
bool l9_141=l9_92;
float l9_142=l9_93;
if ((l9_140==0)||(l9_140==3))
{
float l9_143=l9_139;
float l9_144=0.0;
float l9_145=1.0;
bool l9_146=l9_141;
float l9_147=l9_142;
float l9_148=fast::clamp(l9_143,l9_144,l9_145);
float l9_149=step(abs(l9_143-l9_148),9.9999997e-06);
l9_147*=(l9_149+((1.0-float(l9_146))*(1.0-l9_149)));
l9_143=l9_148;
l9_139=l9_143;
l9_142=l9_147;
}
l9_83.y=l9_139;
l9_93=l9_142;
float2 l9_150=l9_83;
int l9_151=l9_81;
int l9_152=l9_82;
float l9_153=l9_91;
float2 l9_154=l9_150;
int l9_155=l9_151;
int l9_156=l9_152;
float3 l9_157=float3(0.0);
if (l9_155==0)
{
l9_157=float3(l9_154,0.0);
}
else
{
if (l9_155==1)
{
l9_157=float3(l9_154.x,(l9_154.y*0.5)+(0.5-(float(l9_156)*0.5)),0.0);
}
else
{
l9_157=float3(l9_154,float(l9_156));
}
}
float3 l9_158=l9_157;
float3 l9_159=l9_158;
float2 l9_160=l9_159.xy;
float l9_161=l9_153;
float4 l9_162=sc_set2.cursorTexture.sample(sc_set2.cursorTextureSmpSC,l9_160,bias(l9_161));
float4 l9_163=l9_162;
float4 l9_164=l9_163;
if (l9_89)
{
l9_164=mix(l9_90,l9_164,float4(l9_93));
}
float4 l9_165=l9_164;
l9_74=l9_165;
param_1=l9_74;
param_3=param_1;
}
else
{
float4 l9_166=float4(0.0);
float l9_167=0.0;
float4 l9_168=float4(0.0);
float l9_169=0.0;
float4 l9_170=float4(0.0);
float l9_171=0.0;
float4 l9_172=float4(0.0,0.0,0.0,1.0);
float4 l9_173=(*sc_set2.UserUniforms).Port_Default_N088;
ssGlobals l9_174=param_4;
float2 l9_175=float2(0.0);
l9_175=l9_174.Surface_UVCoord0;
float2 l9_176=float2(0.0);
l9_176=(((l9_175-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_177=float2(0.0);
l9_177=((l9_176-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_178=float2(0.0);
l9_178.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_178.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_179=0.0;
l9_179=distance(l9_177,l9_178);
float l9_180=0.0;
float l9_181=(*sc_set2.UserUniforms).circleSquishScale;
l9_180=l9_181;
float l9_182=0.0;
float l9_183=(*sc_set2.UserUniforms).Port_Value_N042;
float l9_184=l9_183+0.001;
l9_184-=0.001;
l9_182=l9_184;
float l9_185=0.0;
l9_185=l9_180*l9_182;
float l9_186=0.0;
l9_186=float(l9_179<l9_185);
l9_167=l9_186;
float l9_187=0.0;
float l9_188=0.0;
float l9_189=(*sc_set2.UserUniforms).Port_Value1_N131;
float l9_190=0.0;
float l9_191=(*sc_set2.UserUniforms).Port_Value2_N131;
float l9_192=0.0;
float l9_193=(*sc_set2.UserUniforms).Port_Value3_N131;
float l9_194=(*sc_set2.UserUniforms).Port_Default_N131;
ssGlobals l9_195=l9_174;
float2 l9_196=float2(0.0);
l9_196=l9_195.Surface_UVCoord0;
float2 l9_197=float2(0.0);
l9_197=(((l9_196-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_198=float2(0.0);
l9_198=((l9_197-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_199=float2(0.0);
l9_199.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_199.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_200=0.0;
l9_200=distance(l9_198,l9_199);
float l9_201=0.0;
float l9_202=(*sc_set2.UserUniforms).outlineOffset;
l9_201=l9_202;
float l9_203=0.0;
float l9_204=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_205=l9_204+0.001;
l9_205-=0.001;
l9_203=l9_205;
float l9_206=0.0;
l9_206=l9_201+l9_203;
float l9_207=0.0;
l9_207=float(l9_200<l9_206);
float l9_208=0.0;
float l9_209=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_210=l9_209+0.001;
l9_210-=0.001;
l9_208=l9_210;
float l9_211=0.0;
l9_211=l9_201+l9_208;
float l9_212=0.0;
l9_212=float(l9_200>l9_211);
float l9_213=0.0;
float l9_214=l9_207;
bool l9_215=(l9_214*1.0)!=0.0;
bool l9_216;
if (l9_215)
{
l9_216=(l9_212*1.0)!=0.0;
}
else
{
l9_216=l9_215;
}
l9_213=float(l9_216);
float l9_217=0.0;
float l9_218=0.0;
float2 l9_219=l9_198;
float l9_220=l9_219.x;
float l9_221=l9_219.y;
l9_217=l9_220;
l9_218=l9_221;
float l9_222=0.0;
l9_222=atan2(l9_218,l9_217);
float l9_223=0.0;
l9_223=3.1415927;
float l9_224=0.0;
l9_224=l9_223*(*sc_set2.UserUniforms).Port_Input1_N071;
float l9_225=0.0;
l9_225=l9_222+l9_224;
float l9_226=0.0;
l9_226=mod(l9_225,l9_224);
float l9_227=0.0;
l9_227=3.1415927;
float l9_228=0.0;
l9_228=l9_227*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_229=0.0;
l9_229=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_230=0.0;
float l9_231=float((*sc_set2.UserUniforms).handType);
l9_230=l9_231;
float l9_232=0.0;
l9_232=l9_229*l9_230;
float l9_233=0.0;
l9_233=radians(l9_232);
float l9_234=0.0;
l9_234=l9_228+l9_233;
float l9_235=0.0;
l9_235=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_236=0.0;
l9_236=radians(l9_235);
float l9_237=0.0;
l9_237=l9_236/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_238=0.0;
l9_238=l9_234+l9_237;
float l9_239=0.0;
l9_239=float(l9_226<l9_238);
float l9_240=0.0;
l9_240=l9_234-l9_237;
float l9_241=0.0;
l9_241=float(l9_226>l9_240);
float l9_242=0.0;
float l9_243=l9_239;
bool l9_244=(l9_243*1.0)!=0.0;
bool l9_245;
if (l9_244)
{
l9_245=(l9_241*1.0)!=0.0;
}
else
{
l9_245=l9_244;
}
l9_242=float(l9_245);
float l9_246=0.0;
l9_246=(l9_230==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_247=0.0;
float l9_248=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_247=l9_248;
float l9_249=0.0;
float l9_250=l9_246;
bool l9_251=(l9_250*1.0)!=0.0;
bool l9_252;
if (l9_251)
{
l9_252=(l9_247*1.0)!=0.0;
}
else
{
l9_252=l9_251;
}
l9_249=float(l9_252);
float l9_253=0.0;
float l9_254=l9_242;
bool l9_255=(l9_254*1.0)!=0.0;
bool l9_256;
if (l9_255)
{
l9_256=(l9_249*1.0)!=0.0;
}
else
{
l9_256=l9_255;
}
l9_253=float(l9_256);
float l9_257=0.0;
l9_257=((l9_253*1.0)!=0.0) ? 0.0 : 1.0;
float l9_258=0.0;
float l9_259=l9_213;
bool l9_260=(l9_259*1.0)!=0.0;
bool l9_261;
if (l9_260)
{
l9_261=(l9_257*1.0)!=0.0;
}
else
{
l9_261=l9_260;
}
l9_258=float(l9_261);
l9_188=l9_258;
float2 l9_262=float2(0.0);
l9_262=l9_195.Surface_UVCoord0;
float2 l9_263=float2(0.0);
l9_263=(((l9_262-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_264=float2(0.0);
l9_264=((l9_263-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_265=0.0;
float l9_266=(*sc_set2.UserUniforms).outlineOffset;
l9_265=l9_266;
float l9_267=0.0;
float l9_268=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_269=l9_268+0.001;
l9_269-=0.001;
l9_267=l9_269;
float l9_270=0.0;
l9_270=l9_265+l9_267;
float l9_271=0.0;
float l9_272=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_273=l9_272+0.001;
l9_273-=0.001;
l9_271=l9_273;
float l9_274=0.0;
l9_274=l9_265+l9_271;
float l9_275=0.0;
l9_275=l9_270+l9_274;
float l9_276=0.0;
l9_276=l9_275/((*sc_set2.UserUniforms).Port_Input1_N054+1.234e-06);
float2 l9_277=float2(0.0);
l9_277.x=l9_276;
l9_277.y=l9_276;
float l9_278=0.0;
l9_278=3.1415927;
float l9_279=0.0;
l9_279=l9_278*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_280=0.0;
l9_280=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_281=0.0;
float l9_282=float((*sc_set2.UserUniforms).handType);
l9_281=l9_282;
float l9_283=0.0;
l9_283=l9_280*l9_281;
float l9_284=0.0;
l9_284=radians(l9_283);
float l9_285=0.0;
l9_285=l9_279+l9_284;
float l9_286=0.0;
l9_286=cos(l9_285);
float l9_287=0.0;
l9_287=sin(l9_285);
float2 l9_288=float2(0.0);
l9_288.x=l9_286;
l9_288.y=l9_287;
float2 l9_289=float2(0.0);
l9_289=l9_277*l9_288;
float l9_290=0.0;
l9_290=distance(l9_264,l9_289);
float l9_291=0.0;
l9_291=l9_270-l9_274;
float l9_292=0.0;
float l9_293=(*sc_set2.UserUniforms).Port_Value_N068;
float l9_294=l9_293+0.001;
l9_294-=0.001;
l9_292=l9_294;
float l9_295=0.0;
l9_295=l9_291*l9_292;
float l9_296=0.0;
l9_296=float(l9_290<l9_295);
float l9_297=0.0;
l9_297=(l9_281==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_298=0.0;
float l9_299=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_298=l9_299;
float l9_300=0.0;
float l9_301=l9_297;
bool l9_302=(l9_301*1.0)!=0.0;
bool l9_303;
if (l9_302)
{
l9_303=(l9_298*1.0)!=0.0;
}
else
{
l9_303=l9_302;
}
l9_300=float(l9_303);
float l9_304=0.0;
float l9_305=l9_296;
bool l9_306=(l9_305*1.0)!=0.0;
bool l9_307;
if (l9_306)
{
l9_307=(l9_300*1.0)!=0.0;
}
else
{
l9_307=l9_306;
}
l9_304=float(l9_307);
l9_190=l9_304;
float2 l9_308=float2(0.0);
l9_308=l9_195.Surface_UVCoord0;
float2 l9_309=float2(0.0);
l9_309=(((l9_308-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_310=float2(0.0);
l9_310=((l9_309-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_311=0.0;
float l9_312=(*sc_set2.UserUniforms).outlineOffset;
l9_311=l9_312;
float l9_313=0.0;
float l9_314=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_315=l9_314+0.001;
l9_315-=0.001;
l9_313=l9_315;
float l9_316=0.0;
l9_316=l9_311+l9_313;
float l9_317=0.0;
float l9_318=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_319=l9_318+0.001;
l9_319-=0.001;
l9_317=l9_319;
float l9_320=0.0;
l9_320=l9_311+l9_317;
float l9_321=0.0;
l9_321=l9_316+l9_320;
float l9_322=0.0;
l9_322=l9_321/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_323=float2(0.0);
l9_323.x=l9_322;
l9_323.y=l9_322;
float l9_324=0.0;
l9_324=3.1415927;
float l9_325=0.0;
l9_325=l9_324*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_326=0.0;
l9_326=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_327=0.0;
float l9_328=float((*sc_set2.UserUniforms).handType);
l9_327=l9_328;
float l9_329=0.0;
l9_329=l9_326*l9_327;
float l9_330=0.0;
l9_330=radians(l9_329);
float l9_331=0.0;
l9_331=l9_325+l9_330;
float l9_332=0.0;
l9_332=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_333=0.0;
l9_333=radians(l9_332);
float l9_334=0.0;
l9_334=l9_333/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_335=0.0;
l9_335=l9_331+l9_334;
float l9_336=0.0;
l9_336=cos(l9_335);
float l9_337=0.0;
l9_337=sin(l9_335);
float2 l9_338=float2(0.0);
l9_338.x=l9_336;
l9_338.y=l9_337;
float2 l9_339=float2(0.0);
l9_339=l9_323*l9_338;
float l9_340=0.0;
l9_340=distance(l9_310,l9_339);
float l9_341=0.0;
l9_341=l9_316-l9_320;
float l9_342=0.0;
l9_342=l9_341/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_343=0.0;
l9_343=float(l9_340<l9_342);
float l9_344=0.0;
l9_344=l9_331-l9_334;
float l9_345=0.0;
l9_345=cos(l9_344);
float l9_346=0.0;
l9_346=sin(l9_344);
float2 l9_347=float2(0.0);
l9_347.x=l9_345;
l9_347.y=l9_346;
float2 l9_348=float2(0.0);
l9_348=l9_323*l9_347;
float l9_349=0.0;
l9_349=distance(l9_310,l9_348);
float l9_350=0.0;
l9_350=float(l9_349<l9_342);
float l9_351=0.0;
float l9_352=l9_343;
bool l9_353=(l9_352*1.0)!=0.0;
bool l9_354;
if (!l9_353)
{
l9_354=(l9_350*1.0)!=0.0;
}
else
{
l9_354=l9_353;
}
l9_351=float(l9_354);
l9_192=l9_351;
float l9_355;
if ((l9_188*1.0)!=0.0)
{
l9_355=l9_189;
}
else
{
if ((l9_190*1.0)!=0.0)
{
l9_355=l9_191;
}
else
{
if ((l9_192*1.0)!=0.0)
{
l9_355=l9_193;
}
else
{
l9_355=l9_194;
}
}
}
l9_187=l9_355;
l9_169=l9_187;
float l9_356=0.0;
float l9_357=0.0;
float l9_358=(*sc_set2.UserUniforms).Port_Value1_N156;
float l9_359=0.0;
float l9_360=(*sc_set2.UserUniforms).Port_Value2_N156;
float l9_361=0.0;
float l9_362=(*sc_set2.UserUniforms).Port_Value3_N156;
float l9_363=0.0;
float l9_364=(*sc_set2.UserUniforms).Port_Value4_N156;
float l9_365=(*sc_set2.UserUniforms).Port_Default_N156;
ssGlobals l9_366=l9_174;
float2 l9_367=float2(0.0);
l9_367=l9_366.Surface_UVCoord0;
float2 l9_368=float2(0.0);
l9_368=(((l9_367-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_369=float2(0.0);
l9_369=((l9_368-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_370=0.0;
float l9_371=(*sc_set2.UserUniforms).outlineOffset;
l9_370=l9_371;
float l9_372=0.0;
float l9_373=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_374=l9_373+0.001;
l9_374-=0.001;
l9_372=l9_374;
float l9_375=0.0;
l9_375=l9_370+l9_372;
float l9_376=0.0;
float l9_377=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_378=l9_377+0.001;
l9_378-=0.001;
l9_376=l9_378;
float l9_379=0.0;
l9_379=l9_370+l9_376;
float l9_380=0.0;
l9_380=l9_375+l9_379;
float l9_381=0.0;
l9_381=l9_380/((*sc_set2.UserUniforms).Port_Input1_N054+1.234e-06);
float2 l9_382=float2(0.0);
l9_382.x=l9_381;
l9_382.y=l9_381;
float l9_383=0.0;
l9_383=3.1415927;
float l9_384=0.0;
l9_384=l9_383*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_385=0.0;
l9_385=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_386=0.0;
float l9_387=float((*sc_set2.UserUniforms).handType);
l9_386=l9_387;
float l9_388=0.0;
l9_388=l9_385*l9_386;
float l9_389=0.0;
l9_389=radians(l9_388);
float l9_390=0.0;
l9_390=l9_384+l9_389;
float l9_391=0.0;
l9_391=cos(l9_390);
float l9_392=0.0;
l9_392=sin(l9_390);
float2 l9_393=float2(0.0);
l9_393.x=l9_391;
l9_393.y=l9_392;
float2 l9_394=float2(0.0);
l9_394=l9_382*l9_393;
float l9_395=0.0;
l9_395=distance(l9_369,l9_394);
float l9_396=0.0;
l9_396=l9_375-l9_379;
float l9_397=0.0;
float l9_398=(*sc_set2.UserUniforms).Port_Value_N068;
float l9_399=l9_398+0.001;
l9_399-=0.001;
l9_397=l9_399;
float l9_400=0.0;
l9_400=l9_396*l9_397;
float l9_401=0.0;
float l9_402=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_401=l9_402;
float l9_403=0.0;
l9_403=l9_400+l9_401;
float l9_404=0.0;
l9_404=float(l9_395<l9_403);
float l9_405=0.0;
l9_405=(l9_386==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_406=0.0;
float l9_407=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_406=l9_407;
float l9_408=0.0;
float l9_409=l9_405;
bool l9_410=(l9_409*1.0)!=0.0;
bool l9_411;
if (l9_410)
{
l9_411=(l9_406*1.0)!=0.0;
}
else
{
l9_411=l9_410;
}
l9_408=float(l9_411);
float l9_412=0.0;
float l9_413=l9_404;
bool l9_414=(l9_413*1.0)!=0.0;
bool l9_415;
if (l9_414)
{
l9_415=(l9_408*1.0)!=0.0;
}
else
{
l9_415=l9_414;
}
l9_412=float(l9_415);
l9_357=l9_412;
float2 l9_416=float2(0.0);
l9_416=l9_366.Surface_UVCoord0;
float2 l9_417=float2(0.0);
l9_417=(((l9_416-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_418=float2(0.0);
l9_418=((l9_417-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_419=float2(0.0);
l9_419.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_419.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_420=0.0;
l9_420=distance(l9_418,l9_419);
float l9_421=0.0;
float l9_422=(*sc_set2.UserUniforms).circleSquishScale;
l9_421=l9_422;
float l9_423=0.0;
float l9_424=(*sc_set2.UserUniforms).Port_Value_N042;
float l9_425=l9_424+0.001;
l9_425-=0.001;
l9_423=l9_425;
float l9_426=0.0;
l9_426=l9_421*l9_423;
float l9_427=0.0;
float l9_428=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_427=l9_428;
float l9_429=0.0;
l9_429=l9_426+l9_427;
float l9_430=0.0;
l9_430=float(l9_420<l9_429);
l9_359=l9_430;
float2 l9_431=float2(0.0);
l9_431=l9_366.Surface_UVCoord0;
float2 l9_432=float2(0.0);
l9_432=(((l9_431-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_433=float2(0.0);
l9_433=((l9_432-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_434=float2(0.0);
l9_434.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_434.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_435=0.0;
l9_435=distance(l9_433,l9_434);
float l9_436=0.0;
float l9_437=(*sc_set2.UserUniforms).outlineOffset;
l9_436=l9_437;
float l9_438=0.0;
float l9_439=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_440=l9_439+0.001;
l9_440-=0.001;
l9_438=l9_440;
float l9_441=0.0;
l9_441=l9_436+l9_438;
float l9_442=0.0;
float l9_443=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_442=l9_443;
float l9_444=0.0;
l9_444=l9_441+l9_442;
float l9_445=0.0;
l9_445=float(l9_435<l9_444);
float l9_446=0.0;
float l9_447=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_448=l9_447+0.001;
l9_448-=0.001;
l9_446=l9_448;
float l9_449=0.0;
l9_449=l9_436+l9_446;
float l9_450=0.0;
l9_450=l9_449-l9_442;
float l9_451=0.0;
l9_451=float(l9_435>l9_450);
float l9_452=0.0;
float l9_453=l9_445;
bool l9_454=(l9_453*1.0)!=0.0;
bool l9_455;
if (l9_454)
{
l9_455=(l9_451*1.0)!=0.0;
}
else
{
l9_455=l9_454;
}
l9_452=float(l9_455);
float l9_456=0.0;
float l9_457=0.0;
float2 l9_458=l9_433;
float l9_459=l9_458.x;
float l9_460=l9_458.y;
l9_456=l9_459;
l9_457=l9_460;
float l9_461=0.0;
l9_461=atan2(l9_457,l9_456);
float l9_462=0.0;
l9_462=3.1415927;
float l9_463=0.0;
l9_463=l9_462*(*sc_set2.UserUniforms).Port_Input1_N071;
float l9_464=0.0;
l9_464=l9_461+l9_463;
float l9_465=0.0;
l9_465=mod(l9_464,l9_463);
float l9_466=0.0;
l9_466=3.1415927;
float l9_467=0.0;
l9_467=l9_466*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_468=0.0;
l9_468=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_469=0.0;
float l9_470=float((*sc_set2.UserUniforms).handType);
l9_469=l9_470;
float l9_471=0.0;
l9_471=l9_468*l9_469;
float l9_472=0.0;
l9_472=radians(l9_471);
float l9_473=0.0;
l9_473=l9_467+l9_472;
float l9_474=0.0;
l9_474=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_475=0.0;
l9_475=radians(l9_474);
float l9_476=0.0;
l9_476=l9_475/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_477=0.0;
l9_477=l9_473+l9_476;
float l9_478=0.0;
l9_478=float(l9_465<l9_477);
float l9_479=0.0;
l9_479=l9_473-l9_476;
float l9_480=0.0;
l9_480=float(l9_465>l9_479);
float l9_481=0.0;
float l9_482=l9_478;
bool l9_483=(l9_482*1.0)!=0.0;
bool l9_484;
if (l9_483)
{
l9_484=(l9_480*1.0)!=0.0;
}
else
{
l9_484=l9_483;
}
l9_481=float(l9_484);
float l9_485=0.0;
l9_485=(l9_469==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_486=0.0;
float l9_487=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_486=l9_487;
float l9_488=0.0;
float l9_489=l9_485;
bool l9_490=(l9_489*1.0)!=0.0;
bool l9_491;
if (l9_490)
{
l9_491=(l9_486*1.0)!=0.0;
}
else
{
l9_491=l9_490;
}
l9_488=float(l9_491);
float l9_492=0.0;
float l9_493=l9_481;
bool l9_494=(l9_493*1.0)!=0.0;
bool l9_495;
if (l9_494)
{
l9_495=(l9_488*1.0)!=0.0;
}
else
{
l9_495=l9_494;
}
l9_492=float(l9_495);
float l9_496=0.0;
l9_496=((l9_492*1.0)!=0.0) ? 0.0 : 1.0;
float l9_497=0.0;
float l9_498=l9_452;
bool l9_499=(l9_498*1.0)!=0.0;
bool l9_500;
if (l9_499)
{
l9_500=(l9_496*1.0)!=0.0;
}
else
{
l9_500=l9_499;
}
l9_497=float(l9_500);
l9_361=l9_497;
float2 l9_501=float2(0.0);
l9_501=l9_366.Surface_UVCoord0;
float2 l9_502=float2(0.0);
l9_502=(((l9_501-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_503=float2(0.0);
l9_503=((l9_502-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_504=0.0;
float l9_505=(*sc_set2.UserUniforms).outlineOffset;
l9_504=l9_505;
float l9_506=0.0;
float l9_507=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_508=l9_507+0.001;
l9_508-=0.001;
l9_506=l9_508;
float l9_509=0.0;
l9_509=l9_504+l9_506;
float l9_510=0.0;
float l9_511=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_512=l9_511+0.001;
l9_512-=0.001;
l9_510=l9_512;
float l9_513=0.0;
l9_513=l9_504+l9_510;
float l9_514=0.0;
l9_514=l9_509+l9_513;
float l9_515=0.0;
l9_515=l9_514/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_516=float2(0.0);
l9_516.x=l9_515;
l9_516.y=l9_515;
float l9_517=0.0;
l9_517=3.1415927;
float l9_518=0.0;
l9_518=l9_517*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_519=0.0;
l9_519=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_520=0.0;
float l9_521=float((*sc_set2.UserUniforms).handType);
l9_520=l9_521;
float l9_522=0.0;
l9_522=l9_519*l9_520;
float l9_523=0.0;
l9_523=radians(l9_522);
float l9_524=0.0;
l9_524=l9_518+l9_523;
float l9_525=0.0;
l9_525=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_526=0.0;
l9_526=radians(l9_525);
float l9_527=0.0;
l9_527=l9_526/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_528=0.0;
l9_528=l9_524+l9_527;
float l9_529=0.0;
l9_529=cos(l9_528);
float l9_530=0.0;
l9_530=sin(l9_528);
float2 l9_531=float2(0.0);
l9_531.x=l9_529;
l9_531.y=l9_530;
float2 l9_532=float2(0.0);
l9_532=l9_516*l9_531;
float l9_533=0.0;
l9_533=distance(l9_503,l9_532);
float l9_534=0.0;
l9_534=l9_509-l9_513;
float l9_535=0.0;
l9_535=l9_534/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_536=0.0;
float l9_537=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_536=l9_537;
float l9_538=0.0;
l9_538=l9_535+l9_536;
float l9_539=0.0;
l9_539=float(l9_533<l9_538);
float l9_540=0.0;
l9_540=l9_524-l9_527;
float l9_541=0.0;
l9_541=cos(l9_540);
float l9_542=0.0;
l9_542=sin(l9_540);
float2 l9_543=float2(0.0);
l9_543.x=l9_541;
l9_543.y=l9_542;
float2 l9_544=float2(0.0);
l9_544=l9_516*l9_543;
float l9_545=0.0;
l9_545=distance(l9_503,l9_544);
float l9_546=0.0;
l9_546=float(l9_545<l9_538);
float l9_547=0.0;
float l9_548=l9_539;
bool l9_549=(l9_548*1.0)!=0.0;
bool l9_550;
if (!l9_549)
{
l9_550=(l9_546*1.0)!=0.0;
}
else
{
l9_550=l9_549;
}
l9_547=float(l9_550);
float l9_551=0.0;
float l9_552=0.0;
float2 l9_553=l9_503;
float l9_554=l9_553.x;
float l9_555=l9_553.y;
l9_551=l9_554;
l9_552=l9_555;
float l9_556=0.0;
l9_556=atan2(l9_552,l9_551);
float l9_557=0.0;
l9_557=3.1415927;
float l9_558=0.0;
l9_558=l9_557*(*sc_set2.UserUniforms).Port_Input1_N071;
float l9_559=0.0;
l9_559=l9_556+l9_558;
float l9_560=0.0;
l9_560=mod(l9_559,l9_558);
float l9_561=0.0;
l9_561=float(l9_560<l9_528);
float l9_562=0.0;
l9_562=float(l9_560>l9_540);
float l9_563=0.0;
float l9_564=l9_561;
bool l9_565=(l9_564*1.0)!=0.0;
bool l9_566;
if (l9_565)
{
l9_566=(l9_562*1.0)!=0.0;
}
else
{
l9_566=l9_565;
}
l9_563=float(l9_566);
float l9_567=0.0;
l9_567=(l9_520==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_568=0.0;
float l9_569=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_568=l9_569;
float l9_570=0.0;
float l9_571=l9_567;
bool l9_572=(l9_571*1.0)!=0.0;
bool l9_573;
if (l9_572)
{
l9_573=(l9_568*1.0)!=0.0;
}
else
{
l9_573=l9_572;
}
l9_570=float(l9_573);
float l9_574=0.0;
float l9_575=l9_563;
bool l9_576=(l9_575*1.0)!=0.0;
bool l9_577;
if (l9_576)
{
l9_577=(l9_570*1.0)!=0.0;
}
else
{
l9_577=l9_576;
}
l9_574=float(l9_577);
float l9_578=0.0;
float l9_579=l9_547;
bool l9_580=(l9_579*1.0)!=0.0;
bool l9_581;
if (l9_580)
{
l9_581=(l9_574*1.0)!=0.0;
}
else
{
l9_581=l9_580;
}
l9_578=float(l9_581);
l9_363=l9_578;
float l9_582;
if ((l9_357*1.0)!=0.0)
{
l9_582=l9_358;
}
else
{
if ((l9_359*1.0)!=0.0)
{
l9_582=l9_360;
}
else
{
if ((l9_361*1.0)!=0.0)
{
l9_582=l9_362;
}
else
{
if ((l9_363*1.0)!=0.0)
{
l9_582=l9_364;
}
else
{
l9_582=l9_365;
}
}
}
}
l9_356=l9_582;
l9_171=l9_356;
float4 l9_583;
if ((l9_167*1.0)!=0.0)
{
float3 l9_584=float3(0.0);
float l9_585=0.0;
float3 l9_586=(*sc_set2.UserUniforms).Port_Value1_N048;
float3 l9_587=(*sc_set2.UserUniforms).Port_Default_N048;
float l9_588=0.0;
float l9_589=float((*sc_set2.UserUniforms).isTriggering!=0);
l9_588=l9_589;
l9_585=l9_588;
float3 l9_590;
if ((l9_585*1.0)!=0.0)
{
l9_590=l9_586;
}
else
{
l9_590=l9_587;
}
l9_584=l9_590;
float2 l9_591=float2(0.0);
l9_591=l9_174.Surface_UVCoord0;
float2 l9_592=float2(0.0);
l9_592=(((l9_591-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_593=float2(0.0);
l9_593=((l9_592-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_594=float2(0.0);
l9_594.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_594.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_595=0.0;
l9_595=distance(l9_593,l9_594);
float l9_596=0.0;
l9_596=mix((*sc_set2.UserUniforms).Port_Input0_N083,(*sc_set2.UserUniforms).Port_Input1_N083,l9_595);
float4 l9_597=float4(0.0);
l9_597=float4(l9_584.x,l9_584.y,l9_584.z,l9_597.w);
l9_597.w=l9_596;
l9_168=l9_597;
l9_583=l9_168;
}
else
{
if ((l9_169*1.0)!=0.0)
{
float l9_598=0.0;
float l9_599=(*sc_set2.UserUniforms).maxAlpha;
l9_598=l9_599;
float l9_600=0.0;
float l9_601=(*sc_set2.UserUniforms).outlineAlpha;
l9_600=l9_601;
float l9_602=0.0;
l9_602=fast::min(l9_598,l9_600);
float4 l9_603=float4(0.0);
l9_603=float4((*sc_set2.UserUniforms).Port_Value1_N014.x,(*sc_set2.UserUniforms).Port_Value1_N014.y,(*sc_set2.UserUniforms).Port_Value1_N014.z,l9_603.w);
l9_603.w=l9_602;
l9_170=l9_603;
l9_583=l9_170;
}
else
{
if ((l9_171*1.0)!=0.0)
{
float l9_604=0.0;
float l9_605=0.0;
float l9_606=0.0;
float l9_607=0.0;
float l9_608=0.0;
float l9_609=0.0;
float l9_610=0.0;
float l9_611=0.0;
float l9_612=0.0;
float l9_613=(*sc_set2.UserUniforms).Port_Default_N155;
ssGlobals l9_614=l9_174;
float2 l9_615=float2(0.0);
l9_615=l9_614.Surface_UVCoord0;
float2 l9_616=float2(0.0);
l9_616=(((l9_615-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_617=float2(0.0);
l9_617=((l9_616-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_618=0.0;
float l9_619=(*sc_set2.UserUniforms).outlineOffset;
l9_618=l9_619;
float l9_620=0.0;
float l9_621=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_622=l9_621+0.001;
l9_622-=0.001;
l9_620=l9_622;
float l9_623=0.0;
l9_623=l9_618+l9_620;
float l9_624=0.0;
float l9_625=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_626=l9_625+0.001;
l9_626-=0.001;
l9_624=l9_626;
float l9_627=0.0;
l9_627=l9_618+l9_624;
float l9_628=0.0;
l9_628=l9_623+l9_627;
float l9_629=0.0;
l9_629=l9_628/((*sc_set2.UserUniforms).Port_Input1_N054+1.234e-06);
float2 l9_630=float2(0.0);
l9_630.x=l9_629;
l9_630.y=l9_629;
float l9_631=0.0;
l9_631=3.1415927;
float l9_632=0.0;
l9_632=l9_631*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_633=0.0;
l9_633=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_634=0.0;
float l9_635=float((*sc_set2.UserUniforms).handType);
l9_634=l9_635;
float l9_636=0.0;
l9_636=l9_633*l9_634;
float l9_637=0.0;
l9_637=radians(l9_636);
float l9_638=0.0;
l9_638=l9_632+l9_637;
float l9_639=0.0;
l9_639=cos(l9_638);
float l9_640=0.0;
l9_640=sin(l9_638);
float2 l9_641=float2(0.0);
l9_641.x=l9_639;
l9_641.y=l9_640;
float2 l9_642=float2(0.0);
l9_642=l9_630*l9_641;
float l9_643=0.0;
l9_643=distance(l9_617,l9_642);
float l9_644=0.0;
l9_644=l9_623-l9_627;
float l9_645=0.0;
float l9_646=(*sc_set2.UserUniforms).Port_Value_N068;
float l9_647=l9_646+0.001;
l9_647-=0.001;
l9_645=l9_647;
float l9_648=0.0;
l9_648=l9_644*l9_645;
float l9_649=0.0;
float l9_650=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_649=l9_650;
float l9_651=0.0;
l9_651=l9_648+l9_649;
float l9_652=0.0;
l9_652=float(l9_643<l9_651);
float l9_653=0.0;
l9_653=(l9_634==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_654=0.0;
float l9_655=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_654=l9_655;
float l9_656=0.0;
float l9_657=l9_653;
bool l9_658=(l9_657*1.0)!=0.0;
bool l9_659;
if (l9_658)
{
l9_659=(l9_654*1.0)!=0.0;
}
else
{
l9_659=l9_658;
}
l9_656=float(l9_659);
float l9_660=0.0;
float l9_661=l9_652;
bool l9_662=(l9_661*1.0)!=0.0;
bool l9_663;
if (l9_662)
{
l9_663=(l9_656*1.0)!=0.0;
}
else
{
l9_663=l9_662;
}
l9_660=float(l9_663);
l9_605=l9_660;
float2 l9_664=float2(0.0);
l9_664=l9_614.Surface_UVCoord0;
float2 l9_665=float2(0.0);
l9_665=(((l9_664-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_666=float2(0.0);
l9_666=((l9_665-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_667=float2(0.0);
l9_667.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_667.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_668=0.0;
l9_668=distance(l9_666,l9_667);
float l9_669=0.0;
float l9_670=(*sc_set2.UserUniforms).circleSquishScale;
l9_669=l9_670;
float l9_671=0.0;
float l9_672=(*sc_set2.UserUniforms).Port_Value_N042;
float l9_673=l9_672+0.001;
l9_673-=0.001;
l9_671=l9_673;
float l9_674=0.0;
l9_674=l9_669*l9_671;
float l9_675=0.0;
float l9_676=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_675=l9_676;
float l9_677=0.0;
l9_677=l9_674+l9_675;
float l9_678=0.0;
l9_678=float(l9_668<l9_677);
l9_607=l9_678;
float2 l9_679=float2(0.0);
l9_679=l9_614.Surface_UVCoord0;
float2 l9_680=float2(0.0);
l9_680=(((l9_679-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_681=float2(0.0);
l9_681=((l9_680-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_682=0.0;
float l9_683=(*sc_set2.UserUniforms).outlineOffset;
l9_682=l9_683;
float l9_684=0.0;
float l9_685=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_686=l9_685+0.001;
l9_686-=0.001;
l9_684=l9_686;
float l9_687=0.0;
l9_687=l9_682+l9_684;
float l9_688=0.0;
float l9_689=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_690=l9_689+0.001;
l9_690-=0.001;
l9_688=l9_690;
float l9_691=0.0;
l9_691=l9_682+l9_688;
float l9_692=0.0;
l9_692=l9_687+l9_691;
float l9_693=0.0;
l9_693=l9_692/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_694=float2(0.0);
l9_694.x=l9_693;
l9_694.y=l9_693;
float l9_695=0.0;
l9_695=3.1415927;
float l9_696=0.0;
l9_696=l9_695*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_697=0.0;
l9_697=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_698=0.0;
float l9_699=float((*sc_set2.UserUniforms).handType);
l9_698=l9_699;
float l9_700=0.0;
l9_700=l9_697*l9_698;
float l9_701=0.0;
l9_701=radians(l9_700);
float l9_702=0.0;
l9_702=l9_696+l9_701;
float l9_703=0.0;
l9_703=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_704=0.0;
l9_704=radians(l9_703);
float l9_705=0.0;
l9_705=l9_704/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_706=0.0;
l9_706=l9_702+l9_705;
float l9_707=0.0;
l9_707=cos(l9_706);
float l9_708=0.0;
l9_708=sin(l9_706);
float2 l9_709=float2(0.0);
l9_709.x=l9_707;
l9_709.y=l9_708;
float2 l9_710=float2(0.0);
l9_710=l9_694*l9_709;
float l9_711=0.0;
l9_711=distance(l9_681,l9_710);
float l9_712=0.0;
l9_712=l9_687-l9_691;
float l9_713=0.0;
l9_713=l9_712/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_714=0.0;
float l9_715=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_714=l9_715;
float l9_716=0.0;
l9_716=l9_713+l9_714;
float l9_717=0.0;
l9_717=float(l9_711<l9_716);
float l9_718=0.0;
l9_718=l9_702-l9_705;
float l9_719=0.0;
l9_719=cos(l9_718);
float l9_720=0.0;
l9_720=sin(l9_718);
float2 l9_721=float2(0.0);
l9_721.x=l9_719;
l9_721.y=l9_720;
float2 l9_722=float2(0.0);
l9_722=l9_694*l9_721;
float l9_723=0.0;
l9_723=distance(l9_681,l9_722);
float l9_724=0.0;
l9_724=float(l9_723<l9_716);
float l9_725=0.0;
float l9_726=l9_717;
bool l9_727=(l9_726*1.0)!=0.0;
bool l9_728;
if (!l9_727)
{
l9_728=(l9_724*1.0)!=0.0;
}
else
{
l9_728=l9_727;
}
l9_725=float(l9_728);
float l9_729=0.0;
float l9_730=0.0;
float2 l9_731=l9_681;
float l9_732=l9_731.x;
float l9_733=l9_731.y;
l9_729=l9_732;
l9_730=l9_733;
float l9_734=0.0;
l9_734=atan2(l9_730,l9_729);
float l9_735=0.0;
l9_735=3.1415927;
float l9_736=0.0;
l9_736=l9_735*(*sc_set2.UserUniforms).Port_Input1_N071;
float l9_737=0.0;
l9_737=l9_734+l9_736;
float l9_738=0.0;
l9_738=mod(l9_737,l9_736);
float l9_739=0.0;
l9_739=float(l9_738<l9_706);
float l9_740=0.0;
l9_740=float(l9_738>l9_718);
float l9_741=0.0;
float l9_742=l9_739;
bool l9_743=(l9_742*1.0)!=0.0;
bool l9_744;
if (l9_743)
{
l9_744=(l9_740*1.0)!=0.0;
}
else
{
l9_744=l9_743;
}
l9_741=float(l9_744);
float l9_745=0.0;
l9_745=(l9_698==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_746=0.0;
float l9_747=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_746=l9_747;
float l9_748=0.0;
float l9_749=l9_745;
bool l9_750=(l9_749*1.0)!=0.0;
bool l9_751;
if (l9_750)
{
l9_751=(l9_746*1.0)!=0.0;
}
else
{
l9_751=l9_750;
}
l9_748=float(l9_751);
float l9_752=0.0;
float l9_753=l9_741;
bool l9_754=(l9_753*1.0)!=0.0;
bool l9_755;
if (l9_754)
{
l9_755=(l9_748*1.0)!=0.0;
}
else
{
l9_755=l9_754;
}
l9_752=float(l9_755);
float l9_756=0.0;
float l9_757=l9_725;
bool l9_758=(l9_757*1.0)!=0.0;
bool l9_759;
if (l9_758)
{
l9_759=(l9_752*1.0)!=0.0;
}
else
{
l9_759=l9_758;
}
l9_756=float(l9_759);
l9_609=l9_756;
float2 l9_760=float2(0.0);
l9_760=l9_614.Surface_UVCoord0;
float2 l9_761=float2(0.0);
l9_761=(((l9_760-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_762=float2(0.0);
l9_762=((l9_761-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_763=float2(0.0);
l9_763.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_763.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_764=0.0;
l9_764=distance(l9_762,l9_763);
float l9_765=0.0;
float l9_766=(*sc_set2.UserUniforms).outlineOffset;
l9_765=l9_766;
float l9_767=0.0;
float l9_768=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_769=l9_768+0.001;
l9_769-=0.001;
l9_767=l9_769;
float l9_770=0.0;
l9_770=l9_765+l9_767;
float l9_771=0.0;
float l9_772=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_771=l9_772;
float l9_773=0.0;
l9_773=l9_770+l9_771;
float l9_774=0.0;
l9_774=float(l9_764<l9_773);
float l9_775=0.0;
float l9_776=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_777=l9_776+0.001;
l9_777-=0.001;
l9_775=l9_777;
float l9_778=0.0;
l9_778=l9_765+l9_775;
float l9_779=0.0;
l9_779=l9_778-l9_771;
float l9_780=0.0;
l9_780=float(l9_764>l9_779);
float l9_781=0.0;
float l9_782=l9_774;
bool l9_783=(l9_782*1.0)!=0.0;
bool l9_784;
if (l9_783)
{
l9_784=(l9_780*1.0)!=0.0;
}
else
{
l9_784=l9_783;
}
l9_781=float(l9_784);
float l9_785=0.0;
float l9_786=0.0;
float2 l9_787=l9_762;
float l9_788=l9_787.x;
float l9_789=l9_787.y;
l9_785=l9_788;
l9_786=l9_789;
float l9_790=0.0;
l9_790=atan2(l9_786,l9_785);
float l9_791=0.0;
l9_791=3.1415927;
float l9_792=0.0;
l9_792=l9_791*(*sc_set2.UserUniforms).Port_Input1_N071;
float l9_793=0.0;
l9_793=l9_790+l9_792;
float l9_794=0.0;
l9_794=mod(l9_793,l9_792);
float l9_795=0.0;
l9_795=3.1415927;
float l9_796=0.0;
l9_796=l9_795*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_797=0.0;
l9_797=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_798=0.0;
float l9_799=float((*sc_set2.UserUniforms).handType);
l9_798=l9_799;
float l9_800=0.0;
l9_800=l9_797*l9_798;
float l9_801=0.0;
l9_801=radians(l9_800);
float l9_802=0.0;
l9_802=l9_796+l9_801;
float l9_803=0.0;
l9_803=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_804=0.0;
l9_804=radians(l9_803);
float l9_805=0.0;
l9_805=l9_804/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_806=0.0;
l9_806=l9_802+l9_805;
float l9_807=0.0;
l9_807=float(l9_794<l9_806);
float l9_808=0.0;
l9_808=l9_802-l9_805;
float l9_809=0.0;
l9_809=float(l9_794>l9_808);
float l9_810=0.0;
float l9_811=l9_807;
bool l9_812=(l9_811*1.0)!=0.0;
bool l9_813;
if (l9_812)
{
l9_813=(l9_809*1.0)!=0.0;
}
else
{
l9_813=l9_812;
}
l9_810=float(l9_813);
float l9_814=0.0;
l9_814=(l9_798==(*sc_set2.UserUniforms).Port_Input1_N035) ? 0.0 : 1.0;
float l9_815=0.0;
float l9_816=float((*sc_set2.UserUniforms).multipleInteractorsActive!=0);
l9_815=l9_816;
float l9_817=0.0;
float l9_818=l9_814;
bool l9_819=(l9_818*1.0)!=0.0;
bool l9_820;
if (l9_819)
{
l9_820=(l9_815*1.0)!=0.0;
}
else
{
l9_820=l9_819;
}
l9_817=float(l9_820);
float l9_821=0.0;
float l9_822=l9_810;
bool l9_823=(l9_822*1.0)!=0.0;
bool l9_824;
if (l9_823)
{
l9_824=(l9_817*1.0)!=0.0;
}
else
{
l9_824=l9_823;
}
l9_821=float(l9_824);
float l9_825=0.0;
l9_825=((l9_821*1.0)!=0.0) ? 0.0 : 1.0;
float l9_826=0.0;
float l9_827=l9_781;
bool l9_828=(l9_827*1.0)!=0.0;
bool l9_829;
if (l9_828)
{
l9_829=(l9_825*1.0)!=0.0;
}
else
{
l9_829=l9_828;
}
l9_826=float(l9_829);
l9_611=l9_826;
float l9_830;
if ((l9_605*1.0)!=0.0)
{
float2 l9_831=float2(0.0);
l9_831=l9_614.Surface_UVCoord0;
float2 l9_832=float2(0.0);
l9_832=(((l9_831-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_833=float2(0.0);
l9_833=((l9_832-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_834=0.0;
float l9_835=(*sc_set2.UserUniforms).outlineOffset;
l9_834=l9_835;
float l9_836=0.0;
float l9_837=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_838=l9_837+0.001;
l9_838-=0.001;
l9_836=l9_838;
float l9_839=0.0;
l9_839=l9_834+l9_836;
float l9_840=0.0;
float l9_841=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_842=l9_841+0.001;
l9_842-=0.001;
l9_840=l9_842;
float l9_843=0.0;
l9_843=l9_834+l9_840;
float l9_844=0.0;
l9_844=l9_839+l9_843;
float l9_845=0.0;
l9_845=l9_844/((*sc_set2.UserUniforms).Port_Input1_N054+1.234e-06);
float2 l9_846=float2(0.0);
l9_846.x=l9_845;
l9_846.y=l9_845;
float l9_847=0.0;
l9_847=3.1415927;
float l9_848=0.0;
l9_848=l9_847*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_849=0.0;
l9_849=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_850=0.0;
float l9_851=float((*sc_set2.UserUniforms).handType);
l9_850=l9_851;
float l9_852=0.0;
l9_852=l9_849*l9_850;
float l9_853=0.0;
l9_853=radians(l9_852);
float l9_854=0.0;
l9_854=l9_848+l9_853;
float l9_855=0.0;
l9_855=cos(l9_854);
float l9_856=0.0;
l9_856=sin(l9_854);
float2 l9_857=float2(0.0);
l9_857.x=l9_855;
l9_857.y=l9_856;
float2 l9_858=float2(0.0);
l9_858=l9_846*l9_857;
float l9_859=0.0;
l9_859=distance(l9_833,l9_858);
float l9_860=0.0;
l9_860=l9_839-l9_843;
float l9_861=0.0;
float l9_862=(*sc_set2.UserUniforms).Port_Value_N068;
float l9_863=l9_862+0.001;
l9_863-=0.001;
l9_861=l9_863;
float l9_864=0.0;
l9_864=l9_860*l9_861;
float l9_865=0.0;
float l9_866=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_865=l9_866;
float l9_867=0.0;
l9_867=l9_864+l9_865;
float l9_868=0.0;
float l9_869=(*sc_set2.UserUniforms).shadowOpacity;
l9_868=l9_869;
float l9_870=0.0;
float l9_871=l9_859;
float l9_872=l9_864;
float l9_873=l9_867;
float l9_874=l9_868;
float l9_875=(*sc_set2.UserUniforms).Port_RangeMaxB_N151;
float l9_876=(((l9_871-l9_872)/(l9_873-l9_872))*(l9_875-l9_874))+l9_874;
float l9_877;
if (l9_875>l9_874)
{
l9_877=fast::clamp(l9_876,l9_874,l9_875);
}
else
{
l9_877=fast::clamp(l9_876,l9_875,l9_874);
}
l9_876=l9_877;
l9_870=l9_876;
l9_606=l9_870;
l9_830=l9_606;
}
else
{
if ((l9_607*1.0)!=0.0)
{
float2 l9_878=float2(0.0);
l9_878=l9_614.Surface_UVCoord0;
float2 l9_879=float2(0.0);
l9_879=(((l9_878-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_880=float2(0.0);
l9_880=((l9_879-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_881=float2(0.0);
l9_881.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_881.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_882=0.0;
l9_882=distance(l9_880,l9_881);
float l9_883=0.0;
float l9_884=(*sc_set2.UserUniforms).circleSquishScale;
l9_883=l9_884;
float l9_885=0.0;
float l9_886=(*sc_set2.UserUniforms).Port_Value_N042;
float l9_887=l9_886+0.001;
l9_887-=0.001;
l9_885=l9_887;
float l9_888=0.0;
l9_888=l9_883*l9_885;
float l9_889=0.0;
float l9_890=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_889=l9_890;
float l9_891=0.0;
l9_891=l9_888+l9_889;
float l9_892=0.0;
float l9_893=(*sc_set2.UserUniforms).shadowOpacity;
l9_892=l9_893;
float l9_894=0.0;
float l9_895=l9_882;
float l9_896=l9_888;
float l9_897=l9_891;
float l9_898=l9_892;
float l9_899=(*sc_set2.UserUniforms).Port_RangeMaxB_N152;
float l9_900=(((l9_895-l9_896)/(l9_897-l9_896))*(l9_899-l9_898))+l9_898;
float l9_901;
if (l9_899>l9_898)
{
l9_901=fast::clamp(l9_900,l9_898,l9_899);
}
else
{
l9_901=fast::clamp(l9_900,l9_899,l9_898);
}
l9_900=l9_901;
l9_894=l9_900;
l9_608=l9_894;
l9_830=l9_608;
}
else
{
if ((l9_609*1.0)!=0.0)
{
float l9_902=0.0;
float l9_903=0.0;
float l9_904=0.0;
float l9_905=0.0;
float l9_906=0.0;
float l9_907=(*sc_set2.UserUniforms).Port_Default_N153;
ssGlobals l9_908=l9_614;
float2 l9_909=float2(0.0);
l9_909=l9_908.Surface_UVCoord0;
float2 l9_910=float2(0.0);
l9_910=(((l9_909-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_911=float2(0.0);
l9_911=((l9_910-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_912=0.0;
float l9_913=(*sc_set2.UserUniforms).outlineOffset;
l9_912=l9_913;
float l9_914=0.0;
float l9_915=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_916=l9_915+0.001;
l9_916-=0.001;
l9_914=l9_916;
float l9_917=0.0;
l9_917=l9_912+l9_914;
float l9_918=0.0;
float l9_919=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_920=l9_919+0.001;
l9_920-=0.001;
l9_918=l9_920;
float l9_921=0.0;
l9_921=l9_912+l9_918;
float l9_922=0.0;
l9_922=l9_917+l9_921;
float l9_923=0.0;
l9_923=l9_922/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_924=float2(0.0);
l9_924.x=l9_923;
l9_924.y=l9_923;
float l9_925=0.0;
l9_925=3.1415927;
float l9_926=0.0;
l9_926=l9_925*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_927=0.0;
l9_927=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_928=0.0;
float l9_929=float((*sc_set2.UserUniforms).handType);
l9_928=l9_929;
float l9_930=0.0;
l9_930=l9_927*l9_928;
float l9_931=0.0;
l9_931=radians(l9_930);
float l9_932=0.0;
l9_932=l9_926+l9_931;
float l9_933=0.0;
l9_933=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_934=0.0;
l9_934=radians(l9_933);
float l9_935=0.0;
l9_935=l9_934/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_936=0.0;
l9_936=l9_932+l9_935;
float l9_937=0.0;
l9_937=cos(l9_936);
float l9_938=0.0;
l9_938=sin(l9_936);
float2 l9_939=float2(0.0);
l9_939.x=l9_937;
l9_939.y=l9_938;
float2 l9_940=float2(0.0);
l9_940=l9_924*l9_939;
float l9_941=0.0;
l9_941=distance(l9_911,l9_940);
float l9_942=0.0;
l9_942=l9_917-l9_921;
float l9_943=0.0;
l9_943=l9_942/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_944=0.0;
float l9_945=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_944=l9_945;
float l9_946=0.0;
l9_946=l9_943+l9_944;
float l9_947=0.0;
l9_947=float(l9_941<l9_946);
l9_903=l9_947;
float2 l9_948=float2(0.0);
l9_948=l9_908.Surface_UVCoord0;
float2 l9_949=float2(0.0);
l9_949=(((l9_948-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_950=float2(0.0);
l9_950=((l9_949-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_951=0.0;
float l9_952=(*sc_set2.UserUniforms).outlineOffset;
l9_951=l9_952;
float l9_953=0.0;
float l9_954=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_955=l9_954+0.001;
l9_955-=0.001;
l9_953=l9_955;
float l9_956=0.0;
l9_956=l9_951+l9_953;
float l9_957=0.0;
float l9_958=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_959=l9_958+0.001;
l9_959-=0.001;
l9_957=l9_959;
float l9_960=0.0;
l9_960=l9_951+l9_957;
float l9_961=0.0;
l9_961=l9_956+l9_960;
float l9_962=0.0;
l9_962=l9_961/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_963=float2(0.0);
l9_963.x=l9_962;
l9_963.y=l9_962;
float l9_964=0.0;
l9_964=3.1415927;
float l9_965=0.0;
l9_965=l9_964*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_966=0.0;
l9_966=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_967=0.0;
float l9_968=float((*sc_set2.UserUniforms).handType);
l9_967=l9_968;
float l9_969=0.0;
l9_969=l9_966*l9_967;
float l9_970=0.0;
l9_970=radians(l9_969);
float l9_971=0.0;
l9_971=l9_965+l9_970;
float l9_972=0.0;
l9_972=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_973=0.0;
l9_973=radians(l9_972);
float l9_974=0.0;
l9_974=l9_973/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_975=0.0;
l9_975=l9_971-l9_974;
float l9_976=0.0;
l9_976=cos(l9_975);
float l9_977=0.0;
l9_977=sin(l9_975);
float2 l9_978=float2(0.0);
l9_978.x=l9_976;
l9_978.y=l9_977;
float2 l9_979=float2(0.0);
l9_979=l9_963*l9_978;
float l9_980=0.0;
l9_980=distance(l9_950,l9_979);
float l9_981=0.0;
l9_981=l9_956-l9_960;
float l9_982=0.0;
l9_982=l9_981/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_983=0.0;
float l9_984=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_983=l9_984;
float l9_985=0.0;
l9_985=l9_982+l9_983;
float l9_986=0.0;
l9_986=float(l9_980<l9_985);
l9_905=l9_986;
float l9_987;
if ((l9_903*1.0)!=0.0)
{
float2 l9_988=float2(0.0);
l9_988=l9_908.Surface_UVCoord0;
float2 l9_989=float2(0.0);
l9_989=(((l9_988-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_990=float2(0.0);
l9_990=((l9_989-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_991=0.0;
float l9_992=(*sc_set2.UserUniforms).outlineOffset;
l9_991=l9_992;
float l9_993=0.0;
float l9_994=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_995=l9_994+0.001;
l9_995-=0.001;
l9_993=l9_995;
float l9_996=0.0;
l9_996=l9_991+l9_993;
float l9_997=0.0;
float l9_998=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_999=l9_998+0.001;
l9_999-=0.001;
l9_997=l9_999;
float l9_1000=0.0;
l9_1000=l9_991+l9_997;
float l9_1001=0.0;
l9_1001=l9_996+l9_1000;
float l9_1002=0.0;
l9_1002=l9_1001/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_1003=float2(0.0);
l9_1003.x=l9_1002;
l9_1003.y=l9_1002;
float l9_1004=0.0;
l9_1004=3.1415927;
float l9_1005=0.0;
l9_1005=l9_1004*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_1006=0.0;
l9_1006=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_1007=0.0;
float l9_1008=float((*sc_set2.UserUniforms).handType);
l9_1007=l9_1008;
float l9_1009=0.0;
l9_1009=l9_1006*l9_1007;
float l9_1010=0.0;
l9_1010=radians(l9_1009);
float l9_1011=0.0;
l9_1011=l9_1005+l9_1010;
float l9_1012=0.0;
l9_1012=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_1013=0.0;
l9_1013=radians(l9_1012);
float l9_1014=0.0;
l9_1014=l9_1013/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_1015=0.0;
l9_1015=l9_1011+l9_1014;
float l9_1016=0.0;
l9_1016=cos(l9_1015);
float l9_1017=0.0;
l9_1017=sin(l9_1015);
float2 l9_1018=float2(0.0);
l9_1018.x=l9_1016;
l9_1018.y=l9_1017;
float2 l9_1019=float2(0.0);
l9_1019=l9_1003*l9_1018;
float l9_1020=0.0;
l9_1020=distance(l9_990,l9_1019);
l9_904=l9_1020;
l9_987=l9_904;
}
else
{
if ((l9_905*1.0)!=0.0)
{
float2 l9_1021=float2(0.0);
l9_1021=l9_908.Surface_UVCoord0;
float2 l9_1022=float2(0.0);
l9_1022=(((l9_1021-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_1023=float2(0.0);
l9_1023=((l9_1022-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float l9_1024=0.0;
float l9_1025=(*sc_set2.UserUniforms).outlineOffset;
l9_1024=l9_1025;
float l9_1026=0.0;
float l9_1027=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_1028=l9_1027+0.001;
l9_1028-=0.001;
l9_1026=l9_1028;
float l9_1029=0.0;
l9_1029=l9_1024+l9_1026;
float l9_1030=0.0;
float l9_1031=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_1032=l9_1031+0.001;
l9_1032-=0.001;
l9_1030=l9_1032;
float l9_1033=0.0;
l9_1033=l9_1024+l9_1030;
float l9_1034=0.0;
l9_1034=l9_1029+l9_1033;
float l9_1035=0.0;
l9_1035=l9_1034/((*sc_set2.UserUniforms).Port_Input1_N094+1.234e-06);
float2 l9_1036=float2(0.0);
l9_1036.x=l9_1035;
l9_1036.y=l9_1035;
float l9_1037=0.0;
l9_1037=3.1415927;
float l9_1038=0.0;
l9_1038=l9_1037*(*sc_set2.UserUniforms).Port_Input1_N097;
float l9_1039=0.0;
l9_1039=float((*sc_set2.UserUniforms).Port_Value_N091);
float l9_1040=0.0;
float l9_1041=float((*sc_set2.UserUniforms).handType);
l9_1040=l9_1041;
float l9_1042=0.0;
l9_1042=l9_1039*l9_1040;
float l9_1043=0.0;
l9_1043=radians(l9_1042);
float l9_1044=0.0;
l9_1044=l9_1038+l9_1043;
float l9_1045=0.0;
l9_1045=float((*sc_set2.UserUniforms).Port_Value_N041);
float l9_1046=0.0;
l9_1046=radians(l9_1045);
float l9_1047=0.0;
l9_1047=l9_1046/((*sc_set2.UserUniforms).Port_Input1_N084+1.234e-06);
float l9_1048=0.0;
l9_1048=l9_1044-l9_1047;
float l9_1049=0.0;
l9_1049=cos(l9_1048);
float l9_1050=0.0;
l9_1050=sin(l9_1048);
float2 l9_1051=float2(0.0);
l9_1051.x=l9_1049;
l9_1051.y=l9_1050;
float2 l9_1052=float2(0.0);
l9_1052=l9_1036*l9_1051;
float l9_1053=0.0;
l9_1053=distance(l9_1023,l9_1052);
l9_906=l9_1053;
l9_987=l9_906;
}
else
{
l9_987=l9_907;
}
}
l9_902=l9_987;
float l9_1054=0.0;
float l9_1055=(*sc_set2.UserUniforms).outlineOffset;
l9_1054=l9_1055;
float l9_1056=0.0;
float l9_1057=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_1058=l9_1057+0.001;
l9_1058-=0.001;
l9_1056=l9_1058;
float l9_1059=0.0;
l9_1059=l9_1054+l9_1056;
float l9_1060=0.0;
float l9_1061=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_1062=l9_1061+0.001;
l9_1062-=0.001;
l9_1060=l9_1062;
float l9_1063=0.0;
l9_1063=l9_1054+l9_1060;
float l9_1064=0.0;
l9_1064=l9_1059-l9_1063;
float l9_1065=0.0;
l9_1065=l9_1064/((*sc_set2.UserUniforms).Port_Input1_N112+1.234e-06);
float l9_1066=0.0;
float l9_1067=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_1066=l9_1067;
float l9_1068=0.0;
l9_1068=l9_1065+l9_1066;
float l9_1069=0.0;
float l9_1070=(*sc_set2.UserUniforms).shadowOpacity;
l9_1069=l9_1070;
float l9_1071=0.0;
float l9_1072=l9_902;
float l9_1073=l9_1065;
float l9_1074=l9_1068;
float l9_1075=l9_1069;
float l9_1076=(*sc_set2.UserUniforms).Port_RangeMaxB_N154;
float l9_1077=(((l9_1072-l9_1073)/(l9_1074-l9_1073))*(l9_1076-l9_1075))+l9_1075;
float l9_1078;
if (l9_1076>l9_1075)
{
l9_1078=fast::clamp(l9_1077,l9_1075,l9_1076);
}
else
{
l9_1078=fast::clamp(l9_1077,l9_1076,l9_1075);
}
l9_1077=l9_1078;
l9_1071=l9_1077;
l9_610=l9_1071;
l9_830=l9_610;
}
else
{
if ((l9_611*1.0)!=0.0)
{
float2 l9_1079=float2(0.0);
l9_1079=l9_614.Surface_UVCoord0;
float2 l9_1080=float2(0.0);
l9_1080=(((l9_1079-float2((*sc_set2.UserUniforms).Port_RangeMinA_N001))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N001-(*sc_set2.UserUniforms).Port_RangeMinA_N001))*((*sc_set2.UserUniforms).Port_RangeMaxB_N001-(*sc_set2.UserUniforms).Port_RangeMinB_N001))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N001);
float2 l9_1081=float2(0.0);
l9_1081=((l9_1080-(*sc_set2.UserUniforms).Port_Center_N002)*(*sc_set2.UserUniforms).Port_Scale_N002)+(*sc_set2.UserUniforms).Port_Center_N002;
float2 l9_1082=float2(0.0);
l9_1082.x=(*sc_set2.UserUniforms).Port_Value1_N046;
l9_1082.y=(*sc_set2.UserUniforms).Port_Value2_N046;
float l9_1083=0.0;
l9_1083=distance(l9_1081,l9_1082);
float l9_1084=0.0;
float l9_1085=(*sc_set2.UserUniforms).outlineOffset;
l9_1084=l9_1085;
float l9_1086=0.0;
float l9_1087=(*sc_set2.UserUniforms).Port_Value_N036;
float l9_1088=l9_1087+0.001;
l9_1088-=0.001;
l9_1086=l9_1088;
float l9_1089=0.0;
l9_1089=l9_1084+l9_1086;
float l9_1090=0.0;
float l9_1091=(*sc_set2.UserUniforms).Port_Value_N037;
float l9_1092=l9_1091+0.001;
l9_1092-=0.001;
l9_1090=l9_1092;
float l9_1093=0.0;
l9_1093=l9_1084+l9_1090;
float l9_1094=0.0;
l9_1094=l9_1089+l9_1093;
float l9_1095=0.0;
l9_1095=l9_1094/((*sc_set2.UserUniforms).Port_Input1_N143+1.234e-06);
float l9_1096=0.0;
l9_1096=l9_1083-l9_1095;
float l9_1097=0.0;
l9_1097=abs(l9_1096);
float l9_1098=0.0;
l9_1098=l9_1089-l9_1095;
float l9_1099=0.0;
float l9_1100=(*sc_set2.UserUniforms).shadowGradientOffset;
l9_1099=l9_1100;
float l9_1101=0.0;
l9_1101=l9_1098+l9_1099;
float l9_1102=0.0;
float l9_1103=(*sc_set2.UserUniforms).shadowOpacity;
l9_1102=l9_1103;
float l9_1104=0.0;
float l9_1105=l9_1097;
float l9_1106=l9_1098;
float l9_1107=l9_1101;
float l9_1108=l9_1102;
float l9_1109=(*sc_set2.UserUniforms).Port_RangeMaxB_N146;
float l9_1110=(((l9_1105-l9_1106)/(l9_1107-l9_1106))*(l9_1109-l9_1108))+l9_1108;
float l9_1111;
if (l9_1109>l9_1108)
{
l9_1111=fast::clamp(l9_1110,l9_1108,l9_1109);
}
else
{
l9_1111=fast::clamp(l9_1110,l9_1109,l9_1108);
}
l9_1110=l9_1111;
l9_1104=l9_1110;
l9_612=l9_1104;
l9_830=l9_612;
}
else
{
l9_830=l9_613;
}
}
}
}
l9_604=l9_830;
float4 l9_1112=float4(0.0);
l9_1112.x=(*sc_set2.UserUniforms).Port_Value1_N149;
l9_1112.y=(*sc_set2.UserUniforms).Port_Value2_N149;
l9_1112.z=(*sc_set2.UserUniforms).Port_Value3_N149;
l9_1112.w=l9_604;
l9_172=l9_1112;
l9_583=l9_172;
}
else
{
l9_583=l9_173;
}
}
}
l9_166=l9_583;
param_2=l9_166;
param_3=param_2;
}
Result_N33=param_3;
FinalColor=Result_N33;
float param_5=FinalColor.w;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (param_5<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1113=gl_FragCoord;
float2 l9_1114=floor(mod(l9_1113.xy,float2(4.0)));
float l9_1115=(mod(dot(l9_1114,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (param_5<l9_1115)
{
discard_fragment();
}
}
bool l9_1116=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_1116)
{
float4 param_6=FinalColor;
if ((int(sc_ProxyAlphaOne_tmp)!=0))
{
param_6.w=1.0;
}
float4 l9_1117=fast::max(param_6,float4(0.0));
float4 param_7=l9_1117;
out.FragColor0=param_7;
return out;
}
float4 param_8=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_1118=param_8;
float4 l9_1119=l9_1118;
float l9_1120=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_1120=l9_1119.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_1120=fast::clamp(l9_1119.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1120=fast::clamp(dot(l9_1119.xyz,float3(l9_1119.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_1120=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_1120=(1.0-dot(l9_1119.xyz,float3(0.33333001)))*l9_1119.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_1120=(1.0-fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0))*l9_1119.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_1120=fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0)*l9_1119.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_1120=fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1120=fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0)*l9_1119.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_1120=dot(l9_1119.xyz,float3(0.33333001))*l9_1119.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_1120=1.0-fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_1120=fast::clamp(dot(l9_1119.xyz,float3(1.0)),0.0,1.0);
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
float l9_1121=l9_1120;
float l9_1122=l9_1121;
float l9_1123=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_1122;
float3 l9_1124=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_1118.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_1125=float4(l9_1124.x,l9_1124.y,l9_1124.z,l9_1123);
param_8=l9_1125;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_8=float4(param_8.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_1126=param_8;
float4 l9_1127=float4(0.0);
float4 l9_1128=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_1129=out.FragColor0;
float4 l9_1130=l9_1129;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_1130.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_1131=l9_1130;
l9_1128=l9_1131;
}
else
{
float4 l9_1132=gl_FragCoord;
float2 l9_1133=(l9_1132.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_1134=l9_1133;
float2 l9_1135=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_1136=1;
int l9_1137=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1137=0;
}
else
{
l9_1137=in.varStereoViewID;
}
int l9_1138=l9_1137;
int l9_1139=l9_1138;
float3 l9_1140=float3(l9_1134,0.0);
int l9_1141=l9_1136;
int l9_1142=l9_1139;
if (l9_1141==1)
{
l9_1140.y=((2.0*l9_1140.y)+float(l9_1142))-1.0;
}
float2 l9_1143=l9_1140.xy;
l9_1135=l9_1143;
}
else
{
l9_1135=l9_1134;
}
float2 l9_1144=l9_1135;
float2 l9_1145=l9_1144;
float2 l9_1146=l9_1145;
int l9_1147=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_1148=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1148=0;
}
else
{
l9_1148=in.varStereoViewID;
}
int l9_1149=l9_1148;
l9_1147=1-l9_1149;
}
else
{
int l9_1150=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1150=0;
}
else
{
l9_1150=in.varStereoViewID;
}
int l9_1151=l9_1150;
l9_1147=l9_1151;
}
int l9_1152=l9_1147;
float2 l9_1153=l9_1146;
int l9_1154=l9_1152;
float2 l9_1155=l9_1153;
int l9_1156=l9_1154;
float l9_1157=0.0;
float4 l9_1158=float4(0.0);
float2 l9_1159=l9_1155;
int l9_1160=sc_ScreenTextureLayout_tmp;
int l9_1161=l9_1156;
float l9_1162=l9_1157;
float2 l9_1163=l9_1159;
int l9_1164=l9_1160;
int l9_1165=l9_1161;
float3 l9_1166=float3(0.0);
if (l9_1164==0)
{
l9_1166=float3(l9_1163,0.0);
}
else
{
if (l9_1164==1)
{
l9_1166=float3(l9_1163.x,(l9_1163.y*0.5)+(0.5-(float(l9_1165)*0.5)),0.0);
}
else
{
l9_1166=float3(l9_1163,float(l9_1165));
}
}
float3 l9_1167=l9_1166;
float3 l9_1168=l9_1167;
float2 l9_1169=l9_1168.xy;
float l9_1170=l9_1162;
float4 l9_1171=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_1169,bias(l9_1170));
float4 l9_1172=l9_1171;
l9_1158=l9_1172;
float4 l9_1173=l9_1158;
float4 l9_1174=l9_1173;
float4 l9_1175=l9_1174;
l9_1128=l9_1175;
}
float4 l9_1176=l9_1128;
float4 l9_1177=l9_1176;
float3 l9_1178=l9_1177.xyz;
float3 l9_1179=l9_1178;
float3 l9_1180=l9_1126.xyz;
float3 l9_1181=definedBlend(l9_1179,l9_1180,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_1127=float4(l9_1181.x,l9_1181.y,l9_1181.z,l9_1127.w);
float3 l9_1182=mix(l9_1178,l9_1127.xyz,float3(l9_1126.w));
l9_1127=float4(l9_1182.x,l9_1182.y,l9_1182.z,l9_1127.w);
l9_1127.w=1.0;
float4 l9_1183=l9_1127;
param_8=l9_1183;
}
else
{
float4 l9_1184=param_8;
float4 l9_1185=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_1185=float4(mix(float3(1.0),l9_1184.xyz,float3(l9_1184.w)),l9_1184.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_1186=l9_1184.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_1186=fast::clamp(l9_1186,0.0,1.0);
}
l9_1185=float4(l9_1184.xyz*l9_1186,l9_1186);
}
else
{
l9_1185=l9_1184;
}
}
float4 l9_1187=l9_1185;
param_8=l9_1187;
}
}
}
float4 l9_1188=param_8;
FinalColor=l9_1188;
if ((*sc_set2.UserUniforms).PreviewEnabled==1)
{
if (PreviewInfo.Saved)
{
FinalColor=float4(PreviewInfo.Color);
}
else
{
FinalColor=float4(0.0);
}
}
float4 l9_1189=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_1189=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_1189=float4(0.0);
}
float4 l9_1190=l9_1189;
float4 Cost=l9_1190;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_9=in.varPos;
float4 param_10=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_9,param_10,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_11=FinalColor;
float4 l9_1191=param_11;
out.FragColor0=l9_1191;
return out;
}
} // FRAGMENT SHADER
