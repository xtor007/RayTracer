//
//  SceneWithTree.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 06.06.2023.
//

import Foundation

class SceneWithTree: SceneProtocol {
    
    private let root = OctNode(
        leftDownPoint: Point3D(x: -3000, y: -3000, z: -3000),
        rightUpPoint: Point3D(x: 3000, y: 3000, z: 3000)
    )
    
    func addObject(_ object: Object3D) {
        root.addObject(object)
    }
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Float {
        let allIntersections = root.getIntersections(forRay: ray)
        return allIntersections.isEmpty ? 0 : 1
        // TODO: Light
    }
    
}
