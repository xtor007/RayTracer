//
//  Light.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "../Vectors/Vector3D.hpp"
#include "Pixel.hpp"

#ifndef Light_hpp
#define Light_hpp

//#pragma pack(push, 1)
struct Light {
public:
    Vector3D direction;
    Pixel color;
    uint8_t one; // just for allignment :(

    Light(Vector3D direction, Pixel color);
};
//#pragma pack(pop)

#endif /* Light_hpp */
