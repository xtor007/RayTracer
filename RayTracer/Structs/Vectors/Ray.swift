//
//  Ray.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Ray {

    let startPoint: Point3D
    let vector: Vector3D
    
    init(startPoint: Point3D, vector: Vector3D) {
        self.startPoint = startPoint
        self.vector = vector.unitVector
    }

}
