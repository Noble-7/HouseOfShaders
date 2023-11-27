Shader "Gab/SimpleOutline"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0

        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth("Outline Width", Range(0.002, 0.2)) = 0.005
    }
        SubShader
        {

            Tags { "Geometry" = "Transparent" }


            ZWrite off
            CGPROGRAM

            #pragma surface surf Lambert vertex:vert

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            float _OutlineWidth;
            fixed4 _Color;
            fixed4 _OutlineColor;

            void vert(inout appdata_full v)
            {
                v.vertex.xyz += v.normal * _OutlineWidth;
            }


            UNITY_INSTANCING_BUFFER_START(Props)

            UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
            {
                
                o.Emission = _OutlineColor.rgb;
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
                fixed4 _Color;


                void surf(Input IN, inout SurfaceOutputStandard o)
                {

                    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
                    o.Albedo = c.rgb;
                    o.Metallic = _Metallic;
                    o.Smoothness = _Glossiness;
                    o.Alpha = c.a;
                }
                ENDCG
        }
            FallBack "Diffuse"
}