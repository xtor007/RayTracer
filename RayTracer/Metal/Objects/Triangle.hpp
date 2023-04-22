//
//  Triangle.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

//#include "../Vectors/Point3D.hpp"
#include "../Vectors/Ray.hpp"

#ifndef Triangle_hpp
#define Triangle_hpp

//#pragma pack(push, 1)
struct Triangle {
public:
    Point3D point1;
    Point3D point2;
    Point3D point3;
    Vector3D normal;
    Material material;

    float distance(Ray ray) const constant;
    
    Point3D getIntersectionPoint(Ray ray) const constant;

    Vector3D getNormal(Point3D point) const constant;

};
//#pragma pack(pop)

#endif /* Triangle_hpp */
