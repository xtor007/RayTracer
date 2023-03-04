//
//  Object3D.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol Object3D {
    func distance(forRay ray: Ray) -> Float?
}
