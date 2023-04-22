//
//  Ray.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Ray.hpp"

Ray::Ray(Point3D point, Vector3D vector) {
   this->startPoint = point;
   this->vector = vector;
}
