//
//  Object3D.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol Object3D {
    func distance(forRay ray: Ray) -> Float?
    func getIntersectionPoint(forRay ray: Ray) -> Point3D?
    func getNormal(forPoint point: Point3D) -> Vector3D
}
