//
//  ObjParser.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import Foundation

final class ObjParser {
    
    private enum Key {
        static var vertex = "v"
        static var face = "f"
    }
    
    private let stringData: String
    
    init(stringData: String) {
        self.stringData = stringData
    }
    
    func getTriangles() throws -> [Triangle] {
        let lines = stringData.components(separatedBy: .newlines)
        let lookupTable = lines.reduce(into: [String : [StringComponents]]()) { dict, line in
            let components = line.components(separatedBy: .whitespaces)
            guard let key = components.first else { return }
            dict[key, default: .init()].append(components)
        }
        
        guard let vertexComponents = lookupTable[Key.vertex] else { throw ObjParsingError.corruptedVerteciesData }
        let vertexParser = PointObjFieldParser()
        let vertecies = try vertexComponents.map {
            guard let res = vertexParser.parse(components: $0) else { throw ObjParsingError.corruptedVerteciesData }
            return res
        }
        
        guard let faceComponents = lookupTable[Key.face] else { throw ObjParsingError.corruptedFacesData }
        let faceParser = FaceObjFieldParser()
        return try faceComponents
            .compactMap(faceParser.parse)
            .compactMap { faceParsingResult in
                guard
                    let firstVertex = vertecies[safe: faceParsingResult.firstPivot.pointIndex - 1],
                    let secondVertex = vertecies[safe: faceParsingResult.secondPivot.pointIndex - 1],
                    let thirdVertex = vertecies[safe: faceParsingResult.thirdPivot.pointIndex - 1]
                else { throw ObjParsingError.corruptedFacesData }
                return Triangle(point1: firstVertex, point2: secondVertex, point3: thirdVertex)
            }
    }
    
}

extension ObjParser {
    
    enum ObjParsingError: Error {
        case corruptedVerteciesData
        case corruptedFacesData
    }
    
}
