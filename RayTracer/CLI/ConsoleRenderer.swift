//
//  ConsoleRenderer.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import Foundation
import ArgumentParser
import ConverterCore

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
        
        let scaleMatrix = Matrix(scale: Vector3D(x: 3, y: 3, z: 3))
        let translateMatrix = Matrix(translation: Vector3D(x: 1, y: 0, z: 0))
        let rotateXMatrix = Matrix(rotateAroundXForAngle: 0)
        let rotateZMatrix = Matrix(rotateAroundZForAngle: Float.pi / 2)
        var newTriangles = [Object3D]()
        
        triangles.forEach { triangle in
            let point1 = try! scaleMatrix * translateMatrix * rotateXMatrix * rotateZMatrix * triangle.point1
            let point2 = try! scaleMatrix * translateMatrix * rotateXMatrix * rotateZMatrix * triangle.point2
            let point3 = try! scaleMatrix * translateMatrix * rotateXMatrix * rotateZMatrix * triangle.point3
            newTriangles.append(Triangle(point1: point1, point2: point2, point3: point3))
        }
        
        let scene = Scene()
        newTriangles.forEach(scene.addObject)
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: -100.8), radius: 100))

        let camera = Camera(
//            matrix: try! Matrix(translation: Vector3D(x: 3, y: 3, z: 0.5)) * Matrix(rotateAroundZForAngle: -Float.pi / 2) * Matrix(rotateAroundYForAngle: 0) * Matrix(rotateAroundXForAngle: 0),
            matrix: Matrix(translation: Vector3D(x: 0, y: 0, z: 0)),
            fov: 60,
            aspectRatio: 16 / 9,
            verticalResolutoion: 64
        )
        
        camera.scene = scene
        let frame = camera.capture()
        let viewport = ImageViewport(frame: frame)
        viewport.display()
    }
    
}
