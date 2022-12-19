

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat3 normalMatrix;
uniform vec3 directionalLightColor[ 1 ];
uniform vec3 directionalLightDirection[ 1 ];

attribute vec3 offset;
attribute vec3 position;
attribute vec3 normal;
attribute vec3 color;
attribute float radius;

varying vec3 vColor;
varying vec3 vLightFront;

void main() {

    vColor = color;

    vec3 objectNormal = normal;
    vec3 transformedNormal = normalMatrix * objectNormal;
    vec4 mvPosition = modelViewMatrix * vec4( position * radius + offset, 1.0 );

    vLightFront = vec3( 0.0 );

    transformedNormal = normalize( transformedNormal );

    vec4 lDirection = viewMatrix * vec4( directionalLightDirection[ 0 ], 0.0 );
    vec3 dirVector = normalize( lDirection.xyz );
    float dotProduct = dot( transformedNormal, dirVector );
    vec3 directionalLightWeighting = vec3( max( dotProduct, 0.0 ) );

    vLightFront += directionalLightColor[ 0 ] * directionalLightWeighting;

    gl_Position = projectionMatrix * mvPosition;
}

