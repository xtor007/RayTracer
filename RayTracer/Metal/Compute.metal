#include "metal_stdlib"
#include "Graphics/Light.hpp"
#include "Objects/Triangle.hpp"
#include "Objects/Sphere.hpp"
using namespace metal;

bool checkIntersection(Ray ray, constant Triangle triangles[], int countOfTriangles, constant Sphere spheres[], int countOfSpheres)  {
    for(int i = 0; i < countOfTriangles; i++) {
        Point3D point = triangles[i].getIntersectionPoint(ray);
        if (point.x != -100 && point.y != -100 && point.z != -100) {
            return true;
        }
    }
    
    for(int i = 0; i < countOfSpheres; i++) {
        Point3D point = spheres[i].getIntersectionPoint(ray);
        if (point.x != -100 && point.y != -100 && point.z != -100) {
            return true;
        }
    }

    return false;
}


Pixel checkIntersectionWithLighting(Ray ray,
                                    constant Triangle *triangles,
                                             int      countOfTriangles,
                                    constant Light    *lights,
                                             int      countOfLights,
                                    constant Sphere   *spheres,
                                             int      countOfSpheres) {
    
    Pixel pixel = Pixel(0, 0, 0);
    Ray newRay = ray;
    
    while (true) {
        
        int closestIndex = -1;
        float minDistance = FLT_MAX;
        Point3D closestPoint;
        bool isTriangle = true;
        
        for (int i = 0; i < countOfTriangles; i++) {
            Point3D point = triangles[i].getIntersectionPoint(newRay);
            
            if ((point.x != -100) || (point.y != -100) || (point.z != -100)) {
                
                float dist = point.distance(newRay.startPoint);
                if (minDistance > dist) {
                    minDistance = dist;
                    closestIndex = i;
                    closestPoint = point;
                }
            }
            
        }
        
        for (int i = 0; i < countOfSpheres; i++) {
            Point3D point = spheres[i].getIntersectionPoint(newRay);
            
            if ((point.x != -100) || (point.y != -100) || (point.z != -100)) {
                
                float dist = point.distance(newRay.startPoint);
                if (minDistance > dist) {
                    minDistance = dist;
                    closestIndex = i;
                    closestPoint = point;
                    isTriangle = false;
                }
            }
            
        }
        
        if (closestIndex == -1) {
            return Pixel(0, 0, 0);
        }
        Vector3D vector = newRay.vector.unitVector();
        
        if (isTriangle) {
            Vector3D normal = triangles[closestIndex].getNormal(closestPoint).unitVector();

            if (triangles[closestIndex].material == mirror) {
                Vector3D reflectedVector = vector - (normal * (vector * normal)) * 2;
                newRay = Ray(closestPoint, reflectedVector);
                continue;
            } else {
                for (int i = 0; i < countOfLights; i++) {
                    Vector3D direction = lights[i].direction;
                    float lighting = normal * direction.unitVector();
                    Ray toLight = Ray(closestPoint, direction * -1);
                    Pixel color = lights[i].color;
                    
                    if (lighting > 0) {
                        if (checkIntersection(toLight, triangles, countOfTriangles, spheres, countOfSpheres)) {
                            pixel = pixel + color * lighting * 0.2;
                        } else {
                            pixel = pixel + color * lighting;
                        }
                    }
                }
                return pixel;
            }
        } else {
            Vector3D normal = spheres[closestIndex].getNormal(closestPoint).unitVector();
            
            if (spheres[closestIndex].material == mirror) {
                Vector3D reflectedVector = vector - (normal * (vector * normal)) * 2;
                newRay = Ray(closestPoint, reflectedVector);
                continue;
            } else {
                for (int i = 0; i < countOfLights; i++) {
                    Vector3D direction = lights[i].direction;
                    float lighting = normal * direction.unitVector();
                    Ray toLight = Ray(closestPoint, direction * -1);
                    Pixel color = lights[i].color;
                    
                    if (lighting > 0) {
                        if (checkIntersection(toLight, triangles, countOfTriangles, spheres, countOfSpheres)) {
                            pixel = pixel + color * lighting * 0.2;
                        } else {
                            pixel = pixel + color * lighting;
                        }
                    }
                }
                return pixel;
            }
        }

    }

    return pixel;
}




kernel void gpuCheckIntersection(constant Ray      *rays             [[ buffer(0) ]],
                                 constant Triangle *triangles        [[ buffer(1) ]],
                                 constant int      *countOfTriangles [[ buffer(2) ]],
                                 constant Light    *lights           [[ buffer(3) ]],
                                 constant int      *countOfLights    [[ buffer(4) ]],
                                 constant Sphere   *spheres          [[ buffer(5) ]],
                                 constant int      *countOfSpheres   [[ buffer(6) ]],
                                 device   Pixel    *pixels           [[ buffer(7) ]],
                                          uint     index [[ thread_position_in_grid ]]) {
    
    Pixel pixel = checkIntersectionWithLighting(
        rays[index],
        triangles,
        *countOfTriangles,
        lights,
        *countOfLights,
        spheres,
        *countOfSpheres
    );
    
    pixels[index].red = pixel.red;
    pixels[index].green = pixel.green;
    pixels[index].blue = pixel.blue;
    return;
}
