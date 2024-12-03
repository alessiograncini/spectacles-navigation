#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_BACKEND_SHADER_FLAGS_END__
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
//output uvec4 position_and_mask 0
//output uvec4 normal_and_more 1
//sampler sampler InnerEdgeTexSmpSC 2:29
//sampler sampler backCapTexSmpSC 2:30
//sampler sampler frontCapTexSmpSC 2:31
//sampler sampler intensityTextureSmpSC 2:32
//sampler sampler outerEdgeTexSmpSC 2:33
//sampler sampler sc_EnvmapDiffuseSmpSC 2:34
//sampler sampler sc_EnvmapSpecularSmpSC 2:35
//sampler sampler sc_RayTracedAoTextureSmpSC 2:37
//sampler sampler sc_RayTracedDiffIndTextureSmpSC 2:38
//sampler sampler sc_RayTracedReflectionTextureSmpSC 2:39
//sampler sampler sc_RayTracedShadowTextureSmpSC 2:40
//sampler sampler sc_SSAOTextureSmpSC 2:41
//sampler sampler sc_ScreenTextureSmpSC 2:42
//sampler sampler sc_ShadowTextureSmpSC 2:43
//sampler sampler z_hitIdAndBarycentricSmp 2:45
//sampler sampler z_rayDirectionsSmpSC 2:46
//texture texture2D InnerEdgeTex 2:4:2:29
//texture texture2D backCapTex 2:5:2:30
//texture texture2D frontCapTex 2:6:2:31
//texture texture2D intensityTexture 2:7:2:32
//texture texture2D outerEdgeTex 2:8:2:33
//texture texture2D sc_EnvmapDiffuse 2:9:2:34
//texture texture2D sc_EnvmapSpecular 2:10:2:35
//texture texture2D sc_RayTracedAoTexture 2:19:2:37
//texture texture2D sc_RayTracedDiffIndTexture 2:20:2:38
//texture texture2D sc_RayTracedReflectionTexture 2:21:2:39
//texture texture2D sc_RayTracedShadowTexture 2:22:2:40
//texture texture2D sc_SSAOTexture 2:23:2:41
//texture texture2D sc_ScreenTexture 2:24:2:42
//texture texture2D sc_ShadowTexture 2:25:2:43
//texture utexture2D z_hitIdAndBarycentric 2:27:2:45
//texture texture2D z_rayDirections 2:28:2:46
//ubo float sc_BonesUBO 2:3:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 2:47:6064 {
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
//bool receivesRayTracedReflections 3808
//bool isProxyMode 3812
//bool receivesRayTracedShadows 3816
//bool receivesRayTracedDiffuseIndirect 3820
//bool receivesRayTracedAo 3824
//float4 sc_RayTracedReflectionTextureSize 3840
//float4 sc_RayTracedReflectionTextureDims 3856
//float4 sc_RayTracedReflectionTextureView 3872
//float4 sc_RayTracedShadowTextureSize 3888
//float4 sc_RayTracedShadowTextureDims 3904
//float4 sc_RayTracedShadowTextureView 3920
//float4 sc_RayTracedDiffIndTextureSize 3936
//float4 sc_RayTracedDiffIndTextureDims 3952
//float4 sc_RayTracedDiffIndTextureView 3968
//float4 sc_RayTracedAoTextureSize 3984
//float4 sc_RayTracedAoTextureDims 4000
//float4 sc_RayTracedAoTextureView 4016
//float receiver_mask 4032
//float3 OriginNormalizationScale 4048
//float3 OriginNormalizationScaleInv 4064
//float3 OriginNormalizationOffset 4080
//int receiverId 4096
//int instance_id 4100
//int lray_triangles_last 4104
//bool noEarlyZ 4108
//bool has_animated_pn 4112
//int emitter_stride 4116
//int proxy_offset_position 4120
//int proxy_offset_normal 4124
//int proxy_offset_tangent 4128
//int proxy_offset_color 4132
//int proxy_offset_texture0 4136
//int proxy_offset_texture1 4140
//int proxy_offset_texture2 4144
//int proxy_offset_texture3 4148
//int proxy_format_position 4152
//int proxy_format_normal 4156
//int proxy_format_tangent 4160
//int proxy_format_color 4164
//int proxy_format_texture0 4168
//int proxy_format_texture1 4172
//int proxy_format_texture2 4176
//int proxy_format_texture3 4180
//float4 z_rayDirectionsSize 4192
//float4 z_rayDirectionsDims 4208
//float4 z_rayDirectionsView 4224
//float correctedIntensity 4240
//float4 intensityTextureSize 4256
//float4 intensityTextureDims 4272
//float4 intensityTextureView 4288
//float3x3 intensityTextureTransform 4304
//float4 intensityTextureUvMinMax 4352
//float4 intensityTextureBorderColor 4368
//float reflBlurWidth 4384
//float reflBlurMinRough 4388
//float reflBlurMaxRough 4392
//int overrideTimeEnabled 4396
//float overrideTimeElapsed 4400
//float overrideTimeDelta 4404
//int PreviewEnabled 4408
//int PreviewNodeID 4412
//float alphaTestThreshold 4416
//float4 backCapTexSize 4432
//float4 backCapTexDims 4448
//float4 backCapTexView 4464
//float3x3 backCapTexTransform 4480
//float4 backCapTexUvMinMax 4528
//float4 backCapTexBorderColor 4544
//float2 backCapTexScale 4560
//float2 backCapTexOffset 4568
//float4 backCapStartingColor 4576
//float4 backCapEndingColor 4592
//float backCapGradientRamp 4608
//float backCapMetallic 4612
//float backCapRoughness 4616
//float4 frontCapTexSize 4624
//float4 frontCapTexDims 4640
//float4 frontCapTexView 4656
//float3x3 frontCapTexTransform 4672
//float4 frontCapTexUvMinMax 4720
//float4 frontCapTexBorderColor 4736
//float2 frontCapTexScale 4752
//float2 frontCapTexOffset 4760
//float4 frontCapStartingColor 4768
//float4 frontCapEndingColor 4784
//float frontCapGradientRamp 4800
//float frontCapMetallic 4804
//float frontCapRoughness 4808
//float4 outerEdgeTexSize 4816
//float4 outerEdgeTexDims 4832
//float4 outerEdgeTexView 4848
//float3x3 outerEdgeTexTransform 4864
//float4 outerEdgeTexUvMinMax 4912
//float4 outerEdgeTexBorderColor 4928
//float2 outerEdgeTexScale 4944
//float2 outerEdgeTexOffset 4952
//float4 outerEdgeStartingColor 4960
//float4 outerEdgeEndingColor 4976
//float outerEdgeGradientRamp 4992
//float outerEdgeMetallic 4996
//float outerRoughness 5000
//float4 InnerEdgeTexSize 5008
//float4 InnerEdgeTexDims 5024
//float4 InnerEdgeTexView 5040
//float3x3 InnerEdgeTexTransform 5056
//float4 InnerEdgeTexUvMinMax 5104
//float4 InnerEdgeTexBorderColor 5120
//float2 InnerEdgeTexScale 5136
//float2 InnerEdgeTexOffset 5144
//float4 InnerEdgeStartingColor 5152
//float4 InnerEdgeEndingColor 5168
//float InnerEdgeGradientRamp 5184
//float InnerEdgeMetallic 5188
//float InnerEdgeRoughness 5192
//float4 Port_Import_N129 5200
//float4 Port_Import_N130 5216
//float Port_Input0_N143 5232
//float Port_Input1_N143 5236
//float Port_RangeMinA_N132 5240
//float Port_RangeMaxA_N132 5244
//float Port_RangeMinB_N132 5248
//float Port_RangeMaxB_N132 5252
//float2 Port_Import_N133 5256
//float2 Port_Center_N134 5264
//float2 Port_Import_N135 5272
//float Port_RangeMinA_N164 5280
//float Port_RangeMaxA_N164 5284
//float Port_RangeMinB_N164 5288
//float Port_RangeMaxB_N164 5292
//float2 Port_Import_N137 5296
//float Port_Input1_N142 5304
//float Port_Input2_N142 5308
//float4 Port_Default_N146 5312
//float Port_Opacity_N149 5328
//float3 Port_Normal_N149 5344
//float3 Port_Emissive_N149 5360
//float3 Port_AO_N149 5376
//float3 Port_SpecularAO_N149 5392
//float4 Port_Import_N098 5408
//float4 Port_Import_N099 5424
//float Port_Input0_N112 5440
//float Port_Input1_N112 5444
//float Port_RangeMinA_N101 5448
//float Port_RangeMaxA_N101 5452
//float Port_RangeMinB_N101 5456
//float Port_RangeMaxB_N101 5460
//float2 Port_Import_N102 5464
//float2 Port_Center_N103 5472
//float2 Port_Import_N104 5480
//float Port_RangeMinA_N160 5488
//float Port_RangeMaxA_N160 5492
//float Port_RangeMinB_N160 5496
//float Port_RangeMaxB_N160 5500
//float2 Port_Import_N106 5504
//float Port_Input1_N111 5512
//float Port_Input2_N111 5516
//float4 Port_Default_N010 5520
//float Port_Opacity_N118 5536
//float3 Port_Normal_N118 5552
//float3 Port_Emissive_N118 5568
//float3 Port_AO_N118 5584
//float3 Port_SpecularAO_N118 5600
//float Port_Input1_N054 5616
//float4 Port_Import_N038 5632
//float4 Port_Import_N039 5648
//float Port_Input0_N066 5664
//float Port_Input1_N066 5668
//float Port_RangeMinA_N033 5672
//float Port_RangeMaxA_N033 5676
//float Port_RangeMinB_N033 5680
//float Port_RangeMaxB_N033 5684
//float2 Port_Import_N017 5688
//float2 Port_Center_N047 5696
//float2 Port_Import_N058 5704
//float Port_RangeMinA_N153 5712
//float Port_RangeMaxA_N153 5716
//float Port_RangeMinB_N153 5720
//float Port_RangeMaxB_N153 5724
//float2 Port_Import_N060 5728
//float Port_Input1_N065 5736
//float Port_Input2_N065 5740
//float4 Port_Default_N046 5744
//float Port_Opacity_N057 5760
//float3 Port_Normal_N057 5776
//float3 Port_Emissive_N057 5792
//float3 Port_AO_N057 5808
//float3 Port_SpecularAO_N057 5824
//float4 Port_Import_N020 5840
//float4 Port_Import_N021 5856
//float Port_Input0_N035 5872
//float Port_Input1_N035 5876
//float Port_RangeMinA_N023 5880
//float Port_RangeMaxA_N023 5884
//float Port_RangeMinB_N023 5888
//float Port_RangeMaxB_N023 5892
//float2 Port_Import_N024 5896
//float2 Port_Center_N025 5904
//float2 Port_Import_N026 5912
//float Port_RangeMinA_N155 5920
//float Port_RangeMaxA_N155 5924
//float Port_RangeMinB_N155 5928
//float Port_RangeMaxB_N155 5932
//float2 Port_Import_N028 5936
//float Port_Input1_N034 5944
//float Port_Input2_N034 5948
//float4 Port_Default_N077 5952
//float Port_Opacity_N080 5968
//float3 Port_Normal_N080 5984
//float3 Port_Emissive_N080 6000
//float3 Port_AO_N080 6016
//float3 Port_SpecularAO_N080 6032
//float Port_Input1_N043 6048
//float Port_Input1_N014 6052
//float depthRef 6056
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
//spec_const bool InnerEdgeTexHasSwappedViews 1031
//spec_const bool SC_USE_CLAMP_TO_BORDER_InnerEdgeTex 1032
//spec_const bool SC_USE_CLAMP_TO_BORDER_backCapTex 1033
//spec_const bool SC_USE_CLAMP_TO_BORDER_frontCapTex 1034
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 1035
//spec_const bool SC_USE_CLAMP_TO_BORDER_outerEdgeTex 1036
//spec_const bool SC_USE_UV_MIN_MAX_InnerEdgeTex 1037
//spec_const bool SC_USE_UV_MIN_MAX_backCapTex 1038
//spec_const bool SC_USE_UV_MIN_MAX_frontCapTex 1039
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 1040
//spec_const bool SC_USE_UV_MIN_MAX_outerEdgeTex 1041
//spec_const bool SC_USE_UV_TRANSFORM_InnerEdgeTex 1042
//spec_const bool SC_USE_UV_TRANSFORM_backCapTex 1043
//spec_const bool SC_USE_UV_TRANSFORM_frontCapTex 1044
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 1045
//spec_const bool SC_USE_UV_TRANSFORM_outerEdgeTex 1046
//spec_const bool UseViewSpaceDepthVariant 1047
//spec_const bool backCapPBR 1048
//spec_const bool backCapTexHasSwappedViews 1049
//spec_const bool frontCapPBR 1050
//spec_const bool frontCapTexHasSwappedViews 1051
//spec_const bool innerEdgePBR 1052
//spec_const bool intensityTextureHasSwappedViews 1053
//spec_const bool outerEdgePBR 1054
//spec_const bool outerEdgeTexHasSwappedViews 1055
//spec_const bool sc_BlendMode_AddWithAlphaFactor 1056
//spec_const bool sc_BlendMode_Add 1057
//spec_const bool sc_BlendMode_AlphaTest 1058
//spec_const bool sc_BlendMode_AlphaToCoverage 1059
//spec_const bool sc_BlendMode_ColoredGlass 1060
//spec_const bool sc_BlendMode_Custom 1061
//spec_const bool sc_BlendMode_Max 1062
//spec_const bool sc_BlendMode_Min 1063
//spec_const bool sc_BlendMode_MultiplyOriginal 1064
//spec_const bool sc_BlendMode_Multiply 1065
//spec_const bool sc_BlendMode_Normal 1066
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 1067
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 1068
//spec_const bool sc_BlendMode_PremultipliedAlpha 1069
//spec_const bool sc_BlendMode_Screen 1070
//spec_const bool sc_DepthOnly 1071
//spec_const bool sc_EnvmapDiffuseHasSwappedViews 1072
//spec_const bool sc_EnvmapSpecularHasSwappedViews 1073
//spec_const bool sc_FramebufferFetch 1074
//spec_const bool sc_HasDiffuseEnvmap 1075
//spec_const bool sc_LightEstimation 1076
//spec_const bool sc_MotionVectorsPass 1077
//spec_const bool sc_OITCompositingPass 1078
//spec_const bool sc_OITDepthBoundsPass 1079
//spec_const bool sc_OITDepthGatherPass 1080
//spec_const bool sc_ProjectiveShadowsCaster 1081
//spec_const bool sc_ProjectiveShadowsReceiver 1082
//spec_const bool sc_ProxyAlphaOne 1083
//spec_const bool sc_RayTracedAoTextureHasSwappedViews 1084
//spec_const bool sc_RayTracedDiffIndTextureHasSwappedViews 1085
//spec_const bool sc_RayTracedReflectionTextureHasSwappedViews 1086
//spec_const bool sc_RayTracedShadowTextureHasSwappedViews 1087
//spec_const bool sc_RenderAlphaToColor 1088
//spec_const bool sc_SSAOEnabled 1089
//spec_const bool sc_ScreenTextureHasSwappedViews 1090
//spec_const bool sc_ShaderComplexityAnalyzer 1091
//spec_const bool sc_UseFramebufferFetchMarker 1092
//spec_const bool sc_VertexBlendingUseNormals 1093
//spec_const bool sc_VertexBlending 1094
//spec_const int DROPLIST_BACK_CAP_MODE 1095
//spec_const int DROPLIST_FRONT_CAP_MODE 1096
//spec_const int DROPLIST_INNER_EDGE_MODE 1097
//spec_const int DROPLIST_OUTER_EDGE_MODE 1098
//spec_const int InnerEdgeTexLayout 1099
//spec_const int SC_DEVICE_CLASS 1100
//spec_const int SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex 1101
//spec_const int SC_SOFTWARE_WRAP_MODE_U_backCapTex 1102
//spec_const int SC_SOFTWARE_WRAP_MODE_U_frontCapTex 1103
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 1104
//spec_const int SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex 1105
//spec_const int SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex 1106
//spec_const int SC_SOFTWARE_WRAP_MODE_V_backCapTex 1107
//spec_const int SC_SOFTWARE_WRAP_MODE_V_frontCapTex 1108
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 1109
//spec_const int SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex 1110
//spec_const int backCapTexLayout 1111
//spec_const int frontCapTexLayout 1112
//spec_const int intensityTextureLayout 1113
//spec_const int outerEdgeTexLayout 1114
//spec_const int sc_AmbientLightMode0 1115
//spec_const int sc_AmbientLightMode1 1116
//spec_const int sc_AmbientLightMode2 1117
//spec_const int sc_AmbientLightMode_Constant 1118
//spec_const int sc_AmbientLightMode_EnvironmentMap 1119
//spec_const int sc_AmbientLightMode_FromCamera 1120
//spec_const int sc_AmbientLightMode_SphericalHarmonics 1121
//spec_const int sc_AmbientLightsCount 1122
//spec_const int sc_DepthBufferMode 1123
//spec_const int sc_DirectionalLightsCount 1124
//spec_const int sc_EnvLightMode 1125
//spec_const int sc_EnvmapDiffuseLayout 1126
//spec_const int sc_EnvmapSpecularLayout 1127
//spec_const int sc_LightEstimationSGCount 1128
//spec_const int sc_MaxTextureImageUnits 1129
//spec_const int sc_PointLightsCount 1130
//spec_const int sc_RayTracedAoTextureLayout 1131
//spec_const int sc_RayTracedDiffIndTextureLayout 1132
//spec_const int sc_RayTracedReflectionTextureLayout 1133
//spec_const int sc_RayTracedShadowTextureLayout 1134
//spec_const int sc_RenderingSpace 1135
//spec_const int sc_ScreenTextureLayout 1136
//spec_const int sc_SkinBonesCount 1137
//spec_const int sc_StereoRenderingMode 1138
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 1139
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
constant bool InnerEdgeTexHasSwappedViews [[function_constant(1031)]];
constant bool InnerEdgeTexHasSwappedViews_tmp = is_function_constant_defined(InnerEdgeTexHasSwappedViews) ? InnerEdgeTexHasSwappedViews : false;
constant bool SC_USE_CLAMP_TO_BORDER_InnerEdgeTex [[function_constant(1032)]];
constant bool SC_USE_CLAMP_TO_BORDER_InnerEdgeTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_InnerEdgeTex) ? SC_USE_CLAMP_TO_BORDER_InnerEdgeTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_backCapTex [[function_constant(1033)]];
constant bool SC_USE_CLAMP_TO_BORDER_backCapTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_backCapTex) ? SC_USE_CLAMP_TO_BORDER_backCapTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_frontCapTex [[function_constant(1034)]];
constant bool SC_USE_CLAMP_TO_BORDER_frontCapTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_frontCapTex) ? SC_USE_CLAMP_TO_BORDER_frontCapTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(1035)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_outerEdgeTex [[function_constant(1036)]];
constant bool SC_USE_CLAMP_TO_BORDER_outerEdgeTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_outerEdgeTex) ? SC_USE_CLAMP_TO_BORDER_outerEdgeTex : false;
constant bool SC_USE_UV_MIN_MAX_InnerEdgeTex [[function_constant(1037)]];
constant bool SC_USE_UV_MIN_MAX_InnerEdgeTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_InnerEdgeTex) ? SC_USE_UV_MIN_MAX_InnerEdgeTex : false;
constant bool SC_USE_UV_MIN_MAX_backCapTex [[function_constant(1038)]];
constant bool SC_USE_UV_MIN_MAX_backCapTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_backCapTex) ? SC_USE_UV_MIN_MAX_backCapTex : false;
constant bool SC_USE_UV_MIN_MAX_frontCapTex [[function_constant(1039)]];
constant bool SC_USE_UV_MIN_MAX_frontCapTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_frontCapTex) ? SC_USE_UV_MIN_MAX_frontCapTex : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(1040)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_outerEdgeTex [[function_constant(1041)]];
constant bool SC_USE_UV_MIN_MAX_outerEdgeTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_outerEdgeTex) ? SC_USE_UV_MIN_MAX_outerEdgeTex : false;
constant bool SC_USE_UV_TRANSFORM_InnerEdgeTex [[function_constant(1042)]];
constant bool SC_USE_UV_TRANSFORM_InnerEdgeTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_InnerEdgeTex) ? SC_USE_UV_TRANSFORM_InnerEdgeTex : false;
constant bool SC_USE_UV_TRANSFORM_backCapTex [[function_constant(1043)]];
constant bool SC_USE_UV_TRANSFORM_backCapTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_backCapTex) ? SC_USE_UV_TRANSFORM_backCapTex : false;
constant bool SC_USE_UV_TRANSFORM_frontCapTex [[function_constant(1044)]];
constant bool SC_USE_UV_TRANSFORM_frontCapTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_frontCapTex) ? SC_USE_UV_TRANSFORM_frontCapTex : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(1045)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_outerEdgeTex [[function_constant(1046)]];
constant bool SC_USE_UV_TRANSFORM_outerEdgeTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_outerEdgeTex) ? SC_USE_UV_TRANSFORM_outerEdgeTex : false;
constant bool UseViewSpaceDepthVariant [[function_constant(1047)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool backCapPBR [[function_constant(1048)]];
constant bool backCapPBR_tmp = is_function_constant_defined(backCapPBR) ? backCapPBR : false;
constant bool backCapTexHasSwappedViews [[function_constant(1049)]];
constant bool backCapTexHasSwappedViews_tmp = is_function_constant_defined(backCapTexHasSwappedViews) ? backCapTexHasSwappedViews : false;
constant bool frontCapPBR [[function_constant(1050)]];
constant bool frontCapPBR_tmp = is_function_constant_defined(frontCapPBR) ? frontCapPBR : false;
constant bool frontCapTexHasSwappedViews [[function_constant(1051)]];
constant bool frontCapTexHasSwappedViews_tmp = is_function_constant_defined(frontCapTexHasSwappedViews) ? frontCapTexHasSwappedViews : false;
constant bool innerEdgePBR [[function_constant(1052)]];
constant bool innerEdgePBR_tmp = is_function_constant_defined(innerEdgePBR) ? innerEdgePBR : false;
constant bool intensityTextureHasSwappedViews [[function_constant(1053)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool outerEdgePBR [[function_constant(1054)]];
constant bool outerEdgePBR_tmp = is_function_constant_defined(outerEdgePBR) ? outerEdgePBR : false;
constant bool outerEdgeTexHasSwappedViews [[function_constant(1055)]];
constant bool outerEdgeTexHasSwappedViews_tmp = is_function_constant_defined(outerEdgeTexHasSwappedViews) ? outerEdgeTexHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(1056)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(1057)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(1058)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(1059)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(1060)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(1061)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(1062)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(1063)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(1064)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(1065)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(1066)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(1067)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(1068)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(1069)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(1070)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(1071)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_EnvmapDiffuseHasSwappedViews [[function_constant(1072)]];
constant bool sc_EnvmapDiffuseHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapDiffuseHasSwappedViews) ? sc_EnvmapDiffuseHasSwappedViews : false;
constant bool sc_EnvmapSpecularHasSwappedViews [[function_constant(1073)]];
constant bool sc_EnvmapSpecularHasSwappedViews_tmp = is_function_constant_defined(sc_EnvmapSpecularHasSwappedViews) ? sc_EnvmapSpecularHasSwappedViews : false;
constant bool sc_FramebufferFetch [[function_constant(1074)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_HasDiffuseEnvmap [[function_constant(1075)]];
constant bool sc_HasDiffuseEnvmap_tmp = is_function_constant_defined(sc_HasDiffuseEnvmap) ? sc_HasDiffuseEnvmap : false;
constant bool sc_LightEstimation [[function_constant(1076)]];
constant bool sc_LightEstimation_tmp = is_function_constant_defined(sc_LightEstimation) ? sc_LightEstimation : false;
constant bool sc_MotionVectorsPass [[function_constant(1077)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(1078)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(1079)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(1080)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(1081)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(1082)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_ProxyAlphaOne [[function_constant(1083)]];
constant bool sc_ProxyAlphaOne_tmp = is_function_constant_defined(sc_ProxyAlphaOne) ? sc_ProxyAlphaOne : false;
constant bool sc_RayTracedAoTextureHasSwappedViews [[function_constant(1084)]];
constant bool sc_RayTracedAoTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedAoTextureHasSwappedViews) ? sc_RayTracedAoTextureHasSwappedViews : false;
constant bool sc_RayTracedDiffIndTextureHasSwappedViews [[function_constant(1085)]];
constant bool sc_RayTracedDiffIndTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureHasSwappedViews) ? sc_RayTracedDiffIndTextureHasSwappedViews : false;
constant bool sc_RayTracedReflectionTextureHasSwappedViews [[function_constant(1086)]];
constant bool sc_RayTracedReflectionTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureHasSwappedViews) ? sc_RayTracedReflectionTextureHasSwappedViews : false;
constant bool sc_RayTracedShadowTextureHasSwappedViews [[function_constant(1087)]];
constant bool sc_RayTracedShadowTextureHasSwappedViews_tmp = is_function_constant_defined(sc_RayTracedShadowTextureHasSwappedViews) ? sc_RayTracedShadowTextureHasSwappedViews : false;
constant bool sc_RenderAlphaToColor [[function_constant(1088)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_SSAOEnabled [[function_constant(1089)]];
constant bool sc_SSAOEnabled_tmp = is_function_constant_defined(sc_SSAOEnabled) ? sc_SSAOEnabled : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(1090)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(1091)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(1092)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(1093)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(1094)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant int DROPLIST_BACK_CAP_MODE [[function_constant(1095)]];
constant int DROPLIST_BACK_CAP_MODE_tmp = is_function_constant_defined(DROPLIST_BACK_CAP_MODE) ? DROPLIST_BACK_CAP_MODE : 0;
constant int DROPLIST_FRONT_CAP_MODE [[function_constant(1096)]];
constant int DROPLIST_FRONT_CAP_MODE_tmp = is_function_constant_defined(DROPLIST_FRONT_CAP_MODE) ? DROPLIST_FRONT_CAP_MODE : 0;
constant int DROPLIST_INNER_EDGE_MODE [[function_constant(1097)]];
constant int DROPLIST_INNER_EDGE_MODE_tmp = is_function_constant_defined(DROPLIST_INNER_EDGE_MODE) ? DROPLIST_INNER_EDGE_MODE : 0;
constant int DROPLIST_OUTER_EDGE_MODE [[function_constant(1098)]];
constant int DROPLIST_OUTER_EDGE_MODE_tmp = is_function_constant_defined(DROPLIST_OUTER_EDGE_MODE) ? DROPLIST_OUTER_EDGE_MODE : 0;
constant int InnerEdgeTexLayout [[function_constant(1099)]];
constant int InnerEdgeTexLayout_tmp = is_function_constant_defined(InnerEdgeTexLayout) ? InnerEdgeTexLayout : 0;
constant int SC_DEVICE_CLASS [[function_constant(1100)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex [[function_constant(1101)]];
constant int SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex) ? SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_backCapTex [[function_constant(1102)]];
constant int SC_SOFTWARE_WRAP_MODE_U_backCapTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_backCapTex) ? SC_SOFTWARE_WRAP_MODE_U_backCapTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_frontCapTex [[function_constant(1103)]];
constant int SC_SOFTWARE_WRAP_MODE_U_frontCapTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_frontCapTex) ? SC_SOFTWARE_WRAP_MODE_U_frontCapTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(1104)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex [[function_constant(1105)]];
constant int SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex) ? SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex [[function_constant(1106)]];
constant int SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex) ? SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_backCapTex [[function_constant(1107)]];
constant int SC_SOFTWARE_WRAP_MODE_V_backCapTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_backCapTex) ? SC_SOFTWARE_WRAP_MODE_V_backCapTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_frontCapTex [[function_constant(1108)]];
constant int SC_SOFTWARE_WRAP_MODE_V_frontCapTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_frontCapTex) ? SC_SOFTWARE_WRAP_MODE_V_frontCapTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(1109)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex [[function_constant(1110)]];
constant int SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex) ? SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex : -1;
constant int backCapTexLayout [[function_constant(1111)]];
constant int backCapTexLayout_tmp = is_function_constant_defined(backCapTexLayout) ? backCapTexLayout : 0;
constant int frontCapTexLayout [[function_constant(1112)]];
constant int frontCapTexLayout_tmp = is_function_constant_defined(frontCapTexLayout) ? frontCapTexLayout : 0;
constant int intensityTextureLayout [[function_constant(1113)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int outerEdgeTexLayout [[function_constant(1114)]];
constant int outerEdgeTexLayout_tmp = is_function_constant_defined(outerEdgeTexLayout) ? outerEdgeTexLayout : 0;
constant int sc_AmbientLightMode0 [[function_constant(1115)]];
constant int sc_AmbientLightMode0_tmp = is_function_constant_defined(sc_AmbientLightMode0) ? sc_AmbientLightMode0 : 0;
constant int sc_AmbientLightMode1 [[function_constant(1116)]];
constant int sc_AmbientLightMode1_tmp = is_function_constant_defined(sc_AmbientLightMode1) ? sc_AmbientLightMode1 : 0;
constant int sc_AmbientLightMode2 [[function_constant(1117)]];
constant int sc_AmbientLightMode2_tmp = is_function_constant_defined(sc_AmbientLightMode2) ? sc_AmbientLightMode2 : 0;
constant int sc_AmbientLightMode_Constant [[function_constant(1118)]];
constant int sc_AmbientLightMode_Constant_tmp = is_function_constant_defined(sc_AmbientLightMode_Constant) ? sc_AmbientLightMode_Constant : 0;
constant int sc_AmbientLightMode_EnvironmentMap [[function_constant(1119)]];
constant int sc_AmbientLightMode_EnvironmentMap_tmp = is_function_constant_defined(sc_AmbientLightMode_EnvironmentMap) ? sc_AmbientLightMode_EnvironmentMap : 0;
constant int sc_AmbientLightMode_FromCamera [[function_constant(1120)]];
constant int sc_AmbientLightMode_FromCamera_tmp = is_function_constant_defined(sc_AmbientLightMode_FromCamera) ? sc_AmbientLightMode_FromCamera : 0;
constant int sc_AmbientLightMode_SphericalHarmonics [[function_constant(1121)]];
constant int sc_AmbientLightMode_SphericalHarmonics_tmp = is_function_constant_defined(sc_AmbientLightMode_SphericalHarmonics) ? sc_AmbientLightMode_SphericalHarmonics : 0;
constant int sc_AmbientLightsCount [[function_constant(1122)]];
constant int sc_AmbientLightsCount_tmp = is_function_constant_defined(sc_AmbientLightsCount) ? sc_AmbientLightsCount : 0;
constant int sc_DepthBufferMode [[function_constant(1123)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_DirectionalLightsCount [[function_constant(1124)]];
constant int sc_DirectionalLightsCount_tmp = is_function_constant_defined(sc_DirectionalLightsCount) ? sc_DirectionalLightsCount : 0;
constant int sc_EnvLightMode [[function_constant(1125)]];
constant int sc_EnvLightMode_tmp = is_function_constant_defined(sc_EnvLightMode) ? sc_EnvLightMode : 0;
constant int sc_EnvmapDiffuseLayout [[function_constant(1126)]];
constant int sc_EnvmapDiffuseLayout_tmp = is_function_constant_defined(sc_EnvmapDiffuseLayout) ? sc_EnvmapDiffuseLayout : 0;
constant int sc_EnvmapSpecularLayout [[function_constant(1127)]];
constant int sc_EnvmapSpecularLayout_tmp = is_function_constant_defined(sc_EnvmapSpecularLayout) ? sc_EnvmapSpecularLayout : 0;
constant int sc_LightEstimationSGCount [[function_constant(1128)]];
constant int sc_LightEstimationSGCount_tmp = is_function_constant_defined(sc_LightEstimationSGCount) ? sc_LightEstimationSGCount : 0;
constant int sc_MaxTextureImageUnits [[function_constant(1129)]];
constant int sc_MaxTextureImageUnits_tmp = is_function_constant_defined(sc_MaxTextureImageUnits) ? sc_MaxTextureImageUnits : 0;
constant int sc_PointLightsCount [[function_constant(1130)]];
constant int sc_PointLightsCount_tmp = is_function_constant_defined(sc_PointLightsCount) ? sc_PointLightsCount : 0;
constant int sc_RayTracedAoTextureLayout [[function_constant(1131)]];
constant int sc_RayTracedAoTextureLayout_tmp = is_function_constant_defined(sc_RayTracedAoTextureLayout) ? sc_RayTracedAoTextureLayout : 0;
constant int sc_RayTracedDiffIndTextureLayout [[function_constant(1132)]];
constant int sc_RayTracedDiffIndTextureLayout_tmp = is_function_constant_defined(sc_RayTracedDiffIndTextureLayout) ? sc_RayTracedDiffIndTextureLayout : 0;
constant int sc_RayTracedReflectionTextureLayout [[function_constant(1133)]];
constant int sc_RayTracedReflectionTextureLayout_tmp = is_function_constant_defined(sc_RayTracedReflectionTextureLayout) ? sc_RayTracedReflectionTextureLayout : 0;
constant int sc_RayTracedShadowTextureLayout [[function_constant(1134)]];
constant int sc_RayTracedShadowTextureLayout_tmp = is_function_constant_defined(sc_RayTracedShadowTextureLayout) ? sc_RayTracedShadowTextureLayout : 0;
constant int sc_RenderingSpace [[function_constant(1135)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(1136)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_SkinBonesCount [[function_constant(1137)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(1138)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(1139)]];
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
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
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
float4 backCapTexSize;
float4 backCapTexDims;
float4 backCapTexView;
float3x3 backCapTexTransform;
float4 backCapTexUvMinMax;
float4 backCapTexBorderColor;
float2 backCapTexScale;
float2 backCapTexOffset;
float4 backCapStartingColor;
float4 backCapEndingColor;
float backCapGradientRamp;
float backCapMetallic;
float backCapRoughness;
float4 frontCapTexSize;
float4 frontCapTexDims;
float4 frontCapTexView;
float3x3 frontCapTexTransform;
float4 frontCapTexUvMinMax;
float4 frontCapTexBorderColor;
float2 frontCapTexScale;
float2 frontCapTexOffset;
float4 frontCapStartingColor;
float4 frontCapEndingColor;
float frontCapGradientRamp;
float frontCapMetallic;
float frontCapRoughness;
float4 outerEdgeTexSize;
float4 outerEdgeTexDims;
float4 outerEdgeTexView;
float3x3 outerEdgeTexTransform;
float4 outerEdgeTexUvMinMax;
float4 outerEdgeTexBorderColor;
float2 outerEdgeTexScale;
float2 outerEdgeTexOffset;
float4 outerEdgeStartingColor;
float4 outerEdgeEndingColor;
float outerEdgeGradientRamp;
float outerEdgeMetallic;
float outerRoughness;
float4 InnerEdgeTexSize;
float4 InnerEdgeTexDims;
float4 InnerEdgeTexView;
float3x3 InnerEdgeTexTransform;
float4 InnerEdgeTexUvMinMax;
float4 InnerEdgeTexBorderColor;
float2 InnerEdgeTexScale;
float2 InnerEdgeTexOffset;
float4 InnerEdgeStartingColor;
float4 InnerEdgeEndingColor;
float InnerEdgeGradientRamp;
float InnerEdgeMetallic;
float InnerEdgeRoughness;
float4 Port_Import_N129;
float4 Port_Import_N130;
float Port_Input0_N143;
float Port_Input1_N143;
float Port_RangeMinA_N132;
float Port_RangeMaxA_N132;
float Port_RangeMinB_N132;
float Port_RangeMaxB_N132;
float2 Port_Import_N133;
float2 Port_Center_N134;
float2 Port_Import_N135;
float Port_RangeMinA_N164;
float Port_RangeMaxA_N164;
float Port_RangeMinB_N164;
float Port_RangeMaxB_N164;
float2 Port_Import_N137;
float Port_Input1_N142;
float Port_Input2_N142;
float4 Port_Default_N146;
float Port_Opacity_N149;
float3 Port_Normal_N149;
float3 Port_Emissive_N149;
float3 Port_AO_N149;
float3 Port_SpecularAO_N149;
float4 Port_Import_N098;
float4 Port_Import_N099;
float Port_Input0_N112;
float Port_Input1_N112;
float Port_RangeMinA_N101;
float Port_RangeMaxA_N101;
float Port_RangeMinB_N101;
float Port_RangeMaxB_N101;
float2 Port_Import_N102;
float2 Port_Center_N103;
float2 Port_Import_N104;
float Port_RangeMinA_N160;
float Port_RangeMaxA_N160;
float Port_RangeMinB_N160;
float Port_RangeMaxB_N160;
float2 Port_Import_N106;
float Port_Input1_N111;
float Port_Input2_N111;
float4 Port_Default_N010;
float Port_Opacity_N118;
float3 Port_Normal_N118;
float3 Port_Emissive_N118;
float3 Port_AO_N118;
float3 Port_SpecularAO_N118;
float Port_Input1_N054;
float4 Port_Import_N038;
float4 Port_Import_N039;
float Port_Input0_N066;
float Port_Input1_N066;
float Port_RangeMinA_N033;
float Port_RangeMaxA_N033;
float Port_RangeMinB_N033;
float Port_RangeMaxB_N033;
float2 Port_Import_N017;
float2 Port_Center_N047;
float2 Port_Import_N058;
float Port_RangeMinA_N153;
float Port_RangeMaxA_N153;
float Port_RangeMinB_N153;
float Port_RangeMaxB_N153;
float2 Port_Import_N060;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Default_N046;
float Port_Opacity_N057;
float3 Port_Normal_N057;
float3 Port_Emissive_N057;
float3 Port_AO_N057;
float3 Port_SpecularAO_N057;
float4 Port_Import_N020;
float4 Port_Import_N021;
float Port_Input0_N035;
float Port_Input1_N035;
float Port_RangeMinA_N023;
float Port_RangeMaxA_N023;
float Port_RangeMinB_N023;
float Port_RangeMaxB_N023;
float2 Port_Import_N024;
float2 Port_Center_N025;
float2 Port_Import_N026;
float Port_RangeMinA_N155;
float Port_RangeMaxA_N155;
float Port_RangeMinB_N155;
float Port_RangeMaxB_N155;
float2 Port_Import_N028;
float Port_Input1_N034;
float Port_Input2_N034;
float4 Port_Default_N077;
float Port_Opacity_N080;
float3 Port_Normal_N080;
float3 Port_Emissive_N080;
float3 Port_AO_N080;
float3 Port_SpecularAO_N080;
float Port_Input1_N043;
float Port_Input1_N014;
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
texture2d<float> InnerEdgeTex [[id(4)]];
texture2d<float> backCapTex [[id(5)]];
texture2d<float> frontCapTex [[id(6)]];
texture2d<float> intensityTexture [[id(7)]];
texture2d<float> outerEdgeTex [[id(8)]];
texture2d<float> sc_EnvmapDiffuse [[id(9)]];
texture2d<float> sc_EnvmapSpecular [[id(10)]];
texture2d<float> sc_RayTracedAoTexture [[id(19)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(20)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(21)]];
texture2d<float> sc_RayTracedShadowTexture [[id(22)]];
texture2d<float> sc_SSAOTexture [[id(23)]];
texture2d<float> sc_ScreenTexture [[id(24)]];
texture2d<float> sc_ShadowTexture [[id(25)]];
texture2d<uint> z_hitIdAndBarycentric [[id(27)]];
texture2d<float> z_rayDirections [[id(28)]];
sampler InnerEdgeTexSmpSC [[id(29)]];
sampler backCapTexSmpSC [[id(30)]];
sampler frontCapTexSmpSC [[id(31)]];
sampler intensityTextureSmpSC [[id(32)]];
sampler outerEdgeTexSmpSC [[id(33)]];
sampler sc_EnvmapDiffuseSmpSC [[id(34)]];
sampler sc_EnvmapSpecularSmpSC [[id(35)]];
sampler sc_RayTracedAoTextureSmpSC [[id(37)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(38)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(39)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(40)]];
sampler sc_SSAOTextureSmpSC [[id(41)]];
sampler sc_ScreenTextureSmpSC [[id(42)]];
sampler sc_ShadowTextureSmpSC [[id(43)]];
sampler z_hitIdAndBarycentricSmp [[id(45)]];
sampler z_rayDirectionsSmpSC [[id(46)]];
constant userUniformsObj* UserUniforms [[id(47)]];
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
struct SurfaceProperties
{
float3 albedo;
float opacity;
float3 normal;
float3 positionWS;
float3 viewDirWS;
float metallic;
float roughness;
float3 emissive;
float3 ao;
float3 specularAo;
float3 bakedShadows;
float3 specColor;
};
struct LightingComponents
{
float3 directDiffuse;
float3 directSpecular;
float3 indirectDiffuse;
float3 indirectSpecular;
float3 emitted;
float3 transmitted;
};
struct LightProperties
{
float3 direction;
float3 color;
float attenuation;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 BumpedNormal;
float3 ViewDirWS;
float3 PositionWS;
float3 VertexNormal_WorldSpace;
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
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
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
float4 backCapTexSize;
float4 backCapTexDims;
float4 backCapTexView;
float3x3 backCapTexTransform;
float4 backCapTexUvMinMax;
float4 backCapTexBorderColor;
float2 backCapTexScale;
float2 backCapTexOffset;
float4 backCapStartingColor;
float4 backCapEndingColor;
float backCapGradientRamp;
float backCapMetallic;
float backCapRoughness;
float4 frontCapTexSize;
float4 frontCapTexDims;
float4 frontCapTexView;
float3x3 frontCapTexTransform;
float4 frontCapTexUvMinMax;
float4 frontCapTexBorderColor;
float2 frontCapTexScale;
float2 frontCapTexOffset;
float4 frontCapStartingColor;
float4 frontCapEndingColor;
float frontCapGradientRamp;
float frontCapMetallic;
float frontCapRoughness;
float4 outerEdgeTexSize;
float4 outerEdgeTexDims;
float4 outerEdgeTexView;
float3x3 outerEdgeTexTransform;
float4 outerEdgeTexUvMinMax;
float4 outerEdgeTexBorderColor;
float2 outerEdgeTexScale;
float2 outerEdgeTexOffset;
float4 outerEdgeStartingColor;
float4 outerEdgeEndingColor;
float outerEdgeGradientRamp;
float outerEdgeMetallic;
float outerRoughness;
float4 InnerEdgeTexSize;
float4 InnerEdgeTexDims;
float4 InnerEdgeTexView;
float3x3 InnerEdgeTexTransform;
float4 InnerEdgeTexUvMinMax;
float4 InnerEdgeTexBorderColor;
float2 InnerEdgeTexScale;
float2 InnerEdgeTexOffset;
float4 InnerEdgeStartingColor;
float4 InnerEdgeEndingColor;
float InnerEdgeGradientRamp;
float InnerEdgeMetallic;
float InnerEdgeRoughness;
float4 Port_Import_N129;
float4 Port_Import_N130;
float Port_Input0_N143;
float Port_Input1_N143;
float Port_RangeMinA_N132;
float Port_RangeMaxA_N132;
float Port_RangeMinB_N132;
float Port_RangeMaxB_N132;
float2 Port_Import_N133;
float2 Port_Center_N134;
float2 Port_Import_N135;
float Port_RangeMinA_N164;
float Port_RangeMaxA_N164;
float Port_RangeMinB_N164;
float Port_RangeMaxB_N164;
float2 Port_Import_N137;
float Port_Input1_N142;
float Port_Input2_N142;
float4 Port_Default_N146;
float Port_Opacity_N149;
float3 Port_Normal_N149;
float3 Port_Emissive_N149;
float3 Port_AO_N149;
float3 Port_SpecularAO_N149;
float4 Port_Import_N098;
float4 Port_Import_N099;
float Port_Input0_N112;
float Port_Input1_N112;
float Port_RangeMinA_N101;
float Port_RangeMaxA_N101;
float Port_RangeMinB_N101;
float Port_RangeMaxB_N101;
float2 Port_Import_N102;
float2 Port_Center_N103;
float2 Port_Import_N104;
float Port_RangeMinA_N160;
float Port_RangeMaxA_N160;
float Port_RangeMinB_N160;
float Port_RangeMaxB_N160;
float2 Port_Import_N106;
float Port_Input1_N111;
float Port_Input2_N111;
float4 Port_Default_N010;
float Port_Opacity_N118;
float3 Port_Normal_N118;
float3 Port_Emissive_N118;
float3 Port_AO_N118;
float3 Port_SpecularAO_N118;
float Port_Input1_N054;
float4 Port_Import_N038;
float4 Port_Import_N039;
float Port_Input0_N066;
float Port_Input1_N066;
float Port_RangeMinA_N033;
float Port_RangeMaxA_N033;
float Port_RangeMinB_N033;
float Port_RangeMaxB_N033;
float2 Port_Import_N017;
float2 Port_Center_N047;
float2 Port_Import_N058;
float Port_RangeMinA_N153;
float Port_RangeMaxA_N153;
float Port_RangeMinB_N153;
float Port_RangeMaxB_N153;
float2 Port_Import_N060;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Default_N046;
float Port_Opacity_N057;
float3 Port_Normal_N057;
float3 Port_Emissive_N057;
float3 Port_AO_N057;
float3 Port_SpecularAO_N057;
float4 Port_Import_N020;
float4 Port_Import_N021;
float Port_Input0_N035;
float Port_Input1_N035;
float Port_RangeMinA_N023;
float Port_RangeMaxA_N023;
float Port_RangeMinB_N023;
float Port_RangeMaxB_N023;
float2 Port_Import_N024;
float2 Port_Center_N025;
float2 Port_Import_N026;
float Port_RangeMinA_N155;
float Port_RangeMaxA_N155;
float Port_RangeMinB_N155;
float Port_RangeMaxB_N155;
float2 Port_Import_N028;
float Port_Input1_N034;
float Port_Input2_N034;
float4 Port_Default_N077;
float Port_Opacity_N080;
float3 Port_Normal_N080;
float3 Port_Emissive_N080;
float3 Port_AO_N080;
float3 Port_SpecularAO_N080;
float Port_Input1_N043;
float Port_Input1_N014;
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
struct sc_PointLight_t_1
{
bool falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
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
texture2d<float> InnerEdgeTex [[id(4)]];
texture2d<float> backCapTex [[id(5)]];
texture2d<float> frontCapTex [[id(6)]];
texture2d<float> intensityTexture [[id(7)]];
texture2d<float> outerEdgeTex [[id(8)]];
texture2d<float> sc_EnvmapDiffuse [[id(9)]];
texture2d<float> sc_EnvmapSpecular [[id(10)]];
texture2d<float> sc_RayTracedAoTexture [[id(19)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(20)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(21)]];
texture2d<float> sc_RayTracedShadowTexture [[id(22)]];
texture2d<float> sc_SSAOTexture [[id(23)]];
texture2d<float> sc_ScreenTexture [[id(24)]];
texture2d<float> sc_ShadowTexture [[id(25)]];
texture2d<uint> z_hitIdAndBarycentric [[id(27)]];
texture2d<float> z_rayDirections [[id(28)]];
sampler InnerEdgeTexSmpSC [[id(29)]];
sampler backCapTexSmpSC [[id(30)]];
sampler frontCapTexSmpSC [[id(31)]];
sampler intensityTextureSmpSC [[id(32)]];
sampler outerEdgeTexSmpSC [[id(33)]];
sampler sc_EnvmapDiffuseSmpSC [[id(34)]];
sampler sc_EnvmapSpecularSmpSC [[id(35)]];
sampler sc_RayTracedAoTextureSmpSC [[id(37)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(38)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(39)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(40)]];
sampler sc_SSAOTextureSmpSC [[id(41)]];
sampler sc_ScreenTextureSmpSC [[id(42)]];
sampler sc_ShadowTextureSmpSC [[id(43)]];
sampler z_hitIdAndBarycentricSmp [[id(45)]];
sampler z_rayDirectionsSmpSC [[id(46)]];
constant userUniformsObj* UserUniforms [[id(47)]];
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
float3 evaluateSSAO(thread const float3& positionWS,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_SSAOTexture,thread sampler sc_SSAOTextureSmpSC)
{
if ((int(sc_SSAOEnabled_tmp)!=0))
{
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
float4 clipSpaceCoord=UserUniforms.sc_ViewProjectionMatrixArray[l9_1]*float4(positionWS,1.0);
float3 l9_2=clipSpaceCoord.xyz/float3(clipSpaceCoord.w);
clipSpaceCoord=float4(l9_2.x,l9_2.y,l9_2.z,clipSpaceCoord.w);
float4 shadowSample=sc_SSAOTexture.sample(sc_SSAOTextureSmpSC,((clipSpaceCoord.xy*0.5)+float2(0.5)));
return float3(shadowSample.x);
}
else
{
return float3(1.0);
}
}
float3 calculateDirectSpecular(thread const SurfaceProperties& surfaceProperties,thread const float3& L,thread const float3& V,constant userUniformsObj& UserUniforms)
{
float r=fast::max(surfaceProperties.roughness,0.029999999);
float3 F0=surfaceProperties.specColor;
float3 N=surfaceProperties.normal;
float3 H=normalize(L+V);
float param=dot(N,L);
float l9_0=fast::clamp(param,0.0,1.0);
float NdotL=l9_0;
float param_1=dot(N,V);
float l9_1=fast::clamp(param_1,0.0,1.0);
float NdotV=l9_1;
float param_2=dot(N,H);
float l9_2=fast::clamp(param_2,0.0,1.0);
float NdotH=l9_2;
float param_3=dot(V,H);
float l9_3=fast::clamp(param_3,0.0,1.0);
float VdotH=l9_3;
if (SC_DEVICE_CLASS_tmp>=2)
{
float param_4=NdotH;
float param_5=r;
float l9_4=param_5*param_5;
float l9_5=l9_4*l9_4;
float l9_6=param_4*param_4;
float l9_7=(l9_6*(l9_5-1.0))+1.0;
float l9_8=l9_7*l9_7;
float l9_9=9.9999999e-09;
bool l9_10=UserUniforms.isProxyMode!=0;
if (l9_10)
{
l9_9=1e-07;
}
float l9_11=l9_5/(l9_8+l9_9);
float param_6=NdotL;
float param_7=NdotV;
float param_8=r;
float l9_12=param_6;
float l9_13=param_8;
float l9_14=l9_13+1.0;
l9_14=(l9_14*l9_14)*0.125;
float l9_15=(l9_12*(1.0-l9_14))+l9_14;
float l9_16=param_7;
float l9_17=param_8;
float l9_18=l9_17+1.0;
l9_18=(l9_18*l9_18)*0.125;
float l9_19=(l9_16*(1.0-l9_18))+l9_18;
float l9_20=1.0/(l9_15*l9_19);
float param_9=VdotH;
float3 param_10=F0;
float l9_21=param_9;
float3 l9_22=param_10;
float3 l9_23=float3(1.0);
float l9_24=1.0-l9_21;
float l9_25=l9_24*l9_24;
float l9_26=(l9_25*l9_25)*l9_24;
float3 l9_27=l9_22+((l9_23-l9_22)*l9_26);
float3 l9_28=l9_27;
return l9_28*(((l9_11*l9_20)*0.25)*NdotL);
}
else
{
float specPower=exp2(11.0-(10.0*r));
float param_11=VdotH;
float3 param_12=F0;
float l9_29=param_11;
float3 l9_30=param_12;
float3 l9_31=float3(1.0);
float l9_32=1.0-l9_29;
float l9_33=l9_32*l9_32;
float l9_34=(l9_33*l9_33)*l9_32;
float3 l9_35=l9_30+((l9_31-l9_30)*l9_34);
float3 l9_36=l9_35;
return ((l9_36*((specPower*0.125)+0.25))*pow(NdotH,specPower))*NdotL;
}
}
float computeDistanceAttenuation(thread const float& distanceToLight,thread const float& falloffEndDistance)
{
float distanceToLightSquared=distanceToLight*distanceToLight;
if (falloffEndDistance==0.0)
{
return 1.0/distanceToLightSquared;
}
float distanceToLightToTheFourth=distanceToLightSquared*distanceToLightSquared;
float falloffEndDistanceToTheFourth=pow(falloffEndDistance,4.0);
return fast::max(fast::min(1.0-(distanceToLightToTheFourth/falloffEndDistanceToTheFourth),1.0),0.0)/distanceToLightSquared;
}
float2 calcSeamlessPanoramicUvsForSampling(thread const float2& uv,thread const float2& topMipRes,thread const float& lod)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 thisMipRes=fast::max(float2(1.0),topMipRes/float2(exp2(lod)));
return ((uv*(thisMipRes-float2(1.0)))/thisMipRes)+(float2(0.5)/thisMipRes);
}
else
{
return uv;
}
}
float4 sampleRayTracedIndirectDiffuse(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedDiffIndTexture,thread sampler sc_RayTracedDiffIndTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedDiffuseIndirect!=0;
if (l9_0)
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedDiffIndTextureHasSwappedViews_tmp)!=0))
{
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
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedDiffIndTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedDiffIndTexture.sample(sc_RayTracedDiffIndTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31;
}
return float4(0.0);
}
float3 getSpecularDominantDir(thread const float3& N,thread const float3& R,thread const float& roughness)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float lerpFactor=(roughness*roughness)*roughness;
return normalize(mix(R,N,float3(lerpFactor)));
}
else
{
return R;
}
}
float4 sampleRayTracedReflections(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedReflectionTexture,thread sampler sc_RayTracedReflectionTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedReflections!=0;
if (!l9_0)
{
return float4(0.0);
}
else
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedReflectionTextureHasSwappedViews_tmp)!=0))
{
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
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedReflectionTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedReflectionTexture.sample(sc_RayTracedReflectionTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31;
}
}
float3 envBRDFApprox(thread const SurfaceProperties& surfaceProperties,thread const float& NdotV)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float4 r=(float4(-1.0,-0.0275,-0.57200003,0.022)*surfaceProperties.roughness)+float4(1.0,0.0425,1.04,-0.039999999);
float a004=(fast::min(r.x*r.x,exp2((-9.2799997)*NdotV))*r.x)+r.y;
float2 AB=(float2(-1.04,1.04)*a004)+r.zw;
return fast::max((surfaceProperties.specColor*AB.x)+float3(AB.y),float3(0.0));
}
else
{
float3 fresnelMax=fast::max(float3(1.0-surfaceProperties.roughness),surfaceProperties.specColor);
float param=NdotV;
float3 param_1=surfaceProperties.specColor;
float3 param_2=fresnelMax;
float l9_0=1.0-param;
float l9_1=l9_0*l9_0;
float l9_2=(l9_1*l9_1)*l9_0;
float3 l9_3=param_1+((param_2-param_1)*l9_2);
return l9_3;
}
}
float sampleRayTracedAo(thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_RayTracedAoTexture,thread sampler sc_RayTracedAoTextureSmpSC,thread float4& gl_FragCoord)
{
bool l9_0=UserUniforms.receivesRayTracedAo!=0;
if (l9_0)
{
float4 l9_1=gl_FragCoord;
float2 l9_2=(l9_1.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 p=l9_2;
float2 param=p;
int l9_3=0;
if ((int(sc_RayTracedAoTextureHasSwappedViews_tmp)!=0))
{
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
l9_3=1-l9_5;
}
else
{
int l9_6=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_6=0;
}
else
{
l9_6=varStereoViewID;
}
int l9_7=l9_6;
l9_3=l9_7;
}
int l9_8=l9_3;
float2 l9_9=param;
int l9_10=l9_8;
float2 l9_11=l9_9;
int l9_12=l9_10;
float l9_13=0.0;
float4 l9_14=float4(0.0);
float2 l9_15=l9_11;
int l9_16=sc_RayTracedAoTextureLayout_tmp;
int l9_17=l9_12;
float l9_18=l9_13;
float2 l9_19=l9_15;
int l9_20=l9_16;
int l9_21=l9_17;
float3 l9_22=float3(0.0);
if (l9_20==0)
{
l9_22=float3(l9_19,0.0);
}
else
{
if (l9_20==1)
{
l9_22=float3(l9_19.x,(l9_19.y*0.5)+(0.5-(float(l9_21)*0.5)),0.0);
}
else
{
l9_22=float3(l9_19,float(l9_21));
}
}
float3 l9_23=l9_22;
float3 l9_24=l9_23;
float2 l9_25=l9_24.xy;
float l9_26=l9_18;
float4 l9_27=sc_RayTracedAoTexture.sample(sc_RayTracedAoTextureSmpSC,l9_25,bias(l9_26));
float4 l9_28=l9_27;
l9_14=l9_28;
float4 l9_29=l9_14;
float4 l9_30=l9_29;
float4 l9_31=l9_30;
return l9_31.x;
}
return 0.0;
}
float srgbToLinear(thread const float& x)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
return pow(x,2.2);
}
else
{
return x*x;
}
}
float linearToSrgb(thread const float& x)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
return pow(x,0.45454547);
}
else
{
return sqrt(x);
}
}
float4 ngsCalculateLighting(thread const float3& albedo,thread const float& opacity,thread const float3& normal,thread const float3& position,thread const float3& viewDir,thread const float3& emissive,thread const float& metallic,thread const float& roughness,thread const float3& ao,thread const float3& specularAO,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_EnvmapDiffuse,thread sampler sc_EnvmapDiffuseSmpSC,thread texture2d<float> sc_EnvmapSpecular,thread sampler sc_EnvmapSpecularSmpSC,thread texture2d<float> sc_ScreenTexture,thread sampler sc_ScreenTextureSmpSC,thread texture2d<float> sc_ShadowTexture,thread sampler sc_ShadowTextureSmpSC,thread texture2d<float> sc_SSAOTexture,thread sampler sc_SSAOTextureSmpSC,thread texture2d<float> sc_RayTracedReflectionTexture,thread sampler sc_RayTracedReflectionTextureSmpSC,thread texture2d<float> sc_RayTracedShadowTexture,thread sampler sc_RayTracedShadowTextureSmpSC,thread texture2d<float> sc_RayTracedDiffIndTexture,thread sampler sc_RayTracedDiffIndTextureSmpSC,thread texture2d<float> sc_RayTracedAoTexture,thread sampler sc_RayTracedAoTextureSmpSC,thread float4& gl_FragCoord,thread float2& varShadowTex,thread float4& FragColor0)
{
SurfaceProperties l9_0;
l9_0.albedo=float3(0.0);
l9_0.opacity=1.0;
l9_0.normal=float3(0.0);
l9_0.positionWS=float3(0.0);
l9_0.viewDirWS=float3(0.0);
l9_0.metallic=0.0;
l9_0.roughness=0.0;
l9_0.emissive=float3(0.0);
l9_0.ao=float3(1.0);
l9_0.specularAo=float3(1.0);
l9_0.bakedShadows=float3(1.0);
SurfaceProperties l9_1=l9_0;
SurfaceProperties surfaceProperties=l9_1;
surfaceProperties.opacity=opacity;
float3 param=albedo;
float3 l9_2;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_2=float3(pow(param.x,2.2),pow(param.y,2.2),pow(param.z,2.2));
}
else
{
l9_2=param*param;
}
float3 l9_3=l9_2;
surfaceProperties.albedo=l9_3;
surfaceProperties.normal=normalize(normal);
surfaceProperties.positionWS=position;
surfaceProperties.viewDirWS=viewDir;
float3 param_1=emissive;
float3 l9_4;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_4=float3(pow(param_1.x,2.2),pow(param_1.y,2.2),pow(param_1.z,2.2));
}
else
{
l9_4=param_1*param_1;
}
float3 l9_5=l9_4;
surfaceProperties.emissive=l9_5;
surfaceProperties.metallic=metallic;
surfaceProperties.roughness=roughness;
surfaceProperties.ao=ao;
surfaceProperties.specularAo=specularAO;
if ((int(sc_SSAOEnabled_tmp)!=0))
{
float3 param_2=surfaceProperties.positionWS;
surfaceProperties.ao=evaluateSSAO(param_2,varStereoViewID,UserUniforms,sc_SSAOTexture,sc_SSAOTextureSmpSC);
}
SurfaceProperties param_3=surfaceProperties;
SurfaceProperties l9_6=param_3;
float3 l9_7=mix(float3(0.039999999),l9_6.albedo*l9_6.metallic,float3(l9_6.metallic));
float3 l9_8=mix(l9_6.albedo*(1.0-l9_6.metallic),float3(0.0),float3(l9_6.metallic));
param_3.albedo=l9_8;
param_3.specColor=l9_7;
SurfaceProperties l9_9=param_3;
surfaceProperties=l9_9;
SurfaceProperties param_4=surfaceProperties;
LightingComponents l9_10;
l9_10.directDiffuse=float3(0.0);
l9_10.directSpecular=float3(0.0);
l9_10.indirectDiffuse=float3(1.0);
l9_10.indirectSpecular=float3(0.0);
l9_10.emitted=float3(0.0);
l9_10.transmitted=float3(0.0);
LightingComponents l9_11=l9_10;
LightingComponents l9_12=l9_11;
float3 l9_13=param_4.viewDirWS;
int l9_14=0;
float4 l9_15=float4(param_4.bakedShadows,1.0);
if (sc_DirectionalLightsCount_tmp>0)
{
sc_DirectionalLight_t l9_16;
LightProperties l9_17;
int l9_18=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_18<sc_DirectionalLightsCount_tmp)
{
l9_16.direction=UserUniforms.sc_DirectionalLights[l9_18].direction;
l9_16.color=UserUniforms.sc_DirectionalLights[l9_18].color;
l9_17.direction=l9_16.direction;
l9_17.color=l9_16.color.xyz;
l9_17.attenuation=l9_16.color.w;
l9_17.attenuation*=l9_15[(l9_14<3) ? l9_14 : 3];
l9_14++;
LightingComponents l9_19=l9_12;
LightProperties l9_20=l9_17;
SurfaceProperties l9_21=param_4;
float3 l9_22=l9_13;
SurfaceProperties l9_23=l9_21;
float3 l9_24=l9_20.direction;
float l9_25=dot(l9_23.normal,l9_24);
float l9_26=fast::clamp(l9_25,0.0,1.0);
float3 l9_27=float3(l9_26);
l9_19.directDiffuse+=((l9_27*l9_20.color)*l9_20.attenuation);
SurfaceProperties l9_28=l9_21;
float3 l9_29=l9_20.direction;
float3 l9_30=l9_22;
l9_19.directSpecular+=((calculateDirectSpecular(l9_28,l9_29,l9_30,UserUniforms)*l9_20.color)*l9_20.attenuation);
LightingComponents l9_31=l9_19;
l9_12=l9_31;
l9_18++;
continue;
}
else
{
break;
}
}
}
if (sc_PointLightsCount_tmp>0)
{
sc_PointLight_t_1 l9_32;
LightProperties l9_33;
int l9_34=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_34<sc_PointLightsCount_tmp)
{
l9_32.falloffEnabled=UserUniforms.sc_PointLights[l9_34].falloffEnabled!=0;
l9_32.falloffEndDistance=UserUniforms.sc_PointLights[l9_34].falloffEndDistance;
l9_32.negRcpFalloffEndDistance4=UserUniforms.sc_PointLights[l9_34].negRcpFalloffEndDistance4;
l9_32.angleScale=UserUniforms.sc_PointLights[l9_34].angleScale;
l9_32.angleOffset=UserUniforms.sc_PointLights[l9_34].angleOffset;
l9_32.direction=UserUniforms.sc_PointLights[l9_34].direction;
l9_32.position=UserUniforms.sc_PointLights[l9_34].position;
l9_32.color=UserUniforms.sc_PointLights[l9_34].color;
float3 l9_35=l9_32.position-param_4.positionWS;
l9_33.direction=normalize(l9_35);
l9_33.color=l9_32.color.xyz;
l9_33.attenuation=l9_32.color.w;
l9_33.attenuation*=l9_15[(l9_14<3) ? l9_14 : 3];
float3 l9_36=l9_33.direction;
float3 l9_37=l9_32.direction;
float l9_38=l9_32.angleScale;
float l9_39=l9_32.angleOffset;
float l9_40=dot(l9_36,l9_37);
float l9_41=fast::clamp((l9_40*l9_38)+l9_39,0.0,1.0);
float l9_42=l9_41*l9_41;
l9_33.attenuation*=l9_42;
if (l9_32.falloffEnabled)
{
float l9_43=length(l9_35);
float l9_44=l9_32.falloffEndDistance;
l9_33.attenuation*=computeDistanceAttenuation(l9_43,l9_44);
}
l9_14++;
LightingComponents l9_45=l9_12;
LightProperties l9_46=l9_33;
SurfaceProperties l9_47=param_4;
float3 l9_48=l9_13;
SurfaceProperties l9_49=l9_47;
float3 l9_50=l9_46.direction;
float l9_51=dot(l9_49.normal,l9_50);
float l9_52=fast::clamp(l9_51,0.0,1.0);
float3 l9_53=float3(l9_52);
l9_45.directDiffuse+=((l9_53*l9_46.color)*l9_46.attenuation);
SurfaceProperties l9_54=l9_47;
float3 l9_55=l9_46.direction;
float3 l9_56=l9_48;
l9_45.directSpecular+=((calculateDirectSpecular(l9_54,l9_55,l9_56,UserUniforms)*l9_46.color)*l9_46.attenuation);
LightingComponents l9_57=l9_45;
l9_12=l9_57;
l9_34++;
continue;
}
else
{
break;
}
}
}
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float3 l9_58=float3(0.0);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float2 l9_59=abs(varShadowTex-float2(0.5));
float l9_60=fast::max(l9_59.x,l9_59.y);
float l9_61=step(l9_60,0.5);
float4 l9_62=sc_ShadowTexture.sample(sc_ShadowTextureSmpSC,varShadowTex)*l9_61;
float3 l9_63=mix(UserUniforms.sc_ShadowColor.xyz,UserUniforms.sc_ShadowColor.xyz*l9_62.xyz,float3(UserUniforms.sc_ShadowColor.w));
float l9_64=l9_62.w*UserUniforms.sc_ShadowDensity;
l9_58=mix(float3(1.0),l9_63,float3(l9_64));
}
else
{
l9_58=float3(1.0);
}
float3 l9_65=l9_58;
float3 l9_66=l9_65;
l9_12.directDiffuse*=l9_66;
l9_12.directSpecular*=l9_66;
}
bool l9_67=UserUniforms.receivesRayTracedShadows!=0;
if (l9_67)
{
float4 l9_68=gl_FragCoord;
float2 l9_69=(l9_68.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 l9_70=l9_69;
float2 l9_71=l9_70;
int l9_72=0;
if ((int(sc_RayTracedShadowTextureHasSwappedViews_tmp)!=0))
{
int l9_73=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_73=0;
}
else
{
l9_73=varStereoViewID;
}
int l9_74=l9_73;
l9_72=1-l9_74;
}
else
{
int l9_75=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_75=0;
}
else
{
l9_75=varStereoViewID;
}
int l9_76=l9_75;
l9_72=l9_76;
}
int l9_77=l9_72;
float2 l9_78=l9_71;
int l9_79=l9_77;
float2 l9_80=l9_78;
int l9_81=l9_79;
float l9_82=0.0;
float4 l9_83=float4(0.0);
float2 l9_84=l9_80;
int l9_85=sc_RayTracedShadowTextureLayout_tmp;
int l9_86=l9_81;
float l9_87=l9_82;
float2 l9_88=l9_84;
int l9_89=l9_85;
int l9_90=l9_86;
float3 l9_91=float3(0.0);
if (l9_89==0)
{
l9_91=float3(l9_88,0.0);
}
else
{
if (l9_89==1)
{
l9_91=float3(l9_88.x,(l9_88.y*0.5)+(0.5-(float(l9_90)*0.5)),0.0);
}
else
{
l9_91=float3(l9_88,float(l9_90));
}
}
float3 l9_92=l9_91;
float3 l9_93=l9_92;
float2 l9_94=l9_93.xy;
float l9_95=l9_87;
float4 l9_96=sc_RayTracedShadowTexture.sample(sc_RayTracedShadowTextureSmpSC,l9_94,bias(l9_95));
float4 l9_97=l9_96;
l9_83=l9_97;
float4 l9_98=l9_83;
float4 l9_99=l9_98;
float4 l9_100=l9_99;
float l9_101=l9_100.x;
float3 l9_102=float3(l9_101);
float3 l9_103=l9_102;
l9_12.directDiffuse*=(float3(1.0)-l9_103);
l9_12.directSpecular*=(float3(1.0)-l9_103);
}
SurfaceProperties l9_104=param_4;
float3 l9_105=l9_104.normal;
float3 l9_106=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
float3 l9_107=l9_105;
float3 l9_108=l9_107;
float l9_109=UserUniforms.sc_EnvmapRotation.y;
float2 l9_110=float2(0.0);
float l9_111=l9_108.x;
float l9_112=-l9_108.z;
float l9_113=(l9_111<0.0) ? (-1.0) : 1.0;
float l9_114=l9_113*acos(fast::clamp(l9_112/length(float2(l9_111,l9_112)),-1.0,1.0));
l9_110.x=l9_114-1.5707964;
l9_110.y=acos(l9_108.y);
l9_110/=float2(6.2831855,3.1415927);
l9_110.y=1.0-l9_110.y;
l9_110.x+=(l9_109/360.0);
l9_110.x=fract((l9_110.x+floor(l9_110.x))+1.0);
float2 l9_115=l9_110;
float2 l9_116=l9_115;
float4 l9_117=float4(0.0);
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 l9_118=l9_116;
float2 l9_119=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_120=5.0;
l9_116=calcSeamlessPanoramicUvsForSampling(l9_118,l9_119,l9_120);
}
float2 l9_121=l9_116;
float l9_122=13.0;
int l9_123=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_124=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_124=0;
}
else
{
l9_124=varStereoViewID;
}
int l9_125=l9_124;
l9_123=1-l9_125;
}
else
{
int l9_126=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_126=0;
}
else
{
l9_126=varStereoViewID;
}
int l9_127=l9_126;
l9_123=l9_127;
}
int l9_128=l9_123;
float2 l9_129=l9_121;
int l9_130=l9_128;
float l9_131=l9_122;
float4 l9_132=float4(0.0);
float2 l9_133=l9_129;
int l9_134=sc_EnvmapSpecularLayout_tmp;
int l9_135=l9_130;
float l9_136=l9_131;
float2 l9_137=l9_133;
int l9_138=l9_134;
int l9_139=l9_135;
float3 l9_140=float3(0.0);
if (l9_138==0)
{
l9_140=float3(l9_137,0.0);
}
else
{
if (l9_138==1)
{
l9_140=float3(l9_137.x,(l9_137.y*0.5)+(0.5-(float(l9_139)*0.5)),0.0);
}
else
{
l9_140=float3(l9_137,float(l9_139));
}
}
float3 l9_141=l9_140;
float3 l9_142=l9_141;
float2 l9_143=l9_142.xy;
float l9_144=l9_136;
float4 l9_145=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_143,bias(l9_144));
float4 l9_146=l9_145;
l9_132=l9_146;
float4 l9_147=l9_132;
float4 l9_148=l9_147;
l9_117=l9_148;
}
else
{
if ((sc_MaxTextureImageUnits_tmp>8)&&(int(sc_HasDiffuseEnvmap_tmp)!=0))
{
float2 l9_149=l9_116;
float2 l9_150=UserUniforms.sc_EnvmapDiffuseSize.xy;
float l9_151=0.0;
l9_116=calcSeamlessPanoramicUvsForSampling(l9_149,l9_150,l9_151);
bool l9_152=UserUniforms.isProxyMode!=0;
if (l9_152)
{
float2 l9_153=l9_116;
float l9_154=0.0;
int l9_155=0;
if ((int(sc_EnvmapDiffuseHasSwappedViews_tmp)!=0))
{
int l9_156=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_156=0;
}
else
{
l9_156=varStereoViewID;
}
int l9_157=l9_156;
l9_155=1-l9_157;
}
else
{
int l9_158=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_158=0;
}
else
{
l9_158=varStereoViewID;
}
int l9_159=l9_158;
l9_155=l9_159;
}
int l9_160=l9_155;
float2 l9_161=l9_153;
int l9_162=l9_160;
float l9_163=l9_154;
float4 l9_164=float4(0.0);
float2 l9_165=l9_161;
int l9_166=sc_EnvmapDiffuseLayout_tmp;
int l9_167=l9_162;
float l9_168=l9_163;
float2 l9_169=l9_165;
int l9_170=l9_166;
int l9_171=l9_167;
float3 l9_172=float3(0.0);
if (l9_170==0)
{
l9_172=float3(l9_169,0.0);
}
else
{
if (l9_170==1)
{
l9_172=float3(l9_169.x,(l9_169.y*0.5)+(0.5-(float(l9_171)*0.5)),0.0);
}
else
{
l9_172=float3(l9_169,float(l9_171));
}
}
float3 l9_173=l9_172;
float3 l9_174=l9_173;
float2 l9_175=l9_174.xy;
float l9_176=l9_168;
float4 l9_177=sc_EnvmapDiffuse.sample(sc_EnvmapDiffuseSmpSC,l9_175,level(l9_176));
float4 l9_178=l9_177;
l9_164=l9_178;
float4 l9_179=l9_164;
float4 l9_180=l9_179;
l9_117=l9_180;
}
else
{
float2 l9_181=l9_116;
float l9_182=-13.0;
int l9_183=0;
if ((int(sc_EnvmapDiffuseHasSwappedViews_tmp)!=0))
{
int l9_184=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_184=0;
}
else
{
l9_184=varStereoViewID;
}
int l9_185=l9_184;
l9_183=1-l9_185;
}
else
{
int l9_186=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_186=0;
}
else
{
l9_186=varStereoViewID;
}
int l9_187=l9_186;
l9_183=l9_187;
}
int l9_188=l9_183;
float2 l9_189=l9_181;
int l9_190=l9_188;
float l9_191=l9_182;
float4 l9_192=float4(0.0);
float2 l9_193=l9_189;
int l9_194=sc_EnvmapDiffuseLayout_tmp;
int l9_195=l9_190;
float l9_196=l9_191;
float2 l9_197=l9_193;
int l9_198=l9_194;
int l9_199=l9_195;
float3 l9_200=float3(0.0);
if (l9_198==0)
{
l9_200=float3(l9_197,0.0);
}
else
{
if (l9_198==1)
{
l9_200=float3(l9_197.x,(l9_197.y*0.5)+(0.5-(float(l9_199)*0.5)),0.0);
}
else
{
l9_200=float3(l9_197,float(l9_199));
}
}
float3 l9_201=l9_200;
float3 l9_202=l9_201;
float2 l9_203=l9_202.xy;
float l9_204=l9_196;
float4 l9_205=sc_EnvmapDiffuse.sample(sc_EnvmapDiffuseSmpSC,l9_203,bias(l9_204));
float4 l9_206=l9_205;
l9_192=l9_206;
float4 l9_207=l9_192;
float4 l9_208=l9_207;
l9_117=l9_208;
}
}
else
{
float2 l9_209=l9_116;
float l9_210=13.0;
int l9_211=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_212=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_212=0;
}
else
{
l9_212=varStereoViewID;
}
int l9_213=l9_212;
l9_211=1-l9_213;
}
else
{
int l9_214=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_214=0;
}
else
{
l9_214=varStereoViewID;
}
int l9_215=l9_214;
l9_211=l9_215;
}
int l9_216=l9_211;
float2 l9_217=l9_209;
int l9_218=l9_216;
float l9_219=l9_210;
float4 l9_220=float4(0.0);
float2 l9_221=l9_217;
int l9_222=sc_EnvmapSpecularLayout_tmp;
int l9_223=l9_218;
float l9_224=l9_219;
float2 l9_225=l9_221;
int l9_226=l9_222;
int l9_227=l9_223;
float3 l9_228=float3(0.0);
if (l9_226==0)
{
l9_228=float3(l9_225,0.0);
}
else
{
if (l9_226==1)
{
l9_228=float3(l9_225.x,(l9_225.y*0.5)+(0.5-(float(l9_227)*0.5)),0.0);
}
else
{
l9_228=float3(l9_225,float(l9_227));
}
}
float3 l9_229=l9_228;
float3 l9_230=l9_229;
float2 l9_231=l9_230.xy;
float l9_232=l9_224;
float4 l9_233=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_231,bias(l9_232));
float4 l9_234=l9_233;
l9_220=l9_234;
float4 l9_235=l9_220;
float4 l9_236=l9_235;
l9_117=l9_236;
}
}
float4 l9_237=l9_117;
float3 l9_238=l9_237.xyz*(1.0/l9_237.w);
float3 l9_239=l9_238*UserUniforms.sc_EnvmapExposure;
l9_106=l9_239;
}
else
{
if (sc_EnvLightMode_tmp==sc_AmbientLightMode_SphericalHarmonics_tmp)
{
float3 l9_240=UserUniforms.sc_Sh[0];
float3 l9_241=UserUniforms.sc_Sh[1];
float3 l9_242=UserUniforms.sc_Sh[2];
float3 l9_243=UserUniforms.sc_Sh[3];
float3 l9_244=UserUniforms.sc_Sh[4];
float3 l9_245=UserUniforms.sc_Sh[5];
float3 l9_246=UserUniforms.sc_Sh[6];
float3 l9_247=UserUniforms.sc_Sh[7];
float3 l9_248=UserUniforms.sc_Sh[8];
float3 l9_249=-l9_105;
float l9_250=0.0;
l9_250=l9_249.x;
float l9_251=l9_249.y;
float l9_252=l9_249.z;
float l9_253=l9_250*l9_250;
float l9_254=l9_251*l9_251;
float l9_255=l9_252*l9_252;
float l9_256=l9_250*l9_251;
float l9_257=l9_251*l9_252;
float l9_258=l9_250*l9_252;
float3 l9_259=((((((l9_248*0.42904299)*(l9_253-l9_254))+((l9_246*0.74312502)*l9_255))+(l9_240*0.88622701))-(l9_246*0.24770799))+((((l9_244*l9_256)+(l9_247*l9_258))+(l9_245*l9_257))*0.85808599))+((((l9_243*l9_250)+(l9_241*l9_251))+(l9_242*l9_252))*1.0233279);
l9_106=l9_259*UserUniforms.sc_ShIntensity;
}
}
bool l9_260=UserUniforms.receivesRayTracedDiffuseIndirect!=0;
if (l9_260)
{
float4 l9_261=sampleRayTracedIndirectDiffuse(varStereoViewID,UserUniforms,sc_RayTracedDiffIndTexture,sc_RayTracedDiffIndTextureSmpSC,gl_FragCoord);
l9_106=mix(l9_106,l9_261.xyz,float3(l9_261.w));
}
if (sc_AmbientLightsCount_tmp>0)
{
if (sc_AmbientLightMode0_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[0].color*UserUniforms.sc_AmbientLights[0].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[0].color.x);
}
}
if (sc_AmbientLightsCount_tmp>1)
{
if (sc_AmbientLightMode1_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[1].color*UserUniforms.sc_AmbientLights[1].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[1].color.x);
}
}
if (sc_AmbientLightsCount_tmp>2)
{
if (sc_AmbientLightMode2_tmp==sc_AmbientLightMode_Constant_tmp)
{
l9_106+=(UserUniforms.sc_AmbientLights[2].color*UserUniforms.sc_AmbientLights[2].intensity);
}
else
{
l9_106.x+=(1e-06*UserUniforms.sc_AmbientLights[2].color.x);
}
}
if ((int(sc_LightEstimation_tmp)!=0))
{
float3 l9_262=l9_105;
float3 l9_263=UserUniforms.sc_LightEstimationData.ambientLight;
sc_SphericalGaussianLight_t l9_264;
float l9_265;
int l9_266=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_266<sc_LightEstimationSGCount_tmp)
{
l9_264.color=UserUniforms.sc_LightEstimationData.sg[l9_266].color;
l9_264.sharpness=UserUniforms.sc_LightEstimationData.sg[l9_266].sharpness;
l9_264.axis=UserUniforms.sc_LightEstimationData.sg[l9_266].axis;
float3 l9_267=l9_262;
float l9_268=dot(l9_264.axis,l9_267);
float l9_269=l9_264.sharpness;
float l9_270=0.36000001;
float l9_271=1.0/(4.0*l9_270);
float l9_272=exp(-l9_269);
float l9_273=l9_272*l9_272;
float l9_274=1.0/l9_269;
float l9_275=(1.0+(2.0*l9_273))-l9_274;
float l9_276=((l9_272-l9_273)*l9_274)-l9_273;
float l9_277=sqrt(1.0-l9_275);
float l9_278=l9_270*l9_268;
float l9_279=l9_271*l9_277;
float l9_280=l9_278+l9_279;
float l9_281=l9_268;
float l9_282=fast::clamp(l9_281,0.0,1.0);
float l9_283=l9_282;
if (step(abs(l9_278),l9_279)>0.5)
{
l9_265=(l9_280*l9_280)/l9_277;
}
else
{
l9_265=l9_283;
}
l9_283=l9_265;
float l9_284=(l9_275*l9_283)+l9_276;
sc_SphericalGaussianLight_t l9_285=l9_264;
float3 l9_286=(l9_285.color/float3(l9_285.sharpness))*6.2831855;
float3 l9_287=(l9_286*l9_284)/float3(3.1415927);
l9_263+=l9_287;
l9_266++;
continue;
}
else
{
break;
}
}
float3 l9_288=l9_263;
l9_106+=l9_288;
}
float3 l9_289=l9_106;
float3 l9_290=l9_289;
l9_12.indirectDiffuse=l9_290;
SurfaceProperties l9_291=param_4;
float3 l9_292=l9_13;
float3 l9_293=float3(0.0);
if ((sc_EnvLightMode_tmp==sc_AmbientLightMode_EnvironmentMap_tmp)||(sc_EnvLightMode_tmp==sc_AmbientLightMode_FromCamera_tmp))
{
SurfaceProperties l9_294=l9_291;
float3 l9_295=l9_292;
float3 l9_296=l9_294.normal;
float3 l9_297=reflect(-l9_295,l9_296);
float3 l9_298=l9_296;
float3 l9_299=l9_297;
float l9_300=l9_294.roughness;
l9_297=getSpecularDominantDir(l9_298,l9_299,l9_300);
float l9_301=l9_294.roughness;
float l9_302=pow(l9_301,0.66666669);
float l9_303=fast::clamp(l9_302,0.0,1.0);
float l9_304=l9_303*5.0;
float l9_305=l9_304;
float l9_306=l9_305;
float3 l9_307=l9_297;
float l9_308=l9_306;
float3 l9_309=l9_307;
float l9_310=l9_308;
float4 l9_311=float4(0.0);
float3 l9_312=l9_309;
float l9_313=UserUniforms.sc_EnvmapRotation.y;
float2 l9_314=float2(0.0);
float l9_315=l9_312.x;
float l9_316=-l9_312.z;
float l9_317=(l9_315<0.0) ? (-1.0) : 1.0;
float l9_318=l9_317*acos(fast::clamp(l9_316/length(float2(l9_315,l9_316)),-1.0,1.0));
l9_314.x=l9_318-1.5707964;
l9_314.y=acos(l9_312.y);
l9_314/=float2(6.2831855,3.1415927);
l9_314.y=1.0-l9_314.y;
l9_314.x+=(l9_313/360.0);
l9_314.x=fract((l9_314.x+floor(l9_314.x))+1.0);
float2 l9_319=l9_314;
float2 l9_320=l9_319;
if (SC_DEVICE_CLASS_tmp>=2)
{
float l9_321=floor(l9_310);
float l9_322=ceil(l9_310);
float l9_323=l9_310-l9_321;
float2 l9_324=l9_320;
float2 l9_325=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_326=l9_321;
float2 l9_327=calcSeamlessPanoramicUvsForSampling(l9_324,l9_325,l9_326);
float2 l9_328=l9_327;
float l9_329=l9_321;
float2 l9_330=l9_328;
float l9_331=l9_329;
int l9_332=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_333=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_333=0;
}
else
{
l9_333=varStereoViewID;
}
int l9_334=l9_333;
l9_332=1-l9_334;
}
else
{
int l9_335=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_335=0;
}
else
{
l9_335=varStereoViewID;
}
int l9_336=l9_335;
l9_332=l9_336;
}
int l9_337=l9_332;
float2 l9_338=l9_330;
int l9_339=l9_337;
float l9_340=l9_331;
float4 l9_341=float4(0.0);
float2 l9_342=l9_338;
int l9_343=sc_EnvmapSpecularLayout_tmp;
int l9_344=l9_339;
float l9_345=l9_340;
float2 l9_346=l9_342;
int l9_347=l9_343;
int l9_348=l9_344;
float3 l9_349=float3(0.0);
if (l9_347==0)
{
l9_349=float3(l9_346,0.0);
}
else
{
if (l9_347==1)
{
l9_349=float3(l9_346.x,(l9_346.y*0.5)+(0.5-(float(l9_348)*0.5)),0.0);
}
else
{
l9_349=float3(l9_346,float(l9_348));
}
}
float3 l9_350=l9_349;
float3 l9_351=l9_350;
float2 l9_352=l9_351.xy;
float l9_353=l9_345;
float4 l9_354=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_352,level(l9_353));
float4 l9_355=l9_354;
l9_341=l9_355;
float4 l9_356=l9_341;
float4 l9_357=l9_356;
float4 l9_358=l9_357;
float4 l9_359=l9_358;
float2 l9_360=l9_320;
float2 l9_361=UserUniforms.sc_EnvmapSpecularSize.xy;
float l9_362=l9_322;
float2 l9_363=calcSeamlessPanoramicUvsForSampling(l9_360,l9_361,l9_362);
float2 l9_364=l9_363;
float l9_365=l9_322;
float2 l9_366=l9_364;
float l9_367=l9_365;
int l9_368=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_369=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_369=0;
}
else
{
l9_369=varStereoViewID;
}
int l9_370=l9_369;
l9_368=1-l9_370;
}
else
{
int l9_371=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_371=0;
}
else
{
l9_371=varStereoViewID;
}
int l9_372=l9_371;
l9_368=l9_372;
}
int l9_373=l9_368;
float2 l9_374=l9_366;
int l9_375=l9_373;
float l9_376=l9_367;
float4 l9_377=float4(0.0);
float2 l9_378=l9_374;
int l9_379=sc_EnvmapSpecularLayout_tmp;
int l9_380=l9_375;
float l9_381=l9_376;
float2 l9_382=l9_378;
int l9_383=l9_379;
int l9_384=l9_380;
float3 l9_385=float3(0.0);
if (l9_383==0)
{
l9_385=float3(l9_382,0.0);
}
else
{
if (l9_383==1)
{
l9_385=float3(l9_382.x,(l9_382.y*0.5)+(0.5-(float(l9_384)*0.5)),0.0);
}
else
{
l9_385=float3(l9_382,float(l9_384));
}
}
float3 l9_386=l9_385;
float3 l9_387=l9_386;
float2 l9_388=l9_387.xy;
float l9_389=l9_381;
float4 l9_390=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_388,level(l9_389));
float4 l9_391=l9_390;
l9_377=l9_391;
float4 l9_392=l9_377;
float4 l9_393=l9_392;
float4 l9_394=l9_393;
float4 l9_395=l9_394;
l9_311=mix(l9_359,l9_395,float4(l9_323));
}
else
{
float2 l9_396=l9_320;
float l9_397=l9_310;
float2 l9_398=l9_396;
float l9_399=l9_397;
int l9_400=0;
if ((int(sc_EnvmapSpecularHasSwappedViews_tmp)!=0))
{
int l9_401=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_401=0;
}
else
{
l9_401=varStereoViewID;
}
int l9_402=l9_401;
l9_400=1-l9_402;
}
else
{
int l9_403=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_403=0;
}
else
{
l9_403=varStereoViewID;
}
int l9_404=l9_403;
l9_400=l9_404;
}
int l9_405=l9_400;
float2 l9_406=l9_398;
int l9_407=l9_405;
float l9_408=l9_399;
float4 l9_409=float4(0.0);
float2 l9_410=l9_406;
int l9_411=sc_EnvmapSpecularLayout_tmp;
int l9_412=l9_407;
float l9_413=l9_408;
float2 l9_414=l9_410;
int l9_415=l9_411;
int l9_416=l9_412;
float3 l9_417=float3(0.0);
if (l9_415==0)
{
l9_417=float3(l9_414,0.0);
}
else
{
if (l9_415==1)
{
l9_417=float3(l9_414.x,(l9_414.y*0.5)+(0.5-(float(l9_416)*0.5)),0.0);
}
else
{
l9_417=float3(l9_414,float(l9_416));
}
}
float3 l9_418=l9_417;
float3 l9_419=l9_418;
float2 l9_420=l9_419.xy;
float l9_421=l9_413;
float4 l9_422=sc_EnvmapSpecular.sample(sc_EnvmapSpecularSmpSC,l9_420,level(l9_421));
float4 l9_423=l9_422;
l9_409=l9_423;
float4 l9_424=l9_409;
float4 l9_425=l9_424;
float4 l9_426=l9_425;
l9_311=l9_426;
}
float4 l9_427=l9_311;
float3 l9_428=l9_427.xyz*(1.0/l9_427.w);
float3 l9_429=l9_428;
float3 l9_430=l9_429*UserUniforms.sc_EnvmapExposure;
l9_430+=float3(1e-06);
float3 l9_431=l9_430;
float3 l9_432=l9_431;
bool l9_433=UserUniforms.receivesRayTracedReflections!=0;
if (l9_433)
{
float4 l9_434=sampleRayTracedReflections(varStereoViewID,UserUniforms,sc_RayTracedReflectionTexture,sc_RayTracedReflectionTextureSmpSC,gl_FragCoord);
l9_432=mix(l9_432,l9_434.xyz,float3(l9_434.w));
}
SurfaceProperties l9_435=l9_294;
float l9_436=abs(dot(l9_296,l9_295));
float3 l9_437=l9_432*envBRDFApprox(l9_435,l9_436);
l9_293+=l9_437;
}
if ((int(sc_LightEstimation_tmp)!=0))
{
SurfaceProperties l9_438=l9_291;
float3 l9_439=l9_292;
float l9_440=fast::clamp(l9_438.roughness*l9_438.roughness,0.0099999998,1.0);
float3 l9_441=UserUniforms.sc_LightEstimationData.ambientLight*l9_438.specColor;
sc_SphericalGaussianLight_t l9_442;
sc_SphericalGaussianLight_t l9_443;
sc_SphericalGaussianLight_t l9_444;
int l9_445=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (l9_445<sc_LightEstimationSGCount_tmp)
{
l9_442.color=UserUniforms.sc_LightEstimationData.sg[l9_445].color;
l9_442.sharpness=UserUniforms.sc_LightEstimationData.sg[l9_445].sharpness;
l9_442.axis=UserUniforms.sc_LightEstimationData.sg[l9_445].axis;
float3 l9_446=l9_438.normal;
float l9_447=l9_440;
float3 l9_448=l9_439;
float3 l9_449=l9_438.specColor;
float3 l9_450=l9_446;
float l9_451=l9_447;
l9_443.axis=l9_450;
float l9_452=l9_451*l9_451;
l9_443.sharpness=2.0/l9_452;
l9_443.color=float3(1.0/(3.1415927*l9_452));
sc_SphericalGaussianLight_t l9_453=l9_443;
sc_SphericalGaussianLight_t l9_454=l9_453;
sc_SphericalGaussianLight_t l9_455=l9_454;
float3 l9_456=l9_448;
l9_444.axis=reflect(-l9_456,l9_455.axis);
l9_444.color=l9_455.color;
l9_444.sharpness=l9_455.sharpness;
l9_444.sharpness/=(4.0*fast::max(dot(l9_455.axis,l9_456),9.9999997e-05));
sc_SphericalGaussianLight_t l9_457=l9_444;
sc_SphericalGaussianLight_t l9_458=l9_457;
sc_SphericalGaussianLight_t l9_459=l9_458;
sc_SphericalGaussianLight_t l9_460=l9_442;
float l9_461=length((l9_459.axis*l9_459.sharpness)+(l9_460.axis*l9_460.sharpness));
float3 l9_462=(l9_459.color*exp((l9_461-l9_459.sharpness)-l9_460.sharpness))*l9_460.color;
float l9_463=1.0-exp((-2.0)*l9_461);
float3 l9_464=((l9_462*6.2831855)*l9_463)/float3(l9_461);
float3 l9_465=l9_464;
float3 l9_466=l9_458.axis;
float l9_467=l9_447*l9_447;
float l9_468=dot(l9_446,l9_466);
float l9_469=fast::clamp(l9_468,0.0,1.0);
float l9_470=l9_469;
float l9_471=dot(l9_446,l9_448);
float l9_472=fast::clamp(l9_471,0.0,1.0);
float l9_473=l9_472;
float3 l9_474=normalize(l9_458.axis+l9_448);
float l9_475=l9_467;
float l9_476=l9_470;
float l9_477=1.0/(l9_476+sqrt(l9_475+(((1.0-l9_475)*l9_476)*l9_476)));
float l9_478=l9_467;
float l9_479=l9_473;
float l9_480=1.0/(l9_479+sqrt(l9_478+(((1.0-l9_478)*l9_479)*l9_479)));
l9_465*=(l9_477*l9_480);
float l9_481=dot(l9_466,l9_474);
float l9_482=fast::clamp(l9_481,0.0,1.0);
float l9_483=pow(1.0-l9_482,5.0);
l9_465*=(l9_449+((float3(1.0)-l9_449)*l9_483));
l9_465*=l9_470;
float3 l9_484=l9_465;
l9_441+=l9_484;
l9_445++;
continue;
}
else
{
break;
}
}
float3 l9_485=l9_441;
l9_293+=l9_485;
}
float3 l9_486=l9_293;
l9_12.indirectSpecular=l9_486;
LightingComponents l9_487=l9_12;
LightingComponents lighting=l9_487;
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
lighting.directDiffuse=float3(0.0);
lighting.indirectDiffuse=float3(0.0);
float4 l9_488=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_489=FragColor0;
float4 l9_490=l9_489;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_490.x+=UserUniforms._sc_framebufferFetchMarker;
}
float4 l9_491=l9_490;
l9_488=l9_491;
}
else
{
float4 l9_492=gl_FragCoord;
float2 l9_493=(l9_492.xy*UserUniforms.sc_WindowToViewportTransform.xy)+UserUniforms.sc_WindowToViewportTransform.zw;
float2 l9_494=l9_493;
float2 l9_495=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_496=1;
int l9_497=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_497=0;
}
else
{
l9_497=varStereoViewID;
}
int l9_498=l9_497;
int l9_499=l9_498;
float3 l9_500=float3(l9_494,0.0);
int l9_501=l9_496;
int l9_502=l9_499;
if (l9_501==1)
{
l9_500.y=((2.0*l9_500.y)+float(l9_502))-1.0;
}
float2 l9_503=l9_500.xy;
l9_495=l9_503;
}
else
{
l9_495=l9_494;
}
float2 l9_504=l9_495;
float2 l9_505=l9_504;
float2 l9_506=l9_505;
int l9_507=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_508=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_508=0;
}
else
{
l9_508=varStereoViewID;
}
int l9_509=l9_508;
l9_507=1-l9_509;
}
else
{
int l9_510=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_510=0;
}
else
{
l9_510=varStereoViewID;
}
int l9_511=l9_510;
l9_507=l9_511;
}
int l9_512=l9_507;
float2 l9_513=l9_506;
int l9_514=l9_512;
float2 l9_515=l9_513;
int l9_516=l9_514;
float l9_517=0.0;
float4 l9_518=float4(0.0);
float2 l9_519=l9_515;
int l9_520=sc_ScreenTextureLayout_tmp;
int l9_521=l9_516;
float l9_522=l9_517;
float2 l9_523=l9_519;
int l9_524=l9_520;
int l9_525=l9_521;
float3 l9_526=float3(0.0);
if (l9_524==0)
{
l9_526=float3(l9_523,0.0);
}
else
{
if (l9_524==1)
{
l9_526=float3(l9_523.x,(l9_523.y*0.5)+(0.5-(float(l9_525)*0.5)),0.0);
}
else
{
l9_526=float3(l9_523,float(l9_525));
}
}
float3 l9_527=l9_526;
float3 l9_528=l9_527;
float2 l9_529=l9_528.xy;
float l9_530=l9_522;
float4 l9_531=sc_ScreenTexture.sample(sc_ScreenTextureSmpSC,l9_529,bias(l9_530));
float4 l9_532=l9_531;
l9_518=l9_532;
float4 l9_533=l9_518;
float4 l9_534=l9_533;
float4 l9_535=l9_534;
l9_488=l9_535;
}
float4 l9_536=l9_488;
float4 l9_537=l9_536;
float3 param_5=l9_537.xyz;
float3 l9_538;
if (SC_DEVICE_CLASS_tmp>=2)
{
l9_538=float3(pow(param_5.x,2.2),pow(param_5.y,2.2),pow(param_5.z,2.2));
}
else
{
l9_538=param_5*param_5;
}
float3 l9_539=l9_538;
float3 framebuffer=l9_539;
lighting.transmitted=framebuffer*mix(float3(1.0),surfaceProperties.albedo,float3(surfaceProperties.opacity));
surfaceProperties.opacity=1.0;
}
bool enablePremultipliedAlpha=false;
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
enablePremultipliedAlpha=true;
}
SurfaceProperties param_6=surfaceProperties;
LightingComponents param_7=lighting;
bool param_8=enablePremultipliedAlpha;
float3 l9_540=float3(0.0);
bool l9_541=UserUniforms.receivesRayTracedAo!=0;
if (l9_541)
{
l9_540=param_6.albedo*(param_7.directDiffuse+(param_7.indirectDiffuse*float3(1.0-sampleRayTracedAo(varStereoViewID,UserUniforms,sc_RayTracedAoTexture,sc_RayTracedAoTextureSmpSC,gl_FragCoord))));
}
else
{
l9_540=param_6.albedo*(param_7.directDiffuse+(param_7.indirectDiffuse*param_6.ao));
}
float3 l9_542=param_7.directSpecular+(param_7.indirectSpecular*param_6.specularAo);
float3 l9_543=param_6.emissive;
float3 l9_544=param_7.transmitted;
if (param_8)
{
float l9_545=param_6.opacity;
l9_540*=srgbToLinear(l9_545);
}
float3 l9_546=((l9_540+l9_542)+l9_543)+l9_544;
float3 l9_547=l9_546;
float4 Output=float4(l9_547,surfaceProperties.opacity);
bool l9_548=UserUniforms.isProxyMode!=0;
if (l9_548)
{
return Output;
}
if (!(int(sc_BlendMode_Multiply_tmp)!=0))
{
float3 param_9=Output.xyz;
float l9_549=1.8;
float l9_550=1.4;
float l9_551=0.5;
float l9_552=1.5;
float3 l9_553=(param_9*((param_9*l9_549)+float3(l9_550)))/((param_9*((param_9*l9_549)+float3(l9_551)))+float3(l9_552));
Output=float4(l9_553.x,l9_553.y,l9_553.z,Output.w);
}
float3 param_10=Output.xyz;
float l9_554=param_10.x;
float l9_555=param_10.y;
float l9_556=param_10.z;
float3 l9_557=float3(linearToSrgb(l9_554),linearToSrgb(l9_555),linearToSrgb(l9_556));
Output=float4(l9_557.x,l9_557.y,l9_557.z,Output.w);
return Output;
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
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=rhp.viewDirWS;
Globals.PositionWS=rhp.positionWS;
Globals.VertexNormal_WorldSpace=rhp.normalWS;
Globals.Surface_UVCoord0=rhp.uv0;
}
else
{
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.Surface_UVCoord0=in.varPackedTex.xy;
}
float4 Output_N150=float4(0.0);
float4 param=float4(1.0);
float4 param_1=float4(1.0,0.0,0.0,0.0);
ssGlobals param_3=Globals;
float4 param_2;
if ((int(backCapPBR_tmp)!=0))
{
float4 l9_7=float4(0.0);
float4 l9_8=float4(0.0);
float4 l9_9=float4(0.0);
float4 l9_10=float4(0.0);
float4 l9_11=(*sc_set2.UserUniforms).Port_Default_N146;
ssGlobals l9_12=param_3;
float4 l9_13;
if (DROPLIST_BACK_CAP_MODE_tmp==0)
{
float2 l9_14=float2(0.0);
l9_14=l9_12.Surface_UVCoord0;
float2 l9_15=float2(0.0);
float2 l9_16=(*sc_set2.UserUniforms).backCapTexScale;
l9_15=l9_16;
float2 l9_17=float2(0.0);
float2 l9_18=(*sc_set2.UserUniforms).backCapTexOffset;
l9_17=l9_18;
float2 l9_19=float2(0.0);
l9_19=(l9_14*l9_15)+l9_17;
float4 l9_20=float4(0.0);
int l9_21=0;
if ((int(backCapTexHasSwappedViews_tmp)!=0))
{
int l9_22=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_22=0;
}
else
{
l9_22=in.varStereoViewID;
}
int l9_23=l9_22;
l9_21=1-l9_23;
}
else
{
int l9_24=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_24=0;
}
else
{
l9_24=in.varStereoViewID;
}
int l9_25=l9_24;
l9_21=l9_25;
}
int l9_26=l9_21;
int l9_27=backCapTexLayout_tmp;
int l9_28=l9_26;
float2 l9_29=l9_19;
bool l9_30=(int(SC_USE_UV_TRANSFORM_backCapTex_tmp)!=0);
float3x3 l9_31=(*sc_set2.UserUniforms).backCapTexTransform;
int2 l9_32=int2(SC_SOFTWARE_WRAP_MODE_U_backCapTex_tmp,SC_SOFTWARE_WRAP_MODE_V_backCapTex_tmp);
bool l9_33=(int(SC_USE_UV_MIN_MAX_backCapTex_tmp)!=0);
float4 l9_34=(*sc_set2.UserUniforms).backCapTexUvMinMax;
bool l9_35=(int(SC_USE_CLAMP_TO_BORDER_backCapTex_tmp)!=0);
float4 l9_36=(*sc_set2.UserUniforms).backCapTexBorderColor;
float l9_37=0.0;
bool l9_38=l9_35&&(!l9_33);
float l9_39=1.0;
float l9_40=l9_29.x;
int l9_41=l9_32.x;
if (l9_41==1)
{
l9_40=fract(l9_40);
}
else
{
if (l9_41==2)
{
float l9_42=fract(l9_40);
float l9_43=l9_40-l9_42;
float l9_44=step(0.25,fract(l9_43*0.5));
l9_40=mix(l9_42,1.0-l9_42,fast::clamp(l9_44,0.0,1.0));
}
}
l9_29.x=l9_40;
float l9_45=l9_29.y;
int l9_46=l9_32.y;
if (l9_46==1)
{
l9_45=fract(l9_45);
}
else
{
if (l9_46==2)
{
float l9_47=fract(l9_45);
float l9_48=l9_45-l9_47;
float l9_49=step(0.25,fract(l9_48*0.5));
l9_45=mix(l9_47,1.0-l9_47,fast::clamp(l9_49,0.0,1.0));
}
}
l9_29.y=l9_45;
if (l9_33)
{
bool l9_50=l9_35;
bool l9_51;
if (l9_50)
{
l9_51=l9_32.x==3;
}
else
{
l9_51=l9_50;
}
float l9_52=l9_29.x;
float l9_53=l9_34.x;
float l9_54=l9_34.z;
bool l9_55=l9_51;
float l9_56=l9_39;
float l9_57=fast::clamp(l9_52,l9_53,l9_54);
float l9_58=step(abs(l9_52-l9_57),9.9999997e-06);
l9_56*=(l9_58+((1.0-float(l9_55))*(1.0-l9_58)));
l9_52=l9_57;
l9_29.x=l9_52;
l9_39=l9_56;
bool l9_59=l9_35;
bool l9_60;
if (l9_59)
{
l9_60=l9_32.y==3;
}
else
{
l9_60=l9_59;
}
float l9_61=l9_29.y;
float l9_62=l9_34.y;
float l9_63=l9_34.w;
bool l9_64=l9_60;
float l9_65=l9_39;
float l9_66=fast::clamp(l9_61,l9_62,l9_63);
float l9_67=step(abs(l9_61-l9_66),9.9999997e-06);
l9_65*=(l9_67+((1.0-float(l9_64))*(1.0-l9_67)));
l9_61=l9_66;
l9_29.y=l9_61;
l9_39=l9_65;
}
float2 l9_68=l9_29;
bool l9_69=l9_30;
float3x3 l9_70=l9_31;
if (l9_69)
{
l9_68=float2((l9_70*float3(l9_68,1.0)).xy);
}
float2 l9_71=l9_68;
float2 l9_72=l9_71;
float2 l9_73=l9_72;
l9_29=l9_73;
float l9_74=l9_29.x;
int l9_75=l9_32.x;
bool l9_76=l9_38;
float l9_77=l9_39;
if ((l9_75==0)||(l9_75==3))
{
float l9_78=l9_74;
float l9_79=0.0;
float l9_80=1.0;
bool l9_81=l9_76;
float l9_82=l9_77;
float l9_83=fast::clamp(l9_78,l9_79,l9_80);
float l9_84=step(abs(l9_78-l9_83),9.9999997e-06);
l9_82*=(l9_84+((1.0-float(l9_81))*(1.0-l9_84)));
l9_78=l9_83;
l9_74=l9_78;
l9_77=l9_82;
}
l9_29.x=l9_74;
l9_39=l9_77;
float l9_85=l9_29.y;
int l9_86=l9_32.y;
bool l9_87=l9_38;
float l9_88=l9_39;
if ((l9_86==0)||(l9_86==3))
{
float l9_89=l9_85;
float l9_90=0.0;
float l9_91=1.0;
bool l9_92=l9_87;
float l9_93=l9_88;
float l9_94=fast::clamp(l9_89,l9_90,l9_91);
float l9_95=step(abs(l9_89-l9_94),9.9999997e-06);
l9_93*=(l9_95+((1.0-float(l9_92))*(1.0-l9_95)));
l9_89=l9_94;
l9_85=l9_89;
l9_88=l9_93;
}
l9_29.y=l9_85;
l9_39=l9_88;
float2 l9_96=l9_29;
int l9_97=l9_27;
int l9_98=l9_28;
float l9_99=l9_37;
float2 l9_100=l9_96;
int l9_101=l9_97;
int l9_102=l9_98;
float3 l9_103=float3(0.0);
if (l9_101==0)
{
l9_103=float3(l9_100,0.0);
}
else
{
if (l9_101==1)
{
l9_103=float3(l9_100.x,(l9_100.y*0.5)+(0.5-(float(l9_102)*0.5)),0.0);
}
else
{
l9_103=float3(l9_100,float(l9_102));
}
}
float3 l9_104=l9_103;
float3 l9_105=l9_104;
float2 l9_106=l9_105.xy;
float l9_107=l9_99;
float4 l9_108=sc_set2.backCapTex.sample(sc_set2.backCapTexSmpSC,l9_106,bias(l9_107));
float4 l9_109=l9_108;
float4 l9_110=l9_109;
if (l9_35)
{
l9_110=mix(l9_36,l9_110,float4(l9_39));
}
float4 l9_111=l9_110;
l9_20=l9_111;
l9_8=l9_20;
l9_13=l9_8;
}
else
{
if (DROPLIST_BACK_CAP_MODE_tmp==1)
{
float4 l9_112=float4(0.0);
float4 l9_113=(*sc_set2.UserUniforms).backCapStartingColor;
l9_112=l9_113;
float4 l9_114=float4(0.0);
l9_114=l9_112;
float4 l9_115=float4(0.0);
float4 l9_116=(*sc_set2.UserUniforms).backCapEndingColor;
l9_115=l9_116;
float4 l9_117=float4(0.0);
l9_117=l9_115;
float2 l9_118=float2(0.0);
l9_118=l9_12.Surface_UVCoord0;
float2 l9_119=float2(0.0);
l9_119=(((l9_118-float2((*sc_set2.UserUniforms).Port_RangeMinA_N132))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N132-(*sc_set2.UserUniforms).Port_RangeMinA_N132))*((*sc_set2.UserUniforms).Port_RangeMaxB_N132-(*sc_set2.UserUniforms).Port_RangeMinB_N132))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N132);
float2 l9_120=float2(0.0);
l9_120=(*sc_set2.UserUniforms).Port_Import_N133;
float2 l9_121=float2(0.0);
l9_121=((l9_119-(*sc_set2.UserUniforms).Port_Center_N134)*l9_120)+(*sc_set2.UserUniforms).Port_Center_N134;
float2 l9_122=float2(0.0);
l9_122=(*sc_set2.UserUniforms).Port_Import_N135;
float2 l9_123=float2(0.0);
l9_123=l9_121-l9_122;
float l9_124=0.0;
float l9_125=(*sc_set2.UserUniforms).backCapGradientRamp;
l9_124=l9_125;
float l9_126=0.0;
l9_126=(((l9_124-(*sc_set2.UserUniforms).Port_RangeMinA_N164)/((*sc_set2.UserUniforms).Port_RangeMaxA_N164-(*sc_set2.UserUniforms).Port_RangeMinA_N164))*((*sc_set2.UserUniforms).Port_RangeMaxB_N164-(*sc_set2.UserUniforms).Port_RangeMinB_N164))+(*sc_set2.UserUniforms).Port_RangeMinB_N164;
float2 l9_127=float2(0.0);
l9_127=float2(0.0,float2(l9_126).y);
float2 l9_128=float2(0.0);
l9_128=l9_127;
float2 l9_129=float2(0.0);
l9_129=l9_128-l9_122;
float l9_130=0.0;
l9_130=dot(l9_123,l9_129);
float l9_131=0.0;
l9_131=dot(l9_129,l9_129);
float l9_132=0.0;
l9_132=l9_130/(l9_131+1.234e-06);
float l9_133=0.0;
l9_133=fast::clamp(l9_132+0.001,(*sc_set2.UserUniforms).Port_Input1_N142+0.001,(*sc_set2.UserUniforms).Port_Input2_N142+0.001)-0.001;
float l9_134=0.0;
l9_134=smoothstep((*sc_set2.UserUniforms).Port_Input0_N143,(*sc_set2.UserUniforms).Port_Input1_N143,l9_133);
float4 l9_135=float4(0.0);
l9_135=mix(l9_114,l9_117,float4(l9_134));
float4 l9_136=float4(0.0);
l9_136=l9_135;
l9_9=l9_136;
l9_13=l9_9;
}
else
{
if (DROPLIST_BACK_CAP_MODE_tmp==2)
{
float4 l9_137=float4(0.0);
float4 l9_138=(*sc_set2.UserUniforms).backCapStartingColor;
l9_137=l9_138;
l9_10=l9_137;
l9_13=l9_10;
}
else
{
l9_13=l9_11;
}
}
}
l9_7=l9_13;
float l9_139=0.0;
float l9_140=(*sc_set2.UserUniforms).backCapMetallic;
l9_139=l9_140;
float l9_141=0.0;
float l9_142=(*sc_set2.UserUniforms).backCapRoughness;
l9_141=l9_142;
float4 l9_143=float4(0.0);
float3 l9_144=l9_7.xyz;
float l9_145=(*sc_set2.UserUniforms).Port_Opacity_N149;
float3 l9_146=(*sc_set2.UserUniforms).Port_Emissive_N149;
float l9_147=l9_139;
float l9_148=l9_141;
float3 l9_149=(*sc_set2.UserUniforms).Port_AO_N149;
float3 l9_150=(*sc_set2.UserUniforms).Port_SpecularAO_N149;
ssGlobals l9_151=param_3;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_151.BumpedNormal=l9_151.VertexNormal_WorldSpace;
}
float l9_152=l9_145;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_152<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_153=gl_FragCoord;
float2 l9_154=floor(mod(l9_153.xy,float2(4.0)));
float l9_155=(mod(dot(l9_154,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_152<l9_155)
{
discard_fragment();
}
}
l9_144=fast::max(l9_144,float3(0.0));
float4 l9_156;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_156=float4(l9_144,l9_145);
}
else
{
l9_147=fast::clamp(l9_147,0.0,1.0);
l9_148=fast::clamp(l9_148,0.0,1.0);
float3 l9_157=l9_144;
float l9_158=l9_145;
float3 l9_159=l9_151.BumpedNormal;
float3 l9_160=l9_151.PositionWS;
float3 l9_161=l9_151.ViewDirWS;
float3 l9_162=l9_146;
float l9_163=l9_147;
float l9_164=l9_148;
float3 l9_165=l9_149;
float3 l9_166=l9_150;
l9_156=ngsCalculateLighting(l9_157,l9_158,l9_159,l9_160,l9_161,l9_162,l9_163,l9_164,l9_165,l9_166,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_156=fast::max(l9_156,float4(0.0));
l9_143=l9_156;
param=l9_143;
param_2=param;
}
else
{
float4 l9_167=float4(0.0);
float4 l9_168=float4(0.0);
float4 l9_169=float4(0.0);
float4 l9_170=float4(0.0);
float4 l9_171=(*sc_set2.UserUniforms).Port_Default_N146;
ssGlobals l9_172=param_3;
float4 l9_173;
if (DROPLIST_BACK_CAP_MODE_tmp==0)
{
float2 l9_174=float2(0.0);
l9_174=l9_172.Surface_UVCoord0;
float2 l9_175=float2(0.0);
float2 l9_176=(*sc_set2.UserUniforms).backCapTexScale;
l9_175=l9_176;
float2 l9_177=float2(0.0);
float2 l9_178=(*sc_set2.UserUniforms).backCapTexOffset;
l9_177=l9_178;
float2 l9_179=float2(0.0);
l9_179=(l9_174*l9_175)+l9_177;
float4 l9_180=float4(0.0);
int l9_181=0;
if ((int(backCapTexHasSwappedViews_tmp)!=0))
{
int l9_182=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_182=0;
}
else
{
l9_182=in.varStereoViewID;
}
int l9_183=l9_182;
l9_181=1-l9_183;
}
else
{
int l9_184=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_184=0;
}
else
{
l9_184=in.varStereoViewID;
}
int l9_185=l9_184;
l9_181=l9_185;
}
int l9_186=l9_181;
int l9_187=backCapTexLayout_tmp;
int l9_188=l9_186;
float2 l9_189=l9_179;
bool l9_190=(int(SC_USE_UV_TRANSFORM_backCapTex_tmp)!=0);
float3x3 l9_191=(*sc_set2.UserUniforms).backCapTexTransform;
int2 l9_192=int2(SC_SOFTWARE_WRAP_MODE_U_backCapTex_tmp,SC_SOFTWARE_WRAP_MODE_V_backCapTex_tmp);
bool l9_193=(int(SC_USE_UV_MIN_MAX_backCapTex_tmp)!=0);
float4 l9_194=(*sc_set2.UserUniforms).backCapTexUvMinMax;
bool l9_195=(int(SC_USE_CLAMP_TO_BORDER_backCapTex_tmp)!=0);
float4 l9_196=(*sc_set2.UserUniforms).backCapTexBorderColor;
float l9_197=0.0;
bool l9_198=l9_195&&(!l9_193);
float l9_199=1.0;
float l9_200=l9_189.x;
int l9_201=l9_192.x;
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
l9_189.x=l9_200;
float l9_205=l9_189.y;
int l9_206=l9_192.y;
if (l9_206==1)
{
l9_205=fract(l9_205);
}
else
{
if (l9_206==2)
{
float l9_207=fract(l9_205);
float l9_208=l9_205-l9_207;
float l9_209=step(0.25,fract(l9_208*0.5));
l9_205=mix(l9_207,1.0-l9_207,fast::clamp(l9_209,0.0,1.0));
}
}
l9_189.y=l9_205;
if (l9_193)
{
bool l9_210=l9_195;
bool l9_211;
if (l9_210)
{
l9_211=l9_192.x==3;
}
else
{
l9_211=l9_210;
}
float l9_212=l9_189.x;
float l9_213=l9_194.x;
float l9_214=l9_194.z;
bool l9_215=l9_211;
float l9_216=l9_199;
float l9_217=fast::clamp(l9_212,l9_213,l9_214);
float l9_218=step(abs(l9_212-l9_217),9.9999997e-06);
l9_216*=(l9_218+((1.0-float(l9_215))*(1.0-l9_218)));
l9_212=l9_217;
l9_189.x=l9_212;
l9_199=l9_216;
bool l9_219=l9_195;
bool l9_220;
if (l9_219)
{
l9_220=l9_192.y==3;
}
else
{
l9_220=l9_219;
}
float l9_221=l9_189.y;
float l9_222=l9_194.y;
float l9_223=l9_194.w;
bool l9_224=l9_220;
float l9_225=l9_199;
float l9_226=fast::clamp(l9_221,l9_222,l9_223);
float l9_227=step(abs(l9_221-l9_226),9.9999997e-06);
l9_225*=(l9_227+((1.0-float(l9_224))*(1.0-l9_227)));
l9_221=l9_226;
l9_189.y=l9_221;
l9_199=l9_225;
}
float2 l9_228=l9_189;
bool l9_229=l9_190;
float3x3 l9_230=l9_191;
if (l9_229)
{
l9_228=float2((l9_230*float3(l9_228,1.0)).xy);
}
float2 l9_231=l9_228;
float2 l9_232=l9_231;
float2 l9_233=l9_232;
l9_189=l9_233;
float l9_234=l9_189.x;
int l9_235=l9_192.x;
bool l9_236=l9_198;
float l9_237=l9_199;
if ((l9_235==0)||(l9_235==3))
{
float l9_238=l9_234;
float l9_239=0.0;
float l9_240=1.0;
bool l9_241=l9_236;
float l9_242=l9_237;
float l9_243=fast::clamp(l9_238,l9_239,l9_240);
float l9_244=step(abs(l9_238-l9_243),9.9999997e-06);
l9_242*=(l9_244+((1.0-float(l9_241))*(1.0-l9_244)));
l9_238=l9_243;
l9_234=l9_238;
l9_237=l9_242;
}
l9_189.x=l9_234;
l9_199=l9_237;
float l9_245=l9_189.y;
int l9_246=l9_192.y;
bool l9_247=l9_198;
float l9_248=l9_199;
if ((l9_246==0)||(l9_246==3))
{
float l9_249=l9_245;
float l9_250=0.0;
float l9_251=1.0;
bool l9_252=l9_247;
float l9_253=l9_248;
float l9_254=fast::clamp(l9_249,l9_250,l9_251);
float l9_255=step(abs(l9_249-l9_254),9.9999997e-06);
l9_253*=(l9_255+((1.0-float(l9_252))*(1.0-l9_255)));
l9_249=l9_254;
l9_245=l9_249;
l9_248=l9_253;
}
l9_189.y=l9_245;
l9_199=l9_248;
float2 l9_256=l9_189;
int l9_257=l9_187;
int l9_258=l9_188;
float l9_259=l9_197;
float2 l9_260=l9_256;
int l9_261=l9_257;
int l9_262=l9_258;
float3 l9_263=float3(0.0);
if (l9_261==0)
{
l9_263=float3(l9_260,0.0);
}
else
{
if (l9_261==1)
{
l9_263=float3(l9_260.x,(l9_260.y*0.5)+(0.5-(float(l9_262)*0.5)),0.0);
}
else
{
l9_263=float3(l9_260,float(l9_262));
}
}
float3 l9_264=l9_263;
float3 l9_265=l9_264;
float2 l9_266=l9_265.xy;
float l9_267=l9_259;
float4 l9_268=sc_set2.backCapTex.sample(sc_set2.backCapTexSmpSC,l9_266,bias(l9_267));
float4 l9_269=l9_268;
float4 l9_270=l9_269;
if (l9_195)
{
l9_270=mix(l9_196,l9_270,float4(l9_199));
}
float4 l9_271=l9_270;
l9_180=l9_271;
l9_168=l9_180;
l9_173=l9_168;
}
else
{
if (DROPLIST_BACK_CAP_MODE_tmp==1)
{
float4 l9_272=float4(0.0);
float4 l9_273=(*sc_set2.UserUniforms).backCapStartingColor;
l9_272=l9_273;
float4 l9_274=float4(0.0);
l9_274=l9_272;
float4 l9_275=float4(0.0);
float4 l9_276=(*sc_set2.UserUniforms).backCapEndingColor;
l9_275=l9_276;
float4 l9_277=float4(0.0);
l9_277=l9_275;
float2 l9_278=float2(0.0);
l9_278=l9_172.Surface_UVCoord0;
float2 l9_279=float2(0.0);
l9_279=(((l9_278-float2((*sc_set2.UserUniforms).Port_RangeMinA_N132))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N132-(*sc_set2.UserUniforms).Port_RangeMinA_N132))*((*sc_set2.UserUniforms).Port_RangeMaxB_N132-(*sc_set2.UserUniforms).Port_RangeMinB_N132))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N132);
float2 l9_280=float2(0.0);
l9_280=(*sc_set2.UserUniforms).Port_Import_N133;
float2 l9_281=float2(0.0);
l9_281=((l9_279-(*sc_set2.UserUniforms).Port_Center_N134)*l9_280)+(*sc_set2.UserUniforms).Port_Center_N134;
float2 l9_282=float2(0.0);
l9_282=(*sc_set2.UserUniforms).Port_Import_N135;
float2 l9_283=float2(0.0);
l9_283=l9_281-l9_282;
float l9_284=0.0;
float l9_285=(*sc_set2.UserUniforms).backCapGradientRamp;
l9_284=l9_285;
float l9_286=0.0;
l9_286=(((l9_284-(*sc_set2.UserUniforms).Port_RangeMinA_N164)/((*sc_set2.UserUniforms).Port_RangeMaxA_N164-(*sc_set2.UserUniforms).Port_RangeMinA_N164))*((*sc_set2.UserUniforms).Port_RangeMaxB_N164-(*sc_set2.UserUniforms).Port_RangeMinB_N164))+(*sc_set2.UserUniforms).Port_RangeMinB_N164;
float2 l9_287=float2(0.0);
l9_287=float2(0.0,float2(l9_286).y);
float2 l9_288=float2(0.0);
l9_288=l9_287;
float2 l9_289=float2(0.0);
l9_289=l9_288-l9_282;
float l9_290=0.0;
l9_290=dot(l9_283,l9_289);
float l9_291=0.0;
l9_291=dot(l9_289,l9_289);
float l9_292=0.0;
l9_292=l9_290/(l9_291+1.234e-06);
float l9_293=0.0;
l9_293=fast::clamp(l9_292+0.001,(*sc_set2.UserUniforms).Port_Input1_N142+0.001,(*sc_set2.UserUniforms).Port_Input2_N142+0.001)-0.001;
float l9_294=0.0;
l9_294=smoothstep((*sc_set2.UserUniforms).Port_Input0_N143,(*sc_set2.UserUniforms).Port_Input1_N143,l9_293);
float4 l9_295=float4(0.0);
l9_295=mix(l9_274,l9_277,float4(l9_294));
float4 l9_296=float4(0.0);
l9_296=l9_295;
l9_169=l9_296;
l9_173=l9_169;
}
else
{
if (DROPLIST_BACK_CAP_MODE_tmp==2)
{
float4 l9_297=float4(0.0);
float4 l9_298=(*sc_set2.UserUniforms).backCapStartingColor;
l9_297=l9_298;
l9_170=l9_297;
l9_173=l9_170;
}
else
{
l9_173=l9_171;
}
}
}
l9_167=l9_173;
param_1=l9_167;
param_2=param_1;
}
Output_N150=param_2;
float4 Output_N120=float4(0.0);
float4 param_4=float4(1.0);
float4 param_5=float4(1.0,0.0,0.0,0.0);
ssGlobals param_7=Globals;
float4 param_6;
if ((int(frontCapPBR_tmp)!=0))
{
float4 l9_299=float4(0.0);
float4 l9_300=float4(0.0);
float4 l9_301=float4(0.0);
float4 l9_302=float4(0.0);
float4 l9_303=(*sc_set2.UserUniforms).Port_Default_N010;
ssGlobals l9_304=param_7;
float4 l9_305;
if (DROPLIST_FRONT_CAP_MODE_tmp==0)
{
float2 l9_306=float2(0.0);
l9_306=l9_304.Surface_UVCoord0;
float2 l9_307=float2(0.0);
float2 l9_308=(*sc_set2.UserUniforms).frontCapTexScale;
l9_307=l9_308;
float2 l9_309=float2(0.0);
float2 l9_310=(*sc_set2.UserUniforms).frontCapTexOffset;
l9_309=l9_310;
float2 l9_311=float2(0.0);
l9_311=(l9_306*l9_307)+l9_309;
float4 l9_312=float4(0.0);
int l9_313=0;
if ((int(frontCapTexHasSwappedViews_tmp)!=0))
{
int l9_314=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_314=0;
}
else
{
l9_314=in.varStereoViewID;
}
int l9_315=l9_314;
l9_313=1-l9_315;
}
else
{
int l9_316=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_316=0;
}
else
{
l9_316=in.varStereoViewID;
}
int l9_317=l9_316;
l9_313=l9_317;
}
int l9_318=l9_313;
int l9_319=frontCapTexLayout_tmp;
int l9_320=l9_318;
float2 l9_321=l9_311;
bool l9_322=(int(SC_USE_UV_TRANSFORM_frontCapTex_tmp)!=0);
float3x3 l9_323=(*sc_set2.UserUniforms).frontCapTexTransform;
int2 l9_324=int2(SC_SOFTWARE_WRAP_MODE_U_frontCapTex_tmp,SC_SOFTWARE_WRAP_MODE_V_frontCapTex_tmp);
bool l9_325=(int(SC_USE_UV_MIN_MAX_frontCapTex_tmp)!=0);
float4 l9_326=(*sc_set2.UserUniforms).frontCapTexUvMinMax;
bool l9_327=(int(SC_USE_CLAMP_TO_BORDER_frontCapTex_tmp)!=0);
float4 l9_328=(*sc_set2.UserUniforms).frontCapTexBorderColor;
float l9_329=0.0;
bool l9_330=l9_327&&(!l9_325);
float l9_331=1.0;
float l9_332=l9_321.x;
int l9_333=l9_324.x;
if (l9_333==1)
{
l9_332=fract(l9_332);
}
else
{
if (l9_333==2)
{
float l9_334=fract(l9_332);
float l9_335=l9_332-l9_334;
float l9_336=step(0.25,fract(l9_335*0.5));
l9_332=mix(l9_334,1.0-l9_334,fast::clamp(l9_336,0.0,1.0));
}
}
l9_321.x=l9_332;
float l9_337=l9_321.y;
int l9_338=l9_324.y;
if (l9_338==1)
{
l9_337=fract(l9_337);
}
else
{
if (l9_338==2)
{
float l9_339=fract(l9_337);
float l9_340=l9_337-l9_339;
float l9_341=step(0.25,fract(l9_340*0.5));
l9_337=mix(l9_339,1.0-l9_339,fast::clamp(l9_341,0.0,1.0));
}
}
l9_321.y=l9_337;
if (l9_325)
{
bool l9_342=l9_327;
bool l9_343;
if (l9_342)
{
l9_343=l9_324.x==3;
}
else
{
l9_343=l9_342;
}
float l9_344=l9_321.x;
float l9_345=l9_326.x;
float l9_346=l9_326.z;
bool l9_347=l9_343;
float l9_348=l9_331;
float l9_349=fast::clamp(l9_344,l9_345,l9_346);
float l9_350=step(abs(l9_344-l9_349),9.9999997e-06);
l9_348*=(l9_350+((1.0-float(l9_347))*(1.0-l9_350)));
l9_344=l9_349;
l9_321.x=l9_344;
l9_331=l9_348;
bool l9_351=l9_327;
bool l9_352;
if (l9_351)
{
l9_352=l9_324.y==3;
}
else
{
l9_352=l9_351;
}
float l9_353=l9_321.y;
float l9_354=l9_326.y;
float l9_355=l9_326.w;
bool l9_356=l9_352;
float l9_357=l9_331;
float l9_358=fast::clamp(l9_353,l9_354,l9_355);
float l9_359=step(abs(l9_353-l9_358),9.9999997e-06);
l9_357*=(l9_359+((1.0-float(l9_356))*(1.0-l9_359)));
l9_353=l9_358;
l9_321.y=l9_353;
l9_331=l9_357;
}
float2 l9_360=l9_321;
bool l9_361=l9_322;
float3x3 l9_362=l9_323;
if (l9_361)
{
l9_360=float2((l9_362*float3(l9_360,1.0)).xy);
}
float2 l9_363=l9_360;
float2 l9_364=l9_363;
float2 l9_365=l9_364;
l9_321=l9_365;
float l9_366=l9_321.x;
int l9_367=l9_324.x;
bool l9_368=l9_330;
float l9_369=l9_331;
if ((l9_367==0)||(l9_367==3))
{
float l9_370=l9_366;
float l9_371=0.0;
float l9_372=1.0;
bool l9_373=l9_368;
float l9_374=l9_369;
float l9_375=fast::clamp(l9_370,l9_371,l9_372);
float l9_376=step(abs(l9_370-l9_375),9.9999997e-06);
l9_374*=(l9_376+((1.0-float(l9_373))*(1.0-l9_376)));
l9_370=l9_375;
l9_366=l9_370;
l9_369=l9_374;
}
l9_321.x=l9_366;
l9_331=l9_369;
float l9_377=l9_321.y;
int l9_378=l9_324.y;
bool l9_379=l9_330;
float l9_380=l9_331;
if ((l9_378==0)||(l9_378==3))
{
float l9_381=l9_377;
float l9_382=0.0;
float l9_383=1.0;
bool l9_384=l9_379;
float l9_385=l9_380;
float l9_386=fast::clamp(l9_381,l9_382,l9_383);
float l9_387=step(abs(l9_381-l9_386),9.9999997e-06);
l9_385*=(l9_387+((1.0-float(l9_384))*(1.0-l9_387)));
l9_381=l9_386;
l9_377=l9_381;
l9_380=l9_385;
}
l9_321.y=l9_377;
l9_331=l9_380;
float2 l9_388=l9_321;
int l9_389=l9_319;
int l9_390=l9_320;
float l9_391=l9_329;
float2 l9_392=l9_388;
int l9_393=l9_389;
int l9_394=l9_390;
float3 l9_395=float3(0.0);
if (l9_393==0)
{
l9_395=float3(l9_392,0.0);
}
else
{
if (l9_393==1)
{
l9_395=float3(l9_392.x,(l9_392.y*0.5)+(0.5-(float(l9_394)*0.5)),0.0);
}
else
{
l9_395=float3(l9_392,float(l9_394));
}
}
float3 l9_396=l9_395;
float3 l9_397=l9_396;
float2 l9_398=l9_397.xy;
float l9_399=l9_391;
float4 l9_400=sc_set2.frontCapTex.sample(sc_set2.frontCapTexSmpSC,l9_398,bias(l9_399));
float4 l9_401=l9_400;
float4 l9_402=l9_401;
if (l9_327)
{
l9_402=mix(l9_328,l9_402,float4(l9_331));
}
float4 l9_403=l9_402;
l9_312=l9_403;
l9_300=l9_312;
l9_305=l9_300;
}
else
{
if (DROPLIST_FRONT_CAP_MODE_tmp==1)
{
float4 l9_404=float4(0.0);
float4 l9_405=(*sc_set2.UserUniforms).frontCapStartingColor;
l9_404=l9_405;
float4 l9_406=float4(0.0);
l9_406=l9_404;
float4 l9_407=float4(0.0);
float4 l9_408=(*sc_set2.UserUniforms).frontCapEndingColor;
l9_407=l9_408;
float4 l9_409=float4(0.0);
l9_409=l9_407;
float2 l9_410=float2(0.0);
l9_410=l9_304.Surface_UVCoord0;
float2 l9_411=float2(0.0);
l9_411=(((l9_410-float2((*sc_set2.UserUniforms).Port_RangeMinA_N101))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N101-(*sc_set2.UserUniforms).Port_RangeMinA_N101))*((*sc_set2.UserUniforms).Port_RangeMaxB_N101-(*sc_set2.UserUniforms).Port_RangeMinB_N101))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N101);
float2 l9_412=float2(0.0);
l9_412=(*sc_set2.UserUniforms).Port_Import_N102;
float2 l9_413=float2(0.0);
l9_413=((l9_411-(*sc_set2.UserUniforms).Port_Center_N103)*l9_412)+(*sc_set2.UserUniforms).Port_Center_N103;
float2 l9_414=float2(0.0);
l9_414=(*sc_set2.UserUniforms).Port_Import_N104;
float2 l9_415=float2(0.0);
l9_415=l9_413-l9_414;
float l9_416=0.0;
float l9_417=(*sc_set2.UserUniforms).frontCapGradientRamp;
l9_416=l9_417;
float l9_418=0.0;
l9_418=(((l9_416-(*sc_set2.UserUniforms).Port_RangeMinA_N160)/((*sc_set2.UserUniforms).Port_RangeMaxA_N160-(*sc_set2.UserUniforms).Port_RangeMinA_N160))*((*sc_set2.UserUniforms).Port_RangeMaxB_N160-(*sc_set2.UserUniforms).Port_RangeMinB_N160))+(*sc_set2.UserUniforms).Port_RangeMinB_N160;
float2 l9_419=float2(0.0);
l9_419=float2(0.0,float2(l9_418).y);
float2 l9_420=float2(0.0);
l9_420=l9_419;
float2 l9_421=float2(0.0);
l9_421=l9_420-l9_414;
float l9_422=0.0;
l9_422=dot(l9_415,l9_421);
float l9_423=0.0;
l9_423=dot(l9_421,l9_421);
float l9_424=0.0;
l9_424=l9_422/(l9_423+1.234e-06);
float l9_425=0.0;
l9_425=fast::clamp(l9_424+0.001,(*sc_set2.UserUniforms).Port_Input1_N111+0.001,(*sc_set2.UserUniforms).Port_Input2_N111+0.001)-0.001;
float l9_426=0.0;
l9_426=smoothstep((*sc_set2.UserUniforms).Port_Input0_N112,(*sc_set2.UserUniforms).Port_Input1_N112,l9_425);
float4 l9_427=float4(0.0);
l9_427=mix(l9_406,l9_409,float4(l9_426));
float4 l9_428=float4(0.0);
l9_428=l9_427;
l9_301=l9_428;
l9_305=l9_301;
}
else
{
if (DROPLIST_FRONT_CAP_MODE_tmp==2)
{
float4 l9_429=float4(0.0);
float4 l9_430=(*sc_set2.UserUniforms).frontCapStartingColor;
l9_429=l9_430;
l9_302=l9_429;
l9_305=l9_302;
}
else
{
l9_305=l9_303;
}
}
}
l9_299=l9_305;
float l9_431=0.0;
float l9_432=(*sc_set2.UserUniforms).frontCapMetallic;
l9_431=l9_432;
float l9_433=0.0;
float l9_434=(*sc_set2.UserUniforms).frontCapRoughness;
l9_433=l9_434;
float4 l9_435=float4(0.0);
float3 l9_436=l9_299.xyz;
float l9_437=(*sc_set2.UserUniforms).Port_Opacity_N118;
float3 l9_438=(*sc_set2.UserUniforms).Port_Emissive_N118;
float l9_439=l9_431;
float l9_440=l9_433;
float3 l9_441=(*sc_set2.UserUniforms).Port_AO_N118;
float3 l9_442=(*sc_set2.UserUniforms).Port_SpecularAO_N118;
ssGlobals l9_443=param_7;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_443.BumpedNormal=l9_443.VertexNormal_WorldSpace;
}
float l9_444=l9_437;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_444<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_445=gl_FragCoord;
float2 l9_446=floor(mod(l9_445.xy,float2(4.0)));
float l9_447=(mod(dot(l9_446,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_444<l9_447)
{
discard_fragment();
}
}
l9_436=fast::max(l9_436,float3(0.0));
float4 l9_448;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_448=float4(l9_436,l9_437);
}
else
{
l9_439=fast::clamp(l9_439,0.0,1.0);
l9_440=fast::clamp(l9_440,0.0,1.0);
float3 l9_449=l9_436;
float l9_450=l9_437;
float3 l9_451=l9_443.BumpedNormal;
float3 l9_452=l9_443.PositionWS;
float3 l9_453=l9_443.ViewDirWS;
float3 l9_454=l9_438;
float l9_455=l9_439;
float l9_456=l9_440;
float3 l9_457=l9_441;
float3 l9_458=l9_442;
l9_448=ngsCalculateLighting(l9_449,l9_450,l9_451,l9_452,l9_453,l9_454,l9_455,l9_456,l9_457,l9_458,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_448=fast::max(l9_448,float4(0.0));
l9_435=l9_448;
param_4=l9_435;
param_6=param_4;
}
else
{
float4 l9_459=float4(0.0);
float4 l9_460=float4(0.0);
float4 l9_461=float4(0.0);
float4 l9_462=float4(0.0);
float4 l9_463=(*sc_set2.UserUniforms).Port_Default_N010;
ssGlobals l9_464=param_7;
float4 l9_465;
if (DROPLIST_FRONT_CAP_MODE_tmp==0)
{
float2 l9_466=float2(0.0);
l9_466=l9_464.Surface_UVCoord0;
float2 l9_467=float2(0.0);
float2 l9_468=(*sc_set2.UserUniforms).frontCapTexScale;
l9_467=l9_468;
float2 l9_469=float2(0.0);
float2 l9_470=(*sc_set2.UserUniforms).frontCapTexOffset;
l9_469=l9_470;
float2 l9_471=float2(0.0);
l9_471=(l9_466*l9_467)+l9_469;
float4 l9_472=float4(0.0);
int l9_473=0;
if ((int(frontCapTexHasSwappedViews_tmp)!=0))
{
int l9_474=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_474=0;
}
else
{
l9_474=in.varStereoViewID;
}
int l9_475=l9_474;
l9_473=1-l9_475;
}
else
{
int l9_476=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_476=0;
}
else
{
l9_476=in.varStereoViewID;
}
int l9_477=l9_476;
l9_473=l9_477;
}
int l9_478=l9_473;
int l9_479=frontCapTexLayout_tmp;
int l9_480=l9_478;
float2 l9_481=l9_471;
bool l9_482=(int(SC_USE_UV_TRANSFORM_frontCapTex_tmp)!=0);
float3x3 l9_483=(*sc_set2.UserUniforms).frontCapTexTransform;
int2 l9_484=int2(SC_SOFTWARE_WRAP_MODE_U_frontCapTex_tmp,SC_SOFTWARE_WRAP_MODE_V_frontCapTex_tmp);
bool l9_485=(int(SC_USE_UV_MIN_MAX_frontCapTex_tmp)!=0);
float4 l9_486=(*sc_set2.UserUniforms).frontCapTexUvMinMax;
bool l9_487=(int(SC_USE_CLAMP_TO_BORDER_frontCapTex_tmp)!=0);
float4 l9_488=(*sc_set2.UserUniforms).frontCapTexBorderColor;
float l9_489=0.0;
bool l9_490=l9_487&&(!l9_485);
float l9_491=1.0;
float l9_492=l9_481.x;
int l9_493=l9_484.x;
if (l9_493==1)
{
l9_492=fract(l9_492);
}
else
{
if (l9_493==2)
{
float l9_494=fract(l9_492);
float l9_495=l9_492-l9_494;
float l9_496=step(0.25,fract(l9_495*0.5));
l9_492=mix(l9_494,1.0-l9_494,fast::clamp(l9_496,0.0,1.0));
}
}
l9_481.x=l9_492;
float l9_497=l9_481.y;
int l9_498=l9_484.y;
if (l9_498==1)
{
l9_497=fract(l9_497);
}
else
{
if (l9_498==2)
{
float l9_499=fract(l9_497);
float l9_500=l9_497-l9_499;
float l9_501=step(0.25,fract(l9_500*0.5));
l9_497=mix(l9_499,1.0-l9_499,fast::clamp(l9_501,0.0,1.0));
}
}
l9_481.y=l9_497;
if (l9_485)
{
bool l9_502=l9_487;
bool l9_503;
if (l9_502)
{
l9_503=l9_484.x==3;
}
else
{
l9_503=l9_502;
}
float l9_504=l9_481.x;
float l9_505=l9_486.x;
float l9_506=l9_486.z;
bool l9_507=l9_503;
float l9_508=l9_491;
float l9_509=fast::clamp(l9_504,l9_505,l9_506);
float l9_510=step(abs(l9_504-l9_509),9.9999997e-06);
l9_508*=(l9_510+((1.0-float(l9_507))*(1.0-l9_510)));
l9_504=l9_509;
l9_481.x=l9_504;
l9_491=l9_508;
bool l9_511=l9_487;
bool l9_512;
if (l9_511)
{
l9_512=l9_484.y==3;
}
else
{
l9_512=l9_511;
}
float l9_513=l9_481.y;
float l9_514=l9_486.y;
float l9_515=l9_486.w;
bool l9_516=l9_512;
float l9_517=l9_491;
float l9_518=fast::clamp(l9_513,l9_514,l9_515);
float l9_519=step(abs(l9_513-l9_518),9.9999997e-06);
l9_517*=(l9_519+((1.0-float(l9_516))*(1.0-l9_519)));
l9_513=l9_518;
l9_481.y=l9_513;
l9_491=l9_517;
}
float2 l9_520=l9_481;
bool l9_521=l9_482;
float3x3 l9_522=l9_483;
if (l9_521)
{
l9_520=float2((l9_522*float3(l9_520,1.0)).xy);
}
float2 l9_523=l9_520;
float2 l9_524=l9_523;
float2 l9_525=l9_524;
l9_481=l9_525;
float l9_526=l9_481.x;
int l9_527=l9_484.x;
bool l9_528=l9_490;
float l9_529=l9_491;
if ((l9_527==0)||(l9_527==3))
{
float l9_530=l9_526;
float l9_531=0.0;
float l9_532=1.0;
bool l9_533=l9_528;
float l9_534=l9_529;
float l9_535=fast::clamp(l9_530,l9_531,l9_532);
float l9_536=step(abs(l9_530-l9_535),9.9999997e-06);
l9_534*=(l9_536+((1.0-float(l9_533))*(1.0-l9_536)));
l9_530=l9_535;
l9_526=l9_530;
l9_529=l9_534;
}
l9_481.x=l9_526;
l9_491=l9_529;
float l9_537=l9_481.y;
int l9_538=l9_484.y;
bool l9_539=l9_490;
float l9_540=l9_491;
if ((l9_538==0)||(l9_538==3))
{
float l9_541=l9_537;
float l9_542=0.0;
float l9_543=1.0;
bool l9_544=l9_539;
float l9_545=l9_540;
float l9_546=fast::clamp(l9_541,l9_542,l9_543);
float l9_547=step(abs(l9_541-l9_546),9.9999997e-06);
l9_545*=(l9_547+((1.0-float(l9_544))*(1.0-l9_547)));
l9_541=l9_546;
l9_537=l9_541;
l9_540=l9_545;
}
l9_481.y=l9_537;
l9_491=l9_540;
float2 l9_548=l9_481;
int l9_549=l9_479;
int l9_550=l9_480;
float l9_551=l9_489;
float2 l9_552=l9_548;
int l9_553=l9_549;
int l9_554=l9_550;
float3 l9_555=float3(0.0);
if (l9_553==0)
{
l9_555=float3(l9_552,0.0);
}
else
{
if (l9_553==1)
{
l9_555=float3(l9_552.x,(l9_552.y*0.5)+(0.5-(float(l9_554)*0.5)),0.0);
}
else
{
l9_555=float3(l9_552,float(l9_554));
}
}
float3 l9_556=l9_555;
float3 l9_557=l9_556;
float2 l9_558=l9_557.xy;
float l9_559=l9_551;
float4 l9_560=sc_set2.frontCapTex.sample(sc_set2.frontCapTexSmpSC,l9_558,bias(l9_559));
float4 l9_561=l9_560;
float4 l9_562=l9_561;
if (l9_487)
{
l9_562=mix(l9_488,l9_562,float4(l9_491));
}
float4 l9_563=l9_562;
l9_472=l9_563;
l9_460=l9_472;
l9_465=l9_460;
}
else
{
if (DROPLIST_FRONT_CAP_MODE_tmp==1)
{
float4 l9_564=float4(0.0);
float4 l9_565=(*sc_set2.UserUniforms).frontCapStartingColor;
l9_564=l9_565;
float4 l9_566=float4(0.0);
l9_566=l9_564;
float4 l9_567=float4(0.0);
float4 l9_568=(*sc_set2.UserUniforms).frontCapEndingColor;
l9_567=l9_568;
float4 l9_569=float4(0.0);
l9_569=l9_567;
float2 l9_570=float2(0.0);
l9_570=l9_464.Surface_UVCoord0;
float2 l9_571=float2(0.0);
l9_571=(((l9_570-float2((*sc_set2.UserUniforms).Port_RangeMinA_N101))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N101-(*sc_set2.UserUniforms).Port_RangeMinA_N101))*((*sc_set2.UserUniforms).Port_RangeMaxB_N101-(*sc_set2.UserUniforms).Port_RangeMinB_N101))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N101);
float2 l9_572=float2(0.0);
l9_572=(*sc_set2.UserUniforms).Port_Import_N102;
float2 l9_573=float2(0.0);
l9_573=((l9_571-(*sc_set2.UserUniforms).Port_Center_N103)*l9_572)+(*sc_set2.UserUniforms).Port_Center_N103;
float2 l9_574=float2(0.0);
l9_574=(*sc_set2.UserUniforms).Port_Import_N104;
float2 l9_575=float2(0.0);
l9_575=l9_573-l9_574;
float l9_576=0.0;
float l9_577=(*sc_set2.UserUniforms).frontCapGradientRamp;
l9_576=l9_577;
float l9_578=0.0;
l9_578=(((l9_576-(*sc_set2.UserUniforms).Port_RangeMinA_N160)/((*sc_set2.UserUniforms).Port_RangeMaxA_N160-(*sc_set2.UserUniforms).Port_RangeMinA_N160))*((*sc_set2.UserUniforms).Port_RangeMaxB_N160-(*sc_set2.UserUniforms).Port_RangeMinB_N160))+(*sc_set2.UserUniforms).Port_RangeMinB_N160;
float2 l9_579=float2(0.0);
l9_579=float2(0.0,float2(l9_578).y);
float2 l9_580=float2(0.0);
l9_580=l9_579;
float2 l9_581=float2(0.0);
l9_581=l9_580-l9_574;
float l9_582=0.0;
l9_582=dot(l9_575,l9_581);
float l9_583=0.0;
l9_583=dot(l9_581,l9_581);
float l9_584=0.0;
l9_584=l9_582/(l9_583+1.234e-06);
float l9_585=0.0;
l9_585=fast::clamp(l9_584+0.001,(*sc_set2.UserUniforms).Port_Input1_N111+0.001,(*sc_set2.UserUniforms).Port_Input2_N111+0.001)-0.001;
float l9_586=0.0;
l9_586=smoothstep((*sc_set2.UserUniforms).Port_Input0_N112,(*sc_set2.UserUniforms).Port_Input1_N112,l9_585);
float4 l9_587=float4(0.0);
l9_587=mix(l9_566,l9_569,float4(l9_586));
float4 l9_588=float4(0.0);
l9_588=l9_587;
l9_461=l9_588;
l9_465=l9_461;
}
else
{
if (DROPLIST_FRONT_CAP_MODE_tmp==2)
{
float4 l9_589=float4(0.0);
float4 l9_590=(*sc_set2.UserUniforms).frontCapStartingColor;
l9_589=l9_590;
l9_462=l9_589;
l9_465=l9_462;
}
else
{
l9_465=l9_463;
}
}
}
l9_459=l9_465;
param_5=l9_459;
param_6=param_5;
}
Output_N120=param_6;
float2 UVCoord_N52=float2(0.0);
UVCoord_N52=Globals.Surface_UVCoord0;
float Output_N53=0.0;
Output_N53=UVCoord_N52.x;
float Output_N54=0.0;
Output_N54=step(Output_N53,(*sc_set2.UserUniforms).Port_Input1_N054);
float4 Output_N51=float4(0.0);
Output_N51=mix(Output_N150,Output_N120,float4(Output_N54));
float4 Output_N75=float4(0.0);
float4 param_8=float4(1.0);
float4 param_9=float4(1.0,0.0,0.0,0.0);
ssGlobals param_11=Globals;
float4 param_10;
if ((int(outerEdgePBR_tmp)!=0))
{
float4 l9_591=float4(0.0);
float4 l9_592=float4(0.0);
float4 l9_593=float4(0.0);
float4 l9_594=float4(0.0);
float4 l9_595=(*sc_set2.UserUniforms).Port_Default_N046;
ssGlobals l9_596=param_11;
float4 l9_597;
if (DROPLIST_OUTER_EDGE_MODE_tmp==0)
{
float2 l9_598=float2(0.0);
l9_598=l9_596.Surface_UVCoord0;
float2 l9_599=float2(0.0);
float2 l9_600=(*sc_set2.UserUniforms).outerEdgeTexScale;
l9_599=l9_600;
float2 l9_601=float2(0.0);
float2 l9_602=(*sc_set2.UserUniforms).outerEdgeTexOffset;
l9_601=l9_602;
float2 l9_603=float2(0.0);
l9_603=(l9_598*l9_599)+l9_601;
float4 l9_604=float4(0.0);
int l9_605=0;
if ((int(outerEdgeTexHasSwappedViews_tmp)!=0))
{
int l9_606=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_606=0;
}
else
{
l9_606=in.varStereoViewID;
}
int l9_607=l9_606;
l9_605=1-l9_607;
}
else
{
int l9_608=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_608=0;
}
else
{
l9_608=in.varStereoViewID;
}
int l9_609=l9_608;
l9_605=l9_609;
}
int l9_610=l9_605;
int l9_611=outerEdgeTexLayout_tmp;
int l9_612=l9_610;
float2 l9_613=l9_603;
bool l9_614=(int(SC_USE_UV_TRANSFORM_outerEdgeTex_tmp)!=0);
float3x3 l9_615=(*sc_set2.UserUniforms).outerEdgeTexTransform;
int2 l9_616=int2(SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex_tmp,SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex_tmp);
bool l9_617=(int(SC_USE_UV_MIN_MAX_outerEdgeTex_tmp)!=0);
float4 l9_618=(*sc_set2.UserUniforms).outerEdgeTexUvMinMax;
bool l9_619=(int(SC_USE_CLAMP_TO_BORDER_outerEdgeTex_tmp)!=0);
float4 l9_620=(*sc_set2.UserUniforms).outerEdgeTexBorderColor;
float l9_621=0.0;
bool l9_622=l9_619&&(!l9_617);
float l9_623=1.0;
float l9_624=l9_613.x;
int l9_625=l9_616.x;
if (l9_625==1)
{
l9_624=fract(l9_624);
}
else
{
if (l9_625==2)
{
float l9_626=fract(l9_624);
float l9_627=l9_624-l9_626;
float l9_628=step(0.25,fract(l9_627*0.5));
l9_624=mix(l9_626,1.0-l9_626,fast::clamp(l9_628,0.0,1.0));
}
}
l9_613.x=l9_624;
float l9_629=l9_613.y;
int l9_630=l9_616.y;
if (l9_630==1)
{
l9_629=fract(l9_629);
}
else
{
if (l9_630==2)
{
float l9_631=fract(l9_629);
float l9_632=l9_629-l9_631;
float l9_633=step(0.25,fract(l9_632*0.5));
l9_629=mix(l9_631,1.0-l9_631,fast::clamp(l9_633,0.0,1.0));
}
}
l9_613.y=l9_629;
if (l9_617)
{
bool l9_634=l9_619;
bool l9_635;
if (l9_634)
{
l9_635=l9_616.x==3;
}
else
{
l9_635=l9_634;
}
float l9_636=l9_613.x;
float l9_637=l9_618.x;
float l9_638=l9_618.z;
bool l9_639=l9_635;
float l9_640=l9_623;
float l9_641=fast::clamp(l9_636,l9_637,l9_638);
float l9_642=step(abs(l9_636-l9_641),9.9999997e-06);
l9_640*=(l9_642+((1.0-float(l9_639))*(1.0-l9_642)));
l9_636=l9_641;
l9_613.x=l9_636;
l9_623=l9_640;
bool l9_643=l9_619;
bool l9_644;
if (l9_643)
{
l9_644=l9_616.y==3;
}
else
{
l9_644=l9_643;
}
float l9_645=l9_613.y;
float l9_646=l9_618.y;
float l9_647=l9_618.w;
bool l9_648=l9_644;
float l9_649=l9_623;
float l9_650=fast::clamp(l9_645,l9_646,l9_647);
float l9_651=step(abs(l9_645-l9_650),9.9999997e-06);
l9_649*=(l9_651+((1.0-float(l9_648))*(1.0-l9_651)));
l9_645=l9_650;
l9_613.y=l9_645;
l9_623=l9_649;
}
float2 l9_652=l9_613;
bool l9_653=l9_614;
float3x3 l9_654=l9_615;
if (l9_653)
{
l9_652=float2((l9_654*float3(l9_652,1.0)).xy);
}
float2 l9_655=l9_652;
float2 l9_656=l9_655;
float2 l9_657=l9_656;
l9_613=l9_657;
float l9_658=l9_613.x;
int l9_659=l9_616.x;
bool l9_660=l9_622;
float l9_661=l9_623;
if ((l9_659==0)||(l9_659==3))
{
float l9_662=l9_658;
float l9_663=0.0;
float l9_664=1.0;
bool l9_665=l9_660;
float l9_666=l9_661;
float l9_667=fast::clamp(l9_662,l9_663,l9_664);
float l9_668=step(abs(l9_662-l9_667),9.9999997e-06);
l9_666*=(l9_668+((1.0-float(l9_665))*(1.0-l9_668)));
l9_662=l9_667;
l9_658=l9_662;
l9_661=l9_666;
}
l9_613.x=l9_658;
l9_623=l9_661;
float l9_669=l9_613.y;
int l9_670=l9_616.y;
bool l9_671=l9_622;
float l9_672=l9_623;
if ((l9_670==0)||(l9_670==3))
{
float l9_673=l9_669;
float l9_674=0.0;
float l9_675=1.0;
bool l9_676=l9_671;
float l9_677=l9_672;
float l9_678=fast::clamp(l9_673,l9_674,l9_675);
float l9_679=step(abs(l9_673-l9_678),9.9999997e-06);
l9_677*=(l9_679+((1.0-float(l9_676))*(1.0-l9_679)));
l9_673=l9_678;
l9_669=l9_673;
l9_672=l9_677;
}
l9_613.y=l9_669;
l9_623=l9_672;
float2 l9_680=l9_613;
int l9_681=l9_611;
int l9_682=l9_612;
float l9_683=l9_621;
float2 l9_684=l9_680;
int l9_685=l9_681;
int l9_686=l9_682;
float3 l9_687=float3(0.0);
if (l9_685==0)
{
l9_687=float3(l9_684,0.0);
}
else
{
if (l9_685==1)
{
l9_687=float3(l9_684.x,(l9_684.y*0.5)+(0.5-(float(l9_686)*0.5)),0.0);
}
else
{
l9_687=float3(l9_684,float(l9_686));
}
}
float3 l9_688=l9_687;
float3 l9_689=l9_688;
float2 l9_690=l9_689.xy;
float l9_691=l9_683;
float4 l9_692=sc_set2.outerEdgeTex.sample(sc_set2.outerEdgeTexSmpSC,l9_690,bias(l9_691));
float4 l9_693=l9_692;
float4 l9_694=l9_693;
if (l9_619)
{
l9_694=mix(l9_620,l9_694,float4(l9_623));
}
float4 l9_695=l9_694;
l9_604=l9_695;
l9_592=l9_604;
l9_597=l9_592;
}
else
{
if (DROPLIST_OUTER_EDGE_MODE_tmp==1)
{
float4 l9_696=float4(0.0);
float4 l9_697=(*sc_set2.UserUniforms).outerEdgeStartingColor;
l9_696=l9_697;
float4 l9_698=float4(0.0);
l9_698=l9_696;
float4 l9_699=float4(0.0);
float4 l9_700=(*sc_set2.UserUniforms).outerEdgeEndingColor;
l9_699=l9_700;
float4 l9_701=float4(0.0);
l9_701=l9_699;
float2 l9_702=float2(0.0);
l9_702=l9_596.Surface_UVCoord0;
float2 l9_703=float2(0.0);
l9_703=(((l9_702-float2((*sc_set2.UserUniforms).Port_RangeMinA_N033))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N033-(*sc_set2.UserUniforms).Port_RangeMinA_N033))*((*sc_set2.UserUniforms).Port_RangeMaxB_N033-(*sc_set2.UserUniforms).Port_RangeMinB_N033))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N033);
float2 l9_704=float2(0.0);
l9_704=(*sc_set2.UserUniforms).Port_Import_N017;
float2 l9_705=float2(0.0);
l9_705=((l9_703-(*sc_set2.UserUniforms).Port_Center_N047)*l9_704)+(*sc_set2.UserUniforms).Port_Center_N047;
float2 l9_706=float2(0.0);
l9_706=(*sc_set2.UserUniforms).Port_Import_N058;
float2 l9_707=float2(0.0);
l9_707=l9_705-l9_706;
float l9_708=0.0;
float l9_709=(*sc_set2.UserUniforms).outerEdgeGradientRamp;
l9_708=l9_709;
float l9_710=0.0;
l9_710=(((l9_708-(*sc_set2.UserUniforms).Port_RangeMinA_N153)/((*sc_set2.UserUniforms).Port_RangeMaxA_N153-(*sc_set2.UserUniforms).Port_RangeMinA_N153))*((*sc_set2.UserUniforms).Port_RangeMaxB_N153-(*sc_set2.UserUniforms).Port_RangeMinB_N153))+(*sc_set2.UserUniforms).Port_RangeMinB_N153;
float2 l9_711=float2(0.0);
l9_711=float2(0.0,float2(l9_710).y);
float2 l9_712=float2(0.0);
l9_712=l9_711;
float2 l9_713=float2(0.0);
l9_713=l9_712-l9_706;
float l9_714=0.0;
l9_714=dot(l9_707,l9_713);
float l9_715=0.0;
l9_715=dot(l9_713,l9_713);
float l9_716=0.0;
l9_716=l9_714/(l9_715+1.234e-06);
float l9_717=0.0;
l9_717=fast::clamp(l9_716+0.001,(*sc_set2.UserUniforms).Port_Input1_N065+0.001,(*sc_set2.UserUniforms).Port_Input2_N065+0.001)-0.001;
float l9_718=0.0;
l9_718=smoothstep((*sc_set2.UserUniforms).Port_Input0_N066,(*sc_set2.UserUniforms).Port_Input1_N066,l9_717);
float4 l9_719=float4(0.0);
l9_719=mix(l9_698,l9_701,float4(l9_718));
float4 l9_720=float4(0.0);
l9_720=l9_719;
l9_593=l9_720;
l9_597=l9_593;
}
else
{
if (DROPLIST_OUTER_EDGE_MODE_tmp==2)
{
float4 l9_721=float4(0.0);
float4 l9_722=(*sc_set2.UserUniforms).outerEdgeStartingColor;
l9_721=l9_722;
l9_594=l9_721;
l9_597=l9_594;
}
else
{
l9_597=l9_595;
}
}
}
l9_591=l9_597;
float l9_723=0.0;
float l9_724=(*sc_set2.UserUniforms).outerEdgeMetallic;
l9_723=l9_724;
float l9_725=0.0;
float l9_726=(*sc_set2.UserUniforms).outerRoughness;
l9_725=l9_726;
float4 l9_727=float4(0.0);
float3 l9_728=l9_591.xyz;
float l9_729=(*sc_set2.UserUniforms).Port_Opacity_N057;
float3 l9_730=(*sc_set2.UserUniforms).Port_Emissive_N057;
float l9_731=l9_723;
float l9_732=l9_725;
float3 l9_733=(*sc_set2.UserUniforms).Port_AO_N057;
float3 l9_734=(*sc_set2.UserUniforms).Port_SpecularAO_N057;
ssGlobals l9_735=param_11;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_735.BumpedNormal=l9_735.VertexNormal_WorldSpace;
}
float l9_736=l9_729;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_736<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_737=gl_FragCoord;
float2 l9_738=floor(mod(l9_737.xy,float2(4.0)));
float l9_739=(mod(dot(l9_738,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_736<l9_739)
{
discard_fragment();
}
}
l9_728=fast::max(l9_728,float3(0.0));
float4 l9_740;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_740=float4(l9_728,l9_729);
}
else
{
l9_731=fast::clamp(l9_731,0.0,1.0);
l9_732=fast::clamp(l9_732,0.0,1.0);
float3 l9_741=l9_728;
float l9_742=l9_729;
float3 l9_743=l9_735.BumpedNormal;
float3 l9_744=l9_735.PositionWS;
float3 l9_745=l9_735.ViewDirWS;
float3 l9_746=l9_730;
float l9_747=l9_731;
float l9_748=l9_732;
float3 l9_749=l9_733;
float3 l9_750=l9_734;
l9_740=ngsCalculateLighting(l9_741,l9_742,l9_743,l9_744,l9_745,l9_746,l9_747,l9_748,l9_749,l9_750,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_740=fast::max(l9_740,float4(0.0));
l9_727=l9_740;
param_8=l9_727;
param_10=param_8;
}
else
{
float4 l9_751=float4(0.0);
float4 l9_752=float4(0.0);
float4 l9_753=float4(0.0);
float4 l9_754=float4(0.0);
float4 l9_755=(*sc_set2.UserUniforms).Port_Default_N046;
ssGlobals l9_756=param_11;
float4 l9_757;
if (DROPLIST_OUTER_EDGE_MODE_tmp==0)
{
float2 l9_758=float2(0.0);
l9_758=l9_756.Surface_UVCoord0;
float2 l9_759=float2(0.0);
float2 l9_760=(*sc_set2.UserUniforms).outerEdgeTexScale;
l9_759=l9_760;
float2 l9_761=float2(0.0);
float2 l9_762=(*sc_set2.UserUniforms).outerEdgeTexOffset;
l9_761=l9_762;
float2 l9_763=float2(0.0);
l9_763=(l9_758*l9_759)+l9_761;
float4 l9_764=float4(0.0);
int l9_765=0;
if ((int(outerEdgeTexHasSwappedViews_tmp)!=0))
{
int l9_766=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_766=0;
}
else
{
l9_766=in.varStereoViewID;
}
int l9_767=l9_766;
l9_765=1-l9_767;
}
else
{
int l9_768=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_768=0;
}
else
{
l9_768=in.varStereoViewID;
}
int l9_769=l9_768;
l9_765=l9_769;
}
int l9_770=l9_765;
int l9_771=outerEdgeTexLayout_tmp;
int l9_772=l9_770;
float2 l9_773=l9_763;
bool l9_774=(int(SC_USE_UV_TRANSFORM_outerEdgeTex_tmp)!=0);
float3x3 l9_775=(*sc_set2.UserUniforms).outerEdgeTexTransform;
int2 l9_776=int2(SC_SOFTWARE_WRAP_MODE_U_outerEdgeTex_tmp,SC_SOFTWARE_WRAP_MODE_V_outerEdgeTex_tmp);
bool l9_777=(int(SC_USE_UV_MIN_MAX_outerEdgeTex_tmp)!=0);
float4 l9_778=(*sc_set2.UserUniforms).outerEdgeTexUvMinMax;
bool l9_779=(int(SC_USE_CLAMP_TO_BORDER_outerEdgeTex_tmp)!=0);
float4 l9_780=(*sc_set2.UserUniforms).outerEdgeTexBorderColor;
float l9_781=0.0;
bool l9_782=l9_779&&(!l9_777);
float l9_783=1.0;
float l9_784=l9_773.x;
int l9_785=l9_776.x;
if (l9_785==1)
{
l9_784=fract(l9_784);
}
else
{
if (l9_785==2)
{
float l9_786=fract(l9_784);
float l9_787=l9_784-l9_786;
float l9_788=step(0.25,fract(l9_787*0.5));
l9_784=mix(l9_786,1.0-l9_786,fast::clamp(l9_788,0.0,1.0));
}
}
l9_773.x=l9_784;
float l9_789=l9_773.y;
int l9_790=l9_776.y;
if (l9_790==1)
{
l9_789=fract(l9_789);
}
else
{
if (l9_790==2)
{
float l9_791=fract(l9_789);
float l9_792=l9_789-l9_791;
float l9_793=step(0.25,fract(l9_792*0.5));
l9_789=mix(l9_791,1.0-l9_791,fast::clamp(l9_793,0.0,1.0));
}
}
l9_773.y=l9_789;
if (l9_777)
{
bool l9_794=l9_779;
bool l9_795;
if (l9_794)
{
l9_795=l9_776.x==3;
}
else
{
l9_795=l9_794;
}
float l9_796=l9_773.x;
float l9_797=l9_778.x;
float l9_798=l9_778.z;
bool l9_799=l9_795;
float l9_800=l9_783;
float l9_801=fast::clamp(l9_796,l9_797,l9_798);
float l9_802=step(abs(l9_796-l9_801),9.9999997e-06);
l9_800*=(l9_802+((1.0-float(l9_799))*(1.0-l9_802)));
l9_796=l9_801;
l9_773.x=l9_796;
l9_783=l9_800;
bool l9_803=l9_779;
bool l9_804;
if (l9_803)
{
l9_804=l9_776.y==3;
}
else
{
l9_804=l9_803;
}
float l9_805=l9_773.y;
float l9_806=l9_778.y;
float l9_807=l9_778.w;
bool l9_808=l9_804;
float l9_809=l9_783;
float l9_810=fast::clamp(l9_805,l9_806,l9_807);
float l9_811=step(abs(l9_805-l9_810),9.9999997e-06);
l9_809*=(l9_811+((1.0-float(l9_808))*(1.0-l9_811)));
l9_805=l9_810;
l9_773.y=l9_805;
l9_783=l9_809;
}
float2 l9_812=l9_773;
bool l9_813=l9_774;
float3x3 l9_814=l9_775;
if (l9_813)
{
l9_812=float2((l9_814*float3(l9_812,1.0)).xy);
}
float2 l9_815=l9_812;
float2 l9_816=l9_815;
float2 l9_817=l9_816;
l9_773=l9_817;
float l9_818=l9_773.x;
int l9_819=l9_776.x;
bool l9_820=l9_782;
float l9_821=l9_783;
if ((l9_819==0)||(l9_819==3))
{
float l9_822=l9_818;
float l9_823=0.0;
float l9_824=1.0;
bool l9_825=l9_820;
float l9_826=l9_821;
float l9_827=fast::clamp(l9_822,l9_823,l9_824);
float l9_828=step(abs(l9_822-l9_827),9.9999997e-06);
l9_826*=(l9_828+((1.0-float(l9_825))*(1.0-l9_828)));
l9_822=l9_827;
l9_818=l9_822;
l9_821=l9_826;
}
l9_773.x=l9_818;
l9_783=l9_821;
float l9_829=l9_773.y;
int l9_830=l9_776.y;
bool l9_831=l9_782;
float l9_832=l9_783;
if ((l9_830==0)||(l9_830==3))
{
float l9_833=l9_829;
float l9_834=0.0;
float l9_835=1.0;
bool l9_836=l9_831;
float l9_837=l9_832;
float l9_838=fast::clamp(l9_833,l9_834,l9_835);
float l9_839=step(abs(l9_833-l9_838),9.9999997e-06);
l9_837*=(l9_839+((1.0-float(l9_836))*(1.0-l9_839)));
l9_833=l9_838;
l9_829=l9_833;
l9_832=l9_837;
}
l9_773.y=l9_829;
l9_783=l9_832;
float2 l9_840=l9_773;
int l9_841=l9_771;
int l9_842=l9_772;
float l9_843=l9_781;
float2 l9_844=l9_840;
int l9_845=l9_841;
int l9_846=l9_842;
float3 l9_847=float3(0.0);
if (l9_845==0)
{
l9_847=float3(l9_844,0.0);
}
else
{
if (l9_845==1)
{
l9_847=float3(l9_844.x,(l9_844.y*0.5)+(0.5-(float(l9_846)*0.5)),0.0);
}
else
{
l9_847=float3(l9_844,float(l9_846));
}
}
float3 l9_848=l9_847;
float3 l9_849=l9_848;
float2 l9_850=l9_849.xy;
float l9_851=l9_843;
float4 l9_852=sc_set2.outerEdgeTex.sample(sc_set2.outerEdgeTexSmpSC,l9_850,bias(l9_851));
float4 l9_853=l9_852;
float4 l9_854=l9_853;
if (l9_779)
{
l9_854=mix(l9_780,l9_854,float4(l9_783));
}
float4 l9_855=l9_854;
l9_764=l9_855;
l9_752=l9_764;
l9_757=l9_752;
}
else
{
if (DROPLIST_OUTER_EDGE_MODE_tmp==1)
{
float4 l9_856=float4(0.0);
float4 l9_857=(*sc_set2.UserUniforms).outerEdgeStartingColor;
l9_856=l9_857;
float4 l9_858=float4(0.0);
l9_858=l9_856;
float4 l9_859=float4(0.0);
float4 l9_860=(*sc_set2.UserUniforms).outerEdgeEndingColor;
l9_859=l9_860;
float4 l9_861=float4(0.0);
l9_861=l9_859;
float2 l9_862=float2(0.0);
l9_862=l9_756.Surface_UVCoord0;
float2 l9_863=float2(0.0);
l9_863=(((l9_862-float2((*sc_set2.UserUniforms).Port_RangeMinA_N033))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N033-(*sc_set2.UserUniforms).Port_RangeMinA_N033))*((*sc_set2.UserUniforms).Port_RangeMaxB_N033-(*sc_set2.UserUniforms).Port_RangeMinB_N033))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N033);
float2 l9_864=float2(0.0);
l9_864=(*sc_set2.UserUniforms).Port_Import_N017;
float2 l9_865=float2(0.0);
l9_865=((l9_863-(*sc_set2.UserUniforms).Port_Center_N047)*l9_864)+(*sc_set2.UserUniforms).Port_Center_N047;
float2 l9_866=float2(0.0);
l9_866=(*sc_set2.UserUniforms).Port_Import_N058;
float2 l9_867=float2(0.0);
l9_867=l9_865-l9_866;
float l9_868=0.0;
float l9_869=(*sc_set2.UserUniforms).outerEdgeGradientRamp;
l9_868=l9_869;
float l9_870=0.0;
l9_870=(((l9_868-(*sc_set2.UserUniforms).Port_RangeMinA_N153)/((*sc_set2.UserUniforms).Port_RangeMaxA_N153-(*sc_set2.UserUniforms).Port_RangeMinA_N153))*((*sc_set2.UserUniforms).Port_RangeMaxB_N153-(*sc_set2.UserUniforms).Port_RangeMinB_N153))+(*sc_set2.UserUniforms).Port_RangeMinB_N153;
float2 l9_871=float2(0.0);
l9_871=float2(0.0,float2(l9_870).y);
float2 l9_872=float2(0.0);
l9_872=l9_871;
float2 l9_873=float2(0.0);
l9_873=l9_872-l9_866;
float l9_874=0.0;
l9_874=dot(l9_867,l9_873);
float l9_875=0.0;
l9_875=dot(l9_873,l9_873);
float l9_876=0.0;
l9_876=l9_874/(l9_875+1.234e-06);
float l9_877=0.0;
l9_877=fast::clamp(l9_876+0.001,(*sc_set2.UserUniforms).Port_Input1_N065+0.001,(*sc_set2.UserUniforms).Port_Input2_N065+0.001)-0.001;
float l9_878=0.0;
l9_878=smoothstep((*sc_set2.UserUniforms).Port_Input0_N066,(*sc_set2.UserUniforms).Port_Input1_N066,l9_877);
float4 l9_879=float4(0.0);
l9_879=mix(l9_858,l9_861,float4(l9_878));
float4 l9_880=float4(0.0);
l9_880=l9_879;
l9_753=l9_880;
l9_757=l9_753;
}
else
{
if (DROPLIST_OUTER_EDGE_MODE_tmp==2)
{
float4 l9_881=float4(0.0);
float4 l9_882=(*sc_set2.UserUniforms).outerEdgeStartingColor;
l9_881=l9_882;
l9_754=l9_881;
l9_757=l9_754;
}
else
{
l9_757=l9_755;
}
}
}
l9_751=l9_757;
param_9=l9_751;
param_10=param_9;
}
Output_N75=param_10;
float4 Output_N81=float4(0.0);
float4 param_12=float4(1.0);
float4 param_13=float4(1.0,0.0,0.0,0.0);
ssGlobals param_15=Globals;
float4 param_14;
if ((int(innerEdgePBR_tmp)!=0))
{
float4 l9_883=float4(0.0);
float4 l9_884=float4(0.0);
float4 l9_885=float4(0.0);
float4 l9_886=float4(0.0);
float4 l9_887=(*sc_set2.UserUniforms).Port_Default_N077;
ssGlobals l9_888=param_15;
float4 l9_889;
if (DROPLIST_INNER_EDGE_MODE_tmp==0)
{
float2 l9_890=float2(0.0);
l9_890=l9_888.Surface_UVCoord0;
float2 l9_891=float2(0.0);
float2 l9_892=(*sc_set2.UserUniforms).InnerEdgeTexScale;
l9_891=l9_892;
float2 l9_893=float2(0.0);
float2 l9_894=(*sc_set2.UserUniforms).InnerEdgeTexOffset;
l9_893=l9_894;
float2 l9_895=float2(0.0);
l9_895=(l9_890*l9_891)+l9_893;
float4 l9_896=float4(0.0);
int l9_897=0;
if ((int(InnerEdgeTexHasSwappedViews_tmp)!=0))
{
int l9_898=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_898=0;
}
else
{
l9_898=in.varStereoViewID;
}
int l9_899=l9_898;
l9_897=1-l9_899;
}
else
{
int l9_900=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_900=0;
}
else
{
l9_900=in.varStereoViewID;
}
int l9_901=l9_900;
l9_897=l9_901;
}
int l9_902=l9_897;
int l9_903=InnerEdgeTexLayout_tmp;
int l9_904=l9_902;
float2 l9_905=l9_895;
bool l9_906=(int(SC_USE_UV_TRANSFORM_InnerEdgeTex_tmp)!=0);
float3x3 l9_907=(*sc_set2.UserUniforms).InnerEdgeTexTransform;
int2 l9_908=int2(SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex_tmp,SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex_tmp);
bool l9_909=(int(SC_USE_UV_MIN_MAX_InnerEdgeTex_tmp)!=0);
float4 l9_910=(*sc_set2.UserUniforms).InnerEdgeTexUvMinMax;
bool l9_911=(int(SC_USE_CLAMP_TO_BORDER_InnerEdgeTex_tmp)!=0);
float4 l9_912=(*sc_set2.UserUniforms).InnerEdgeTexBorderColor;
float l9_913=0.0;
bool l9_914=l9_911&&(!l9_909);
float l9_915=1.0;
float l9_916=l9_905.x;
int l9_917=l9_908.x;
if (l9_917==1)
{
l9_916=fract(l9_916);
}
else
{
if (l9_917==2)
{
float l9_918=fract(l9_916);
float l9_919=l9_916-l9_918;
float l9_920=step(0.25,fract(l9_919*0.5));
l9_916=mix(l9_918,1.0-l9_918,fast::clamp(l9_920,0.0,1.0));
}
}
l9_905.x=l9_916;
float l9_921=l9_905.y;
int l9_922=l9_908.y;
if (l9_922==1)
{
l9_921=fract(l9_921);
}
else
{
if (l9_922==2)
{
float l9_923=fract(l9_921);
float l9_924=l9_921-l9_923;
float l9_925=step(0.25,fract(l9_924*0.5));
l9_921=mix(l9_923,1.0-l9_923,fast::clamp(l9_925,0.0,1.0));
}
}
l9_905.y=l9_921;
if (l9_909)
{
bool l9_926=l9_911;
bool l9_927;
if (l9_926)
{
l9_927=l9_908.x==3;
}
else
{
l9_927=l9_926;
}
float l9_928=l9_905.x;
float l9_929=l9_910.x;
float l9_930=l9_910.z;
bool l9_931=l9_927;
float l9_932=l9_915;
float l9_933=fast::clamp(l9_928,l9_929,l9_930);
float l9_934=step(abs(l9_928-l9_933),9.9999997e-06);
l9_932*=(l9_934+((1.0-float(l9_931))*(1.0-l9_934)));
l9_928=l9_933;
l9_905.x=l9_928;
l9_915=l9_932;
bool l9_935=l9_911;
bool l9_936;
if (l9_935)
{
l9_936=l9_908.y==3;
}
else
{
l9_936=l9_935;
}
float l9_937=l9_905.y;
float l9_938=l9_910.y;
float l9_939=l9_910.w;
bool l9_940=l9_936;
float l9_941=l9_915;
float l9_942=fast::clamp(l9_937,l9_938,l9_939);
float l9_943=step(abs(l9_937-l9_942),9.9999997e-06);
l9_941*=(l9_943+((1.0-float(l9_940))*(1.0-l9_943)));
l9_937=l9_942;
l9_905.y=l9_937;
l9_915=l9_941;
}
float2 l9_944=l9_905;
bool l9_945=l9_906;
float3x3 l9_946=l9_907;
if (l9_945)
{
l9_944=float2((l9_946*float3(l9_944,1.0)).xy);
}
float2 l9_947=l9_944;
float2 l9_948=l9_947;
float2 l9_949=l9_948;
l9_905=l9_949;
float l9_950=l9_905.x;
int l9_951=l9_908.x;
bool l9_952=l9_914;
float l9_953=l9_915;
if ((l9_951==0)||(l9_951==3))
{
float l9_954=l9_950;
float l9_955=0.0;
float l9_956=1.0;
bool l9_957=l9_952;
float l9_958=l9_953;
float l9_959=fast::clamp(l9_954,l9_955,l9_956);
float l9_960=step(abs(l9_954-l9_959),9.9999997e-06);
l9_958*=(l9_960+((1.0-float(l9_957))*(1.0-l9_960)));
l9_954=l9_959;
l9_950=l9_954;
l9_953=l9_958;
}
l9_905.x=l9_950;
l9_915=l9_953;
float l9_961=l9_905.y;
int l9_962=l9_908.y;
bool l9_963=l9_914;
float l9_964=l9_915;
if ((l9_962==0)||(l9_962==3))
{
float l9_965=l9_961;
float l9_966=0.0;
float l9_967=1.0;
bool l9_968=l9_963;
float l9_969=l9_964;
float l9_970=fast::clamp(l9_965,l9_966,l9_967);
float l9_971=step(abs(l9_965-l9_970),9.9999997e-06);
l9_969*=(l9_971+((1.0-float(l9_968))*(1.0-l9_971)));
l9_965=l9_970;
l9_961=l9_965;
l9_964=l9_969;
}
l9_905.y=l9_961;
l9_915=l9_964;
float2 l9_972=l9_905;
int l9_973=l9_903;
int l9_974=l9_904;
float l9_975=l9_913;
float2 l9_976=l9_972;
int l9_977=l9_973;
int l9_978=l9_974;
float3 l9_979=float3(0.0);
if (l9_977==0)
{
l9_979=float3(l9_976,0.0);
}
else
{
if (l9_977==1)
{
l9_979=float3(l9_976.x,(l9_976.y*0.5)+(0.5-(float(l9_978)*0.5)),0.0);
}
else
{
l9_979=float3(l9_976,float(l9_978));
}
}
float3 l9_980=l9_979;
float3 l9_981=l9_980;
float2 l9_982=l9_981.xy;
float l9_983=l9_975;
float4 l9_984=sc_set2.InnerEdgeTex.sample(sc_set2.InnerEdgeTexSmpSC,l9_982,bias(l9_983));
float4 l9_985=l9_984;
float4 l9_986=l9_985;
if (l9_911)
{
l9_986=mix(l9_912,l9_986,float4(l9_915));
}
float4 l9_987=l9_986;
l9_896=l9_987;
l9_884=l9_896;
l9_889=l9_884;
}
else
{
if (DROPLIST_INNER_EDGE_MODE_tmp==1)
{
float4 l9_988=float4(0.0);
float4 l9_989=(*sc_set2.UserUniforms).InnerEdgeStartingColor;
l9_988=l9_989;
float4 l9_990=float4(0.0);
l9_990=l9_988;
float4 l9_991=float4(0.0);
float4 l9_992=(*sc_set2.UserUniforms).InnerEdgeEndingColor;
l9_991=l9_992;
float4 l9_993=float4(0.0);
l9_993=l9_991;
float2 l9_994=float2(0.0);
l9_994=l9_888.Surface_UVCoord0;
float2 l9_995=float2(0.0);
l9_995=(((l9_994-float2((*sc_set2.UserUniforms).Port_RangeMinA_N023))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N023-(*sc_set2.UserUniforms).Port_RangeMinA_N023))*((*sc_set2.UserUniforms).Port_RangeMaxB_N023-(*sc_set2.UserUniforms).Port_RangeMinB_N023))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N023);
float2 l9_996=float2(0.0);
l9_996=(*sc_set2.UserUniforms).Port_Import_N024;
float2 l9_997=float2(0.0);
l9_997=((l9_995-(*sc_set2.UserUniforms).Port_Center_N025)*l9_996)+(*sc_set2.UserUniforms).Port_Center_N025;
float2 l9_998=float2(0.0);
l9_998=(*sc_set2.UserUniforms).Port_Import_N026;
float2 l9_999=float2(0.0);
l9_999=l9_997-l9_998;
float l9_1000=0.0;
float l9_1001=(*sc_set2.UserUniforms).InnerEdgeGradientRamp;
l9_1000=l9_1001;
float l9_1002=0.0;
l9_1002=(((l9_1000-(*sc_set2.UserUniforms).Port_RangeMinA_N155)/((*sc_set2.UserUniforms).Port_RangeMaxA_N155-(*sc_set2.UserUniforms).Port_RangeMinA_N155))*((*sc_set2.UserUniforms).Port_RangeMaxB_N155-(*sc_set2.UserUniforms).Port_RangeMinB_N155))+(*sc_set2.UserUniforms).Port_RangeMinB_N155;
float2 l9_1003=float2(0.0);
l9_1003=float2(0.0,float2(l9_1002).y);
float2 l9_1004=float2(0.0);
l9_1004=l9_1003;
float2 l9_1005=float2(0.0);
l9_1005=l9_1004-l9_998;
float l9_1006=0.0;
l9_1006=dot(l9_999,l9_1005);
float l9_1007=0.0;
l9_1007=dot(l9_1005,l9_1005);
float l9_1008=0.0;
l9_1008=l9_1006/(l9_1007+1.234e-06);
float l9_1009=0.0;
l9_1009=fast::clamp(l9_1008+0.001,(*sc_set2.UserUniforms).Port_Input1_N034+0.001,(*sc_set2.UserUniforms).Port_Input2_N034+0.001)-0.001;
float l9_1010=0.0;
l9_1010=smoothstep((*sc_set2.UserUniforms).Port_Input0_N035,(*sc_set2.UserUniforms).Port_Input1_N035,l9_1009);
float4 l9_1011=float4(0.0);
l9_1011=mix(l9_990,l9_993,float4(l9_1010));
float4 l9_1012=float4(0.0);
l9_1012=l9_1011;
l9_885=l9_1012;
l9_889=l9_885;
}
else
{
if (DROPLIST_INNER_EDGE_MODE_tmp==2)
{
float4 l9_1013=float4(0.0);
float4 l9_1014=(*sc_set2.UserUniforms).InnerEdgeStartingColor;
l9_1013=l9_1014;
l9_886=l9_1013;
l9_889=l9_886;
}
else
{
l9_889=l9_887;
}
}
}
l9_883=l9_889;
float l9_1015=0.0;
float l9_1016=(*sc_set2.UserUniforms).InnerEdgeMetallic;
l9_1015=l9_1016;
float l9_1017=0.0;
float l9_1018=(*sc_set2.UserUniforms).InnerEdgeRoughness;
l9_1017=l9_1018;
float4 l9_1019=float4(0.0);
float3 l9_1020=l9_883.xyz;
float l9_1021=(*sc_set2.UserUniforms).Port_Opacity_N080;
float3 l9_1022=(*sc_set2.UserUniforms).Port_Emissive_N080;
float l9_1023=l9_1015;
float l9_1024=l9_1017;
float3 l9_1025=(*sc_set2.UserUniforms).Port_AO_N080;
float3 l9_1026=(*sc_set2.UserUniforms).Port_SpecularAO_N080;
ssGlobals l9_1027=param_15;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1027.BumpedNormal=l9_1027.VertexNormal_WorldSpace;
}
float l9_1028=l9_1021;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_1028<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_1029=gl_FragCoord;
float2 l9_1030=floor(mod(l9_1029.xy,float2(4.0)));
float l9_1031=(mod(dot(l9_1030,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_1028<l9_1031)
{
discard_fragment();
}
}
l9_1020=fast::max(l9_1020,float3(0.0));
float4 l9_1032;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_1032=float4(l9_1020,l9_1021);
}
else
{
l9_1023=fast::clamp(l9_1023,0.0,1.0);
l9_1024=fast::clamp(l9_1024,0.0,1.0);
float3 l9_1033=l9_1020;
float l9_1034=l9_1021;
float3 l9_1035=l9_1027.BumpedNormal;
float3 l9_1036=l9_1027.PositionWS;
float3 l9_1037=l9_1027.ViewDirWS;
float3 l9_1038=l9_1022;
float l9_1039=l9_1023;
float l9_1040=l9_1024;
float3 l9_1041=l9_1025;
float3 l9_1042=l9_1026;
l9_1032=ngsCalculateLighting(l9_1033,l9_1034,l9_1035,l9_1036,l9_1037,l9_1038,l9_1039,l9_1040,l9_1041,l9_1042,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.sc_EnvmapDiffuse,sc_set2.sc_EnvmapDiffuseSmpSC,sc_set2.sc_EnvmapSpecular,sc_set2.sc_EnvmapSpecularSmpSC,sc_set2.sc_ScreenTexture,sc_set2.sc_ScreenTextureSmpSC,sc_set2.sc_ShadowTexture,sc_set2.sc_ShadowTextureSmpSC,sc_set2.sc_SSAOTexture,sc_set2.sc_SSAOTextureSmpSC,sc_set2.sc_RayTracedReflectionTexture,sc_set2.sc_RayTracedReflectionTextureSmpSC,sc_set2.sc_RayTracedShadowTexture,sc_set2.sc_RayTracedShadowTextureSmpSC,sc_set2.sc_RayTracedDiffIndTexture,sc_set2.sc_RayTracedDiffIndTextureSmpSC,sc_set2.sc_RayTracedAoTexture,sc_set2.sc_RayTracedAoTextureSmpSC,gl_FragCoord,in.varShadowTex,out.FragColor0);
}
l9_1032=fast::max(l9_1032,float4(0.0));
l9_1019=l9_1032;
param_12=l9_1019;
param_14=param_12;
}
else
{
float4 l9_1043=float4(0.0);
float4 l9_1044=float4(0.0);
float4 l9_1045=float4(0.0);
float4 l9_1046=float4(0.0);
float4 l9_1047=(*sc_set2.UserUniforms).Port_Default_N077;
ssGlobals l9_1048=param_15;
float4 l9_1049;
if (DROPLIST_INNER_EDGE_MODE_tmp==0)
{
float2 l9_1050=float2(0.0);
l9_1050=l9_1048.Surface_UVCoord0;
float2 l9_1051=float2(0.0);
float2 l9_1052=(*sc_set2.UserUniforms).InnerEdgeTexScale;
l9_1051=l9_1052;
float2 l9_1053=float2(0.0);
float2 l9_1054=(*sc_set2.UserUniforms).InnerEdgeTexOffset;
l9_1053=l9_1054;
float2 l9_1055=float2(0.0);
l9_1055=(l9_1050*l9_1051)+l9_1053;
float4 l9_1056=float4(0.0);
int l9_1057=0;
if ((int(InnerEdgeTexHasSwappedViews_tmp)!=0))
{
int l9_1058=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1058=0;
}
else
{
l9_1058=in.varStereoViewID;
}
int l9_1059=l9_1058;
l9_1057=1-l9_1059;
}
else
{
int l9_1060=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1060=0;
}
else
{
l9_1060=in.varStereoViewID;
}
int l9_1061=l9_1060;
l9_1057=l9_1061;
}
int l9_1062=l9_1057;
int l9_1063=InnerEdgeTexLayout_tmp;
int l9_1064=l9_1062;
float2 l9_1065=l9_1055;
bool l9_1066=(int(SC_USE_UV_TRANSFORM_InnerEdgeTex_tmp)!=0);
float3x3 l9_1067=(*sc_set2.UserUniforms).InnerEdgeTexTransform;
int2 l9_1068=int2(SC_SOFTWARE_WRAP_MODE_U_InnerEdgeTex_tmp,SC_SOFTWARE_WRAP_MODE_V_InnerEdgeTex_tmp);
bool l9_1069=(int(SC_USE_UV_MIN_MAX_InnerEdgeTex_tmp)!=0);
float4 l9_1070=(*sc_set2.UserUniforms).InnerEdgeTexUvMinMax;
bool l9_1071=(int(SC_USE_CLAMP_TO_BORDER_InnerEdgeTex_tmp)!=0);
float4 l9_1072=(*sc_set2.UserUniforms).InnerEdgeTexBorderColor;
float l9_1073=0.0;
bool l9_1074=l9_1071&&(!l9_1069);
float l9_1075=1.0;
float l9_1076=l9_1065.x;
int l9_1077=l9_1068.x;
if (l9_1077==1)
{
l9_1076=fract(l9_1076);
}
else
{
if (l9_1077==2)
{
float l9_1078=fract(l9_1076);
float l9_1079=l9_1076-l9_1078;
float l9_1080=step(0.25,fract(l9_1079*0.5));
l9_1076=mix(l9_1078,1.0-l9_1078,fast::clamp(l9_1080,0.0,1.0));
}
}
l9_1065.x=l9_1076;
float l9_1081=l9_1065.y;
int l9_1082=l9_1068.y;
if (l9_1082==1)
{
l9_1081=fract(l9_1081);
}
else
{
if (l9_1082==2)
{
float l9_1083=fract(l9_1081);
float l9_1084=l9_1081-l9_1083;
float l9_1085=step(0.25,fract(l9_1084*0.5));
l9_1081=mix(l9_1083,1.0-l9_1083,fast::clamp(l9_1085,0.0,1.0));
}
}
l9_1065.y=l9_1081;
if (l9_1069)
{
bool l9_1086=l9_1071;
bool l9_1087;
if (l9_1086)
{
l9_1087=l9_1068.x==3;
}
else
{
l9_1087=l9_1086;
}
float l9_1088=l9_1065.x;
float l9_1089=l9_1070.x;
float l9_1090=l9_1070.z;
bool l9_1091=l9_1087;
float l9_1092=l9_1075;
float l9_1093=fast::clamp(l9_1088,l9_1089,l9_1090);
float l9_1094=step(abs(l9_1088-l9_1093),9.9999997e-06);
l9_1092*=(l9_1094+((1.0-float(l9_1091))*(1.0-l9_1094)));
l9_1088=l9_1093;
l9_1065.x=l9_1088;
l9_1075=l9_1092;
bool l9_1095=l9_1071;
bool l9_1096;
if (l9_1095)
{
l9_1096=l9_1068.y==3;
}
else
{
l9_1096=l9_1095;
}
float l9_1097=l9_1065.y;
float l9_1098=l9_1070.y;
float l9_1099=l9_1070.w;
bool l9_1100=l9_1096;
float l9_1101=l9_1075;
float l9_1102=fast::clamp(l9_1097,l9_1098,l9_1099);
float l9_1103=step(abs(l9_1097-l9_1102),9.9999997e-06);
l9_1101*=(l9_1103+((1.0-float(l9_1100))*(1.0-l9_1103)));
l9_1097=l9_1102;
l9_1065.y=l9_1097;
l9_1075=l9_1101;
}
float2 l9_1104=l9_1065;
bool l9_1105=l9_1066;
float3x3 l9_1106=l9_1067;
if (l9_1105)
{
l9_1104=float2((l9_1106*float3(l9_1104,1.0)).xy);
}
float2 l9_1107=l9_1104;
float2 l9_1108=l9_1107;
float2 l9_1109=l9_1108;
l9_1065=l9_1109;
float l9_1110=l9_1065.x;
int l9_1111=l9_1068.x;
bool l9_1112=l9_1074;
float l9_1113=l9_1075;
if ((l9_1111==0)||(l9_1111==3))
{
float l9_1114=l9_1110;
float l9_1115=0.0;
float l9_1116=1.0;
bool l9_1117=l9_1112;
float l9_1118=l9_1113;
float l9_1119=fast::clamp(l9_1114,l9_1115,l9_1116);
float l9_1120=step(abs(l9_1114-l9_1119),9.9999997e-06);
l9_1118*=(l9_1120+((1.0-float(l9_1117))*(1.0-l9_1120)));
l9_1114=l9_1119;
l9_1110=l9_1114;
l9_1113=l9_1118;
}
l9_1065.x=l9_1110;
l9_1075=l9_1113;
float l9_1121=l9_1065.y;
int l9_1122=l9_1068.y;
bool l9_1123=l9_1074;
float l9_1124=l9_1075;
if ((l9_1122==0)||(l9_1122==3))
{
float l9_1125=l9_1121;
float l9_1126=0.0;
float l9_1127=1.0;
bool l9_1128=l9_1123;
float l9_1129=l9_1124;
float l9_1130=fast::clamp(l9_1125,l9_1126,l9_1127);
float l9_1131=step(abs(l9_1125-l9_1130),9.9999997e-06);
l9_1129*=(l9_1131+((1.0-float(l9_1128))*(1.0-l9_1131)));
l9_1125=l9_1130;
l9_1121=l9_1125;
l9_1124=l9_1129;
}
l9_1065.y=l9_1121;
l9_1075=l9_1124;
float2 l9_1132=l9_1065;
int l9_1133=l9_1063;
int l9_1134=l9_1064;
float l9_1135=l9_1073;
float2 l9_1136=l9_1132;
int l9_1137=l9_1133;
int l9_1138=l9_1134;
float3 l9_1139=float3(0.0);
if (l9_1137==0)
{
l9_1139=float3(l9_1136,0.0);
}
else
{
if (l9_1137==1)
{
l9_1139=float3(l9_1136.x,(l9_1136.y*0.5)+(0.5-(float(l9_1138)*0.5)),0.0);
}
else
{
l9_1139=float3(l9_1136,float(l9_1138));
}
}
float3 l9_1140=l9_1139;
float3 l9_1141=l9_1140;
float2 l9_1142=l9_1141.xy;
float l9_1143=l9_1135;
float4 l9_1144=sc_set2.InnerEdgeTex.sample(sc_set2.InnerEdgeTexSmpSC,l9_1142,bias(l9_1143));
float4 l9_1145=l9_1144;
float4 l9_1146=l9_1145;
if (l9_1071)
{
l9_1146=mix(l9_1072,l9_1146,float4(l9_1075));
}
float4 l9_1147=l9_1146;
l9_1056=l9_1147;
l9_1044=l9_1056;
l9_1049=l9_1044;
}
else
{
if (DROPLIST_INNER_EDGE_MODE_tmp==1)
{
float4 l9_1148=float4(0.0);
float4 l9_1149=(*sc_set2.UserUniforms).InnerEdgeStartingColor;
l9_1148=l9_1149;
float4 l9_1150=float4(0.0);
l9_1150=l9_1148;
float4 l9_1151=float4(0.0);
float4 l9_1152=(*sc_set2.UserUniforms).InnerEdgeEndingColor;
l9_1151=l9_1152;
float4 l9_1153=float4(0.0);
l9_1153=l9_1151;
float2 l9_1154=float2(0.0);
l9_1154=l9_1048.Surface_UVCoord0;
float2 l9_1155=float2(0.0);
l9_1155=(((l9_1154-float2((*sc_set2.UserUniforms).Port_RangeMinA_N023))/float2((*sc_set2.UserUniforms).Port_RangeMaxA_N023-(*sc_set2.UserUniforms).Port_RangeMinA_N023))*((*sc_set2.UserUniforms).Port_RangeMaxB_N023-(*sc_set2.UserUniforms).Port_RangeMinB_N023))+float2((*sc_set2.UserUniforms).Port_RangeMinB_N023);
float2 l9_1156=float2(0.0);
l9_1156=(*sc_set2.UserUniforms).Port_Import_N024;
float2 l9_1157=float2(0.0);
l9_1157=((l9_1155-(*sc_set2.UserUniforms).Port_Center_N025)*l9_1156)+(*sc_set2.UserUniforms).Port_Center_N025;
float2 l9_1158=float2(0.0);
l9_1158=(*sc_set2.UserUniforms).Port_Import_N026;
float2 l9_1159=float2(0.0);
l9_1159=l9_1157-l9_1158;
float l9_1160=0.0;
float l9_1161=(*sc_set2.UserUniforms).InnerEdgeGradientRamp;
l9_1160=l9_1161;
float l9_1162=0.0;
l9_1162=(((l9_1160-(*sc_set2.UserUniforms).Port_RangeMinA_N155)/((*sc_set2.UserUniforms).Port_RangeMaxA_N155-(*sc_set2.UserUniforms).Port_RangeMinA_N155))*((*sc_set2.UserUniforms).Port_RangeMaxB_N155-(*sc_set2.UserUniforms).Port_RangeMinB_N155))+(*sc_set2.UserUniforms).Port_RangeMinB_N155;
float2 l9_1163=float2(0.0);
l9_1163=float2(0.0,float2(l9_1162).y);
float2 l9_1164=float2(0.0);
l9_1164=l9_1163;
float2 l9_1165=float2(0.0);
l9_1165=l9_1164-l9_1158;
float l9_1166=0.0;
l9_1166=dot(l9_1159,l9_1165);
float l9_1167=0.0;
l9_1167=dot(l9_1165,l9_1165);
float l9_1168=0.0;
l9_1168=l9_1166/(l9_1167+1.234e-06);
float l9_1169=0.0;
l9_1169=fast::clamp(l9_1168+0.001,(*sc_set2.UserUniforms).Port_Input1_N034+0.001,(*sc_set2.UserUniforms).Port_Input2_N034+0.001)-0.001;
float l9_1170=0.0;
l9_1170=smoothstep((*sc_set2.UserUniforms).Port_Input0_N035,(*sc_set2.UserUniforms).Port_Input1_N035,l9_1169);
float4 l9_1171=float4(0.0);
l9_1171=mix(l9_1150,l9_1153,float4(l9_1170));
float4 l9_1172=float4(0.0);
l9_1172=l9_1171;
l9_1045=l9_1172;
l9_1049=l9_1045;
}
else
{
if (DROPLIST_INNER_EDGE_MODE_tmp==2)
{
float4 l9_1173=float4(0.0);
float4 l9_1174=(*sc_set2.UserUniforms).InnerEdgeStartingColor;
l9_1173=l9_1174;
l9_1046=l9_1173;
l9_1049=l9_1046;
}
else
{
l9_1049=l9_1047;
}
}
}
l9_1043=l9_1049;
param_13=l9_1043;
param_14=param_13;
}
Output_N81=param_14;
float Output_N42=0.0;
Output_N42=UVCoord_N52.y;
float Output_N43=0.0;
Output_N43=step(Output_N42,(*sc_set2.UserUniforms).Port_Input1_N043);
float4 Output_N0=float4(0.0);
Output_N0=mix(Output_N75,Output_N81,float4(Output_N43));
float Output_N12=0.0;
Output_N12=UVCoord_N52.y;
float Output_N14=0.0;
Output_N14=step(Output_N12,(*sc_set2.UserUniforms).Port_Input1_N014);
float4 Output_N13=float4(0.0);
Output_N13=mix(Output_N51,Output_N0,float4(Output_N14));
FinalColor=Output_N13;
bool l9_1175=(*sc_set2.UserUniforms).isProxyMode!=0;
if (l9_1175)
{
float4 param_16=FinalColor;
if ((int(sc_ProxyAlphaOne_tmp)!=0))
{
param_16.w=1.0;
}
float4 l9_1176=fast::max(param_16,float4(0.0));
float4 param_17=l9_1176;
out.FragColor0=param_17;
return out;
}
float4 param_18=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_1177=param_18;
float4 l9_1178=l9_1177;
float l9_1179=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_1179=l9_1178.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_1179=fast::clamp(l9_1178.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1179=fast::clamp(dot(l9_1178.xyz,float3(l9_1178.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_1179=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_1179=(1.0-dot(l9_1178.xyz,float3(0.33333001)))*l9_1178.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_1179=(1.0-fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0))*l9_1178.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_1179=fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0)*l9_1178.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_1179=fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_1179=fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0)*l9_1178.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_1179=dot(l9_1178.xyz,float3(0.33333001))*l9_1178.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_1179=1.0-fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_1179=fast::clamp(dot(l9_1178.xyz,float3(1.0)),0.0,1.0);
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
float l9_1180=l9_1179;
float l9_1181=l9_1180;
float l9_1182=(*sc_set2.UserUniforms).sc_ShadowDensity*l9_1181;
float3 l9_1183=mix((*sc_set2.UserUniforms).sc_ShadowColor.xyz,(*sc_set2.UserUniforms).sc_ShadowColor.xyz*l9_1177.xyz,float3((*sc_set2.UserUniforms).sc_ShadowColor.w));
float4 l9_1184=float4(l9_1183.x,l9_1183.y,l9_1183.z,l9_1182);
param_18=l9_1184;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_18=float4(param_18.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_1185=param_18;
float4 l9_1186=float4(0.0);
float4 l9_1187=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_1188=out.FragColor0;
float4 l9_1189=l9_1188;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_1189.x+=(*sc_set2.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_1190=l9_1189;
l9_1187=l9_1190;
}
else
{
float4 l9_1191=gl_FragCoord;
float2 l9_1192=(l9_1191.xy*(*sc_set2.UserUniforms).sc_WindowToViewportTransform.xy)+(*sc_set2.UserUniforms).sc_WindowToViewportTransform.zw;
float2 l9_1193=l9_1192;
float2 l9_1194=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_1195=1;
int l9_1196=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1196=0;
}
else
{
l9_1196=in.varStereoViewID;
}
int l9_1197=l9_1196;
int l9_1198=l9_1197;
float3 l9_1199=float3(l9_1193,0.0);
int l9_1200=l9_1195;
int l9_1201=l9_1198;
if (l9_1200==1)
{
l9_1199.y=((2.0*l9_1199.y)+float(l9_1201))-1.0;
}
float2 l9_1202=l9_1199.xy;
l9_1194=l9_1202;
}
else
{
l9_1194=l9_1193;
}
float2 l9_1203=l9_1194;
float2 l9_1204=l9_1203;
float2 l9_1205=l9_1204;
int l9_1206=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_1207=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1207=0;
}
else
{
l9_1207=in.varStereoViewID;
}
int l9_1208=l9_1207;
l9_1206=1-l9_1208;
}
else
{
int l9_1209=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1209=0;
}
else
{
l9_1209=in.varStereoViewID;
}
int l9_1210=l9_1209;
l9_1206=l9_1210;
}
int l9_1211=l9_1206;
float2 l9_1212=l9_1205;
int l9_1213=l9_1211;
float2 l9_1214=l9_1212;
int l9_1215=l9_1213;
float l9_1216=0.0;
float4 l9_1217=float4(0.0);
float2 l9_1218=l9_1214;
int l9_1219=sc_ScreenTextureLayout_tmp;
int l9_1220=l9_1215;
float l9_1221=l9_1216;
float2 l9_1222=l9_1218;
int l9_1223=l9_1219;
int l9_1224=l9_1220;
float3 l9_1225=float3(0.0);
if (l9_1223==0)
{
l9_1225=float3(l9_1222,0.0);
}
else
{
if (l9_1223==1)
{
l9_1225=float3(l9_1222.x,(l9_1222.y*0.5)+(0.5-(float(l9_1224)*0.5)),0.0);
}
else
{
l9_1225=float3(l9_1222,float(l9_1224));
}
}
float3 l9_1226=l9_1225;
float3 l9_1227=l9_1226;
float2 l9_1228=l9_1227.xy;
float l9_1229=l9_1221;
float4 l9_1230=sc_set2.sc_ScreenTexture.sample(sc_set2.sc_ScreenTextureSmpSC,l9_1228,bias(l9_1229));
float4 l9_1231=l9_1230;
l9_1217=l9_1231;
float4 l9_1232=l9_1217;
float4 l9_1233=l9_1232;
float4 l9_1234=l9_1233;
l9_1187=l9_1234;
}
float4 l9_1235=l9_1187;
float4 l9_1236=l9_1235;
float3 l9_1237=l9_1236.xyz;
float3 l9_1238=l9_1237;
float3 l9_1239=l9_1185.xyz;
float3 l9_1240=definedBlend(l9_1238,l9_1239,in.varStereoViewID,(*sc_set2.UserUniforms),sc_set2.intensityTexture,sc_set2.intensityTextureSmpSC);
l9_1186=float4(l9_1240.x,l9_1240.y,l9_1240.z,l9_1186.w);
float3 l9_1241=mix(l9_1237,l9_1186.xyz,float3(l9_1185.w));
l9_1186=float4(l9_1241.x,l9_1241.y,l9_1241.z,l9_1186.w);
l9_1186.w=1.0;
float4 l9_1242=l9_1186;
param_18=l9_1242;
}
else
{
float4 l9_1243=param_18;
float4 l9_1244=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_1244=float4(mix(float3(1.0),l9_1243.xyz,float3(l9_1243.w)),l9_1243.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_1245=l9_1243.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_1245=fast::clamp(l9_1245,0.0,1.0);
}
l9_1244=float4(l9_1243.xyz*l9_1245,l9_1245);
}
else
{
l9_1244=l9_1243;
}
}
float4 l9_1246=l9_1244;
param_18=l9_1246;
}
}
}
float4 l9_1247=param_18;
FinalColor=l9_1247;
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
float4 l9_1248=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_1248=float4((*sc_set2.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_1248=float4(0.0);
}
float4 l9_1249=l9_1248;
float4 Cost=l9_1249;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_19=in.varPos;
float4 param_20=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_19,param_20,in.varStereoViewID,(*sc_set2.UserUniforms));
float4 param_21=FinalColor;
float4 l9_1250=param_21;
out.FragColor0=l9_1250;
return out;
}
} // FRAGMENT SHADER

