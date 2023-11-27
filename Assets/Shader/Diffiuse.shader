Shader "Gab/Diffiuse"
{
    Properties
    {
        _Colour("Albedo Colour", Color) = (1,1,1,1)
        _Texture("Texture",2D) = "white" {}
        _NMap("NormalMap",2D) = "white" {}

    }
        SubShader
    {

        Tags { "RenderType" = "Opaque" }
        CGPROGRAM
        #pragma surface surf Lambert

        fixed4 _Colour; //Direct reference to properties 
        sampler2D _Texture;
        sampler2D _NMap;

        struct Input {
            float2 uv_Texture;
            float2 uv_NMap;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_Texture, IN.uv_Texture) * _Colour.rgb;
            o.Normal = tex2D(_NMap, IN.uv_NMap);
        }
        ENDCG
    }
        Fallback "Diffuse"
}
