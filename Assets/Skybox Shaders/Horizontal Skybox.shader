Shader "Skybox/Horizontal Skybox"
{
    Properties
    {
        _Color1 ("Top Color", Color) = (1, 1, 1, 0)
        _Color2 ("Horizon Color", Color) = (1, 1, 1, 0)
        _Color3 ("Bottom Color", Color) = (1, 1, 1, 0)
        _Intensity ("Intensity", Float) = 1.0
        _Exponent ("Exponent", Float) = 1.0
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    struct v2f
    {
        float4 position : SV_POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    half4 _Color1;
    half4 _Color2;
    half4 _Color3;
    half _Intensity;
    half _Exponent;
    
    v2f vert (appdata v)
    {
        v2f o;
        o.position = mul (UNITY_MATRIX_MVP, v.position);
        o.texcoord = v.texcoord;
        return o;
    }
    
    fixed4 frag (v2f i) : COLOR
    {
        float p = normalize (i.texcoord).y;
        float p1 = pow (max (0.0f, p), _Exponent);
        float p3 = pow (max (0.0f, -p), _Exponent);
        float p2 = 1.0f - p1 - p3;
        return (_Color1 * p1 + _Color2 * p2 + _Color3 * p3) * _Intensity;
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
}
