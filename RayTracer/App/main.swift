//
//  main.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

let scene = Scene()
//scene.addObject(Sphere(center: Point3D(x: 0, y: 0, z: 10), radius: 2))
//scene.addObject(Sphere(center: Point3D(x: 0, y: 10, z: 50), radius: 10))
//scene.addObject(Sphere(center: Point3D(x: 8, y: -10, z: 50), radius: 8))
//scene.addObject(Sphere(center: Point3D(x: -8, y: -10, z: 50), radius: 8))

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
    verticalResolutoion: 50
)

camera.scene = scene
let frame = camera.capture()
let viewport = ConsoleViewport(frame: frame)
viewport.display()
