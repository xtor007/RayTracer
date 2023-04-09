//
//  Triangle.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 09.04.2023.
//

import Foundation

final class Triangle: Object3D {

    let point1: Point3D
    let point2: Point3D
    let point3: Point3D

    init(point1: Point3D, point2: Point3D, point3: Point3D) {
        self.point1 = point1
        self.point2 = point2
        self.point3 = point3
    }

    /// Möller–Trumbore intersection algorithm https://en.wikipedia.org/wiki/Möller–Trumbore_intersection_algorithm
    func distance(forRay ray: Ray) -> Float? {
        let e1 = Vector3D(start: point1, end: point2)
        let e2 = Vector3D(start: point1, end: point3)
        let pvec = ray.vector.crossProduct(e2)
        let scalar = e1 * pvec
        if -0.000001...0.000001 ~= scalar {
            return nil
        }
        let invScalar = 1 / scalar // 1 / cos
        let inclinedLineToTriangle = Vector3D(start: point1, end: ray.startPoint)
        let u = (inclinedLineToTriangle * pvec) * invScalar
        guard 0...1 ~= u else {
            return nil
        }
        let qvec = inclinedLineToTriangle.crossProduct(e1)
        let v = (ray.vector * qvec) * invScalar
        if v < 0 || u + v > 1 {
            return nil
        }
        let result = (e2 * qvec) * invScalar
        return result < 0 ? nil : result
    }
    
    func getIntersectionPoint(forRay ray: Ray) -> Point3D? {
        guard let distance = distance(forRay: ray) else {
            return nil
        }
        return ray.startPoint + distance * ray.vector
    }
    
    func getNormal(forPoint point: Point3D) -> Vector3D {
        return Vector3D(start: point1, end: point2).crossProduct(Vector3D(start: point1, end: point3)).unitVector
    }

}
