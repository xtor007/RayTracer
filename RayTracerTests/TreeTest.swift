//
//  TreeTest.swift
//  RayTracerTests
//
//  Created by Anatoliy Khramchenko on 06.06.2023.
//

import XCTest

final class TreeTest: XCTestCase {
    
    func testTree() {
        let root = OctNode(
            leftDownPoint: Point3D(x: -10, y: -10, z: -10),
            rightUpPoint: Point3D(x: 10, y: 10, z: 10)
        )
        let sphere = Sphere(center: Point3D(x: -4, y: -4, z: -4), radius: 2)
        root.addObject(sphere)
        let disc = Disc(
            center: Point3D(x: 2, y: 2, z: 2),
            normal: Vector3D(x: 1, y: 0, z: 0),
            radius: 1
        )
        root.addObject(disc)
        let triangle = Triangle(
            point1: Point3D(x: 1, y: -2, z: -1),
            point2: Point3D(x: 2, y: -2, z: -1),
            point3: Point3D(x: 1, y: -1, z: -2)
        )
        root.addObject(triangle)
        let ray1 = Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: -1, y: -1, z: -1)
        )
        let res1 = root.getIntersections(forRay: ray1)
        XCTAssertEqual(res1.count, 1)
        XCTAssertNotNil(res1[0].2 as? Sphere)
        let ray2 = Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 1.5, y: -2, z: -1.5)
        )
        let res2 = root.getIntersections(forRay: ray2)
        XCTAssertEqual(res2.count, 1)
        XCTAssertNotNil(res2[0].2 as? Triangle)
    }
    
}
