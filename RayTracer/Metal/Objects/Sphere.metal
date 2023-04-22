//
//  Sphere.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Sphere.hpp"
#include "metal_stdlib"

float Sphere::distance(Ray ray) constant {
    Point3D k = ray.startPoint - center;
    
    float a = ray.vector.scalarSquare();
    float b = 2 * (ray.vector * k);
    float c = k.scalarSquare() - radius * radius;
    float discriminant = b * b - 4 * a * c;
    if (discriminant < 0) {
        return -1;
    }
    
    float solution1 = (-b + metal::sqrt(discriminant)) / (2 * a);
    float solution2 = (-b - metal::sqrt(discriminant)) / (2 * a);
    
    if (solution1 <= solution2 && solution1 > 0.001) {
        return solution1;
    } else if (solution2 > 0.001) {
        return solution2;
    } else {
        return -1;
    }
}

Point3D Sphere::getIntersectionPoint(Ray ray) constant {
    
    float dist = distance(ray);
    if (dist != -1) {
        return ray.vector * dist + ray.startPoint;
    }
    
    return Point3D(-100, -100, -100);
}

Vector3D Sphere::getNormal(Point3D point) constant {
    Point3D p = center;
    Point3D normal = p - point;
    return Vector3D(normal.x, normal.y, normal.z);
}
