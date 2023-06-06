//
//  Plane.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Plane: Object3D {
    
    let point: Point3D
    let normal: Vector3D
    
    init(point: Point3D, normal: Vector3D) {
        self.point = point
        self.normal = normal.unitVector
    }
    
    func distance(forRay ray: Ray) -> Float? {
        let D = -(normal * point)
        let divider = normal * ray.vector
        if divider == 0 {
            return nil
        }
        let distance = -((normal * ray.startPoint) + D) / divider
        if distance < 0 {
            return nil
        }
        return distance
    }
    
    func getIntersectionPoint(forRay ray: Ray) -> Point3D? {
        
        if let distance = distance(forRay: ray) {
            return ray.startPoint + distance * ray.vector
        }
        
        return nil
    }
    
    func getNormal(forPoint point: Point3D) -> Vector3D {
        return normal
    }
    
    func isFullInCube(leftDownPoint: Point3D, rightUpPoint: Point3D) -> Bool {
        return false
    }
    
}
