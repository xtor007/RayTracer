//
//  SceneProtocol.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 06.06.2023.
//

import Foundation

protocol SceneProtocol {
    func addObject(_ object: Object3D)
    func addLight(_ light: Light)
    func checkIntersectionWithLighting(usingRay ray: Ray) -> Pixel
}
