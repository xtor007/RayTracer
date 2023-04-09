//
//  TriangleDistanceTest.swift
//  RayTracerTests
//
//  Created by Anatoliy Khramchenko on 09.04.2023.
//

import XCTest

final class TriangleDistanceTest: XCTestCase {

    let triange = Triangle(
        point1: Point3D(x: 1, y: 2, z: 3),
        point2: Point3D(x: 1, y: 2, z: 2),
        point3: Point3D(x: 1, y: 3, z: 3)
    )
    let startPoint = Point3D(x: 0, y: 0, z: 0)

    func testOk() {
        let distance = triange.distance(forRay: Ray(startPoint: startPoint, vector: Vector3D(x: 1, y: 2.5, z: 2.7)))
        XCTAssertNotNil(distance)
        XCTAssertEqual(distance ?? 0, 3.8131, accuracy: 0.01)
    }

    func testOpposite() {
        let distance = triange.distance(forRay: Ray(startPoint: startPoint, vector: Vector3D(x: -1, y: -2.5, z: -2.7)))
        XCTAssertNil(distance)
    }

}
