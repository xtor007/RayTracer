#include "metal_stdlib"
using namespace metal;

struct Point3D {
    float x;
    float y;
    float z;
    
    Point3D() {}
    
    Point3D(float x, float y, float z) {
        this->x = x;
        this->y = y;
        this->z = z;
    }
    
    Point3D operator - (Point3D right) {
        return Point3D(
            this->x - right.x,
            this->y - right.y,
            this->z - right.z
        );
    }
    
    float distance(Point3D toPoint) {
        float x2 = toPoint.x - x;
        float y2 = toPoint.y - y;
        float z2 = toPoint.z - z;
        return sqrt(x2 * x2 + y2 * y2 + z2 * z2);
    }
};

struct Vector3D {
    float x;
    float y;
    float z;
    
    Vector3D() {}

    Vector3D(float x, float y, float z) {
        this->x = x;
        this->y = y;
        this->z = z;
    }
    
    Vector3D(Point3D start, Point3D end) {
        Point3D pointRepr = end - start;
        this->x = pointRepr.x;
        this->y = pointRepr.y;
        this->z = pointRepr.z;
    }

    Vector3D crossProduct(Vector3D vector) {
        return Vector3D(this->y * vector.z - this->z * vector.y,
                        this->z * vector.x - this->x * vector.z,
                        this->x * vector.y - this->y * vector.x
        );
    }

    float operator*(const Vector3D right) {
        return this->x * right.x + this->y * right.y + this->z * right.z;
    }
    
    Vector3D operator*(float right) const {
        return Vector3D(this->x * right, this->y * right, this->z * right);
    }
    
    Point3D operator+(Point3D right) {
        return Point3D(
            right.x + x,
            right.y + y,
            right.z + z
        );
    }
    
    Vector3D unitVector() {
        return Vector3D(
            this->x * (1 / (sqrt(x * x + y * y + z * z))),
            this->y * (1 / (sqrt(x * x + y * y + z * z))),
            this->z * (1 / (sqrt(x * x + y * y + z * z)))
        );
    }
};



struct Ray {
    Point3D startPoint;
    Vector3D vector;
    
    Ray(Point3D point, Vector3D vector) {
        this->startPoint = point;
        this->vector = vector;
    }
};

struct Pixel {
public:
    uint8_t red;
    uint8_t green;
    uint8_t blue;
    
    Pixel() {}
    
    Pixel(uint8_t red, uint8_t green, uint8_t blue) {
        this->red = red;
        this->green = green;
        this->blue = blue;
    }
};

class Light {
public:
    Vector3D direction;
    Pixel color;
    
    Light(Vector3D direction, Pixel color) {
        this->direction = direction;
        this->color = color;
    }
};

struct Triangle {
public:
    Point3D point1;
    Point3D point2;
    Point3D point3;
    Vector3D normal;

    /// Möller–Trumbore intersection algorithm https://en.wikipedia.org/wiki/Möller–Trumbore_intersection_algorithm
    float distance(Ray ray) const constant {
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
        return result < 0 ? -1 : result;
    }

    Point3D getIntersectionPoint(Ray ray) const constant {
        float dist = distance(ray);

        if (dist == -1) {
            return Point3D(-100, -100, -100);
        }
        return ((ray.vector * dist) + ray.startPoint);
    }

    Vector3D getNormal(Point3D point) const constant {
        return normal;
    }

};


kernel void gpuCheckIntersection(constant Ray      *rays          [[ buffer(0) ]],
                                 constant Triangle *triangles     [[ buffer(1) ]],
                                 constant int      *size          [[ buffer(2) ]],
                                 constant Light    *lights        [[ buffer(3) ]],
                                 constant int      *countOfLights [[ buffer(4) ]],
                                 device   Pixel    *pixels        [[ buffer(5) ]],
                                          uint     index [[ thread_position_in_grid ]]) {
    
    int closestIndex = -1;
    float minDistance = 10000;
    Point3D closestPoint;
        
    for (int i = 0; i < size[0]; i++) {
        Point3D point = triangles[i].getIntersectionPoint(rays[index]);

        if ((point.x != -100) || (point.y != -100) || (point.z != -100)) {

            float dist = point.distance(rays[index].startPoint);
            if (minDistance > dist) {
                minDistance = dist;
                closestIndex = i;
                closestPoint = point;
            }
        }
        
    }
    
    if (closestIndex == -1) {
        pixels[index].red = 0;
        pixels[index].green = 0;
        pixels[index].blue = 0;
        return;
    }
    
//    for(int i = 0; i < *countOfLights; i++) {
//        Vector3D direction = lights[i].direction;
//        Ray newRay = Ray(closestPoint, direction * -1);
//        float lighting = normal.unitVector() * direction.unitVector();
//        if lighting > 0 {
//            if Scene.checkIntersection(withObjects: newObjects, usingRay: newRay) {
//                pixel = pixel + lighting * Scene.shadowBrightness * light.color
//            } else {
//                pixel = pixel + lighting * light.color
//            }
//        }
//    }
    
    Vector3D light = Vector3D(0, 1, 0);
    float lighting = triangles[closestIndex].getNormal(closestPoint).unitVector() * light.unitVector();

    if (lighting > 0) {
        pixels[index].red = 255 * lighting;
        pixels[index].green = 255 * lighting;
        pixels[index].blue = 255 * lighting;
        return;
    }

    pixels[index].red = 255 * 0;
    pixels[index].green = 255 * 0;
    pixels[index].blue = 255 * 0;
    return;
}
