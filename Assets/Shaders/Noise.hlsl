//UNITY_SHADER_NO_UPGRADE
#ifndef MYHLSLINCLUDE_INCLUDED
#define MYHLSLINCLUDE_INCLUDED

float random(float value)
{
    return frac(sin(value) * 2746313);
}

float random2D(float2 value)
{
    //make value smaller to avoid artefacts
    float2 smallValue = sin(value);
    //get scalar value from 2d vector
    float random = dot(smallValue, float2(13.37, 42.0));
    //make value more random by making it bigger and then taking the factional part
    return frac(sin(random) * 2746313);
}

float random3D(float3 value)
{
    //make value smaller to avoid artefacts
    float3 smallValue = sin(value);
    //get scalar value from 3d vector
    float random = dot(smallValue, float3(13.37, 42.0, 22.8));
    //make value more random by making it bigger and then taking the factional part
    return frac(sin(random) * 2746313);
}

float random4D(float4 value)
{
    //make value smaller to avoid artefacts
    float4 smallValue = sin(value);
    //get scalar value from 4d vector
    float random = dot(smallValue, float4(13.37, 42.0, 22.8, 69.69));
    //make value more random by making it bigger and then taking the factional part
    return frac(sin(random) * 2746313);
}

void Noise_float(float value, float scale, out float Out)
{
    value *= scale;
    float id = floor(value);
    float localValue = frac(value);

    float x0 = random(id);
    float x1 = random(id + 1);

    float4 smoothstep = localValue * localValue * (3 - 2 * localValue);

    Out = lerp(x0, x1, smoothstep);
}

void Noise2D_float(float2 value, float scale, out float Out)
{
    value *= scale;
    float2 id = floor(value);
    float2 localValue = frac(value);
    
    float x0y0 = random2D(id);
    float x1y0 = random2D(id + float2(1, 0));
    float x0y1 = random2D(id + float2(0, 1));
    float x1y1 = random2D(id + float2(1, 1));

    float2 smoothstep = localValue * localValue * (3 - 2 * localValue);


    float2 ylerp = lerp(float2(x0y0, x1y0), float2(x0y1, x1y1), smoothstep.y);

    Out =  lerp(ylerp.x, ylerp.y, smoothstep.x);
}

void Noise3D_float(float3 value, float scale, out float Out)
{
    value *= scale;
    float3 id = floor(value);
    float3 localValue = frac(value);
    
    float x0y0z0 = random3D(id);
    float x1y0z0 = random3D(id + float3(1, 0, 0));
    float x0y1z0 = random3D(id + float3(0, 1, 0));
    float x1y1z0 = random3D(id + float3(1, 1, 0));
    float x0y0z1 = random3D(id + float3(0, 0, 1));
    float x1y0z1 = random3D(id + float3(1, 0, 1));
    float x0y1z1 = random3D(id + float3(0, 1, 1));
    float x1y1z1 = random3D(id + float3(1, 1, 1));

    float3 smoothstep = localValue * localValue * (3 - 2 * localValue);

    float4 zlerp = lerp(float4(x0y0z0, x1y0z0, x0y1z0, x1y1z0), float4(x0y0z1, x1y0z1, x0y1z1, x1y1z1), smoothstep.z);
    float2 ylerp = lerp(zlerp.xy, zlerp.zw, smoothstep.y);

    Out =  lerp(ylerp.x, ylerp.y, smoothstep.x);
}

void Noise4D_float(float4 value, float scale, out float Out)
{
    value *= scale;
    float4 id = floor(value);
    float4 localValue = frac(value);
    
    float x0y0z0w0 = random4D(id);
    float x1y0z0w0 = random4D(id + float4(1, 0, 0, 0));
    float x0y1z0w0 = random4D(id + float4(0, 1, 0, 0));
    float x1y1z0w0 = random4D(id + float4(1, 1, 0, 0));
    float x0y0z1w0 = random4D(id + float4(0, 0, 1, 0));
    float x1y0z1w0 = random4D(id + float4(1, 0, 1, 0));
    float x0y1z1w0 = random4D(id + float4(0, 1, 1, 0));
    float x1y1z1w0 = random4D(id + float4(1, 1, 1, 0));
    float x0y0z0w1 = random4D(id + float4(0, 0, 0, 1));
    float x1y0z0w1 = random4D(id + float4(1, 0, 0, 1));
    float x0y1z0w1 = random4D(id + float4(0, 1, 0, 1));
    float x1y1z0w1 = random4D(id + float4(1, 1, 0, 1));
    float x0y0z1w1 = random4D(id + float4(0, 0, 1, 1));
    float x1y0z1w1 = random4D(id + float4(1, 0, 1, 1));
    float x0y1z1w1 = random4D(id + float4(0, 1, 1, 1));
    float x1y1z1w1 = random4D(id + float4(1, 1, 1, 1));

    float4 smoothstep = localValue * localValue * (3 - 2 * localValue);

    float4 wLerp1 = lerp(float4(x0y0z0w0, x1y0z0w0, x0y1z0w0, x1y1z0w0), float4(x0y0z0w1, x1y0z0w1, x0y1z0w1, x1y1z0w1), smoothstep.w);
    float4 wLerp2 = lerp(float4(x0y0z1w0, x1y0z1w0, x0y1z1w0, x1y1z1w0), float4(x0y0z1w1, x1y0z1w1, x0y1z1w1, x1y1z1w1), smoothstep.w);

    float4 zlerp = lerp(wLerp1, wLerp2, smoothstep.z);
    float2 ylerp = lerp(zlerp.xy, zlerp.zw, smoothstep.y);

    Out =  lerp(ylerp.x, ylerp.y, smoothstep.x);
}

void Voronoi_float(float2 value, float scale, out float Out, out float2 Cell)
{
    value *= scale;
    float2 id = floor(value);
    float2 localValue = frac(value);

    float2 nearestPoint1 = localValue;
    float2 nearestPoint2 = localValue;

    float distanceToNearestPoint1 = 2;
    float distanceToNearestPoint2 = 2   ;

    for(int y = -1; y <= 1; y++)
    {
        for(int x = -1; x <= 1; x++)
        {
            float2 offset = float2(x, y);
            float2 p = random2D(id + offset);

            float distance = length(p - localValue + offset);

            if(distance < distanceToNearestPoint1)
            {
                nearestPoint1 = p + offset;
                distanceToNearestPoint1 = distance;
            }else if(distance < distanceToNearestPoint2)
            {
                nearestPoint2 = p + offset;
                distanceToNearestPoint2 = distance;
            }
        }
    }

    float2 poin1ToPoint2 = nearestPoint2 - nearestPoint1;
    float2 point1ToLocalValue = localValue - nearestPoint1;

    float projectionDistance =  dot(point1ToLocalValue, poin1ToPoint2) / length(poin1ToPoint2);

    Cell = nearestPoint2;

    Out = distanceToNearestPoint2;
}
#endif //MYHLSLINCLUDE_INCLUDED
