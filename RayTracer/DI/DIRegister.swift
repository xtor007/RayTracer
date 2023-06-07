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
    }
    
}
