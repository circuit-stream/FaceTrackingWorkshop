// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyCollection/InvisibleDistortion"
{
	Properties
	{
		_Blending("Blending", Range( 0 , 1)) = 0
		_DistortionMap("DistortionMap", 2D) = "bump" {}
		_DistortionScale("DistortionScale", Range( 0 , 1)) = 0
		_RippleSpeed("RippleSpeed", Range( 0 , 1)) = 0
		_RippleScale("RippleScale", Range( 0 , 20)) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float4 screenPos;
		};

		uniform float4 _Color0;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform sampler2D _DistortionMap;
		uniform float _RippleScale;
		uniform float _RippleSpeed;
		uniform float _DistortionScale;
		uniform float _Blending;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color0.rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float3 tex2DNode15 = UnpackNormal( tex2D( _DistortionMap, ( _RippleScale * (( ( _Time.y * _RippleSpeed ) + ase_grabScreenPosNorm )).xy ) ) );
			float4 screenColor11 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float4( ( tex2DNode15 * _DistortionScale ) , 0.0 ) + ase_grabScreenPosNorm ).xy);
			float4 temp_cast_3 = (1.0).xxxx;
			float4 lerpResult12 = lerp( screenColor11 , temp_cast_3 , _Blending);
			o.Emission = lerpResult12.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
2472;73;1089;651;908.7623;532.6099;2.034502;False;False
Node;AmplifyShaderEditor.TimeNode;20;-1122.509,39.43609;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;-1172.687,331.1841;Inherit;False;Property;_RippleSpeed;RippleSpeed;4;0;Create;True;0;0;False;0;0;0.19;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;27;-893.5016,502.8945;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-910.399,189.3941;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-646.0139,236.8999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-873.3271,-156.082;Inherit;False;Property;_RippleScale;RippleScale;5;0;Create;True;0;0;False;0;0;0.7;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;21;-760.239,-9.951947;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-580.95,-96.4109;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;15;-400.7442,-139.623;Inherit;True;Property;_DistortionMap;DistortionMap;2;0;Create;True;0;0;False;0;-1;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-434.0556,206.3166;Inherit;False;Property;_DistortionScale;DistortionScale;3;0;Create;True;0;0;False;0;0;0.45;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-81.22119,-49.01387;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;40.17342,215.2866;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;14;94.79063,464.3233;Inherit;False;Property;_Blending;Blending;1;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;31.41322,353.0361;Inherit;False;Constant;_White;White;1;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;11;159.0072,26.79974;Inherit;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;28;421.4698,-205.0056;Inherit;False;Property;_Color0;Color 0;6;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;12;357.9698,98.29923;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;29;160.0106,-276.8429;Inherit;False;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;760.5751,-75.83258;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;MyCollection/InvisibleDistortion;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;20;2
WireConnection;25;1;26;0
WireConnection;24;0;25;0
WireConnection;24;1;27;0
WireConnection;21;0;24;0
WireConnection;22;0;23;0
WireConnection;22;1;21;0
WireConnection;15;1;22;0
WireConnection;18;0;15;0
WireConnection;18;1;19;0
WireConnection;17;0;18;0
WireConnection;17;1;27;0
WireConnection;11;0;17;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;12;2;14;0
WireConnection;29;0;15;0
WireConnection;29;1;12;0
WireConnection;0;0;28;0
WireConnection;0;2;12;0
ASEEND*/
//CHKSM=9584E42B3E4FF1310B138F44033562FF10D4C2B6