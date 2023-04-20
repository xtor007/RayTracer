//
//  Camera.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation
import PluginInterface
import MetalKit

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
        
        var rays = [Ray]()

        for yOffset in 0..<verticalResolution {
            for xOffset in 0..<horizontalResolution {
                let pixelCoordinates = getPixelCoordinates(basedOnX: xOffset, y: yOffset)
                let ray = Ray(
                    startPoint: origin,
                    vector: Vector3D(
                        start: origin,
                        end: pixelCoordinates
                    )
                )
                rays.append(ray)
            }
        }
        
        var frame = Frame<Pixel>(
            width: horizontalResolution,
            height: verticalResolution,
            defaultValue: Pixel(red: 0, green: 0, blue: 0)
        )
        
        let device = MTLCreateSystemDefaultDevice()
        let commandQueue = device?.makeCommandQueue()
        let gpuFunctionLibrary = device?.makeDefaultLibrary()
        let checkIntersectionGpuFunction = gpuFunctionLibrary?.makeFunction(name: "gpuCheckIntersection")
        var checkIntersectionPipelineState: MTLComputePipelineState!
        do {
            checkIntersectionPipelineState = try device?.makeComputePipelineState(function: checkIntersectionGpuFunction!)
        } catch {
            print(error)
        }
        
        let raysBuff = device?.makeBuffer(
            bytes: rays,
            length: MemoryLayout<Ray>.stride * rays.count,
            options: .storageModeShared
        )
                
        let triangles = scene.objects.map { $0 as! Triangle }

        let trianglesBuff = device?.makeBuffer(
            bytes: triangles,
            length: MemoryLayout<Triangle>.stride * triangles.count,
            options: .storageModeShared
        )

        let trianglesCountBuff = device?.makeBuffer(
            bytes: [triangles.count],
            length: MemoryLayout<Int>.stride,
            options: .storageModeShared
        )
        
        print(MemoryLayout<Light>.stride)
        var lights = [Light]()
        for light in scene.lights {
            lights.append(light)
        }
        
        let lightsBuff = device?.makeBuffer(
            bytes: lights,
            length: MemoryLayout<Light>.stride * lights.count,
            options: .storageModeShared
        )
        
        let lightsCountBuff = device?.makeBuffer(
            bytes: [scene.lights.count],
            length: MemoryLayout<Int>.stride,
            options: .storageModeShared
        )

        
        let pixelBuff = device?.makeBuffer(
            length: MemoryLayout<Pixel>.stride * rays.count,
            options: .storageModeShared
        )
                
        let commandBuffer = commandQueue?.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeComputeCommandEncoder()
        commandEncoder?.setComputePipelineState(checkIntersectionPipelineState)
        
        commandEncoder?.setBuffer(raysBuff, offset: 0, index: 0)
        commandEncoder?.setBuffer(trianglesBuff, offset: 0, index: 1)
        commandEncoder?.setBuffer(trianglesCountBuff, offset: 0, index: 2)
        commandEncoder?.setBuffer(lightsBuff, offset: 0, index: 3)
        commandEncoder?.setBuffer(lightsCountBuff, offset: 0, index: 4)
        commandEncoder?.setBuffer(pixelBuff, offset: 0, index: 5)
        
        let threadsPerGrid = MTLSize(width: rays.count, height: 1, depth: 1)
        let maxThreadsPerThreadgroup = checkIntersectionPipelineState.maxTotalThreadsPerThreadgroup
        let threadsPerThreadgroup = MTLSize(width: maxThreadsPerThreadgroup, height: 1, depth: 1)

        commandEncoder?.dispatchThreads(threadsPerGrid,
                                        threadsPerThreadgroup: threadsPerThreadgroup)

        let start = Date.timeIntervalSinceReferenceDate
        commandEncoder?.endEncoding()
        commandBuffer?.commit()
        commandBuffer?.waitUntilCompleted()
        let end = Date.timeIntervalSinceReferenceDate
        print("rendering time: \(end - start)")
        
        var pixelBufferPointer = pixelBuff?.contents().bindMemory(to: Pixel.self,
                                                                  capacity: MemoryLayout<Pixel>.stride * rays.count)
        
        for i in 0..<verticalResolution {
            for j in 0..<horizontalResolution {
                frame[j, i] = pixelBufferPointer!.pointee
                pixelBufferPointer = pixelBufferPointer?.advanced(by: 1)
            }
        }
        return frame
    }
    
    func capture(with type: Pixel.Type) -> Frame<Pixel> {
        var frame = Frame<Pixel>(width: horizontalResolution, height: verticalResolution, defaultValue: Pixel(red: 0, green: 0, blue: 0))
        for yOffset in 0..<verticalResolution {
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
