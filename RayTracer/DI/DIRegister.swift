//
//  DIRegister.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.06.2023.
//

import Foundation

final class DIRegister {
    
    private init() {}
    
    static func register() {
        DIContainer.shared.register(type: (any Viewport<Pixel>).self, service: ImageViewport())
        DIContainer.shared.register(type: ObjParserType.self, service: ObjParser())
        DIContainer.shared.register(type: SceneProtocol.self, service: SceneWithTree())
        
        let camera = Camera(
            matrix: Matrix(translation: Vector3D(x: 1, y: 0, z: 0)),// * Matrix(rotateAroundZForAngle: Float.pi / 4),
            fov: 60,
            aspectRatio: 16 / 9,
            verticalResolutoion: 480
        )
        DIContainer.shared.register(type: CameraProtocol.self, service: camera)
    }
    
}
