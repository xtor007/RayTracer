//
//  ScenesStore.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.06.2023.
//

import Foundation

final class ScenesStore {
    
    private let scene = DIContainer.shared.resolve(type: SceneProtocol.self)
    
    func loadScene(withName name: String?) {
        let name = name ?? "default"
        switch name {
        case "scene-1":
            scene.addObject(Sphere(center: Point3D(x: 0, y: 50, z: 0), radius: 10))
            scene.addObject(Sphere(center: Point3D(x: 0, y: 50, z: 10), radius: 4))
            scene.addObject(Sphere(center: Point3D(x: 10, y: 50, z: 0), radius: 7))
            scene.addObject(Sphere(center: Point3D(x: 20, y: 50, z: 0), radius: 15))
            scene.addObject(Sphere(center: Point3D(x: 0, y: 50, z: 20), radius: 12))
            scene.addObject(Sphere(center: Point3D(x: -10, y: 50, z: 20), radius: 14))
            scene.addObject(Sphere(center: Point3D(x: -10, y: 40, z: 20), radius: 5))
            
            scene.addLight(AmbientLight(color: Pixel(red: 123, green: 16, blue: 189), intensity: 0.4))
            
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
        default:
            print("⚠️ Default scene used")
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
        }
    }
    
}
