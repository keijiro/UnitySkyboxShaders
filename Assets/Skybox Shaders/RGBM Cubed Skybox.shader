Shader "Skybox/RGBM Cubed Skybox"
{
    Properties
    {
        _Cubemap("Cubemap", Cube) = "white" {}
        _Exposure("Exposure", Float) = 1
        _YawAngle("Yaw Angle", Float) = 0
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata_t
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };

    struct v2f
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };

    samplerCUBE _Cubemap;
    half _Exposure;
    float _YawAngle;

    float4x4 MakeRotationMatrix()
    {
        float radian = 0.01745329251 * _YawAngle;
        float sn = sin(radian);
        float cs = cos(radian);
        return float4x4(
             cs, 0, sn, 0,
              0, 1,  0, 0,
            -sn, 0, cs, 0,
              0, 0,  0, 1
        );
    }

    v2f vert(appdata_t v)
    {
        v2f o;
        float4 p = mul(MakeRotationMatrix(), v.position);
        o.position = mul(UNITY_MATRIX_MVP, p);
        o.texcoord = v.texcoord;
        return o;
    }

    half4 frag(v2f i) : COLOR
    {
        float4 c = texCUBE(_Cubemap, i.texcoord);
#if USE_LINEAR
        half e = c.a * _Exposure * 8.0f;
        half e2 = e * e;
        half lin_e = dot(half2(0.7532f, 0.2468f), half2(e2, e2 * e));
        c.rgb = c.rgb * lin_e;
#else
        c.rgb = c.rgb * c.a * _Exposure * 8.0f;
#endif
        c.a = 1.0f;
        return c;
    }

    ENDCG

    SubShader
    {
        Tags { "Queue"="Background" "RenderType"="Background" }
        Cull Off
        ZWrite Off
        Fog { Mode Off }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile USE_GAMMA USE_LINEAR
            ENDCG
        }
    } 
    CustomEditor "RgbmCubedSkyboxInspector"
}
