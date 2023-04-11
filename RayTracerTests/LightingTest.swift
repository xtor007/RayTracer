//
//  LightingTest.swift
//  RayTracerTests
//
//  Created by Yasha Serhiienko on 10.04.2023.
//

import XCTest

final class LightingTest: XCTestCase {
    
    func testSphereWithLight1() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 5, y: 5, z: 10), radius: 2))
        scene.addObject(Sphere(center: Point3D(x: 11, y: 11, z: 20), radius: 5))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 1, y: 1, z: 2))
        )
        
        XCTAssertEqual(lighting, 1, accuracy: 0.1)
    }
    
    func testSphereWithLight2() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 5, y: 5, z: 10), radius: 2))
        scene.addObject(Sphere(center: Point3D(x: 11, y: 11, z: 20), radius: 5))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 1, y: -1, z: 2))
        )
        
        XCTAssertEqual(lighting, 0, accuracy: 0.1)
    }
    
    func testDiscWithLight1() {
        let scene = Scene()
        scene.addObject(Disc(center: Point3D(x: 0, y: 10, z: 50),
                             normal: Vector3D(x: 0.5, y: 1, z: 1),
                             radius: 10))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 1, z: 4))
        )
        
        XCTAssertEqual(lighting, 1, accuracy: 0.1)
    }
    
    func testDiscWithLight2() {
        let scene = Scene()
        scene.addObject(Disc(center: Point3D(x: 0, y: 10, z: 50),
                             normal: Vector3D(x: -0.5, y: -1, z: -1),
                             radius: 10))
        
        let lighting = scene.checkIntersectionWithLighting(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 1, z: 4))
        )
        
        XCTAssertEqual(lighting, -1, accuracy: 0.1)
    }
    
    func testClosestObject1() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 10), radius: 5))
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 20), radius: 18))
        
        let lighting = scene.getClosestIntersection(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 0, z: 1))
        )!.1
        
        XCTAssertEqual(lighting, 2, accuracy: 0.001)
    }
    
    func testClosestObject2() {
        let scene = Scene()
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 10), radius: 5))
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 20), radius: 18))
        scene.addObject(Plane(point: Point3D(x: 0, y: 0, z: 1), normal: Vector3D(x: 0, y: 0, z: 1)))
        
        
        let lighting = scene.getClosestIntersection(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 0, z: 1))
        )!.1
        
        XCTAssertEqual(lighting, 1, accuracy: 0.001)
    }
    
    func testClosestObject3() {
        let scene = Scene()
        scene.addObject(Disc(center: Point3D(x: 1, y: 1, z: 1), normal: Vector3D(x: 0.2, y: 0.8, z: 1), radius: 10))
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 20), radius: 18))
        scene.addObject(Plane(point: Point3D(x: 0, y: 0, z: 5), normal: Vector3D(x: 0, y: 0, z: 1)))
        
        let lighting = scene.getClosestIntersection(usingRay: Ray(
            startPoint: Point3D(x: 0, y: 0, z: 0),
            vector: Vector3D(x: 0, y: 0, z: 1))
        )!.1
        
        XCTAssertEqual(lighting, 2, accuracy: 0.001)
    }
    
}
