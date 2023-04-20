//
//  ConsoleRenderer.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import Foundation
import ArgumentParser
import ConverterCore
import PluginInterface

struct ConsoleRenderer: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "ray-tracer",
        abstract: "Renders a given .obj file and creates an image of a given extension.",
        version: "1.0.0",
        shouldDisplay: true,
        subcommands: [],
        defaultSubcommand: nil,
        helpNames: [.short, .long, .customLong("hlp")]
    )
    
    @Option(name: .shortAndLong, help: "The source image file.")
    var source: String
    
    //    @Option(name: .shortAndLong, help: "The format to convert the image to.")
    //    var output: String
    
    func run() throws {
        let sourceURL = URL(fileURLWithPath: "\(FileManager.default.currentDirectoryPath)/\(source)")
        //        let goalURL = sourceURL.deletingLastPathComponent().appending(component: output)
        
        guard FilesHelper.fileExists(atPath: "\(FileManager.default.currentDirectoryPath)/\(source)") else {
            print(sourceURL
            )
            print("Error: source file does not exist")
            return
        }
        
        let data = try Data(contentsOf: sourceURL)
        guard let stringData = String(data: data, encoding: .utf8) else { return }
        
        let fileParser = ObjParser(stringData: stringData)
        let triangles = try fileParser.getTriangles()
        
        let cowChangeColors = Matrix (translation: Vector3D(x: 0, y: 1, z: 0.0))
        var newTriangles = [Object3D]()
        triangles.forEach { triangle in
            let point1 = try! cowChangeColors * triangle.point1
            let point2 = try! cowChangeColors * triangle.point2
            let point3 = try! cowChangeColors * triangle.point3
            newTriangles.append(Triangle(point1: point1, point2: point2, point3: point3))
        }
        
        let scene = Scene()
        newTriangles.forEach(scene.addObject)
//        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: -100.3), radius: 100))
        scene.addLight(Light(
            direction: Vector3D(x: -1, y: 0.7, z: -1),
            color: Pixel(red: 0, green: 0, blue: 255)
        ))
        scene.addLight(Light(
            direction: Vector3D(x: 0.5, y: 0.6, z: -1),
            color: Pixel(red: 255, green: 0, blue: 0)
        ))
        scene.addLight(Light(
            direction: Vector3D(x: 0, y: 0.5, z: -0.5),
            color: Pixel(red: 0, green: 122, blue: 0)
        ))
        
//        scene.addLight(Light(
//            direction: Vector3D(x: 0, y: 0.3, z: -1),
//            color: Pixel(red: 0, green: 87, blue: 183)
//        ))
//        print(MemoryLayout<Light>.stride)
//        scene.addLight(Light(
//            direction: Vector3D(x: 0, y: 1, z: 0),
//            color: Pixel(red: 255, green: 255, blue: 0)
//        ))
        
//        for i in 0...5 {
//            scene.addLight(Light(
//                direction: Vector3D(x: -1 + Float(i) * 0.4, y: 1, z: -1),
//                color: Pixel(red: UInt8(100 - i * 10), green: 40 / 2, blue: UInt8(40 + i * 10))
//            ))
//        }
        
//        triangles = [
        scene.addObject(
            Triangle(
                point1: Point3D(x: 200, y: 20, z: -0.31),
                point2: Point3D(x: -200, y: 20, z: -0.31),
                point3: Point3D(x: 0, y: 0.2, z: -0.31)
            )
        )
//        ]
        
        let camera = Camera(
//            matrix: try! Matrix(translation: Vector3D(x: -0.25, y: 0, z: 0)) * Matrix(rotateAroundZForAngle: -Float.pi / 18),
            matrix: Matrix(),
            fov: 60,
            aspectRatio: 2560 / 1600,
            verticalResolutoion: 3200
        )
        
        camera.scene = scene
//        let frame = camera.capture()
        let start = Date.timeIntervalSinceReferenceDate
        let frame = camera.captureWithGpu()
        let end = Date.timeIntervalSinceReferenceDate
        print("Rendrering time: \(end - start)")
        let viewport = ImageViewport(frame: frame)
        viewport.display()
    }
    
}
