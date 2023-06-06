//
//  PointLight.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import Foundation
import PluginInterface

class PointLight: Light {
    let origin: Point3D
    let color: Pixel
    let intensity: Float
    
    init(origin: Point3D, color: Pixel, intensity: Float) {
        self.origin = origin
        self.color = color
        self.intensity = intensity
    }
    
    func getPixel(normal: Vector3D, objects: [Object3D], reflectedFrom point: Point3D) -> Pixel {
        let rayDirection = Vector3D(start: point, end: origin).unitVector
        let ray = Ray(startPoint: point, vector: rayDirection)
        
        let lighting = normal * (-1 * rayDirection) * intensity
        
        if lighting > 0 {
            if !checkIntersection(withObjects: objects, usingRay: ray) {
                return lighting * color
            }
        }
        
        return Pixel(red: 0, green: 0, blue: 0)
    }
    
    func checkIntersection(withObjects objects: [Object3D], usingRay ray: Ray) -> Bool {
        for object in objects {
            if object.getIntersectionPoint(forRay: ray) != nil {
                return true
            }
        }

        return false
    }
}
