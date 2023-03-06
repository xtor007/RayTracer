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
    
    init(point: Point3D, normal: Vector3D) {
        self.point = point
        self.normal = normal.unitVector
    }
    
}
