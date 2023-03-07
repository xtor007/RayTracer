//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol CameraProtocol {
    var location: Point3D { get }
    var fov: Float { get }
    var direction: Vector3D { get }
    
    func setScene(_ scene: Scene)
    func capture() -> Frame<Float>
}

final class Camera: CameraProtocol {

    private struct Bounds {
        let upperLeft: Point3D
        let upperRight: Point3D
        let lowerLeft: Point3D
        let lowerRight: Point3D
    }
    
    var location: Point3D
    var fov: Float
    var direction: Vector3D
    unowned var scene: Scene!
    
    private let frameBounds = Bounds(
        upperLeft: Point3D(x: -1, y: 1, z: 1),
        upperRight: Point3D(x: 1, y: 1, z: 1),
        lowerLeft: Point3D(x: -1, y: -1, z: 1),
        lowerRight: Point3D(x: 1, y: -1, z: 1))
    
    private let frameWidth = 2
    private let frameHight = 2
    
    private let width = 20
    private let height = 20

    init(location: Point3D, fov: Float, direction: Vector3D) {
        self.location = location
        self.fov = fov
        self.direction = direction
    }
    
    func setScene(_ scene: Scene) {
        self.scene = scene
    }
    
    func capture() -> Frame<Float> {
        let pixelWidth = Float(frameWidth) / Float(width)
        let pixelHeight = Float(frameHight) / Float(height)
        let pixelCompensationWidth = pixelWidth / 2
        let pixelCompensationHeight = pixelHeight / 2
        
        var frame = Frame<Float>(width: width, height: height, defaultValue: 0)
        for xStep in 0..<width {
            for yStep in 0..<height {
                let x = frameBounds.upperLeft.x + Float(xStep) * pixelWidth + pixelCompensationWidth
                let y = frameBounds.upperLeft.y - Float(yStep) * pixelHeight + pixelCompensationHeight
                let pixelPoint = Point3D(x: x, y: y, z: 1)
                let ray = Ray(
                    startPoint: location,
                    vector: Vector3D(
                        start: location,
                        end: pixelPoint)
                )
                print(ray.vector.x, ray.vector.y, ray.vector.z)
                frame[xStep, yStep] = scene.checkIntersection(usingRay: ray) ? 1 : 0
            }
        }
        return frame
    }

}

// MARK: - Intersection Calculations
private extension Camera {}
