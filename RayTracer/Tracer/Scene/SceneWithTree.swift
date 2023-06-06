//
//  SceneWithTree.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 06.06.2023.
//

import Foundation

class SceneWithTree: SceneProtocol {
    
    private(set) var lights = [Light]()
    
    private let root = OctNode(
        leftDownPoint: Point3D(x: -3000, y: -3000, z: -3000),
        rightUpPoint: Point3D(x: 3000, y: 3000, z: 3000)
    )
    
    func addObject(_ object: Object3D) {
        root.addObject(object)
    }
    
    func addLight(_ light: Light) {
        lights.append(light)
    }
    
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Pixel {
        let allIntersections: [(distance: Float, point: Point3D, object: Object3D)] = root.getIntersections(forRay: ray)
        
        let closestIntersection = allIntersections.min(by: { $0.distance < $1.distance })
        
        var pixel = Pixel(red: 0, green: 0, blue: 0)
        
        if let intersection = closestIntersection {
            let normal = intersection.object.getNormal(forPoint: intersection.point).unitVector
            for light in lights {
                pixel = pixel + light.getPixel(normal: normal, root: root, reflectedFrom: intersection.point)
            }
        }
        
        return pixel
    }
    
}
