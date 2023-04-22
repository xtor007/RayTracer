//
//  Vector3D.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Point3D.hpp"

#ifndef Vector3D_h
#define Vector3D_h

#pragma pack(push, 1)
struct Vector3D {
    float x;
    float y;
    float z;
    
    Vector3D();

    Vector3D(float x, float y, float z);
    
    Vector3D(Point3D start, Point3D end);

    Vector3D crossProduct(Vector3D vector);

    float operator*(const Vector3D right);
    
    float operator*(const Point3D right);
    
    Vector3D operator*(float right) const;
    
    Point3D operator+(Point3D right);
    
    Vector3D operator - (Vector3D right);
    
    Vector3D unitVector();
    
    float scalarSquare();
};
#pragma pack(pop)


#endif /* Vector3D_h */
