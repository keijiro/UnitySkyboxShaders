Shader "Custom/GradientSkybox" {
    Properties {
        _Color1 ("Color 1", Color) = (1, 1, 1, 0)
        _Color2 ("Color 2", Color) = (1, 1, 1, 0)
        _UpVector ("Up Vector", Vector) = (0, 1, 0, 0)
        // The properties below are used in the custom inspector.
        _UpVectorPitch ("Up Vector Pitch", float) = 0
        _UpVectorYaw ("Up Vector Yaw", float) = 0
    }
    SubShader {
        Tags { "Queue"="Background" }
        Pass {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            float4 _Color1;
            float4 _Color2;
            float4 _UpVector;
            
            struct appdata {
                float4 pos : POSITION;
                float3 uvw : TEXCOORD0;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float3 uvw : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = mul (UNITY_MATRIX_MVP, v.pos);
                o.uvw = v.uvw;
                return o;
            }

            half4 frag (v2f i) : COLOR
            {
                return lerp(_Color1, _Color2, dot(normalize(i.uvw), _UpVector) * 0.5f + 0.5f);
            }
            ENDCG
        }
    }
    CustomEditor "GradientSkyboxInspector"
}