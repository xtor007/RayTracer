//
//  AmbientLight.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import Foundation

class AmbientLight: Light {
    let color: Pixel
    let intensity: Float
    
    init(color: Pixel, intensity: Float) {
        self.color = color
        self.intensity = intensity
    }
    
    func getPixel(normal: Vector3D, root: OctNode, reflectedFrom point: Point3D) -> Pixel {
        return intensity * color
    }
    
    func getPixel(normal: Vector3D, objects: [Object3D], reflectedFrom point: Point3D) -> Pixel {
        return intensity * color
    }
}
