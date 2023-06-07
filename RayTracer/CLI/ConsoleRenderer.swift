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
    var source: String?
    
    @Option(name: .shortAndLong, help: "Scene to render.")
    var sceneName: String?
    
    func run() throws {
        let scene = DIContainer.shared.resolve(type: SceneProtocol.self)
        
        if let source {
            let sourceURL = URL(fileURLWithPath: "\(FileManager.default.currentDirectoryPath)/\(source)")
            
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
            
            newTriangles.forEach(scene.addObject)
        }
        
        ScenesStore().loadScene(withName: sceneName)
        
        let camera = DIContainer.shared.resolve(type: CameraProtocol.self)
        camera.setScene(scene)
        let frame = camera.capture()
        
        let viewport = DIContainer.shared.resolve(type: (any Viewport<Pixel>).self)
        viewport.display(frame: frame)
    }
    
}
