Shader "Gab/ExpandingVoid"
{
    Properties
    {
        _OutlineWidth ("Outline Width", Range(0.0, 10)) = 0.005
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        
    }
    SubShader
    {
        
        Pass
        {
            Cull front  

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;

            };

            struct v2f
            {

                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };

            float _OutlineWidth;
            float4 _OutlineColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                float3 norm = normalize(mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float2 offset = TransformViewToProjection(norm.xy);
                
                o.pos.xy += offset * o.pos.z * _OutlineWidth;
                o.color = _OutlineColor;

                return o;
            }


            fixed4 frag (v2f i) : SV_Target
            {

                return i.color;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
