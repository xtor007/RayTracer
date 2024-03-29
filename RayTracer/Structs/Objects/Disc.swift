//
//  Disc.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 07.03.2023.
//

import Foundation

struct Disc: Object3D {
    
    let center: Point3D
    let normal: Vector3D
    let radius: Float
    
    init(center: Point3D, normal: Vector3D, radius: Float) {
        self.center = center
        self.normal = normal.unitVector
        self.radius = radius
    }
    
    func distance(forRay ray: Ray) -> Float? {
        
        let D = -(normal * center)
        let divider = normal * ray.vector
        
        if abs(divider) < 0.0001 {
            return nil
        }
        
        let distance = -((normal * ray.startPoint) + D) / divider
        
        if distance < 0.0001 {
            return nil
        }
        
        let intersectionPoint = ray.startPoint + distance * ray.vector

        if intersectionPoint.distance(to: center) > radius {
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
        guard leftDownPoint.x...rightUpPoint.x ~= center.x &&
                leftDownPoint.y...rightUpPoint.y ~= center.y &&
                leftDownPoint.z...rightUpPoint.z ~= center.z else {
            return false
        }
        let projection = radius * normal
        guard leftDownPoint.x...rightUpPoint.x ~= center.x + projection.x &&
                leftDownPoint.y...rightUpPoint.y ~= center.y + projection.y &&
                leftDownPoint.z...rightUpPoint.z ~= center.z + projection.z else {
            return false
        }
        guard leftDownPoint.x...rightUpPoint.x ~= center.x - projection.x &&
                leftDownPoint.y...rightUpPoint.y ~= center.y - projection.y &&
                leftDownPoint.z...rightUpPoint.z ~= center.z - projection.z else {
            return false
        }
        return true
    }
    
}
