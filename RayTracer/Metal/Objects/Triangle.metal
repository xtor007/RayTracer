//
//  Triangle.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Triangle.hpp"


/// Möller–Trumbore intersection algorithm https://en.wikipedia.org/wiki/Möller–Trumbore_intersection_algorithm
float Triangle::distance(Ray ray) const constant {
    Vector3D e1 = Vector3D(point1, point2);
    Vector3D e2 = Vector3D(point1, point3);
    Vector3D pvec = ray.vector.crossProduct(e2);
    float scalar = e1 * pvec;
    if (scalar <= 0.000001 && scalar >= 0.000001) {
        return -1;
    }
    float invScalar = 1 / scalar;
    Vector3D inclinedLineToTriangle = Vector3D(point1, ray.startPoint);
    float u = (inclinedLineToTriangle * pvec) * invScalar;
    if (u > 1 || u < 0) {
        return -1;
    }
    Vector3D qvec = inclinedLineToTriangle.crossProduct(e1);
    float v = (ray.vector * qvec) * invScalar;
    if ((v < 0) || ((u + v) > 1)) {
        return -1;
    }
    float result = (e2 * qvec) * invScalar;
    return result <= 0.001 ? -1 : result;
}

Point3D Triangle::getIntersectionPoint(Ray ray) const constant {
    float dist = distance(ray);
    
    if (dist == -1) {
        return Point3D(-100, -100, -100);
    }
    return ((ray.vector * dist) + ray.startPoint);
}

Vector3D Triangle::getNormal(Point3D point) const constant {
    return Vector3D(point3, point1).crossProduct(Vector3D(point2, point1));
}

