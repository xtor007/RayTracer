//
//  ShadowTest.swift
//  RayTracerTests
//
//  Created by Yasha Serhiienko on 10.04.2023.
//

import XCTest

final class ShadowTest: XCTestCase {
    
    func testShadow1() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 1, y: 2, z: 2), radius: 1))
        scene.addObject(Sphere(center: Point3D(x: -0.5, y: -1, z: -1), radius: 1))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0.5, y: 1, z: 1))
        )
        
        XCTAssertEqual(lighting, 1 * Scene.shadowBrightness, accuracy: 0.1)
    }
    
    func testShadow2() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 1, y: 2, z: 2), radius: 1))
        scene.addObject(Sphere(center: Point3D(x: -0.5, y: -1, z: 1), radius: 1))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0.5, y: 1, z: 1))
        )
        
        XCTAssertEqual(lighting, 1, accuracy: 0.1)
    }
    
    func testShadow3() {
        let objects: [Object3D] = [
            Disc(center: Point3D(x: 1, y: 1, z: 1), normal: Vector3D(x: 0.2, y: 0.8, z: 1), radius: 10),
            Sphere(center: Point3D(x: 0, y: 0, z: 20), radius: 18),
            Plane(point: Point3D(x: 0, y: 0, z: 5), normal: Vector3D(x: 0, y: 0, z: 1))
        ]
                
        let doesIntersects = Scene.checkIntersection(withObjects: objects, usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 0, z: 1))
        )
        
        XCTAssertTrue(doesIntersects)
    }

    func testShadow4() {
        let objects: [Object3D] = [
            Sphere(center: Point3D(x: 0, y: 0, z: 20), radius: 10),
            Sphere(center: Point3D(x: 10, y: 5, z: 10), radius: 1)
        ]
                
        let doesIntersects = Scene.checkIntersection(withObjects: objects, usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 2, y: 5, z: 1))
        )
        
        XCTAssertFalse(doesIntersects)
    }

}
