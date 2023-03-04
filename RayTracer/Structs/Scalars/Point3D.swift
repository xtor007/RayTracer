//
//  Point3D.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Point3D: Scalar3D {
    
    static func + (left: Point3D, right: Scalar3D) -> Point3D {
        return Point3D(
            x: left.x + right.x,
            y: left.y + right.y,
            z: left.z + right.z
        )
    }

    static func - (left: Point3D, right: Scalar3D) -> Point3D {
        return Point3D(
            x: left.x - right.x,
            y: left.y - right.y,
            z: left.z - right.z
        )
    }

    private(set) var x: Float
    private(set) var y: Float
    private(set) var z: Float

}
