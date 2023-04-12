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
    
    func getTriangles() -> [Triangle]? {
        let lines = stringData.components(separatedBy: .newlines)
        let lookupTable = lines.reduce(into: [String : [[String]]]()) { dict, line in
            let components = line.components(separatedBy: .whitespaces)
            guard let key = components.first else { return }
            dict[key, default: .init()].append(components)
        }
        
        guard let vertexComponents = lookupTable[Key.vertex] else { return nil }
        let vertexParser = PointObjFieldParser()
        let vertecies = vertexComponents.compactMap(vertexParser.parse)
        
        guard let faceComponents = lookupTable[Key.face] else { return nil }
        print("🟢", faceComponents.count)
        let faceParser = FaceObjFieldParser()
        return faceComponents
            .compactMap(faceParser.parse)
            .compactMap { faceParsingResult in
                print(faceParsingResult.firstPivot.pointIndex, faceParsingResult.secondPivot.pointIndex, faceParsingResult.thirdPivot.pointIndex)
                guard
                    let firstVertex = vertecies[safe: faceParsingResult.firstPivot.pointIndex - 1],
                    let secondVertex = vertecies[safe: faceParsingResult.secondPivot.pointIndex - 1],
                    let thirdVertex = vertecies[safe: faceParsingResult.thirdPivot.pointIndex - 1]
                else { return nil }
                return Triangle(point1: firstVertex, point2: secondVertex, point3: thirdVertex)
            }
    }
    
}
