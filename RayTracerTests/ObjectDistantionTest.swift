//
//  ObjectDistantionTest.swift
//  RayTracerTests
//
//  Created by Anatoliy Khramchenko on 05.03.2023.
//

import XCTest

final class ObjectDistantionTest: XCTestCase {

    let camera = Point3D(x: 0, y: 0, z: 0)
    let sphere = Sphere(center: Point3D(x: 3, y: 5, z: 5), radius: 2)
    
    func testSphere1() {
        let distanceToSphere = sphere.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 0,
                y: 5,
                z: 5
            )
        ))
        XCTAssertNil(distanceToSphere)
    }
    
    func testSphere2() {
        let distanceToSphere = sphere.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: -3,
                y: -5,
                z: -5
            )
        ))
        XCTAssertNil(distanceToSphere)
    }
    
    func testSphere3() {
        let distanceToSphere = sphere.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 3,
                y: 5,
                z: 5
            )
        ))
        XCTAssertNotNil(distanceToSphere)
        XCTAssertEqual(distanceToSphere!, sqrt(Float(59)) - 2, accuracy: 0.01)
    }
    
    func testSphere4() {
        let distanceToSphere = sphere.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 3,
                y: 5,
                z: 3
            )
        ))
        XCTAssertNotNil(distanceToSphere)
        XCTAssertEqual(distanceToSphere!, sqrt(Float(43)), accuracy: 0.01)
    }

}
