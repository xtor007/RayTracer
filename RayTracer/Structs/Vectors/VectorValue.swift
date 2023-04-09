//
//  VectorValue.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

protocol VectorValue {
    
    var x: Float { get }
    var y: Float { get }
    var z: Float { get }

    init(x: Float, y: Float, z: Float)

    func scalarSquare() -> Float
    
}
