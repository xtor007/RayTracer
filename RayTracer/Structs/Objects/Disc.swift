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
    
    func distance(forRay ray: Ray) -> Float? {
        
        let D = -(normal * center)
        let divider = normal * ray.vector
        
        if abs(divider) < 0.0001 {
            return nil
        }
        
        let distance = -((normal * ray.startPoint) + D) / divider
        
        if distance < 0 {
            return nil
        }
        
        let p = ray.startPoint + distance * ray.vector
        let dp = p - center

        if p.distance(to: center) > radius {
            return nil
        }

        return distance
    }

}
