//
//  Sphere.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "../Vectors/Ray.hpp"

#ifndef Sphere_hpp
#define Sphere_hpp

//#pragma pack(push, 1)
struct Sphere {

    Point3D center;
    float radius;
    Material material;

    float distance(Ray ray) constant;

    Point3D getIntersectionPoint(Ray ray) constant;

    Vector3D getNormal(Point3D point) constant;

};
//#pragma pack(pop)

#endif /* Sphere_hpp */
