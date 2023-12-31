Shader "Gab/Gradient" {
    Properties{
        _ColorStart("Start Color", Color) = (1,1,1,1)
        _ColorEnd("End Color", Color) = (0,0,0,1)
    }

        SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 100
        
        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input {
            float3 worldPos;
        };
        
        fixed4 _ColorStart;
        fixed4 _ColorEnd;
        
        void surf (Input IN, inout SurfaceOutput o) {
            
            float gradient = IN.worldPos.x;
            
            gradient = saturate((gradient - _ColorStart.x) / (_ColorEnd.x - _ColorStart.x));
            
            fixed4 finalColor = lerp(_ColorStart, _ColorEnd, gradient);
            
            o.Albedo = finalColor.rgb;
        }
        ENDCG
    }
            
        FallBack "Diffuse"
}