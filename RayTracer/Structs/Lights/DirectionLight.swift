//
//  DirectionLight.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import Foundation

class DirectionLight: Light {
    let direction: Vector3D
    let color: Pixel
    let intensity: Float
    
    init(direction: Vector3D, color: Pixel, intensity: Float) {
        self.direction = direction.unitVector
        self.color = color
        self.intensity = intensity
    }
    
    func getPixel(normal: Vector3D, root: OctNode, reflectedFrom point: Point3D) -> Pixel {
        let rayDirection = -1 * direction
        let ray = Ray(startPoint: point, vector: rayDirection)
        
        let lighting = normal * direction * intensity
        
        if lighting > 0 {
            if !root.isInetersectedWithObject(byRay: ray) {
                return lighting * color
            }
        }
        
        return Pixel(red: 0, green: 0, blue: 0)
    }
    
    func getPixel(normal: Vector3D, objects: [Object3D], reflectedFrom point: Point3D) -> Pixel {
        let rayDirection = -1 * direction
        let ray = Ray(startPoint: point, vector: rayDirection)
        
        let lighting = normal * direction * intensity
        
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
