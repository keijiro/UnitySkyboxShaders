Shader "Custom/HorizontalSkybox" {
    Properties {
        _Color1 ("Top Color", Color) = (1, 1, 1, 0)
        _Color2 ("Horizon Color", Color) = (1, 1, 1, 0)
        _Color3 ("Bottom Color", Color) = (1, 1, 1, 0)
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
            float4 _Color3;
            
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
                float p = normalize(i.uvw).y;
                float p1 = max(0.0f, p);
                float p2 = 1.0f - abs(p);
                float p3 = max(0.0f, -p);
                return _Color1 * p1 + _Color2 * p2 + _Color3 * p3;
            }
            ENDCG
        }
    } 
}