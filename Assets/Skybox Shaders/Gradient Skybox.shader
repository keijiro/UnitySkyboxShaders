Shader "Skybox/Gradient Skybox"
{
    Properties
    {
        _Color1 ("Color 1", Color) = (1, 1, 1, 0)
        _Color2 ("Color 2", Color) = (1, 1, 1, 0)
        _UpVector ("Up Vector", Vector) = (0, 1, 0, 0)
        _Intensity ("Intensity", Float) = 1.0
        _Exponent ("Exponent", Float) = 1.0
        // The properties below are used in the custom inspector.
        _UpVectorPitch ("Up Vector Pitch", float) = 0
        _UpVectorYaw ("Up Vector Yaw", float) = 0
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
    half4 _UpVector;
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
        half d = dot (normalize (i.texcoord), _UpVector) * 0.5f + 0.5f;
        return lerp (_Color1, _Color2, pow (d, _Exponent)) * _Intensity;
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
    CustomEditor "GradientSkyboxInspector"
}
