//
//  Light.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Light.hpp"

Light::Light(Vector3D direction, Pixel color) {
    this->direction = direction;
    this->color = color;
}
