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
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Float {
        
        let intersections: [(object: Object3D, distance: Float, point: Point3D, index: Int)] = Scene.getIntersections(withObjects: objects, usingRay: ray)
        
        let closestIntersection = intersections.min(by: { $0.distance < $1.distance })
        
        guard let closestIntersection = closestIntersection else {
            return 0
        }
        
        var newObjects = objects
        newObjects.remove(at: closestIntersection.index)
        
        
        let directionToLight = Vector3D(
            x: -Light.direction.x,
            y: -Light.direction.y,
            z: -Light.direction.z) - closestIntersection.point
        let newRay = Ray(startPoint: closestIntersection.point, vector: directionToLight)
        
        if Scene.getIntersections(withObjects: newObjects, usingRay: newRay).isEmpty {
            let normal = closestIntersection.object.getNormal(forPoint: closestIntersection.point)
            return normal.unitVector * Light.direction.unitVector
        }
                    
        return 0
    }
    
    static func getIntersections(withObjects objects: [Object3D], usingRay ray: Ray) -> [(Object3D, Float, Point3D, Int)] {

        var intersections = [(object: Object3D, distance: Float, point: Point3D, index: Int)]()
        var index = 0
        
        for object in objects {
            
            if let point = object.getIntersectionPoint(forRay: ray) {
                let distance = point.distance(to: ray.startPoint)
                intersections.append((object, distance, point, index))
            }
            index += 1
            
        }
        return intersections
    }
}
