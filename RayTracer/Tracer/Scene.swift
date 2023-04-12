//
//  Scene.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

class Scene {
    
    private(set) var objects = [Object3D]()
    static let shadowBrightness: Float = 0.2
    
    func addObject(_ object: Object3D) {
        objects.append(object)
    }
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Float {
        
        let closestIntersection: (object: Object3D, distance: Float, point: Point3D, index: Int)? = getClosestIntersection(usingRay: ray)
        
        
        guard let closestIntersection = closestIntersection else {
            return 0
        }

        let newRay = Ray(startPoint: closestIntersection.point, vector: -1 * Light.direction)
        var newObjects = objects
        newObjects.remove(at: closestIntersection.index)
        
        let normal = closestIntersection.object.getNormal(forPoint: closestIntersection.point)
        let lighting = normal.unitVector * Light.direction.unitVector

        if Scene.checkIntersection(withObjects: newObjects, usingRay: newRay) {
            return lighting * Scene.shadowBrightness
        } else {
            return lighting
        }
    }
    
    func getClosestIntersection(usingRay ray: Ray) -> (Object3D, Float, Point3D, Int)? {

        var intersections = [(object: Object3D, distance: Float, point: Point3D, index: Int)]()
        var index = 0
        
        for object in objects {
            
            if let point = object.getIntersectionPoint(forRay: ray) {
                let distance = point.distance(to: ray.startPoint)
                intersections.append((object, distance, point, index))
            }
            index += 1
            
        }
        return intersections.min(by: { $0.distance < $1.distance })
    }
    
    static func checkIntersection(withObjects objects: [Object3D], usingRay ray: Ray) -> Bool {
        for object in objects {
            if object.getIntersectionPoint(forRay: ray) != nil {
                return true
            }
        }

        return false
    }
}
