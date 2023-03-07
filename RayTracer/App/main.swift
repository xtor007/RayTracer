//
//  main.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

let scene = Scene()
scene.addObject(Sphere(center: Point3D(x: 3, y: 5, z: 5), radius: 2))
scene.addObject(Plane(point: Point3D(x: 3, y: 0, z: 0), normal: Vector3D(x: 1, y: 0, z: 0)))
scene.addObject(Disc(center: Point3D(x: 3, y: 4, z: 2), normal: Vector3D(x: 0, y: 0, z: -1), radius: 1))
print(scene.display())

