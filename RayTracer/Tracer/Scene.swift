//
//  Scene.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation
import PluginInterface

class Scene {
    
    private(set) var objects = [Object3D]()
    private(set) var lights = [Light]()
    static let shadowBrightness: Float = 0.2
    
    func addObject(_ object: Object3D) {
        objects.append(object)
    }
    
    func addLight(_ light: Light) {
        lights.append(light)
    }
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Pixel {
        
        let closestIntersection: (object: Object3D, distance: Float, point: Point3D, index: Int)? = getClosestIntersection(usingRay: ray)
        
        
        guard let closestIntersection = closestIntersection else {
            return Pixel(red: 0, green: 0, blue: 0)
        }

        
        let normal = closestIntersection.object.getNormal(forPoint: closestIntersection.point)
        
        var newObjects = objects
        newObjects.remove(at: closestIntersection.index)
        var pixel = Pixel(red: 0, green: 0, blue: 0)

        for light in lights {
            let newRay = Ray(startPoint: closestIntersection.point, vector: -1 * light.direction)
            let lighting = normal.unitVector * light.direction.unitVector
            if lighting > 0 {
                if Scene.checkIntersection(withObjects: newObjects, usingRay: newRay) {
                    pixel = pixel + lighting * Scene.shadowBrightness * light.color
                } else {
                    pixel = pixel + lighting * light.color
                }
            }
        }

        return pixel
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

fileprivate extension Pixel {
    static func * (left: Float, right: Pixel) -> Pixel {
        return Pixel(
            red: UInt8(left * Float(right.red)),
            green: UInt8(left * Float(right.green)),
            blue: UInt8(left * Float(right.blue))
        )
    }
    
    static func + (left: Pixel, right: Pixel) -> Pixel {
        return Pixel(
            red: UInt8(min(Float(left.red) + Float(right.red), Float(UInt8.max))),
            green: UInt8(min(Float(left.green) + Float(right.green), Float(UInt8.max))),
            blue: UInt8(min(Float(left.blue) + Float(right.blue), Float(UInt8.max)))
        )
    }

}
