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
    
}
