//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol CameraProtocol {
    var origin: Point3D { get }
    var direction: Vector3D { get }
    var upOrientation: Vector3D { get }
    var fov: Float { get }
    
    func setScene(_ scene: SceneProtocol)
    func capture() -> Frame<Float>
}

final class Camera: CameraProtocol {
    
    var origin: Point3D
    var direction: Vector3D
    var upOrientation: Vector3D
    /// degrees
    var fov: Float
    var scene: SceneProtocol!
    
    /// width/height ratio
    private var aspectRatio: Float
    private var verticalResolutoion: Int
    private var horizontalResolution: Int

    private lazy var n = direction.unitVector
    private lazy var v: Vector3D = -1 * n.crossProduct(upOrientation).unitVector
    private lazy var u: Vector3D = -1 * upOrientation

    private lazy var topLeftFramePoint = getTopLeftFramePoint()
    private lazy var height = getHeight()
    private lazy var width = height * aspectRatio
    private lazy var pixelHeight = height / Float(verticalResolutoion)
    private lazy var pixelWidth = width / Float(horizontalResolution)
    private lazy var pixelHalfHeight: Float = pixelHeight / 2
    private lazy var pixelHalfWidth: Float = pixelWidth / 2
    private lazy var pointOfInterest: Point3D = origin + direction
    
    init(
        matrix: Matrix,
        fov: Float,
        aspectRatio: Float,
        verticalResolutoion: Int
    ) {
        self.origin = matrix * Point3D(x: 0, y: 0, z: 0)
        self.direction = matrix * Vector3D(x: 0, y: 1, z: 0)
        self.upOrientation = matrix * Vector3D(x: 0, y: 0, z: 1).unitVector
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.verticalResolutoion = verticalResolutoion
        self.horizontalResolution = Int(Float(verticalResolutoion) * aspectRatio)
    }
    
    func setScene(_ scene: SceneProtocol) {
        self.scene = scene
    }
    
    func capture() -> Frame<Float> {
        var frame = Frame<Float>(width: horizontalResolution, height: verticalResolutoion, defaultValue: 0)
        for yOffset in 0..<verticalResolutoion {
            for xOffset in 0..<horizontalResolution {
                let pixelCoordinates = getPixelCoordinates(basedOnX: xOffset, y: yOffset)
                let ray = Ray(
                    startPoint: origin,
                    vector: Vector3D(
                        start: origin,
                        end: pixelCoordinates
                    )
                )
                
                frame[xOffset, yOffset] = scene.checkIntersectionWithLighting(usingRay: ray)
            }
        }
        
        return frame
    }
    
}

// MARK: Image Plane Setup
private extension Camera {
    
    func getTopLeftFramePoint() -> Point3D {
        pointOfInterest - ((width / 2) * v) + ((height / 2) * u)
    }
    
    func getHeight() -> Float {
        tan(Math.degToRad(fov / 2)) * Vector3D(start: origin, end: pointOfInterest).lenght * 2
    }
    
}

// MARK: - Pixel Coordinate
private extension Camera {
    
    func getPixelCoordinates(basedOnX x: Int, y: Int) -> Point3D {
        return topLeftFramePoint + ((Float(x) * pixelWidth + pixelHalfWidth) * v) - ((Float(y) * pixelHeight + pixelHalfHeight) * u)
    }
    
}
