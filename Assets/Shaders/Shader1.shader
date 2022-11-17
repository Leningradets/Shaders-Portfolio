Shader "Example/URPUnlitShaderBasic"
{
    Properties
    {         
        _ColorA("ColorA", Color) = (0,0,0,1)
        _ColorB("ColorB", Color) = (1,1,1,1)
        _Frequency("Frequency", Float) = 2
        _Amplitude("Amplitude", Range(0, 0.2)) = 0.05
        _Speed("Speed", Float) = 1
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"            
            
            #define TAU 6.28318530718

            float4 _ColorA;
            float4 _ColorB;
            float _Frequency;
            float _Amplitude;
            float _Speed;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float GetRadialDistanse(float2 uv)
            {
                float2 uvsCentered = uv * 2 - 1;
                return length(uvsCentered);
            }

            float InverseLerp( float a, float b, float v ) {
                return (v-a)/(b-a);
            }

            float GetWave(float2 uv)
            {
                float d = GetRadialDistanse(uv);
                float t = cos((d - _Time.y * _Speed) * _Frequency * TAU) * 0.5 + 0.5;
                t *= InverseLerp(1, 0, d);
                return saturate(t);
            }

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                v.vertex.y += GetWave(v.uv) * _Amplitude;
                o.vertex = TransformObjectToHClip(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // sample the texture
                float4 outColor = lerp(_ColorA, _ColorB, GetWave(i.uv));
                return outColor;
            }
            ENDHLSL
        }
    }
}