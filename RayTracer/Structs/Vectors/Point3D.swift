//
//  Point3D.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Point3D: VectorValue, Equatable {
    
    static func + (left: Point3D, right: VectorValue) -> Point3D {
        return Point3D(
            x: left.x + right.x,
            y: left.y + right.y,
            z: left.z + right.z
        )
    }

    static func - (left: Point3D, right: VectorValue) -> Point3D {
        return Point3D(
            x: left.x - right.x,
            y: left.y - right.y,
            z: left.z - right.z
        )
    }
    
    static func * (left: Point3D, right: VectorValue) -> Float {
        return left.x * right.x + left.y * right.y + left.z * right.z
    }
    
    static let zero = Point3D(x: 0, y: 0, z: 0)

    private(set) var x: Float
    private(set) var y: Float
    private(set) var z: Float
    
    func scalarSquare() -> Float {
        return self * self
    }
    
    func distance(to point: Point3D) -> Float {
        return sqrt(pow((self.x - point.x), 2) + pow((self.y - point.y), 2) + pow((self.z - point.z), 2))
    }

}
