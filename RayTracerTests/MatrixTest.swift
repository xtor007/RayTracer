//
//  MatrixTest.swift
//  RayTracerTests
//
//  Created by Anatoliy Khramchenko on 09.04.2023.
//

import XCTest

final class MatrixTest: XCTestCase {

    func testMultiplication() {
        let matrix = Matrix(values: [
            [1.2, 0.3, 0, 0],
            [-0.7, 0.7, 0, 0],
            [0, 0, 0, 1]
        ])
        let vector = Vector3D(x: 1, y: -1, z: 0)
        do {
            let newVector = try matrix * vector
            XCTAssertEqual(newVector.x, 0.9, accuracy: 0.01)
            XCTAssertEqual(newVector.y, -1.4, accuracy: 0.01)
        } catch {
            XCTAssertTrue(false)
        }
    }

}
