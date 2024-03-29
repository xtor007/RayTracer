//
//  PointLight.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import Foundation

class PointLight: Light {
    let origin: Point3D
    let color: Pixel
    let intensity: Float
    
    init(origin: Point3D, color: Pixel, intensity: Float) {
        self.origin = origin
        self.color = color
        self.intensity = intensity
    }
    
    func getPixel(normal: Vector3D, root: OctNode, reflectedFrom point: Point3D) -> Pixel {
        let rayDirection = Vector3D(start: point, end: origin).unitVector
        let ray = Ray(startPoint: point, vector: rayDirection)
        
        let lighting = normal * (-1 * rayDirection) * intensity
        
        if lighting > 0 {
            if !root.isInetersectedWithObject(byRay: ray, beforePoint: origin) {
                return lighting * color
            }
        }
        
        return Pixel(red: 0, green: 0, blue: 0)
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
            if let intersectionPoint = object.getIntersectionPoint(forRay: ray) {
                if ray.startPoint.distance(to: intersectionPoint) < ray.startPoint.distance(to: origin) {
                    return true
                }
            }
        }

        return false
    }
}
