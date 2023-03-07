//
//  Vector3D.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

struct Vector3D: VectorValue {
    
    static func + (left: Vector3D, right: VectorValue) -> Vector3D {
        return Vector3D(
            x: left.x + right.x,
            y: left.y + right.y,
            z: left.z + right.z
        )
    }

    static func - (left: Vector3D, right: VectorValue) -> Vector3D {
        return Vector3D(
            x: left.x - right.x,
            y: left.y - right.y,
            z: left.z - right.z
        )
    }
    
    static func * (left: Vector3D, right: VectorValue) -> Float {
        return left.x * right.x + left.y * right.y + left.z * right.z
    }
    
    static func * (left: Float, right: Vector3D) -> Vector3D {
        return Vector3D(
            x: left * right.x,
            y: left * right.y,
            z: left * right.z
        )
    }

    private(set) var x: Float
    private(set) var y: Float
    private(set) var z: Float
    
    init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(start: Point3D, end: Point3D) {
        let pointRepr = end - start
        self.init(x: pointRepr.x, y: pointRepr.y, z: pointRepr.z)
    }
    
    var lenght: Float {
        return sqrt(x * x + y * y + z * z)
    }
    
    var isUnit: Bool {
        return lenght == 1
    }
    
    var unitVector: Vector3D {
        return (1 / lenght) * self
    }
    
    func scalarSquare() -> Float {
        return self * self
    }
    
    func crossProduct(_ vector: Vector3D) -> Vector3D {
        return Vector3D(
            x: self.y * vector.z - self.z * vector.y,
            y: self.z * vector.x - self.x * vector.z,
            z: self.x * vector.y - self.y * vector.x
        )
    }

}
