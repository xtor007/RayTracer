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
            let newVector = matrix * vector
            XCTAssertEqual(newVector.x, 0.9, accuracy: 0.01)
            XCTAssertEqual(newVector.y, -1.4, accuracy: 0.01)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testScale() {
        let matrix = Matrix(scale: Vector3D(x: 2, y: 2, z: 2))
        let vector = Vector3D(x: 1, y: -1, z: 2)
        do {
            let newVector = matrix * vector
            XCTAssertEqual(newVector.x, 2, accuracy: 0.01)
            XCTAssertEqual(newVector.y, -2, accuracy: 0.01)
            XCTAssertEqual(newVector.z, 4, accuracy: 0.01)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testTranslation() {
        let matrix = Matrix(translation: Vector3D(x: 1, y: 1, z: -2))
        let point = Point3D(x: 1, y: -1, z: 2)
        do {
            let newPoint = matrix * point
            XCTAssertEqual(newPoint.x, 2, accuracy: 0.01)
            XCTAssertEqual(newPoint.y, 0, accuracy: 0.01)
            XCTAssertEqual(newPoint.z, 0, accuracy: 0.01)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testRotetion() {
        let matrix = Matrix(rotateAroundXForAngle: Float.pi / 2)
        let vector = Vector3D(x: 1, y: -1, z: 2)
        do {
            let newVector = matrix * vector
            XCTAssertEqual(newVector.x, 1, accuracy: 0.01)
            XCTAssertEqual(newVector.y, -2, accuracy: 0.01)
            XCTAssertEqual(newVector.z, -1, accuracy: 0.01)
        } catch {
            XCTAssertTrue(false)
        }
    }

}
