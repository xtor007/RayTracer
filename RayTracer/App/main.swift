//
//  main.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

let scene = Scene()
scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 200), radius: 100))

let camera = Camera(location: Point3D(x: 0, y: 0, z: 0), fov: 30, direction: Vector3D(x: 0, y: 0, z: 1))
camera.scene = scene

let frame = camera.capture()

for x in 0..<frame.width {
    for y in 0..<frame.height {
        print(frame[x, y] == 1 ? "⬜️" : "⬛️", terminator: "")
    }
    print()
}
