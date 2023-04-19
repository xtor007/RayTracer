//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation
import PluginInterface

protocol CameraProtocol {
    var origin: Point3D { get }
    var direction: Vector3D { get }
    var upOrientation: Vector3D { get }
    var fov: Float { get }
    
    func setScene(_ scene: Scene)
    func capture() -> Frame<Pixel>
}

final class Camera: CameraProtocol {
    
    var origin: Point3D
    var direction: Vector3D
    var upOrientation: Vector3D
    /// degrees
    var fov: Float
    unowned var scene: Scene!
    
    /// width/height ratio
    private var aspectRatio: Float
    private var verticalResolution: Int
    private var horizontalResolution: Int

    private lazy var n = direction.unitVector
    private lazy var v: Vector3D = -1 * n.crossProduct(upOrientation).unitVector
    private lazy var u: Vector3D = -1 * upOrientation

    private lazy var topLeftFramePoint = getTopLeftFramePoint()
    private lazy var height = getHeight()
    private lazy var width = height * aspectRatio
    private lazy var pixelHeight = height / Float(verticalResolution)
    private lazy var pixelWidth = width / Float(horizontalResolution)
    private lazy var pixelHalfHeight: Float = pixelHeight / 2
    private lazy var pixelHalfWidth: Float = pixelWidth / 2
    private lazy var pointOfInterest: Point3D = origin + direction
    var progress = 0.0
    
    init(
        matrix: Matrix,
        fov: Float,
        aspectRatio: Float,
        verticalResolutoion: Int
    ) {
        self.origin = try! matrix * Point3D(x: 0, y: 0, z: 0)
        self.direction = try! matrix * Vector3D(x: 0, y: 1, z: 0)
        self.upOrientation = try! matrix * Vector3D(x: 0, y: 0, z: 1).unitVector
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.verticalResolution = verticalResolutoion
        self.horizontalResolution = Int(Float(verticalResolutoion) * aspectRatio)
    }
    
    func setScene(_ scene: Scene) {
        self.scene = scene
    }
    
    func capture() -> Frame<Pixel> {
        var threads = [Thread]()
        let countOfThreads = verticalResolution / 4
        
        var frame = Frame<Pixel>(
            width: horizontalResolution,
            height: verticalResolution,
            defaultValue: Pixel(red: 0, green: 0, blue: 0)
        )
        
        for i in 0..<countOfThreads {
            threads.append(
                Thread {
                    let start = i * self.verticalResolution / countOfThreads
                    let end = start + self.verticalResolution / countOfThreads
                    for yOffset in start..<end {
                        for xOffset in 0..<self.horizontalResolution {
                            let pixelCoordinates = self.getPixelCoordinates(basedOnX: xOffset, y: yOffset)
                            let ray = Ray(
                                startPoint: self.origin,
                                vector: Vector3D(
                                    start: self.origin,
                                    end: pixelCoordinates
                                )
                            )
                            
                            frame[xOffset, yOffset] = self.scene.checkIntersectionWithLighting(usingRay: ray)
                        }
                        self.progress += round((100 / (Double(self.verticalResolution))) * 100) / 100
                        print("progress: \(self.progress)%")
                    }
                }
            )
        }

        threads.forEach {
            $0.threadPriority = 0.1
            $0.start()
        }

        outerloop: while(true) {
            for thread in threads {
                if !thread.isFinished {
                    sleep(1)
                    continue outerloop
                }
                threads.remove(at: 0)
                continue outerloop
            }
            break
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
