//
//  Sphere.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Sphere: Object3D {
    
    private let center: Point3D
    private let radius: Float
    
    func distance(forRay ray: Ray) -> Float? {
        return 1
    }
    
}
