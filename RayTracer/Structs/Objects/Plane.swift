//
//  Plane.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Plane: Object3D {
    
    let point: Point3D
    let normal: Vector3D
    
    func distance(forRay ray: Ray) -> Float? {
        return 1
    }
    
}
