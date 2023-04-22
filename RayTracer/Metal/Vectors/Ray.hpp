//
//  Ray.hpp
//  RayTracer
//
//  Created by Yasha Serhiienko on 22.04.2023.
//

#include "Vector3D.hpp"

#ifndef Ray_hpp
#define Ray_hpp

#pragma pack(push, 1)
struct Ray {
    Point3D startPoint;
    Vector3D vector;
    
    Ray(Point3D point, Vector3D vector);
};
#pragma pack(pop)


#endif /* Ray_hpp */
