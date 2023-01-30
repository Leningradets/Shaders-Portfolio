//UNITY_SHADER_NO_UPGRADE
#ifndef MYHLSLINCLUDE_INCLUDED
#define MYHLSLINCLUDE_INCLUDED

float random(float4 p, float4 dotDir = float4(13.37, 22.8, 69.69, 420))
{
    //make value smaller to avoid artefacts
    float4 smallP = sin(p);
    //get scalar value from 4d vector
    float random = dot(smallP, dotDir);
    //make value more random by making it bigger and then taking the factional part
    random = frac(sin(random) * 2746313);
    return random;
}

void _4DNoise_float(float4 coords, float scale, out float Out)
{
    coords *= scale;
    float4 id = floor(coords);
    float4 localCoords = frac(coords);
    
    float x0y0z0w0 = random(id + float4(0, 0, 0, 0));
    float x1y0z0w0 = random(id + float4(1, 0, 0, 0));
    float x0y1z0w0 = random(id + float4(0, 1, 0, 0));
    float x1y1z0w0 = random(id + float4(1, 1, 0, 0));
    float x0y0z1w0 = random(id + float4(0, 0, 1, 0));
    float x1y0z1w0 = random(id + float4(1, 0, 1, 0));
    float x0y1z1w0 = random(id + float4(0, 1, 1, 0));
    float x1y1z1w0 = random(id + float4(1, 1, 1, 0));
    float x0y0z0w1 = random(id + float4(0, 0, 0, 1));
    float x1y0z0w1 = random(id + float4(1, 0, 0, 1));
    float x0y1z0w1 = random(id + float4(0, 1, 0, 1));
    float x1y1z0w1 = random(id + float4(1, 1, 0, 1));
    float x0y0z1w1 = random(id + float4(0, 0, 1, 1));
    float x1y0z1w1 = random(id + float4(1, 0, 1, 1));
    float x0y1z1w1 = random(id + float4(0, 1, 1, 1));
    float x1y1z1w1 = random(id + float4(1, 1, 1, 1));

    float4 smoothstep = localCoords * localCoords * (3 - 2 * localCoords);
    //float4 smoothstep = localCoords;

    float4 wLerp1 = lerp(float4(x0y0z0w0, x1y0z0w0, x0y1z0w0, x1y1z0w0), float4(x0y0z0w1, x1y0z0w1, x0y1z0w1, x1y1z0w1), smoothstep.w);
    float4 wLerp2 = lerp(float4(x0y0z1w0, x1y0z1w0, x0y1z1w0, x1y1z1w0), float4(x0y0z1w1, x1y0z1w1, x0y1z1w1, x1y1z1w1), smoothstep.w);

    float4 zlerp = lerp(wLerp1, wLerp2, smoothstep.z);
    float2 ylerp = lerp(zlerp.xy, zlerp.zw, smoothstep.y);

    Out =  lerp(ylerp.x, ylerp.y, smoothstep.x);
}
#endif //MYHLSLINCLUDE_INCLUDED
