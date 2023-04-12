//
//  FaceObjFieldParser.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import Foundation

struct FaceObjFieldParser: ObjFieldParser {
    
    typealias PivotPair = (pointIndex: Int, normalIndex: Int)
    
    struct Result {
        let firstPivot: PivotPair
        let secondPivot: PivotPair
        let thirdPivot: PivotPair
    }
    
    private let separator = "//"
    
    func parse(components: Components) -> Result? {
        guard
            let firstPart = components[safe: 1], let firstPivot = parsePivot(fromString: firstPart),
            let secondPart = components[safe: 2], let secondPivot = parsePivot(fromString: secondPart),
            let thirdPart = components[safe: 3], let thirdPivot = parsePivot(fromString: thirdPart)
        else { return nil }
        
        return Result(firstPivot: firstPivot, secondPivot: secondPivot, thirdPivot: thirdPivot)
    }
    
    private func parsePivot(fromString string: String) -> PivotPair? {
        let components = string.components(separatedBy: "//")
        guard
            components.count == 2,
            let first = components.first, let intFirst = Int(first),
            let last = components.last, let intLast = Int(last)
        else { return nil }
        return (intFirst, intLast)
    }
    
}
