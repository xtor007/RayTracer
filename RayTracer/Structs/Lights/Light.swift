//
//  Light.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol Light {
    func getPixel(normal: Vector3D, root: OctNode, reflectedFrom point: Point3D) -> Pixel
    func getPixel(normal: Vector3D, objects: [Object3D], reflectedFrom point: Point3D) -> Pixel
}
