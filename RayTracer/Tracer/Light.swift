//
//  Light.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation
import PluginInterface

struct Light {
    let direction: Vector3D
    let color: Pixel
    
    init(direction: Vector3D, color: Pixel) {
        self.direction = direction
        self.color = color
    }
}
