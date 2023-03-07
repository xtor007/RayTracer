//
//  main.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

let scene = Scene()
scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 10), radius: 2))
scene.addObject(Sphere(center: Point3D(x: 0, y: 10, z: 50), radius: 10))
scene.addObject(Sphere(center: Point3D(x: 8, y: -10, z: 50), radius: 8))
scene.addObject(Sphere(center: Point3D(x: -8, y: -10, z: 50), radius: 8))

let camera = Camera(
    origin: .zero,
    pointOfInterest: Point3D(x: 0, y: 0, z: 1),
    upOrientation: Vector3D(x: 0, y: 1, z: 0),
    fov: 60,
    aspectRatio: 1,
    verticalResolutoion: 20,
    horizontalResolution: 20
)

camera.scene = scene
let frame = camera.capture()

for x in 0..<frame.width {
    for y in 0..<frame.height {
        print(frame[x, y] == 1 ? "⬜️" : "⬛️", terminator: "")
    }
    print()
}
