//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol CameraProtocol {
    var origin: Point3D { get }
    var pointOfInterest: Point3D { get }
    var upOrientation: Vector3D { get }
    var fov: Float { get }
    
    func setScene(_ scene: Scene)
    func capture() -> Frame<Float>
}

final class Camera: CameraProtocol {
    
    var origin: Point3D
    var pointOfInterest: Point3D
    var upOrientation: Vector3D
    /// degrees
    var fov: Float
    unowned var scene: Scene!
    
    /// width/height ratio
    private var aspectRatio: Float
    private var verticalResolutoion: Int
    private var horizontalResolution: Int

    private lazy var n = Vector3D(start: origin, end: pointOfInterest).unitVector
    private lazy var v: Vector3D = -1 * n.crossProduct(upOrientation).unitVector
    private lazy var u: Vector3D = -1 * upOrientation

    private lazy var topLeftFramePoint = getTopLeftFramePoint()
    private lazy var height = getHeight()
    private lazy var width = height * aspectRatio
    private lazy var pixelHeight = height / Float(verticalResolutoion)
    private lazy var pixelWidth = width / Float(horizontalResolution)
    private lazy var pixelHalfHeight: Float = pixelHeight / 2
    private lazy var pixelHalfWidth: Float = pixelWidth / 2
    
    init(
        origin: Point3D,
        pointOfInterest: Point3D,
        upOrientation: Vector3D,
        fov: Float,
        aspectRatio: Float,
        verticalResolutoion: Int,
        horizontalResolution: Int
    ) {
        self.origin = origin
        self.pointOfInterest = pointOfInterest
        self.upOrientation = upOrientation.unitVector
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.verticalResolutoion = verticalResolutoion
        self.horizontalResolution = horizontalResolution
    }
    
    func setScene(_ scene: Scene) {
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
        topLeftFramePoint + ((Float(x) * pixelWidth + pixelHalfWidth) * v) - ((Float(y) * pixelHeight + pixelHalfHeight) * u)
    }
    
}
