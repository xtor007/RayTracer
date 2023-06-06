//
//  SceneProtocol.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 06.06.2023.
//

import Foundation

protocol SceneProtocol {
    func addObject(_ object: Object3D)
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Float
}
