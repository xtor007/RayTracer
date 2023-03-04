//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

class Camera {

    var location: Point3D
    var viewingAngle: Float
    var direction: Vector3D

    init(location: Point3D, viewingAngle: Float, direction: Vector3D) {
        self.location = location
        self.viewingAngle = viewingAngle
        self.direction = direction
    }

}