namespace SNAP_RECV {
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 BumpedNormal;
float3 ViewDirWS;
float3 PositionWS;
float3 VertexNormal_WorldSpace;
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
int receivesRayTracedReflections;
int isProxyMode;
int receivesRayTracedShadows;
int receivesRayTracedDiffuseIndirect;
int receivesRayTracedAo;
float4 sc_RayTracedReflectionTextureSize;
float4 sc_RayTracedReflectionTextureDims;
float4 sc_RayTracedReflectionTextureView;
float4 sc_RayTracedShadowTextureSize;
float4 sc_RayTracedShadowTextureDims;
float4 sc_RayTracedShadowTextureView;
float4 sc_RayTracedDiffIndTextureSize;
float4 sc_RayTracedDiffIndTextureDims;
float4 sc_RayTracedDiffIndTextureView;
float4 sc_RayTracedAoTextureSize;
float4 sc_RayTracedAoTextureDims;
float4 sc_RayTracedAoTextureView;
float receiver_mask;
float3 OriginNormalizationScale;
float3 OriginNormalizationScaleInv;
float3 OriginNormalizationOffset;
int receiverId;
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
float4 backCapTexSize;
float4 backCapTexDims;
float4 backCapTexView;
float3x3 backCapTexTransform;
float4 backCapTexUvMinMax;
float4 backCapTexBorderColor;
float2 backCapTexScale;
float2 backCapTexOffset;
float4 backCapStartingColor;
float4 backCapEndingColor;
float backCapGradientRamp;
float backCapMetallic;
float backCapRoughness;
float4 frontCapTexSize;
float4 frontCapTexDims;
float4 frontCapTexView;
float3x3 frontCapTexTransform;
float4 frontCapTexUvMinMax;
float4 frontCapTexBorderColor;
float2 frontCapTexScale;
float2 frontCapTexOffset;
float4 frontCapStartingColor;
float4 frontCapEndingColor;
float frontCapGradientRamp;
float frontCapMetallic;
float frontCapRoughness;
float4 outerEdgeTexSize;
float4 outerEdgeTexDims;
float4 outerEdgeTexView;
float3x3 outerEdgeTexTransform;
float4 outerEdgeTexUvMinMax;
float4 outerEdgeTexBorderColor;
float2 outerEdgeTexScale;
float2 outerEdgeTexOffset;
float4 outerEdgeStartingColor;
float4 outerEdgeEndingColor;
float outerEdgeGradientRamp;
float outerEdgeMetallic;
float outerRoughness;
float4 InnerEdgeTexSize;
float4 InnerEdgeTexDims;
float4 InnerEdgeTexView;
float3x3 InnerEdgeTexTransform;
float4 InnerEdgeTexUvMinMax;
float4 InnerEdgeTexBorderColor;
float2 InnerEdgeTexScale;
float2 InnerEdgeTexOffset;
float4 InnerEdgeStartingColor;
float4 InnerEdgeEndingColor;
float InnerEdgeGradientRamp;
float InnerEdgeMetallic;
float InnerEdgeRoughness;
float4 Port_Import_N129;
float4 Port_Import_N130;
float Port_Input0_N143;
float Port_Input1_N143;
float Port_RangeMinA_N132;
float Port_RangeMaxA_N132;
float Port_RangeMinB_N132;
float Port_RangeMaxB_N132;
float2 Port_Import_N133;
float2 Port_Center_N134;
float2 Port_Import_N135;
float Port_RangeMinA_N164;
float Port_RangeMaxA_N164;
float Port_RangeMinB_N164;
float Port_RangeMaxB_N164;
float2 Port_Import_N137;
float Port_Input1_N142;
float Port_Input2_N142;
float4 Port_Default_N146;
float Port_Opacity_N149;
float3 Port_Normal_N149;
float3 Port_Emissive_N149;
float3 Port_AO_N149;
float3 Port_SpecularAO_N149;
float4 Port_Import_N098;
float4 Port_Import_N099;
float Port_Input0_N112;
float Port_Input1_N112;
float Port_RangeMinA_N101;
float Port_RangeMaxA_N101;
float Port_RangeMinB_N101;
float Port_RangeMaxB_N101;
float2 Port_Import_N102;
float2 Port_Center_N103;
float2 Port_Import_N104;
float Port_RangeMinA_N160;
float Port_RangeMaxA_N160;
float Port_RangeMinB_N160;
float Port_RangeMaxB_N160;
float2 Port_Import_N106;
float Port_Input1_N111;
float Port_Input2_N111;
float4 Port_Default_N010;
float Port_Opacity_N118;
float3 Port_Normal_N118;
float3 Port_Emissive_N118;
float3 Port_AO_N118;
float3 Port_SpecularAO_N118;
float Port_Input1_N054;
float4 Port_Import_N038;
float4 Port_Import_N039;
float Port_Input0_N066;
float Port_Input1_N066;
float Port_RangeMinA_N033;
float Port_RangeMaxA_N033;
float Port_RangeMinB_N033;
float Port_RangeMaxB_N033;
float2 Port_Import_N017;
float2 Port_Center_N047;
float2 Port_Import_N058;
float Port_RangeMinA_N153;
float Port_RangeMaxA_N153;
float Port_RangeMinB_N153;
float Port_RangeMaxB_N153;
float2 Port_Import_N060;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Default_N046;
float Port_Opacity_N057;
float3 Port_Normal_N057;
float3 Port_Emissive_N057;
float3 Port_AO_N057;
float3 Port_SpecularAO_N057;
float4 Port_Import_N020;
float4 Port_Import_N021;
float Port_Input0_N035;
float Port_Input1_N035;
float Port_RangeMinA_N023;
float Port_RangeMaxA_N023;
float Port_RangeMinB_N023;
float Port_RangeMaxB_N023;
float2 Port_Import_N024;
float2 Port_Center_N025;
float2 Port_Import_N026;
float Port_RangeMinA_N155;
float Port_RangeMaxA_N155;
float Port_RangeMinB_N155;
float Port_RangeMaxB_N155;
float2 Port_Import_N028;
float Port_Input1_N034;
float Port_Input2_N034;
float4 Port_Default_N077;
float Port_Opacity_N080;
float3 Port_Normal_N080;
float3 Port_Emissive_N080;
float3 Port_AO_N080;
float3 Port_SpecularAO_N080;
float Port_Input1_N043;
float Port_Input1_N014;
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
texture2d<float> InnerEdgeTex [[id(4)]];
texture2d<float> backCapTex [[id(5)]];
texture2d<float> frontCapTex [[id(6)]];
texture2d<float> intensityTexture [[id(7)]];
texture2d<float> outerEdgeTex [[id(8)]];
texture2d<float> sc_EnvmapDiffuse [[id(9)]];
texture2d<float> sc_EnvmapSpecular [[id(10)]];
texture2d<float> sc_RayTracedAoTexture [[id(19)]];
texture2d<float> sc_RayTracedDiffIndTexture [[id(20)]];
texture2d<float> sc_RayTracedReflectionTexture [[id(21)]];
texture2d<float> sc_RayTracedShadowTexture [[id(22)]];
texture2d<float> sc_SSAOTexture [[id(23)]];
texture2d<float> sc_ScreenTexture [[id(24)]];
texture2d<float> sc_ShadowTexture [[id(25)]];
texture2d<uint> z_hitIdAndBarycentric [[id(27)]];
texture2d<float> z_rayDirections [[id(28)]];
sampler InnerEdgeTexSmpSC [[id(29)]];
sampler backCapTexSmpSC [[id(30)]];
sampler frontCapTexSmpSC [[id(31)]];
sampler intensityTextureSmpSC [[id(32)]];
sampler outerEdgeTexSmpSC [[id(33)]];
sampler sc_EnvmapDiffuseSmpSC [[id(34)]];
sampler sc_EnvmapSpecularSmpSC [[id(35)]];
sampler sc_RayTracedAoTextureSmpSC [[id(37)]];
sampler sc_RayTracedDiffIndTextureSmpSC [[id(38)]];
sampler sc_RayTracedReflectionTextureSmpSC [[id(39)]];
sampler sc_RayTracedShadowTextureSmpSC [[id(40)]];
sampler sc_SSAOTextureSmpSC [[id(41)]];
sampler sc_ScreenTextureSmpSC [[id(42)]];
sampler sc_ShadowTextureSmpSC [[id(43)]];
sampler z_hitIdAndBarycentricSmp [[id(45)]];
sampler z_rayDirectionsSmpSC [[id(46)]];
constant userUniformsObj* UserUniforms [[id(47)]];
};
struct main_recv_out
{
uint4 position_and_mask [[color(0)]];
uint4 normal_and_more [[color(1)]];
};
struct main_recv_in
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
fragment main_recv_out main_recv(main_recv_in in [[stage_in]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]])
{
main_recv_out out={};
if ((int(sc_DepthOnly_tmp)!=0))
{
return out;
}
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
Globals.BumpedNormal=float3(0.0);
Globals.ViewDirWS=normalize((*sc_set2.UserUniforms).sc_Camera.position-in.varPos);
Globals.PositionWS=in.varPos;
Globals.VertexNormal_WorldSpace=normalize(in.varNormal);
Globals.Surface_UVCoord0=in.varPackedTex.xy;
ssGlobals param=Globals;
if ((int(backCapPBR_tmp)!=0))
{
float l9_2=0.0;
float l9_3=(*sc_set2.UserUniforms).backCapRoughness;
l9_2=l9_3;
float l9_4=(*sc_set2.UserUniforms).Port_Opacity_N149;
float l9_5=l9_2;
ssGlobals l9_6=param;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_6.BumpedNormal=l9_6.VertexNormal_WorldSpace;
}
float l9_7=l9_4;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_7<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_8=gl_FragCoord;
float2 l9_9=floor(mod(l9_8.xy,float2(4.0)));
float l9_10=(mod(dot(l9_9,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_7<l9_10)
{
discard_fragment();
}
}
float3 l9_11=l9_6.PositionWS;
float3 l9_12=l9_6.BumpedNormal;
float l9_13=l9_5;
float3 l9_14=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_11);
if (dot(l9_14,l9_12)>=(-0.050000001))
{
uint3 l9_15=uint3(round((l9_11-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_15.x,l9_15.y,l9_15.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_16=l9_12;
float l9_17=dot(abs(l9_16),float3(1.0));
l9_16/=float3(l9_17);
float l9_18=fast::clamp(-l9_16.z,0.0,1.0);
float2 l9_19=l9_16.xy;
float l9_20;
if (l9_16.x>=0.0)
{
l9_20=l9_18;
}
else
{
l9_20=-l9_18;
}
l9_19.x+=l9_20;
float l9_21;
if (l9_16.y>=0.0)
{
l9_21=l9_18;
}
else
{
l9_21=-l9_18;
}
l9_19.y+=l9_21;
float2 l9_22=l9_19;
float2 l9_23=l9_22;
uint2 l9_24=uint2(as_type<uint>(half2(float2(l9_23.x,0.0))),as_type<uint>(half2(float2(l9_23.y,0.0))));
out.normal_and_more=uint4(l9_24.x,l9_24.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_25;
if (l9_13<0.0)
{
l9_25=1023u;
}
else
{
l9_25=uint(fast::clamp(l9_13,0.0,1.0)*1000.0);
}
uint l9_26=l9_25;
l9_26 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_26;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
}
else
{
}
ssGlobals param_1=Globals;
if ((int(frontCapPBR_tmp)!=0))
{
float l9_27=0.0;
float l9_28=(*sc_set2.UserUniforms).frontCapRoughness;
l9_27=l9_28;
float l9_29=(*sc_set2.UserUniforms).Port_Opacity_N118;
float l9_30=l9_27;
ssGlobals l9_31=param_1;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_31.BumpedNormal=l9_31.VertexNormal_WorldSpace;
}
float l9_32=l9_29;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_32<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_33=gl_FragCoord;
float2 l9_34=floor(mod(l9_33.xy,float2(4.0)));
float l9_35=(mod(dot(l9_34,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_32<l9_35)
{
discard_fragment();
}
}
float3 l9_36=l9_31.PositionWS;
float3 l9_37=l9_31.BumpedNormal;
float l9_38=l9_30;
float3 l9_39=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_36);
if (dot(l9_39,l9_37)>=(-0.050000001))
{
uint3 l9_40=uint3(round((l9_36-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_40.x,l9_40.y,l9_40.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_41=l9_37;
float l9_42=dot(abs(l9_41),float3(1.0));
l9_41/=float3(l9_42);
float l9_43=fast::clamp(-l9_41.z,0.0,1.0);
float2 l9_44=l9_41.xy;
float l9_45;
if (l9_41.x>=0.0)
{
l9_45=l9_43;
}
else
{
l9_45=-l9_43;
}
l9_44.x+=l9_45;
float l9_46;
if (l9_41.y>=0.0)
{
l9_46=l9_43;
}
else
{
l9_46=-l9_43;
}
l9_44.y+=l9_46;
float2 l9_47=l9_44;
float2 l9_48=l9_47;
uint2 l9_49=uint2(as_type<uint>(half2(float2(l9_48.x,0.0))),as_type<uint>(half2(float2(l9_48.y,0.0))));
out.normal_and_more=uint4(l9_49.x,l9_49.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_50;
if (l9_38<0.0)
{
l9_50=1023u;
}
else
{
l9_50=uint(fast::clamp(l9_38,0.0,1.0)*1000.0);
}
uint l9_51=l9_50;
l9_51 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_51;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
}
else
{
}
ssGlobals param_2=Globals;
if ((int(outerEdgePBR_tmp)!=0))
{
float l9_52=0.0;
float l9_53=(*sc_set2.UserUniforms).outerRoughness;
l9_52=l9_53;
float l9_54=(*sc_set2.UserUniforms).Port_Opacity_N057;
float l9_55=l9_52;
ssGlobals l9_56=param_2;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_56.BumpedNormal=l9_56.VertexNormal_WorldSpace;
}
float l9_57=l9_54;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_57<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_58=gl_FragCoord;
float2 l9_59=floor(mod(l9_58.xy,float2(4.0)));
float l9_60=(mod(dot(l9_59,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_57<l9_60)
{
discard_fragment();
}
}
float3 l9_61=l9_56.PositionWS;
float3 l9_62=l9_56.BumpedNormal;
float l9_63=l9_55;
float3 l9_64=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_61);
if (dot(l9_64,l9_62)>=(-0.050000001))
{
uint3 l9_65=uint3(round((l9_61-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_65.x,l9_65.y,l9_65.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_66=l9_62;
float l9_67=dot(abs(l9_66),float3(1.0));
l9_66/=float3(l9_67);
float l9_68=fast::clamp(-l9_66.z,0.0,1.0);
float2 l9_69=l9_66.xy;
float l9_70;
if (l9_66.x>=0.0)
{
l9_70=l9_68;
}
else
{
l9_70=-l9_68;
}
l9_69.x+=l9_70;
float l9_71;
if (l9_66.y>=0.0)
{
l9_71=l9_68;
}
else
{
l9_71=-l9_68;
}
l9_69.y+=l9_71;
float2 l9_72=l9_69;
float2 l9_73=l9_72;
uint2 l9_74=uint2(as_type<uint>(half2(float2(l9_73.x,0.0))),as_type<uint>(half2(float2(l9_73.y,0.0))));
out.normal_and_more=uint4(l9_74.x,l9_74.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_75;
if (l9_63<0.0)
{
l9_75=1023u;
}
else
{
l9_75=uint(fast::clamp(l9_63,0.0,1.0)*1000.0);
}
uint l9_76=l9_75;
l9_76 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_76;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
}
else
{
}
ssGlobals param_3=Globals;
if ((int(innerEdgePBR_tmp)!=0))
{
float l9_77=0.0;
float l9_78=(*sc_set2.UserUniforms).InnerEdgeRoughness;
l9_77=l9_78;
float l9_79=(*sc_set2.UserUniforms).Port_Opacity_N080;
float l9_80=l9_77;
ssGlobals l9_81=param_3;
if (!(int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
l9_81.BumpedNormal=l9_81.VertexNormal_WorldSpace;
}
float l9_82=l9_79;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (l9_82<(*sc_set2.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_83=gl_FragCoord;
float2 l9_84=floor(mod(l9_83.xy,float2(4.0)));
float l9_85=(mod(dot(l9_84,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (l9_82<l9_85)
{
discard_fragment();
}
}
float3 l9_86=l9_81.PositionWS;
float3 l9_87=l9_81.BumpedNormal;
float l9_88=l9_80;
float3 l9_89=normalize((*sc_set2.UserUniforms).sc_Camera.position-l9_86);
if (dot(l9_89,l9_87)>=(-0.050000001))
{
uint3 l9_90=uint3(round((l9_86-(*sc_set2.UserUniforms).OriginNormalizationOffset)*(*sc_set2.UserUniforms).OriginNormalizationScale));
out.position_and_mask=uint4(l9_90.x,l9_90.y,l9_90.z,out.position_and_mask.w);
out.position_and_mask.w=uint((*sc_set2.UserUniforms).receiver_mask);
float3 l9_91=l9_87;
float l9_92=dot(abs(l9_91),float3(1.0));
l9_91/=float3(l9_92);
float l9_93=fast::clamp(-l9_91.z,0.0,1.0);
float2 l9_94=l9_91.xy;
float l9_95;
if (l9_91.x>=0.0)
{
l9_95=l9_93;
}
else
{
l9_95=-l9_93;
}
l9_94.x+=l9_95;
float l9_96;
if (l9_91.y>=0.0)
{
l9_96=l9_93;
}
else
{
l9_96=-l9_93;
}
l9_94.y+=l9_96;
float2 l9_97=l9_94;
float2 l9_98=l9_97;
uint2 l9_99=uint2(as_type<uint>(half2(float2(l9_98.x,0.0))),as_type<uint>(half2(float2(l9_98.y,0.0))));
out.normal_and_more=uint4(l9_99.x,l9_99.y,out.normal_and_more.z,out.normal_and_more.w);
out.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_100;
if (l9_88<0.0)
{
l9_100=1023u;
}
else
{
l9_100=uint(fast::clamp(l9_88,0.0,1.0)*1000.0);
}
uint l9_101=l9_100;
l9_101 |= uint(((*sc_set2.UserUniforms).receiverId%32)<<int(10u));
out.normal_and_more.w=l9_101;
}
else
{
out.position_and_mask=uint4(0u);
out.normal_and_more=uint4(0u);
}
}
else
{
}
return out;
}
} // RECEIVER MODE SHADER
