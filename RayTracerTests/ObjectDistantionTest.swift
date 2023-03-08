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
    let plane = Plane(point: Point3D(x: 3, y: 0, z: 0), normal: Vector3D(x: 1, y: 0, z: 0))
    let disc = Disc(center: Point3D(x: 0, y: 0, z: 3), normal: Vector3D(x: 1, y: 1, z: 1), radius: 1)
    
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
    
    func testPlane1() {
        let distanceToPlane = plane.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 0,
                y: 0,
                z: 1
            )
        ))
        XCTAssertNil(distanceToPlane)
    }
    
    func testPlane2() {
        let distanceToPlane = plane.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: -1,
                y: 0,
                z: 0
            )
        ))
        XCTAssertNil(distanceToPlane)
    }
    
    func testPlane3() {
        let distanceToPlane = plane.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 1,
                y: 1,
                z: 1
            )
        ))
        XCTAssertNotNil(distanceToPlane)
        XCTAssertEqual(distanceToPlane!, 3 * sqrt(Float(3)), accuracy: 0.01)
    }

    func testDisc1() {
        let distanceToDisc = disc.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 0,
                y: 0.1,
                z: 1.1)
        ))
        
        XCTAssertNotNil(distanceToDisc)
        XCTAssertEqual(distanceToDisc!, camera.distance(to: Point3D(x: 0, y: 0.25, z: 2.75)), accuracy: 0.01)
    }
    
    func testDisc2() {
        let distanceToDisc = disc.distance(forRay: Ray(
            startPoint: camera,
            vector: Vector3D(
                x: 0,
                y: 1.1,
                z: 1.1)
        ))
        
        XCTAssertNil(distanceToDisc)
    }
    
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
    
}
