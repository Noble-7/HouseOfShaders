Shader "Gab/EmmissiveBase"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Emission("Emission", Range(0,10)) = 0.0
        _Metallic("Metallic", Range(0,1)) = 0.0

        _EmissiveColour("Outline Color", Color) = (0,0,0,1)

    }
        SubShader
        {
            Tags { "Geometry" = "Transparent" }

            ZWrite off
            CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            fixed4 _Color;
            fixed4 _EmissiveColour;


            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Emission = _EmissiveColour.rgb;
            }
            ENDCG

            ZWrite on

            Tags { "RenderType" = "Opaque" }

            LOD 200

            CGPROGRAM
                #pragma surface surf Standard fullforwardshadows

                #pragma target 3.0

                sampler2D _MainTex;

                struct Input
                {
                    float2 uv_MainTex;
                };

                half _Glossiness;
                half _Metallic;
                half _Emission;
                fixed4 _Color;
                fixed4 _EmissiveColour;


                void surf(Input IN, inout SurfaceOutputStandard o)
                {

                    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
                    o.Albedo = c.rgb * _Color;

                    o.Emission = _EmissiveColour * _Emission;
                    o.Metallic = _Metallic;
                    o.Smoothness = _Glossiness;
                    o.Alpha = c.a;
                }
                ENDCG



        }
}