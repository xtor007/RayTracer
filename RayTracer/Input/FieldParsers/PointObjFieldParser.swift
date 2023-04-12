//
//  PointObjFieldParser.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import Foundation

struct PointObjFieldParser: ObjFieldParser {
    
    func parse(components: Components) -> Point3D? {
        guard
            let x = components[safe: 1], let floatX = Float(x),
            let y = components[safe: 2], let floatY = Float(y),
            let z = components[safe: 3], let floatZ = Float(z)
        else { return nil }
        return Point3D(x: floatX, y: floatY, z: floatZ)
    }
    
}
