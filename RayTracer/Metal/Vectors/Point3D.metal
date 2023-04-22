//
//  Point3D.cpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Point3D.hpp"
#include "metal_stdlib"

Point3D::Point3D() {}

Point3D::Point3D(float x, float y, float z) {
    this->x = x;
    this->y = y;
    this->z = z;
}

Point3D Point3D::operator - (Point3D right) {
    return Point3D(
                   this->x - right.x,
                   this->y - right.y,
                   this->z - right.z
                   );
}

float Point3D::operator * (Point3D right) {
    return this->x * right.x + this->y * right.y + this->z * right.z;
}

float Point3D::distance(Point3D toPoint) {
    float x2 = toPoint.x - x;
    float y2 = toPoint.y - y;
    float z2 = toPoint.z - z;
    return metal::sqrt(x2 * x2 + y2 * y2 + z2 * z2);
}

float Point3D::scalarSquare() {
    return *this * *this;
}
