//
//  Scene.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

class Scene {
    
    private var camera = Camera(
        location: Point3D(x: 0, y: 0, z: 0),
        viewingAngle: 60,
        direction: Vector3D(x: 0, y: 0, z: 1)
    )
    
    private(set) var objects = [Object3D]()
    
    func addObject(_ object: Object3D) {
        objects.append(object)
    }
    
    func display() -> String {
        // tracing
        return "So far, tracing has not been implemented"
    }
    
}
