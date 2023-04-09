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
    
//    @Option(name: .shortAndLong, help: "The source image file.")
//    var source: String
//
//    @Option(name: .shortAndLong, help: "The format to convert the image to.")
//    var output: String
    
    func run() throws {
//        let sourceURL = URL(fileURLWithPath: "\(FileManager.default.currentDirectoryPath)/\(source)")
//        let goalURL = sourceURL.deletingLastPathComponent().appending(component: output)
//        
//        guard FilesHelper.fileExists(filename: source) else {
//            print("Error: source file does not exist")
//            return
//        }
        
        let scene = Scene()
        
        scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 10), radius: 2))
        scene.addObject(Sphere(center: Point3D(x: 0, y: 10, z: 50), radius: 10))
        scene.addObject(Sphere(center: Point3D(x: -12, y: 1, z: 50), radius: 6))
        scene.addObject(Disc(center: Point3D(x: -20, y: 10, z: 50),
                             normal: Vector3D(x: 60, y: 0, z: 35),
                             radius: 10))
        scene.addObject(Plane(point: Point3D(x: 10, y: -10, z: 0),
                              normal: Vector3D(x: 1, y: 0, z: 0)))
        
        let camera = Camera(
            origin: .zero,
            pointOfInterest: Point3D(x: 0, y: 0, z: 1),
            upOrientation: Vector3D(x: 1, y: 0, z: 0),
            fov: 60,
            aspectRatio: 1,
            verticalResolutoion: 2000
        )
        
        camera.scene = scene
        let frame = camera.capture()
        let viewport = ImageViewport(frame: frame)
        viewport.display()
    }
    
}
