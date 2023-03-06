//
//  QuadraticEquation.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

extension Math {
    static func quadraticEquationSolution(a: Float, b: Float, c: Float) -> [Float] {
        let discriminant = b * b - 4 * a * c
        if discriminant < 0 {
            return []
        }
        let solution1 = (-b + sqrt(discriminant)) / (2 * a)
        let solution2 = (-b - sqrt(discriminant)) / (2 * a)
        return solution1 == solution2 ? [solution1] : [solution1, solution2]
    }
}
