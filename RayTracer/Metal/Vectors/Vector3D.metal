//
//  Vector3D.metal
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include <metal_stdlib>
#include "Vector3D.hpp"
using namespace metal;


Vector3D::Vector3D() {}

Vector3D::Vector3D(float x, float y, float z) {
    this->x = x;
    this->y = y;
    this->z = z;
}

Vector3D::Vector3D(Point3D start, Point3D end) {
    Point3D pointRepr = Point3D(end.x - start.x, end.y - start.y, end.z - start.z);
    this->x = pointRepr.x;
    this->y = pointRepr.y;
    this->z = pointRepr.z;
}

Vector3D Vector3D::crossProduct(Vector3D vector) {
    return Vector3D(this->y * vector.z - this->z * vector.y,
                    this->z * vector.x - this->x * vector.z,
                    this->x * vector.y - this->y * vector.x
                    );
}

float Vector3D::operator * (const Vector3D right) {
    return (this->x * right.x + this->y * right.y + this->z * right.z);
}

float Vector3D::operator * (const Point3D right) {
    return (this->x * right.x + this->y * right.y + this->z * right.z);
}

Vector3D Vector3D::operator * (float right) const {
    return Vector3D(this->x * right, this->y * right, this->z * right);
}

Point3D Vector3D::operator + (Point3D right) {
    return Point3D(
                   right.x + x,
                   right.y + y,
                   right.z + z
                   );
}

Vector3D Vector3D::operator - (Vector3D right) {
    return Vector3D(
                    x - right.x,
                    y - right.y,
                    z - right.z
                    );
}

Vector3D Vector3D::unitVector() {
    return *this * (1 / (sqrt(x * x + y * y + z * z)));
}

float Vector3D::scalarSquare() {
    return *this * *this;
}
