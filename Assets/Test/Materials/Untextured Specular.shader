Shader "Custom/Untextured Specular"
{
    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 0)
        _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 0)
        _Shininess ("Shininess", float) = 0.1
        _Gloss ("Gloss", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM

        #pragma surface surf BlinnPhong

        half4 _Color;
        half _Shininess;
        half _Gloss;

        struct Input
        {
            float dummy;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            o.Specular = _Shininess;
            o.Gloss = _Gloss;
        }

        ENDCG
    } 
    FallBack "Specular"
}
