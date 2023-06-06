//
//  LightsTest.swift
//  RayTracerTests
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import XCTest

final class LightsTest: XCTestCase {
    
    func testAmbientLight1() {
        let light = AmbientLight(color: Pixel(red: 100, green: 50, blue: 25), intensity: 0.5)
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Sphere(center: Point3D(x: 0, y: 0, z: 0), radius: 10)],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 50, green: 25, blue: 12))
    }
    
    func testAmbientLight2() {
        let light = AmbientLight(color: Pixel(red: 255, green: 50, blue: 255), intensity: 1)
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Sphere(center: Point3D(x: 0, y: 0, z: 0), radius: 10)],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 255, green: 50, blue: 255))
    }
    
    func testAmbientLight3() {
        let light = AmbientLight(color: Pixel(red: 0, green: 0, blue: 0), intensity: 0.8)
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Sphere(center: Point3D(x: 0, y: 0, z: 0), radius: 10)],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 0, green: 0, blue: 0))
    }
    
    func testAmbientLigh4() {
        let light = AmbientLight(color: Pixel(red: 255, green: 255, blue: 255), intensity: 0)
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Sphere(center: Point3D(x: 0, y: 0, z: 0), radius: 10)],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 0, green: 0, blue: 0))
    }
    
    func testPointLight1() {
        let light = PointLight(
            origin: Point3D(x: 0, y: 0, z: 0),
            color: Pixel(red: 255, green: 100, blue: 0),
            intensity: 0.5
        )
        
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 127, green: 50, blue: 0))
    }
    
    func testPointLight2() {
        let light = PointLight(
            origin: Point3D(x: 0, y: 0, z: 0),
            color: Pixel(red: 255, green: 100, blue: 0),
            intensity: 0.5
        )
        
        var pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Plane(point: Point3D(x: 0, y: 0.5, z: 0), normal: Vector3D(x: 0, y: -1, z: 0))],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 0, green: 0, blue: 0))
        
        let ambientLight = AmbientLight(
            color: Pixel(red: 200, green: 100, blue: 0),
            intensity: 0.5
        )
        
        pixel = pixel + ambientLight.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Plane(point: Point3D(x: 0, y: 0.5, z: 0), normal: Vector3D(x: 0, y: -1, z: 0))],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 100, green: 50, blue: 0))
    }
    
    func testDirectionLight1() {
        let light = DirectionLight(
            direction: Vector3D(x: 0, y: 1, z: 0),
            color: Pixel(red: 100, green: 100, blue: 20),
            intensity: 0.5
        )
        
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 50, green: 50, blue: 10))
    }
    
    func testDirectionLight2() {
        let light = DirectionLight(
            direction: Vector3D(x: 0, y: 1, z: 0),
            color: Pixel(red: 100, green: 100, blue: 20),
            intensity: 0.5
        )
        
        let pixel = light.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [Plane(point: Point3D(x: 0, y: 0.5, z: 0), normal: Vector3D(x: 0, y: -1, z: 0))],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 0, green: 0, blue: 0))
    }

    func testDirectionLight3() {
        let directionLight = DirectionLight(
            direction: Vector3D(x: 0, y: 1, z: 0),
            color: Pixel(red: 100, green: 100, blue: 20),
            intensity: 0.5
        )
        
        let pointLight = PointLight(
            origin: Point3D(x: 0, y: 0, z: 1),
            color: Pixel(red: 200, green: 20, blue: 100),
            intensity: 0.5
        )
        
        var pixel = directionLight.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        pixel = pixel + pointLight.getPixel(
            normal: Vector3D(x: 0, y: 1, z: 0),
            objects: [],
            reflectedFrom: Point3D(x: 0, y: 1, z: 0)
        )
        
        XCTAssertEqual(pixel, Pixel(red: 120, green: 57, blue: 45))
    }
    
}
