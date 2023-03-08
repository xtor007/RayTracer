//
//  Scene.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

class Scene {
    
    private(set) var objects = [Object3D]()
    
    func addObject(_ object: Object3D) {
        objects.append(object)
    }
    
    func checkIntersection(usingRay ray: Ray) -> Bool {
        for object in objects where object.distance(forRay: ray) != nil {
            return true
        }
        
        return false
    }
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Float {
        
        var closestObject: Object3D?
        var intersectionPoint: Point3D?
        var minDistance = Float.greatestFiniteMagnitude
        
        for object in objects {
            
            if let point = object.getIntersectionPoint(forRay: ray) {
                let distance = point.distance(to: ray.startPoint)
                if minDistance > distance {
                    minDistance = distance
                    intersectionPoint = point
                    closestObject = object
                }
            }
            
        }
        
        if let object = closestObject, let point = intersectionPoint {
            let normal = object.getNormal(forPoint: point)
            return normal.unitVector * Light.direction.unitVector
        }
        
        return 0
    }
    
}
