//
//  Point3D.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#ifndef Point3D_hpp
#define Point3D_hpp

#pragma pack(push, 1)
struct Point3D {
    float x;
    float y;
    float z;
    
    Point3D();
    
    Point3D(float x, float y, float z);
    
    Point3D operator - (Point3D right);

    float operator * (Point3D right);

    float distance(Point3D toPoint);

    float scalarSquare();
};

enum Material { mirror, regular };
#pragma pack(pop)


#endif /* Point3D_hpp */
