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

    func distance(forRay ray: Ray) -> Float? {
        <#code#>
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
