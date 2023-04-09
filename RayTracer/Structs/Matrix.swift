//
//  Matrix.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 09.04.2023.
//

import Foundation

struct Matrix {

    private(set) var values: [[Float]]

    static func *<T: VectorValue> (left: Matrix, right: T) throws -> T {
        if left.values.isEmpty {
            throw MatrixError.notRightSizeForMultiplication
        }
        guard left.values[0].count == 4 else {
            throw MatrixError.notRightSizeForMultiplication
        }
        let vectorMatrix = Matrix(values: [
            [right.x],
            [right.y],
            [right.z],
            [1]
        ])
        let resultMartix = try left * vectorMatrix
        return T(
            x: resultMartix.values[0][0],
            y: resultMartix.values[1][0],
            z: resultMartix.values[2][0]
        )
    }

    static func * (left: Matrix, right: Matrix) throws -> Matrix {
        if left.values.isEmpty {
            throw MatrixError.notRightSizeForMultiplication
        }
        guard left.values[0].count == right.values.count else {
            throw MatrixError.notRightSizeForMultiplication
        }
        var newValues: [[Float]] = Array(repeating: Array(repeating: 0, count: right.values[0].count), count: left.values.count)
        for i in 0..<newValues.count {
            for j in 0..<newValues[i].count {
                var newValue: Float = 0
                for k in 0..<left.values[0].count {
                    newValue += left.values[i][k] * right.values[k][j]
                }
                newValues[i][j] = newValue
            }
        }
        return Matrix(values: newValues)
    }

    init(values: [[Float]]) {
        self.values = values
    }

    /// angle in radians
    init(rotateAroundXForAngle angle: Float) {
        values = [
            [1, 0, 0, 0],
            [0, cos(angle), -sin(angle), 0],
            [0, sin(angle), cos(angle), 0],
            [0, 0, 0, 1]
        ]
    }

    /// angle in radians
    init(rotateAroundYForAngle angle: Float) {
        values = [
            [cos(angle), 0, sin(angle), 0],
            [0, 1, 0, 0],
            [-sin(angle), 0, cos(angle), 0],
            [0, 0, 0, 1]
        ]
    }

    /// angle in radians
    init(rotateAroundZForAngle angle: Float) {
        values = [
            [cos(angle), -sin(angle), 0, 0],
            [sin(angle), cos(angle), 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ]
    }

    init(translation vector: Vector3D) {
        values = [
            [1, 0, 0, vector.x],
            [0, 1, 0, vector.y],
            [0, 0, 1, vector.z],
            [0, 0, 0, 1]
        ]
    }

    init(scale vector: Vector3D) {
        values = [
            [vector.x, 0, 0, 0],
            [0, vector.y, 0, 0],
            [0, 0, vector.z, 0],
            [0, 0, 0, 1]
        ]
    }

}

enum MatrixError: Error {
    case notRightSizeForMultiplication
}
