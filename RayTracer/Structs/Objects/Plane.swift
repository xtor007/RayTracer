//
//  Plane.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Plane: Object3D {
    
    private let point: Point3D
    private let normal: Vector3D
    
    func distance(forRay ray: Ray) -> Float? {
        return 1
    }
    
}
