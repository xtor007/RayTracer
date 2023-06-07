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
            print(sourceURL)
            print("Error: source file does not exist")
            return
        }
        
        let data = try Data(contentsOf: sourceURL)
        guard let stringData = String(data: data, encoding: .utf8) else { return }
        
        let fileParser = DIContainer.shared.resolve(type: ObjParserType.self)
        let triangles = try fileParser.getTriangles(stringData: stringData)
        
        let cowChangeColors = Matrix(translation: Vector3D(x: 0, y: 1, z: 0.0))
        var newTriangles = [Object3D]()
        triangles.forEach { triangle in
            let point1 = cowChangeColors * triangle.point1
            let point2 = cowChangeColors * triangle.point2
            let point3 = cowChangeColors * triangle.point3
            newTriangles.append(Triangle(point1: point1, point2: point2, point3: point3))
        }
        
        let scene = DIContainer.shared.resolve(type: SceneProtocol.self)
        newTriangles.forEach(scene.addObject)
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: -100.3), radius: 100))

        scene.addLight(AmbientLight(color: Pixel(red: 100, green: 100, blue: 100), intensity: 0.2))
        
        scene.addLight(PointLight(
            origin: Point3D(x: -0.6, y: 0, z: 0.2),
            color: Pixel(red: 200, green: 0, blue: 50),
            intensity: 1.0
        ))
        
        scene.addLight(DirectionLight(
            direction: Vector3D(x: 1, y: 0, z: -0.2),
            color: Pixel(red: 0, green: 255, blue: 0),
            intensity: 1
        ))
        
        let camera = Camera(
            matrix: Matrix(translation: Vector3D(x: 1, y: 0, z: 0)) * Matrix(rotateAroundZForAngle: Float.pi / 4),
            fov: 60,
            aspectRatio: 16 / 9,
            verticalResolutoion: 480
        )
        
//        scene.addObject(Plane(point: Point3D(x: -10, y: 0, z: 0), normal: Vector3D(x: 1, y: 0, z: 0)))
        
        camera.scene = scene
        let frame = camera.capture()
        
        let viewport = DIContainer.shared.resolve(type: (any Viewport<Pixel>).self)
        viewport.display(frame: frame)
    }
    
}
