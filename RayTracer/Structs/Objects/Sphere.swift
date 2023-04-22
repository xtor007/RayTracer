//
//  Sphere.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Sphere: Object3D {
    
    let center: Point3D
    let radius: Float
    var material: Material = .mirror
    
    func distance(forRay ray: Ray) -> Float? {
        let k = ray.startPoint - center
        var distances = Math.quadraticEquationSolution(
            a: ray.vector.scalarSquare(),
            b: 2 * (ray.vector * k),
            c: k.scalarSquare() - radius * radius
        )
        distances.removeAll { distance in
            return distance < 0
        }
        switch distances.count {
        case 0:
            return nil
        case 1:
            return distances[0]
        case 2:
            return distances[0] < distances[1] ? distances[0] : distances[1]
        default:
            return nil
        }
    }
    
    func getIntersectionPoint(forRay ray: Ray) -> Point3D? {
        
        if let distance = distance(forRay: ray) {
            return ray.startPoint + distance * ray.vector
        }
        
        return nil
    }
    
    func getNormal(forPoint point: Point3D) -> Vector3D {
        
        let normal = center - point
        return Vector3D(x: normal.x, y: normal.y, z: normal.z)
    }
    
}
